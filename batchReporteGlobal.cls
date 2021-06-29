/**
 * @description       : Primer batch para procesamiento de información de reporte global de descuentos. En este batch se procesa el descuento autorizado por cuenta
 * @author            : Salvador Ramírez López (sramirez@freewayconsulting.com)
 * @Project           : PaqueteXpress
 * @Created Date      : 06-23-2021
**/
global class batchReporteGlobal implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    public String strQuery                                  = '';
    public String strPlaza                                  = '';
    public String strInicioCot                              = '';
    public String strFinCot                                 = '';
    public Date strInicioDR;
    public Date strFinDR;
    public Date dtInicioCot;
    public Date dtFinCot;
    public Boolean blnEnviador                              = false;
    public Boolean blnReceptor                              = false;
    public Wrapper wp                                       = new Wrapper();
    public Map<String, Wrapper> mapAccounts                 = new Map<String, Wrapper>();
    public List<String> listAccounts                        = new List<String>();
    public List<String> listCuentas                         = new List<String>();
    public List<DescuentoGlobalAutorizado__c> listDescuento = new List<DescuentoGlobalAutorizado__c>();
    public batchReporteGlobal(String Plaza, String InicioCot, String FinCot, String InicioDR, String FinDR, Boolean Enviador, Boolean Receptor) {
        try{
            this.strInicioDR    = Date.valueOf(InicioDR); //Respaldo de fecha inicial en formato de fecha
            this.strFinDR       = Date.valueOf(FinDR); //Respaldo de fecha final en formato de fecha
            this.dtInicioCot    = Date.valueOf(InicioCot);
            this.dtFinCot       = Date.valueOf(FinCot);
            this.strQuery       = 'SELECT ID, Name, SBQQ__Account__c, SBQQ__Account__r.Name, SBQQ__Account__r.Id_SIpWeb__c, Ingreso_Mensual__c, TarifaLlenaMensual__c FROM SBQQ__QUOTE__C '+ 
                                'WHERE Fecha_de_autorizada__c >= ' + InicioCot + ' AND Fecha_de_autorizada__c <= ' + FinCot; //Query en formato string  para traer cotizaciones 
            if(Plaza != 'ALL'){
                this.strQuery   = strQuery + ' AND SBQQ__Account__r.Plaza_Envio__c = \'' + Plaza + '\'';
            }
            if(Enviador && !Receptor){
                this.strQuery   = strQuery + ' AND SBQQ__Account__r.Tipo_de_cliente__c = \'Enviador\'';
            } else if(!Enviador && Receptor){
                this.strQuery   = strQuery + ' AND SBQQ__Account__r.Tipo_de_cliente__c = \'Receptor\'';
            }
        } catch(Exception ex){
            System.debug('Error en constructor batchReporteGlobal: ' + ex.getMessage() + '. ' + ex.getLineNumber());
        }
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(this.strQuery);	
    }
    global void execute(Database.BatchableContext bc, List<SBQQ__QUOTE__C> records){
        try{
            for(SBQQ__QUOTE__C Q : records){
                if(Q.SBQQ__Account__r.Name != null && Q.TarifaLlenaMensual__c != null && Q.Ingreso_Mensual__c != null){
                    if(!this.mapAccounts.containsKey(Q.SBQQ__Account__c)){
                        this.mapAccounts.put(Q.SBQQ__Account__c, new Wrapper());
                        this.mapAccounts.get(Q.SBQQ__Account__c).decTotalTarifaLlena        = Q.TarifaLlenaMensual__c;
                        this.mapAccounts.get(Q.SBQQ__Account__c).decTotalTarifaPropuesta    = Q.Ingreso_Mensual__c;
                        this.mapAccounts.get(Q.SBQQ__Account__c).strCotizaciones            = Q.Name;
                    } else {
                        this.mapAccounts.get(Q.SBQQ__Account__c).decTotalTarifaLlena        += Q.TarifaLlenaMensual__c;
                        this.mapAccounts.get(Q.SBQQ__Account__c).decTotalTarifaPropuesta    += Q.Ingreso_Mensual__c;
                        this.mapAccounts.get(Q.SBQQ__Account__c).strCotizaciones            = this.mapAccounts.get(Q.SBQQ__Account__c).strCotizaciones + ','+ Q.Name;
                    }
                    if(!this.listAccounts.contains(Q.SBQQ__Account__c))
                        this.listAccounts.add(Q.SBQQ__Account__c);
                }
            }
            for(Ventas__c v : [SELECT Cuenta__c, totalAntesdeImpuestos__c, fechaId__c, descuento__c FROM Ventas__c WHERE Cuenta__c IN :this.listAccounts AND fechaId__c >= :this.strInicioDR AND fechaId__c <= :this.strFinDR and descuento__c  > 0 and totalAntesdeImpuestos__c  > 0]){
                if(this.mapAccounts.containsKey(v.Cuenta__c)){
                    this.mapAccounts.get(v.Cuenta__c).Venta     = this.mapAccounts.get(v.Cuenta__c).Venta + v.totalAntesdeImpuestos__c;
                    this.mapAccounts.get(v.Cuenta__c).Descuento = this.mapAccounts.get(v.Cuenta__c).Descuento + v.descuento__c;
                }
            }
            for(Id idAccount : this.listAccounts){
                if(this.mapAccounts.containsKey(idAccount)){
                    this.mapAccounts.get(idAccount).decDescuento    = (this.mapAccounts.get(idAccount).decTotalTarifaPropuesta / this.mapAccounts.get(idAccount).decTotalTarifaLlena) - 1;
                    this.mapAccounts.get(idAccount).TarifaLlena     = this.mapAccounts.get(idAccount).Descuento + this.mapAccounts.get(idAccount).Venta;
                }
            }
        }catch(Exception ex){
            System.debug('batchReporteGlobal.Execute: ' + ex.getMessage() + '. ' + ex.getLineNumber());
        }
    }
    global void finish(Database.BatchableContext bc){
        try{
            DescuentoGlobalAutorizado__c objDescuento = new DescuentoGlobalAutorizado__c();
            for(String idAccount : this.listAccounts){
                objDescuento                            = new DescuentoGlobalAutorizado__c();
                objDescuento.Fecha_inicio_DR__c         = this.strInicioDR;
                objDescuento.Fecha_fin_DR__c            = this.strFinDR;
                objDescuento.Fecha_inicio_cot__c        = this.dtInicioCot;
                objDescuento.Fecha_fin_cot__c           = this.dtFinCot;
                objDescuento.Cuenta__c                  = idAccount;
                objDescuento.Descuento_autorizado__c    = this.mapAccounts.get(idAccount).decDescuento;
                if(this.mapAccounts.get(idAccount).Venta > 0 && this.mapAccounts.get(idAccount).TarifaLlena > 0)
                    objDescuento.Descuento_BI__c        = (this.mapAccounts.get(idAccount).Venta / this.mapAccounts.get(idAccount).TarifaLlena) - 1;
                else objDescuento.Descuento_BI__c       = 0;
                objDescuento.Cotizaciones__c            = this.mapAccounts.get(idAccount).strCotizaciones;
                this.listDescuento.add(objDescuento);
            }
            List<DescuentoGlobalAutorizado__c> listBorrar = [SELECT ID FROM DescuentoGlobalAutorizado__c];
            if(this.listDescuento.size() > 0){
                if(listBorrar.size() > 0){
                    for(Database.DeleteResult delRes : Database.delete(listBorrar, false)){
                        if(!delRes.isSuccess()){
                            for(Database.Error errDel: delRes.getErrors())
                                System.debug('Error eliminando batchReporteGlobal: ' + errDel.getMessage());
                        }
                    }
                }
                for(Database.SaveResult resDeducUPD : Database.insert(this.listDescuento, false)){
                    if(!resDeducUPD.isSuccess()){
                        for(Database.Error insError: resDeducUPD.getErrors())
                            System.debug('Error al guardar datos de partidas de cotización BatchSeguimientoODC2: ' + insError.getMessage());
                    }
                }
            }

            User U = [SELECT Id, Email  FROM User WHERE Id = :System.UserInfo.getUserId()];
            String strLink = 'https://paquetexpress--qa2020--c.visualforce.com/apex/PAQ_ReporteGlobalDescuentos_PAG'; //Link temporal para pruebas
            List<string> toAddress = new List<string>{U.Email};
            String strTemplate = '<hr color="purple" Style="border:15px;"/><br><br>El procesamiento del reporte global de descuentos autorizados ha terminado.<br/> Para ver los resultados dar clic al siguiente enlace <a href="'+ strLink +'"><span style="color:#0066FF" wfd-id="2">Descargar</span>.<br><br><hr color="purple" Style="border:15px;"/>';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddress);
            mail.setSubject('Reporte global de descuentos autorizados');
            mail.setHTMLBody(strTemplate);
            // mail.setTargetObjectId(primaryContact);
            mail.setWhatId('a162f000000RFQe');
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);
            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            allmsg.add(mail);

        
            Messaging.sendEmail(allmsg,false);
            return;
        } catch(Exception ex){
            System.debug('batchReporteGlobal.finish: '+ ex.getMessage() + '. ' + ex.getLineNumber());
        }
    }
    public class Wrapper{
        public Decimal decTotalTarifaLlena;
        public Decimal decTotalTarifaPropuesta;
        public Decimal decDescuento;
        public Decimal decDescuentoBI;
        public Decimal Venta;
        public Decimal Descuento;
        public Decimal TarifaLlena;
        public String strIdSipweb;
        public String strCotizaciones;
        public Wrapper (){
            this.decTotalTarifaLlena        = 0;
            this.decTotalTarifaPropuesta    = 0;
            this.decDescuento               = 0;
            this.decDescuentoBI             = 0;
            this.Venta                      = 0;
            this.Descuento                  = 0;
            this.TarifaLlena                = 0;
            this.strIdSipweb                = '';
            this.strCotizaciones            = '';
        }
    }
}
