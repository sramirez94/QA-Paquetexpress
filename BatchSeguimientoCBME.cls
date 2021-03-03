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
    public Map<String, List<SBQQ__QuoteLine__c>> mapQuotes                          = new Map<String, List<SBQQ__QuoteLine__c>>();
    public Map<String, String> mapIdCotizacion                                      = new Map<String, String>();
    public Map<String, Decimal> mapCotizacionesCargadas                             = new Map<String, Decimal>();
    public Map<String, Decimal> mapCotizacionesCargadasZP                           = new Map<String, Decimal>();
    public Wrapper wp                                                               = new Wrapper();
    public BatchSeguimientoCBME(String AccountId, String Inicio, String Fin, String Modelo) {
        try{
            this.AccId = AccountId;
            Query = 'SELECT Id, Name, Servicios_adicionales__c, Fecha_de_autorizada__c FROM SBQQ__Quote__c WHERE (SBQQ__Account__c = \'' + AccountId + '\' OR SBQQ__Account__r.ParentId = \'' + AccountId + '\') ' +
            + 'AND Fecha_de_autorizada__c >= '+Inicio+' and Fecha_de_autorizada__c <= '+Fin+' AND SBQQ__Status__c = \'Approved\' AND Modelo_de_tarifas__c = \'' + Modelo + '\'';
        } catch (Exception ex){
            System.debug('escribir mensaje de error');
        }
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('consulta: '+ query);
        return Database.getQueryLocator(this.Query);	
    }
    global void execute(Database.BatchableContext bc, List<SBQQ__Quote__c> records) {
        try{
            String strId = '';
            for(Tarifario_general_terrestre__c objTarifarioT: queryTarifarioTFull())
                if(!wp.mapTarifarioT.containsKey(objTarifarioT.Tarifa__c))
                    wp.mapTarifarioT.put(objTarifarioT.Tarifa__c, new Map<String, Tarifario_general_terrestre__c>{objTarifarioT.RangoKM__c => objTarifarioT});
                else if (!wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).containsKey(objTarifarioT.RangoKM__c))
                    wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).put(objTarifarioT.RangoKM__c, objTarifarioT);
            for(SBQQ__Quote__c objQuote : records){
                /*for(SBQQ__QuoteLine__c objCot : [SELECT Id, ZonaPlus__c, PackWeightAVG__c, PackVolAVG__c, Tarifa__c, SBQQ__Quantity__c, Destiny__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :objQuote.Id]){
                    if(objCot.SBQQ__Quantity__c != 0)
                    listQL.add(objCot);
                }*/
                strId = objQuote.Id;
                if(!this.listIds.contains(objQuote.Id))
                    this.listIds.add(objQuote.Id);
                if(!this.mapIdCotizacion.containsKey(objQuote.Id))
                    this.mapIdCotizacion.put(objQuote.Id, objQuote.Name);
                Decimal tarLlena;
                String strTarifa = '';
                for(SBQQ__QuoteLine__c objQLine : [SELECT Id, ZonaPlus__c, PackWeightAVG__c, PackVolAVG__c, Tarifa__c, SBQQ__Quantity__c, Rango_KM__c, Destiny__c, Flete__c, RAD__c, EAD__c, ACK__C FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :objQuote.Id]){
                    if(objQline.SBQQ__Quantity__c != 0){
                        if(!(objQline.Tarifa__c == 'TARIFA T7' && objQline.ZonaPlus__c)){
                            tarLlena = 0;
                            String strKey1 = '';
                            strTarifa = '';
                            if(!objQline.ZonaPlus__c && objQline.Destiny__c == null){
                                strKey1 = 'ESTÁNDAR PXS';
                            } else if (objQline.ZonaPlus__c && objQline.Destiny__c == null) {
                                strKey1 = 'ESTÁNDAR, ZP';
                            } else if (objQline.Destiny__c != null && !objQline.ZonaPlus__c){
                                strKey1 = 'ESTÁNDAR ' + objQline.Destiny__c;
                            }
                            if(objQline.Tarifa__c == 'TARIFA SOBRE')
                                strTarifa = 'TARIFA TS';
                            else strTarifa = objQline.Tarifa__c;
                            tarLlena = this.wp.mapTarifarioT.get(strTarifa).get(objQline.Rango_KM__c).Flete__c;
                            if(objQline.RAD__c != null)
                                tarLlena += objQline.RAD__c;
                            if(objQline.EAD__c != null)
                                tarLlena += objQline.EAD__c;
                            if(objQline.ACK__c != null)
                                tarLlena += objQline.ACK__c;
                            if(!objQline.ZonaPlus__c){
                                if(!this.mapCotizaciones.containsKey(strKey1))
                                    this.mapCotizaciones.put(strKey1, new Map<String, Map<Decimal, wpCotizaciones>>());
                                if(!this.mapCotizaciones.get(strKey1).containsKey(objQuote.Id))
                                    this.mapCotizaciones.get(strKey1).put(objQuote.Id, new Map<Decimal, wpCotizaciones>());
                                if(!this.mapCotizaciones.get(strKey1).get(objQuote.Id).containsKey(objQline.PackWeightAVG__c)){
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).put(objQline.PackWeightAVG__c, new  wpCotizaciones());
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).intBultos                 = objQline.PackWeightAVG__c;
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decVolPromedio            = objQline.PackVolAVG__c;
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decPesoVolumetrico        = objQline.PackVolAVG__c;
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTarifaLlena            = tarLlena;
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTotalTarifaLlena       = (objQline.SBQQ__Quantity__c * tarLlena);
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTotalTarifaPropuesta   = (tarLlena * objQline.Flete__c);
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decDescuento              = (this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTotalTarifaPropuesta / this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTotalTarifaLlena) - 1;
                                } else {
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).intBultos                 += objQline.PackWeightAVG__c;
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTarifaLlena            += tarLlena;
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTotalTarifaLlena       += (objQline.SBQQ__Quantity__c * tarLlena);
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTotalTarifaPropuesta   += (tarLlena * objQline.Flete__c);
                                    this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decDescuento              = (this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTotalTarifaPropuesta / this.mapCotizaciones.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decTotalTarifaLlena) - 1;
                                }
                            } else if(objQline.ZonaPlus__c && objQline.Tarifa__c != 'TARIFA T7'){
                                if(!this.mapCotizacionesZP.containsKey(strKey1))
                                    this.mapCotizacionesZP.put(strKey1, new Map<String, Map<Decimal, wpCotizaciones>>());
                                if(!this.mapCotizacionesZP.get(strKey1).containsKey(objQuote.Id))
                                    this.mapCotizacionesZP.get(strKey1).put(objQuote.Id, new Map<Decimal, wpCotizaciones>());
                                if(!this.mapCotizacionesZP.get(strKey1).get(objQuote.Id).containsKey(objQline.PackWeightAVG__c)){
                                    this.mapCotizacionesZP.get(strKey1).get(objQuote.Id).put(objQline.PackWeightAVG__c, new  wpCotizaciones());
                                    this.mapCotizacionesZP.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).intBultos           = objQline.PackWeightAVG__c;
                                    this.mapCotizacionesZP.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decVolPromedio      = objQline.PackVolAVG__c;
                                    this.mapCotizacionesZP.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).decPesoVolumetrico  = objQline.PackVolAVG__c;
                                } else {
                                    this.mapCotizacionesZP.get(strKey1).get(objQuote.Id).get(objQline.PackWeightAVG__c).intBultos += objQline.PackWeightAVG__c;
                                }
                            }
    
                        }
                    }
                }
            }
            String strKey = '';
            System.debug('grabar: ' + this.mapCotizacionesZP.get('ESTÁNDAR, ZP'));
            for(SBQQ__Quote__c objQuote : records){
                for(SBQQ__QuoteLine__c objQLine : [SELECT Id, ZonaPlus__c, PackWeightAVG__c, PackVolAVG__c, Tarifa__c, SBQQ__Quantity__c, Rango_KM__c, Destiny__c, Flete__c, RAD__c, EAD__c, ACK__C FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :objQuote.Id]){
                    if(objQline.SBQQ__Quantity__c != 0){
                        if(!objQLine.ZonaPlus__c){
                            if(this.mapCotizacionesCargadas.get(objQuote.Name) != objQline.PackWeightAVG__c){
                                strKey = '';
                                if(objQline.Destiny__c != null)
                                    strKey = 'ESTÁNDAR ' + objQline.Destiny__c;
                                else strKey = 'ESTÁNDAR PXS';
                                Descuento_Real_SipWeb__c des    = new Descuento_Real_SipWeb__c();
                                des.Servicio__c                 = strKey;
                                des.Cotizaci_n__c               = objQuote.Name;
                                des.Fecha_de_Aprobaci_n__c      = objQuote.Fecha_de_autorizada__c;
                                des.Servicios__c                = objQuote.Servicios_adicionales__c;
                                des.bultos__c                   = this.mapCotizaciones.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).intBultos;
                                des.Peso__c                     = objQLine.PackWeightAVG__c;
                                des.Volumen__c                  = this.mapCotizaciones.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decVolPromedio;
                                des.PesoVol__c                  = this.mapCotizaciones.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decPesoVolumetrico;
                                des.Cuenta__c                   = this.AccId;
                                des.TotalLlena__c               = this.mapCotizaciones.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decTotalTarifaLlena;
                                des.TotalPropuesta__c           = this.mapCotizaciones.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decTotalTarifaPropuesta;
                                des.Descuento__c                = this.mapCotizaciones.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decDescuento;
                                insertDescuentos.add(des);
                                this.mapCotizacionesCargadas.put(objQuote.Name, objQLine.PackWeightAVG__c);
                            }
                        } else if(objQline.ZonaPlus__c && objQline.Tarifa__c != 'TARIFA T7'){
                            if(this.mapCotizacionesCargadasZP.get(objQuote.Name) != objQline.PackWeightAVG__c){
                                strKey = '';
                                strKey = 'ESTÁNDAR, ZP';
                                Descuento_Real_SipWeb__c des    = new Descuento_Real_SipWeb__c();
                                des.Servicio__c                 = strKey;
                                des.Cotizaci_n__c               = objQuote.Name;
                                des.Fecha_de_Aprobaci_n__c      = objQuote.Fecha_de_autorizada__c;
                                des.Servicios__c                = objQuote.Servicios_adicionales__c;
                                des.bultos__c                   = this.mapCotizacionesZP.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).intBultos;
                                des.Peso__c                     = objQLine.PackWeightAVG__c;
                                des.Volumen__c                  = this.mapCotizacionesZP.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decVolPromedio;
                                des.PesoVol__c                  = this.mapCotizacionesZP.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decPesoVolumetrico;
                                des.TotalLlena__c               = this.mapCotizacionesZP.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decTotalTarifaLlena;
                                des.TotalPropuesta__c           = this.mapCotizacionesZP.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decTotalTarifaPropuesta;
                                des.Descuento__c                = this.mapCotizacionesZP.get(strKey).get(objQuote.Id).get(objQLine.PackWeightAVG__c).decDescuento;
                                des.Cuenta__c                   = this.AccId;
    
                                insertDescuentos.add(des);
                                this.mapCotizacionesCargadasZP.put(objQuote.Name, objQLine.PackWeightAVG__c);
                            }
                        }
                    }
                    //des.TotalLlena__c                  = 
                }
            }

        } catch(Exception ex){
            System.debug('execute: ' + + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    global void finish(Database.BatchableContext bc) {
        for(Database.SaveResult resDeducUPD : Database.insert(this.insertDescuentos, false)){
            if(resDeducUPD.isSuccess())
                System.debug('Se guardaron correctamente los cambios.');
            else {
                for(Database.Error insError: resDeducUPD.getErrors())
                    System.debug('Error al guardar datos de partidas de cotización: ' + insError.getMessage());
            }
        }
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
    public class wpCotizaciones {
        public Decimal decVolPromedio;
        public Decimal intBultos;
        public Decimal decPesoVolumetrico;
        public Decimal decTarifaLlena;
        public Decimal decTotalTarifaLlena;
        public Decimal decTotalTarifaPropuesta;
        public Decimal decDescuento;
        public wpCotizaciones (){
            this.decVolPromedio             = 0;
            this.intBultos                  = 0;
            this.decPesoVolumetrico         = 0;
            this.decTarifaLlena             = 0;
            this.decTotalTarifaLlena        = 0;
            this.decTotalTarifaPropuesta    = 0;
            this.decDescuento               = 0;
        }
        public wpCotizaciones(Decimal volPromedio, Decimal bultos, Decimal PesoVol, Decimal TarLlena){
            this.decVolPromedio     = volPromedio;
            this.intBultos          = bultos;
            this.decPesoVolumetrico = PesoVol;
            this.decTarifaLlena     = TarLlena;
        }
    }
    public class Wrapper{
        public Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT       {get; set;}
        public Wrapper (){
            this.mapTarifarioT      = new Map<String, Map<String, Tarifario_general_terrestre__c>>();
        }
    }
}
