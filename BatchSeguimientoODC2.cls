/**
 * @description       : Obtiene la frecuencia real del reporte de descuento real costos fijos por tarifa
 * @author            : Salvador Ramírez López (sramirez@freewayconsulting.com)
**/
global class BatchSeguimientoODC2 implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    public String query; //Salvador Ramírez López (sramirez@freewayconsulting.com): Variable para almacenar la consulta en formato string
    public String AccId; //Salvador Ramírez López (sramirez@freewayconsulting.com): Variable para almacenar el id de la cuenta
    public String strIdQuote;
    public Decimal bultos; //Salvador Ramírez López (sramirez@freewayconsulting.com): Variable para almacenar el total de bultos en alguna iteración
    public Map<String, Map<String, SBQQ__QuoteLine__c>> quotes = new Map<String, Map<String, SBQQ__QuoteLine__c>>(); //Salvador Ramírez López (sramirez@freewayconsulting.com): Mapa que va a guardar las partidas de cotización seccionadas por tarifa y rango de km
    public Map<String, wpFrecuencias> mapFrecuencias                                = new Map<String, wpFrecuencias>();
    public Map<String, Map<String, wpFrecuencias>> mapQuotes                        = new Map<String, Map<String, wpFrecuencias>>();
    public Map<String, Map<String, Decimal>> mapFlete                               = new Map<String, Map<String, Decimal>>();
    public Map<String, String> mapTarifas                                           = new Map<String, String>();
    public Map<String, String> mapRangeByDest                                       = new Map<String, String>();
    public Wrapper wp                                                               = new Wrapper();
    public List<String> listRangeDestiny                                            = new List<String>(); //Salvador Ramírez López (sramirez@freewayconsulting.com): Lista con los rangos de km que va a obtener de las frecuencias reales
    public List<Decimal> listBloques                                                = new list<Decimal>();
    public List<String> listFee = new List<String>(); //Salvador Ramírez López (sramirez@freewayconsulting.com): Lista de tarifas
    public List<FrecuenciaDeEnvios__c> insertFrecuencias = new List<FrecuenciaDeEnvios__c>(); //Salvador Ramírez López (sramirez@freewayconsulting.com): Lista de sObjects que va a guardar los datos a insertar
    public List<Frecuencia_real_envio__c> listFrec                                  = new List<Frecuencia_real_envio__c>();
    public BatchSeguimientoODC2(String AccountId, String Inicio, String Fin, String quote, Map<String, Map<String, Decimal>> Fletes) {
        AccId           = AccountId;
        strIdQuote      = quote;
        this.mapFlete   = fletes;
        query = 'SELECT Id, Cuenta__c, Cuenta__r.ParentId, Fecha__c, Linea__c, Rango_Kms__c, Peso_de_bultos__c, Tarifa_de_Bulto__c, ' +
                'Bultos__c, Volumen_de_bultos__c, Servicio__c, Site_Destino__c, Site_Origen__c FROM Seguimiento_de_descuento_real__c ' +
                'WHERE (Cuenta__c = \'' + AccountId + '\' OR Cuenta__r.ParentId = \'' + AccountId + '\') ' +
                'AND Fecha__c >= ' + Inicio + ' AND Fecha__c <= ' + Fin +
                ' AND (Linea__c = \'DOC_LINEA_NORMAL\' OR Linea__c = \'DOC_LINEA_NORMAL_PT\' OR Linea__c = \'DOC_LINEA_ZE\' OR Linea__c = \'DOC_LINEA_ZE_PT\') ';
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug(query);
    	return Database.getQueryLocator(query);	
    }
    global void execute(Database.BatchableContext bc, List<Seguimiento_de_descuento_real__c> records){
        try{
            String strTarifa        = '';
            String strRangeDest     = '';
            Decimal decRAD          = 0;
            Decimal decEAD          = 0;
            Decimal decFlete        = 0;
            Cotizador__c ObjCostos  = [SELECT  EAD__c, RAD__c FROM Cotizador__c LIMIT 1];
            //Obtener tarifas para rangos por km del año actual
            for(Tarifario_general_terrestre__c objTarifarioT: queryTarifarioTFull()){
                if(!wp.mapTarifarioT.containsKey(objTarifarioT.Tarifa__c)){
                    wp.mapTarifarioT.put(objTarifarioT.Tarifa__c, new Map<String, Tarifario_general_terrestre__c>{objTarifarioT.RangoKM__c => objTarifarioT});
                } else if (!wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).containsKey(objTarifarioT.RangoKM__c)){
                    wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).put(objTarifarioT.RangoKM__c, objTarifarioT);
                }
            }
            //Obtener tarifas para acuse del año en curso
            for (AcusePorGuia__mdt objACK : queryACK()){
                wp.mapACK.put(objACK.Label, objACK.Amount__c);
            }
            //Procesar los bultos
            for (Seguimiento_de_descuento_real__c s: records){
                strRangeDest    = '';
                strTarifa       = '';
                strTarifa       = getTarifa(s.Tarifa_de_Bulto__c, s.Linea__c, s.Site_Destino__c);
                if(!this.mapTarifas.containsKey(strTarifa))
                    this.mapTarifas.put(strTarifa, 'TARIFA ' + s.Tarifa_de_Bulto__c);
                if(s.Site_Destino__c == 'ALL'){
                    strRangeDest    = ObtieneRangoKM(s.Rango_Kms__c);
                } else {
                    strRangeDest = s.Site_Destino__c;
                    if(!this.mapRangeByDest.containsKey(strRangeDest))
                        this.mapRangeByDest.put(s.Site_Destino__c, ObtieneRangoKM(s.Rango_Kms__c));
                }
                if(!this.mapQuotes.containsKey(strTarifa))
                    this.mapQuotes.put(strTarifa, new map<String, wpFrecuencias>());
                if(!this.mapQuotes.get(strTarifa).containsKey(strRangeDest)){
                    System.debug('Tarifa: ' + strTarifa + '. Rango: ' + strRangeDest);
                    wpFrecuencias wpF = new wpFrecuencias();
                    this.mapQuotes.get(strTarifa).put(strRangeDest, wpF);
                }
                this.mapQuotes.get(strTarifa).get(strRangeDest).bultos      += Decimal.valueOf(s.Bultos__c);
                this.mapQuotes.get(strTarifa).get(strRangeDest).decPeso     = Decimal.valueOf(s.Peso_de_bultos__c);
                this.mapQuotes.get(strTarifa).get(strRangeDest).decVolumen  = Decimal.valueOf(s.Volumen_de_bultos__c);
                if(s.Linea__c == 'DOC_LINEA_ZE_PT' || s.Linea__c == 'DOC_LINEA_NORMAL_PT')
                    this.mapQuotes.get(strTarifa).get(strRangeDest).blnZP   = true;
                if(!this.listFee.contains(strTarifa))
                    this.listFee.add(strTarifa);
                if(!this.listRangeDestiny.contains(strRangeDest))
                    this.listRangeDestiny.add(strRangeDest);
            }
            //System.debug('mapa: ' + this.mapQuotes.get('T6').get('PBC'));
            for(String keyFee : this.listFee){
                for(String keyRange : this.listRangeDestiny){
                    //Inicia proceso de recotización
                    if(this.mapRangeByDest.containsKey(keyRange)){
                        decFlete                                                            = this.wp.mapTarifarioT.get(this.mapTarifas.get(keyFee)).get(this.mapRangeByDest.get(keyRange)).Flete__c;
                    } else {
                        decFlete                                                            = this.wp.mapTarifarioT.get(this.mapTarifas.get(keyFee)).get(keyRange).Flete__c;
                    }
                    decRAD                                                                  = decFlete * (ObjCostos.EAD__c / 100);
                    decEAD                                                                  = decFlete * (ObjCostos.EAD__c / 100);
                    this.mapQuotes.get(keyFee).get(keyRange).decTarifaLlena             = decFlete + decRAD + decEAD;
                    this.mapQuotes.get(keyFee).get(keyRange).decTotalTarifaLlena        = this.mapQuotes.get(keyFee).get(keyRange).bultos * this.mapQuotes.get(keyFee).get(keyRange).decTarifaLlena;
                    this.mapQuotes.get(keyFee).get(keyRange).decTotalTarifaPropuesta    = this.mapFlete.get(this.mapTarifas.get(keyFee)).get(keyRange) * this.mapQuotes.get(keyFee).get(keyRange).bultos;
                }
            }
        } catch(Exception ex){
            System.debug('Error en execute BatchSeguimientoODC2: ' + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    global void finish(Database.BatchableContext bc){
        try{
            //Crear registros de Frecuencia real
            List<FrecuenciaDeEnvios__c> borrar2 = new List<FrecuenciaDeEnvios__c>();
            borrar2 = [SELECT Id, Cuenta__c, Tipo__c, RecordType.Name FROM FrecuenciaDeEnvios__c WHERE Cuenta__c =: AccId AND Tipo__c = 'DOC_LINEA' AND RecordType.Name = 'Frecuencia Real'];
            Id tipo = [SELECT Id, Name FROM RecordType WHERE Name = 'Frecuencia Real'].Id;
            for(String keyFee : this.listFee){
                for(String keyRange : this.listRangeDestiny){
                    if(this.mapQuotes.containsKey(keyFee) && this.mapQuotes.get(keyFee).containsKey(keyRange)){
                        if(this.mapQuotes.get(keyFee).get(keyRange).bultos > 0){
                            FrecuenciaDeEnvios__c fr = new FrecuenciaDeEnvios__c();
                            fr.Cuenta__c = AccId;
                            fr.RecordTypeId = tipo;
                            fr.Tipo__c = 'DOC_LINEA';
                            fr.Rango__c = keyRange;
                            fr.Tarifa__c = keyFee;
                            fr.Bultos__c = mapQuotes.get(keyFee).get(keyRange).bultos;
                            fr.Peso__c = mapQuotes.get(keyFee).get(keyRange).decPeso;
                            fr.Volumen__c = mapQuotes.get(keyFee).get(keyRange).decVolumen;
                            fr.Zona_Plus__c = mapQuotes.get(keyFee).get(keyRange).blnZP;
                            fr.Total_tarifa_llena__c = mapQuotes.get(keyFee).get(keyRange).decTotalTarifaLlena;
                            fr.Total_propuesta__c = mapQuotes.get(keyFee).get(keyRange).decTotalTarifaPropuesta;
                            insertFrecuencias.add(fr);
                        }
                    }
                }
            }
            if(insertFrecuencias.size()>0){
            	if(borrar2.size()>0) {
                    for(Database.DeleteResult delRes : Database.delete(borrar2, false)){
                        if(!delRes.isSuccess()){
                            for(Database.Error errDel: delRes.getErrors())
                                System.debug('Error eliminando frecuencia de envíos frecuencia real: ' + errDel.getMessage());
                        }
                    }
                }
            	for(Database.SaveResult resDeducUPD : Database.insert(this.insertFrecuencias, false)){
                    if(!resDeducUPD.isSuccess()){
                        for(Database.Error insError: resDeducUPD.getErrors())
                            System.debug('Error al guardar datos de partidas de cotización BatchSeguimientoODC2: ' + insError.getMessage());
                    }
                }
        	}
            User U = [SELECT Id, Email  FROM User WHERE Id = :System.UserInfo.getUserId()];
            String strLink = 'https://paquetexpress--qa2020.lightning.force.com/lightning/r/Account/'+AccId+'/view'; //Link temporal para pruebas
            List<string> toAddress = new List<string>{U.Email};
            String strTemplate = '<hr color="purple" Style="border:15px;"/><br><br>Se le notifica que el procesamiento del reporte seguimiento al descuento real ha terminado. <br/> Para más resultados <a href="'+ strLink +'"><span style="color:#0066FF" wfd-id="2">click aquí</span>.<br><br><hr color="purple" Style="border:15px;"/>';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            //mail.setTemplateId(et.Id);
            mail.setToAddresses(toAddress);
            mail.setSubject('Seguimiento al descuento real Prepago');
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
            System.debug('Error en finish BatchSeguimientoODC2: ' + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public static String getTarifa(String tarifa, String Linea, String Destino){
        String result = '';
        if(tarifa != ''){
            if(Linea == 'DOC_LINEA_ZE'){
                result = tarifa + ' ZP';
            } else if(Linea == 'DOC_LINEA_ZE_PT'){
                result = tarifa + ' ZP ' + Destino;
            } else if(Linea == 'DOC_LINEA_NORMAL_PT'){
                result = tarifa + ' ' + Destino;
            } else {
                result = tarifa;
            }
        }
        return result;
    }
    public static Decimal getPeso(String tarifa){
        if(!tarifa.contains('T7') || !tarifa.contains('DS') || !tarifa.contains('DS') || !tarifa.contains('2DS') || !tarifa.contains('A12')){
            if(tarifa.contains('TS'))
                return 1.00;
            else if(tarifa.contains('T0'))
                return 5.00;
            else if(tarifa.contains('T1'))
                return 10.00;
            else if(tarifa.contains('T2'))
                return 20.00;
            else if(tarifa.contains('T3'))
                return 30.00;
            else if(tarifa.contains('T4'))
                return 40.00;
            else if(tarifa.contains('T5'))
                return 50.00;
            else if(tarifa.contains('T6'))
                return 60.00;
            else return 0.00;
        } else return 0.00;
    }
    public static Decimal getVolumen(String tarifa){
        if(!tarifa.contains('T7') || !tarifa.contains('DS') || !tarifa.contains('DS') || !tarifa.contains('2DS') || !tarifa.contains('A12')){
            if(tarifa.contains('TS'))
                return 0.0001;
            else if(tarifa.contains('T0'))
                return 0.010;
            else if(tarifa.contains('T1'))
                return 0.023;
            else if(tarifa.contains('T2'))
                return 0.048;
            else if(tarifa.contains('T3'))
                return 0.075;
            else if(tarifa.contains('T4'))
                return 0.144;
            else if(tarifa.contains('T5'))
                return 0.245;
            else if(tarifa.contains('T6'))
                return 0.320;
            else return 0.00;
        } else return 0.00;
    }
    public static String ObtieneRangoKM(String rango){
        if(rango == '0-400')
            return '0000-0400';
        else if(rango == '401-800')
            return '0401-0800';
        else if(rango == '801-1200')
            return '0801-1200';
        else if(rango == '1201-1600')
            return '1201-1600';
        else if(rango == '1601-2000')
            return '1601-2000';
        else if(rango == '2001-2400')
            return '2001-2400';
        else if(rango == 'Más de 2400' || rango == '+2400')
            return '2401-9999';
        else if(rango == '0000-0400')
            return '0-400';
        else if(rango == '0401-0800')
            return '401-800';
        else if(rango == '0801-1200')
            return '801-1200';
        else if(rango == '2401-9999')
            return 'Más de 2400';
        else return '';
    }
    public static List<Tarifario_general_terrestre__c> queryTarifarioTFull(){
        return [SELECT  Id
        , Tarifa__c
        , Flete__c
        , Name
        , PesoMaximo__c
        , VolumenMaximo__c
        , RangoKM__c
        FROM Tarifario_general_terrestre__c WHERE Year__c = null];
    }
    public static List<SBQQ__QuoteLine__c> queryQuoteItem(String strQuoteId){
        return [SELECT Id
        , SBQQ__Quantity__c
        , SBQQ__CustomerTotal__c
        , Pack_Seg__c
        , DiscountAcuse__c
        , DiscountFlete__c
        , DiscountRecolection__c
        , DiscountDelivery__c
        , DiscountSeg__c
        , DiscountGuia__c
        , Servicio__c
        , PackWeightAVG__c
        , PackVolAVG__c
        , SBQQ__Discount__c
        , SBQQ__CustomerPrice__c
        , SBQQ__NetPrice__c
        , SBQQ__NetTotal__c
        , QuoteTotal__c
        , MAN__c
        , EDC__c
        , EDD__c
        , CRF__c
        , ACK__c
        , EAD__c
        , RAD__c
        , SEG__c
        , Tarifa__c
        , Width__c
        , Weight__c
        , Large__c
        , High__c
        , Vol__c
        , VolWeight__c
        , Rango_KM__c
        , ZonaPlus__c
        , SBQQ__VolumeDiscount__c
        , SBQQ__SpecialPrice__c
        , Destiny__c
        , GUIA__c
        , KG_ADICIONAL__c
        , FLETE__c
        , DiscKgAditional__c
        , SBQQ__Description__c
        FROM SBQQ__QuoteLine__c
        WHERE SBQQ__Quote__c =: strQuoteId];
    }
    public static List<AcusePorGuia__mdt> queryACK(){
        List<AcusePorGuia__mdt> listACK = new List<AcusePorGuia__mdt>();
        try {
            listACK = [SELECT Id, Label, Amount__c FROM AcusePorGuia__mdt];
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage() + ' caused by: ' + ex.getCause());
        }
        return listACK;
    }
    public class wpFrecuencias{
        Decimal bultos;
        Decimal decPeso;
        Decimal decVolumen;
        Decimal decTarifaLlena;
        Decimal decTarifaPropuesta;
        Decimal decTotalTarifaLlena;
        Decimal decTotalTarifaPropuesta;
        Boolean blnZP;
        public wpFrecuencias(){
            this.bultos                     = 0;
            this.decPeso                    = 0;
            this.decVolumen                 = 0;
            this.decTarifaLlena             = 0;
            this.decTarifaPropuesta         = 0;
            this.decTotalTarifaLlena        = 0;
            this.decTotalTarifaPropuesta    = 0;
            this.blnZP                      = false;
        }
    }
    public class Wrapper{
        public Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT       {get; set;}
        public Map<String, Decimal> mapACK                                                  {get; set;}
        public List<SBQQ__QuoteLine__c> listQuoteItem                                       {get; set;}
        public Wrapper (){
            this.mapTarifarioT      = new Map<String, Map<String, Tarifario_general_terrestre__c>>();
            this.mapACK             = new Map<String, Decimal>();
            this.listQuoteItem      = new List<SBQQ__QuoteLine__c>();
        }
    }
}
