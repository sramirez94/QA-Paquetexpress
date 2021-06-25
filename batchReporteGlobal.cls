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
    public Boolean blnEnviador                              = false;
    public Boolean blnReceptor                              = false;
    public Wrapper wp                                       = new Wrapper();
    public Map<String, Wrapper> mapAccounts                 = new Map<String, Wrapper>();
    public List<String> listAccounts                        = new List<String>();
    public List<String> listCuentas                         = new List<String>();
    public List<DescuentoGlobalAutorizado__c> listDescuento = new List<DescuentoGlobalAutorizado__c>();
    public batchReporteGlobal(String Plaza, String InicioCot, String FinCot, String InicioDR, String FinDR, Boolean Enviador, Boolean Receptor) {
        try{
            this.strInicioDR    = Date.valueOf(InicioDR);
            this.strFinDR       = Date.valueOf(FinDR);
            this.strQuery       = 'SELECT ID, Name, SBQQ__Account__c, SBQQ__Account__r.Name, SBQQ__Account__r.Id_SIpWeb__c, Ingreso_Mensual__c, TarifaLlenaMensual__c FROM SBQQ__QUOTE__C '+ 
                                'WHERE Fecha_de_autorizada__c >= ' + InicioCot + ' AND Fecha_de_autorizada__c <= ' + FinCot;
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
                        this.mapAccounts.get(Q.SBQQ__Account__c).decTotalTarifaLlena = Q.TarifaLlenaMensual__c;
                        this.mapAccounts.get(Q.SBQQ__Account__c).decTotalTarifaPropuesta = Q.Ingreso_Mensual__c;
                        this.mapAccounts.get(Q.SBQQ__Account__c).strCotizaciones = Q.Name;
                        //this.mapAccounts.get(Q.SBQQ__Account__c).strIdSipweb = Q.SBQQ__Account__r.Id_SIpWeb__c;
                    } else {
                        this.mapAccounts.get(Q.SBQQ__Account__c).decTotalTarifaLlena += Q.TarifaLlenaMensual__c;
                        this.mapAccounts.get(Q.SBQQ__Account__c).decTotalTarifaPropuesta += Q.Ingreso_Mensual__c;
                        this.mapAccounts.get(Q.SBQQ__Account__c).strCotizaciones = this.mapAccounts.get(Q.SBQQ__Account__c).strCotizaciones + ','+ Q.Name;
                    }
                    if(!this.listAccounts.contains(Q.SBQQ__Account__c))
                        this.listAccounts.add(Q.SBQQ__Account__c);
                    /*if(!this.listCuentas.contains('\''+Q.SBQQ__Account__c+'\''))
                        this.listCuentas.add('\''+Q.SBQQ__Account__c+'\'');*/
                }
            }
            for(Id idAccount : this.listAccounts){
                if(this.mapAccounts.containsKey(idAccount)){
                    this.mapAccounts.get(idAccount).decDescuento = (this.mapAccounts.get(idAccount).decTotalTarifaPropuesta / this.mapAccounts.get(idAccount).decTotalTarifaLlena) - 1;
                }
            }
            for(Ventas__c v : [SELECT Cuenta__c, totalAntesdeImpuestos__c, fechaId__c, descuento__c FROM Ventas__c WHERE Cuenta__c IN :this.listAccounts AND fechaId__c >= :this.strInicioDR AND fechaId__c <= :this.strFinDR and descuento__c  > 0 and totalAntesdeImpuestos__c  > 0]){
                if(this.mapAccounts.containsKey(v.Cuenta__c)){
                    this.mapAccounts.get(v.Cuenta__c).decVentaLlena += v.totalAntesdeImpuestos__c;
                    this.mapAccounts.get(v.Cuenta__c).decVentaPropuesta += v.descuento__c;
                }
            }
        }catch(Exception ex){
            System.debug('batchReporteGlobal.Execute: ' + ex.getMessage() + '. ' + ex.getLineNumber());
        }
    }
    global void finish(Database.BatchableContext bc){
        try{
            //batchReporteGlobal2 batch2 = new batchReporteGlobal2(this.strInicioDR, this.strFinDR, this.listAccounts, this.listCuentas, this.mapAccounts);
            //database.executeBatch(batch2);
            DescuentoGlobalAutorizado__c objDescuento = new DescuentoGlobalAutorizado__c();
            for(String idAccount : this.listAccounts){
                System.debug('Cuenta: ' + idAccount + '. Venta propuesta: ' + this.mapAccounts.get(idAccount).decVentaPropuesta + '. Llena: '  + this.mapAccounts.get(idAccount).decVentaLlena);
                objDescuento                            = new DescuentoGlobalAutorizado__c();
                objDescuento.Cuenta__c                  = idAccount;
                objDescuento.Descuento_autorizado__c    = this.mapAccounts.get(idAccount).decDescuento;
                if(this.mapAccounts.get(idAccount).decVentaPropuesta > 0 && this.mapAccounts.get(idAccount).decVentaLlena > 0)
                    objDescuento.Descuento_BI__c            = (this.mapAccounts.get(idAccount).decVentaPropuesta / this.mapAccounts.get(idAccount).decVentaLlena) - 1;
                else objDescuento.Descuento_BI__c           = 0;
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
        } catch(Exception ex){
            System.debug('batchReporteGlobal.finish: '+ ex.getMessage() + '. ' + ex.getLineNumber());
        }
    }
    public class Wrapper{
        public Decimal decTotalTarifaLlena;
        public Decimal decTotalTarifaPropuesta;
        public Decimal decDescuento;
        public Decimal decDescuentoBI;
        public Decimal decVentaLlena;
        public Decimal decVentaPropuesta;
        public String strIdSipweb;
        public String strCotizaciones;
        public Wrapper (){
            this.decTotalTarifaLlena        = 0;
            this.decTotalTarifaPropuesta    = 0;
            this.decDescuento               = 0;
            this.decDescuentoBI             = 0;
            this.decVentaLlena              = 0;
            this.decVentaPropuesta          = 0;
            this.strIdSipweb                = '';
            this.strCotizaciones            = '';
        }
    }
}
