/*Created by: Salvador Ramírez López 24/02/2021*/
/*Batch para generación de datos de seguimiento al descuento real de costo base más excedente. Estos datos son en base a las cotizaciones.*/
global class BatchSeguimientoCBME implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful{
    public List<SBQQ__Quote__c> objQuote                                            = new list<SBQQ__Quote__c>();
    public String Query                                                             = '';
    public String AccId                                                             = '';
    public List<Descuento_Real_SipWeb__c> insertDescuentos                          = new List<Descuento_Real_SipWeb__c>();
    public List<String> listIds                                                     = new List<String>();
    public List<String> listBloquesCargados                                         = new List<String>();
    list<SBQQ__QuoteLine__c> listQL                                                 = new list<SBQQ__QuoteLine__c>();
    public Map<String, Map<String, Map<Decimal, wpCotizaciones>>> mapCotizaciones   = new Map<String, Map<String, Map<Decimal, wpCotizaciones>>>();
    public Map<String, Map<String, Map<Decimal, wpCotizaciones>>> mapCotizacionesZP = new Map<String, Map<String, Map<Decimal, wpCotizaciones>>>();
    public Map<String, SBQQ__QuoteLine__c> mapQuotes                                = new Map<String, SBQQ__QuoteLine__c>();
    public Map<String, String> mapIdCotizacion                                      = new Map<String, String>();
    public BatchSeguimientoCBME(String AccountId, String Inicio, String Fin) {
        try{
            Query = 'SELECT Id, Name, Servicios_adicionales__c, Fecha_de_autorizada__c FROM SBQQ__Quote__c WHERE (SBQQ__Account__c = \'' + AccId + '\' OR SBQQ__Account__r.ParentId = \'' + AccId + '\') ' +
            + 'AND Fecha_de_autorizada__c >= '+Inicio+' and Fecha_de_autorizada__c <= '+Fin+' AND SBQQ__Status__c = \'Approved\'';
        } catch (Exception ex){
            System.debug('escribir mensaje de error');
        }
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(this.Query);	
    }
    global void execute(Database.BatchableContext bc, List<SBQQ__Quote__c> records) {
        try{
            String strId = '';
            for(SBQQ__Quote__c objQuote : records){
                SBQQ__QuoteLine__c objCot = [SELECT Id, ZonaPlus__c, PackWeightAVG__c, PackVolAVG__c, Tarifa__c, SBQQ__Quantity__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :objQuote.Id];
                listQL.add(objCot);
                /*Descuento_Real_SipWeb__c des    = new Descuento_Real_SipWeb__c();
                des.Cotizaci_n__c               = objQuote.Name;
                des.Fecha_de_Aprobaci_n__c      = objQuote.Fecha_de_autorizada__c;
                des.Servicio__c                 = objQuote.Servicios_adicionales__c;*/
                strId = objQuote.Id;
                if(!this.listIds.contains(objQuote.Id))
                    this.listIds.add(objQuote.Id);
                if(!this.mapQuotes.containsKey(strId))
                    this.mapQuotes.put(strId, objCot);
                if(!this.mapIdCotizacion.containsKey(objQuote.Id))
                    this.mapIdCotizacion.put(objQuote.Id, objQuote.Name);
                Integer intBultos = 0;
                for(SBQQ__QuoteLine__c objQLine : listQL){
                    if(!(objQline.Tarifa__c == 'TARIFA T7' && objQline.ZonaPlus__c)){
                        String strKey1 = '';
                        if(!objQline.ZonaPlus__c && objQline.Destiny__c == null){
                            strKey1 = 'ESTÁNDAR PXS';
                        } else if (objQline.ZonaPlus__c && objQline.Destiny__c == null) {
                            strKey1 = 'ESTÁNDAR, ZP';
                        } else if (objQline.Destiny__c != null){
                            strKey1 = 'ESTÁNDAR ' + objQline.Destiny__c;
                        }
                        if(!this.mapCotizaciones.containsKey(strKey1))
                            this.mapCotizaciones.put(strKey1, new Map<String, Map<Decimal, wpCotizaciones>>());
                        if(!this.mapCotizaciones.get(strKey1).containsKey(objQuote.Id))
                            this.mapCotizaciones.get(strKey1).put(objQuote.Id, new Map<Decimal, wpCotizaciones>());
                        if(!this.mapCotizaciones.get(strKey1).get(objQuote.Id).containsKey(objQline.PackWeightAVG__c)){
                            this.mapCotizaciones.get(strKey1).get(objQuote.Id).put(objQline.PackWeightAVG__c, new  wpCotizaciones(objQline.PackVolAVG__c, objQline.PackWeightAVG__c, objQline.PackWeightAVG__c));
                        } else {
                            this.mapCotizaciones.get(strKey1).get(strId).get(objQline.PackWeightAVG__c).intBultos += objQline.PackWeightAVG__c;
                        }
                    }
                }
            }
            for(SBQQ__Quote__c objQuote : records){
                for(SBQQ__QuoteLine__c objQLine : listQL){
                    Descuento_Real_SipWeb__c des    = new Descuento_Real_SipWeb__c();
                    des.Servicio__c                 = 'ESTÁNDAR PXS';
                    des.Cotizaci_n__c               = objQuote.Name;
                    des.Fecha_de_Aprobaci_n__c      = objQuote.Fecha_de_autorizada__c;
                    des.Servicio__c                 = objQuote.Servicios_adicionales__c;
                    des.bultos__c                   = this.mapCotizaciones.get('ESTÁNDAR PXS').get(objQuote.Id).get(objQLine.PackWeightAVG__c).intBultos;
                    des.Peso__c                     = objQLine.PackWeightAVG__c;
                    des.Volumen__c                  = this.mapCotizaciones.get('ESTÁNDAR PXS').get(objQuote.Id).get(objQLine.PackWeightAVG__c).decVolPromedio;
                    des.PesoVol__c                  = this.mapCotizaciones.get('ESTÁNDAR PXS').get(objQuote.Id).get(objQLine.PackWeightAVG__c).decPesoVolumetrico;
                    //des.TotalLlena__c                  = 
                }
            }
        } catch(Exception ex){
            System.debug('mensaje de error');
        }
    }
    global void finish(Database.BatchableContext bc) {

    }
    public class wpCotizaciones {
        public Decimal decVolPromedio;
        public Decimal intBultos;
        public Decimal decPesoVolumetrico;
        public wpCotizaciones (){
            this.decVolPromedio     = 0;
            this.intBultos          = 0;
            this.decPesoVolumetrico = 0;
        }
        public wpCotizaciones(Decimal volPromedio, Decimal bultos, Decimal PesoVol){
            this.decVolPromedio     = volPromedio;
            this.intBultos          = bultos;
            this.decPesoVolumetrico = PesoVol;
        }
    }
}
