/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-21-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-20-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global class BatchSeguimientoCBME3 implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    public String query;
    public String AccId;
    public String strIdQuote;
    public Boolean blnRAD                                                           = false;
    public Boolean blnEAD                                                           = false;
    public Boolean blnACK                                                           = false;
    public Map<String, wpFrecuencias> mapFrecuencias                                = new Map<String, wpFrecuencias>();
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes                   = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public Wrapper wp                                                               = new Wrapper();
    public Map<String, Decimal> mapAcuse                                            = new Map<String, Decimal>();
    public List<String> listRangeDestiny                                            = new List<String>();
    public List<Decimal> listBloques                                                = new list<Decimal>();
    public Map<String, Decimal> mapFlete                                            = new Map<String, Decimal>();
    public List<FrecuenciaDeEnvios__c> insertarF                                    = new List<FrecuenciaDeEnvios__c>();

    public BatchSeguimientoCBME3(String AccountId, String Inicio, String Fin, String strQuote, Boolean RAD, Boolean EAD, Boolean ACK, Map<String, Decimal> mapAc) {
        AccId = AccountId;
        this.strIdQuote = strQuote;
        this.blnRAD = RAD;
        this.blnEAD = EAD;
        this.blnACK = ACK;
        //this.mapAcuse = mapAc;
        query = 'SELECT Id, Cuenta__c, Cuenta__r.ParentId, Fecha__c, Linea__c, Rango_Kms__c, Peso_de_bultos__c, Tarifa_de_Bulto__c, ' +
            	'Bultos__c, Volumen_de_bultos__c, Servicio__c FROM Seguimiento_de_descuento_real__c ' +
            	'WHERE (Cuenta__c = \'' + AccountId + '\' OR Cuenta__r.ParentId = \'' + AccountId + '\') ' +
            	' AND Fecha__c >= ' + Inicio + ' AND Fecha__c <= ' + Fin +
            	' AND Servicio__c = \'STD-T\' AND Linea__c = \'DOC_LINEA_NORMAL\'';
    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        system.debug(query);
    	return Database.getQueryLocator(query);	
    }
    global void execute(Database.BatchableContext bc, List<Seguimiento_de_descuento_real__c> records){
        for(Tarifario_general_terrestre__c objTarifarioT: queryTarifarioTFull())
            if(!wp.mapTarifarioT.containsKey(objTarifarioT.Tarifa__c))
                wp.mapTarifarioT.put(objTarifarioT.Tarifa__c, new Map<String, Tarifario_general_terrestre__c>{objTarifarioT.RangoKM__c => objTarifarioT});
            else if (!wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).containsKey(objTarifarioT.RangoKM__c))
                wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).put(objTarifarioT.RangoKM__c, objTarifarioT);
        for (AcusePorGuia__mdt objACK : queryACK())
            wp.mapACK.put(objACK.Label, objACK.Amount__c);
        this.wp.listQuoteItem = queryQuoteItem(this.strIdQuote); //30/03/2021 Salvador (sramirez@freewayconsulting.com): se consultan los costos de flete por rango de km o  destino
        String strRangeDest;
        for(SBQQ__QuoteLine__c QL : this.wp.listQuoteItem){
            strRangeDest = '';
            if(QL.Destiny__c != null)
                strRangeDest = QL.Destiny__c.remove(' (' + QL.Rango_KM__c + ')');
            else strRangeDest = QL.Rango_KM__c;
            if(!this.mapFlete.containsKey(strRangeDest))
                this.mapFlete.put(strRangeDest, QL.Flete__c);
            if(this.blnACK){
                if(!this.mapAcuse.containsKey(strRangeDest))
                    this.mapAcuse.put(strRangeDest, QL.ACK__c);
            }
            if(!this.listRangeDestiny.contains(strRangeDest))
                this.listRangeDestiny.add(strRangeDest);
        }
        Decimal tarLlena;
        Decimal decPropuesta;
        String strTarifa;
        for (Seguimiento_de_descuento_real__c s: records){
            //29/03/2021 Salvador (sramirez@freewayconsulting.com): Recorrido para llenar todas las cantidades de frecuencias
            if(!mapFrecuencias.containsKey(s.Peso_de_bultos__c)){
                this.mapFrecuencias.put(s.Peso_de_bultos__c, new wpFrecuencias());
                this.mapFrecuencias.get(s.Peso_de_bultos__c).bultos = Decimal.valueOf(s.Bultos__c);
                this.mapFrecuencias.get(s.Peso_de_bultos__c).decPeso = Decimal.valueOf(s.Peso_de_bultos__c);
                this.mapFrecuencias.get(s.Peso_de_bultos__c).decVolumen = Decimal.valueOf(s.Volumen_de_bultos__c);
                this.mapFrecuencias.get(s.Peso_de_bultos__c).decPesoVol = Decimal.valueOf(s.Volumen_de_bultos__c) * 200;
            } else {
                this.mapFrecuencias.get(s.Peso_de_bultos__c).bultos += Decimal.valueOf(s.Bultos__c);
            }
            if(!this.listBloques.contains(Decimal.valueOf(s.Peso_de_bultos__c)))
                this.listBloques.add(Decimal.valueOf(s.Peso_de_bultos__c));
        }
        for (Seguimiento_de_descuento_real__c s: records){
            //29/03/2021 Salvador (sramirez@freewayconsulting.com): Recorrido para recotizar los montos pero ahora de las frecuencias reales obtenidas del ws
            tarLlena = 0;
            decPropuesta = 0;
            strRangeDest = '';
            if(s.Tarifa_de_Bulto__c == 'T7')
                strTarifa = 'TARIFA T7P';
            else if(s.Tarifa_de_Bulto__c == 'TS')
                strTarifa = 'TARIFA SOBRE';
            else strTarifa = 'TARIFA ' + s.Tarifa_de_Bulto__c;
            tarLlena = wp.mapTarifarioT.get(strTarifa).get(ObtieneRangoKM(s.Rango_Kms__c)).Flete__c;
            if(this.blnRAD)
                tarLlena += wp.mapTarifarioT.get(strTarifa).get(ObtieneRangoKM(s.Rango_Kms__c)).Flete__c * 0.11;
            if(this.blnEAD)
                tarLlena += wp.mapTarifarioT.get(strTarifa).get(ObtieneRangoKM(s.Rango_Kms__c)).Flete__c * 0.11;
            if(this.blnACK){
                tarLlena += wp.mapACK.get(ObtieneRangoKM(s.Rango_Kms__c));
            }
            if(s.Site_Destino__c != 'ALL')
                strRangeDest = s.Site_Destino__c;
            else strRangeDest = ObtieneRangoKM(s.Rango_Kms__c);
            decPropuesta = this.mapFlete.get(strRangeDest);
            if(this.blnACK)
                decPropuesta += this.mapAcuse.get(strRangeDest);
            this.mapFrecuencias.get(s.Peso_de_bultos__c).decTotalTarifaLlena += this.mapFrecuencias.get(s.Peso_de_bultos__c).bultos * tarLlena;
            this.mapFrecuencias.get(s.Peso_de_bultos__c).decTotalTarifaPropuesta += decPropuesta;
        }
        for(Decimal decBloque : this.listBloques){
            //29/03/2021 Salvador (sramirez@freewayconsulting.com): Recorridos para obtener los descuentos en base a lo recotizado anteriormente, se recorren todos los bloques ya que se debe obtener por costos finales
            if(this.mapFrecuencias.containsKey(String.ValueOf(decBloque))){
                this.mapFrecuencias.get(String.valueOf(decBloque)).decDescuento = this.mapFrecuencias.get(String.valueOf(decBloque)).decTotalTarifaPropuesta / this.mapFrecuencias.get(String.valueOf(decBloque)).decTotalTarifaLlena - 1;
            }
        }
    }
    global void finish(Database.BatchableContext bc){
        //Al retomar este desarrollo esta nota te va a servir:
        //Es necesario guardar lo que está en mapFrecuencias en el objeto de frecuencias, deben crearse los campos para almacenar los totales y también debe hacerse un mapa que guarde las frecuencias totales.
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
        Decimal decPesoVol;
        Decimal decTotalTarifaLlena;
        Decimal decTotalTarifaPropuesta;
        Decimal decDescuento;
        public wpFrecuencias(){
            this.bultos     = 0;
            this.decPeso    = 0;
            this.decVolumen = 0;
            this.decPesoVol = 0;
            this.decTotalTarifaLlena = 0;
            this.decTotalTarifaPropuesta = 0;
            this.decDescuento = 0;
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
