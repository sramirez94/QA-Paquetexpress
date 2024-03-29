/**
 * @description       : 
 * @author            : msalinas@freewayconsulting.com
 * @group             : 
 * @last modified on  : 07-14-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   12-15-2021   msalinas@freewayconsulting.com   	  Initial Version
**/
global class BatchSeguimiento3b implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    //Variables tipo String
    public String query;
    public String AccId;
    public String strIdQuote;
    public String strtipoAcuse;
    //Variables tipo Decimal
    public Decimal bultos;
    public Date dtInicio;
    public Date dtFin;
    public Wrapper wp                                                               = new Wrapper();
    //Variables tipo Boolean
    public Boolean blnEAD                                                           = false;
    public Boolean blnRAD                                                           = false;
    public Boolean blnACK                                                           = false;
    public Boolean blnSEG                                                           = false;
    //Objetos de mapas
    public Map<String, Map<String, SBQQ__QuoteLine__c>> quotes                      = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapTarifas                  = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapTarifasZP                = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public Map<String, wpFrecuencias> mapFrecuencias                                = new Map<String, wpFrecuencias>();
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes                   = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public Map<String, Decimal> mapAcuse                                            = new Map<String, Decimal>();
    public Map<String, Decimal> mapFlete                                            = new Map<String, Decimal>();
    //Listas de sObjects y de variables
    public List<Frecuencia_real_envio__c> listFrec                                  = new List<Frecuencia_real_envio__c>();
    public List<SBQQ__QuoteLine__c> theQuotes	                                    = new List<SBQQ__QuoteLine__c>();
    public List<FrecuenciaDeEnvios__c> insertFrecuencias                            = new List<FrecuenciaDeEnvios__c>();
    public List<String> listRangeDestiny                                            = new List<String>();
    public List<Decimal> listBloques                                                = new list<Decimal>();
    public List<String> listRange                                                   = new List<String> {'0-400', '401-800', '801-1200', '1201-1600', '1601-2000', '2001-2400', 'Más de 2400'};
    public List<String> listFee                                                     = new List<String> {'TS', 'T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7','TS ZP', 'T0 ZP', 'T1 ZP', 'T2 ZP', 'T3 ZP', 'T4 ZP', 'T5 ZP', 'T6 ZP','A12', 'DS', '2DS'};
    
    public BatchSeguimiento3b(String AccountId, String Inicio, String Fin, String quote){
        AccId = AccountId;
        strIdQuote = quote;
        this.dtInicio = Date.valueOf(Inicio);
        this.dtFin = Date.valueOf(Fin);
        for(String Fee:listFee){
            quotes.put(Fee, new Map<String, SBQQ__QuoteLine__c>());
            for(String Range:listRange){
                SBQQ__QuoteLine__c q = new SBQQ__QuoteLine__c();
                q.SBQQ__Quantity__c = 0;
                q.PackWeightAVG__c = 0;
                q.PackVolAVG__c = 0;
                q.SBQQ__CustomerPrice__c = 0;
                q.SBQQ__NetPrice__c = 0;
                quotes.get(Fee).put(Range, q);
            }
        }
        
        query = 'SELECT Id, Cuenta__c, Cuenta__r.ParentId, Fecha__c, Linea__c, Rango_Kms__c, Peso_de_bultos__c, Tarifa_de_Bulto__c, ' +
            	'Bultos__c, Volumen_de_bultos__c, Servicio__c, Site_Destino__c, Site_Origen__c FROM Seguimiento_de_descuento_real__c ' +
            	'WHERE (Cuenta__c = \'' + AccountId + '\' OR Cuenta__r.ParentId = \'' + AccountId + '\') ' +
            	'AND Fecha__c >= ' + Inicio + ' AND Fecha__c <= ' + Fin +
            	' AND (Linea__c = \'PREPAGO_NORMAL\' OR Linea__c = \'PREPAGO_ZE\') ';
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug(query);
    	return Database.getQueryLocator(query);	
    }
    
    global void execute(Database.BatchableContext bc, List<Seguimiento_de_descuento_real__c> records) {
        Decimal decFlete = 0;
        Decimal decRAD = 0;
        Decimal decEAD = 0;
        Decimal decACK = 0;
        Decimal decSEG = 0;
        Decimal decTarifaLlena = 0;
        Decimal decTotalLlena = 0;
        Decimal decTotalpropuesta = 0;
        String strTarifa = '';
        Cotizador__c ObjCostos = [SELECT EntregaDomicilioZonaPlus__c, SeguroMillarDeclarado__c, IVA__c, EAD__c, RAD__c, CoeficientePV__c, MinEAD__c, MinRAD__c FROM Cotizador__c LIMIT 1];
        try{
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
            //Se consultan las partidas de presupuesto para la cotización más actual
            this.theQuotes = queryQuoteItem(this.AccId, this.dtInicio, this.dtFin);
            //Se definen los servicios para la recotización
            if(this.theQuotes[0].SBQQ__QUOTE__R.Servicios_adicionales__c.contains('RAD'))
                this.blnRAD = true;
            if(this.theQuotes[0].SBQQ__QUOTE__R.Servicios_adicionales__c.contains('EAD'))
                this.blnEAD = true;
            if(this.theQuotes[0].SBQQ__QUOTE__R.Servicios_adicionales__c.contains('Acuse'))
                this.blnACK = true;

            for(SBQQ__QuoteLine__c QL : this.theQuotes){
                if(QL.Tarifa__c == 'TARIFA SOBRE')
                    strTarifa = 'TS';
                else strTarifa = QL.Tarifa__c.remove('TARIFA ');
                if(this.strtipoAcuse == '')
                    this.strtipoAcuse = QL.SBQQ__Quote__r.Acuse__c;
                if(!QL.ZonaPlus__c){
                    if(!this.mapTarifas.containsKey(strTarifa))
                        this.mapTarifas.put(strTarifa, new map<String, SBQQ__QuoteLine__c>( ));
                    if(!this.mapTarifas.get(strTarifa).containsKey(QL.Rango_KM__c))
                        this.mapTarifas.get(strTarifa).put(QL.Rango_KM__c, QL);
                } else {
                    if(!this.mapTarifasZP.containsKey(strTarifa))
                        this.mapTarifasZP.put(strTarifa, new map<String, SBQQ__QuoteLine__c>( ));
                    if(!this.mapTarifasZP.get(strTarifa).containsKey(QL.Rango_KM__c))
                        this.mapTarifasZP.get(strTarifa).put(QL.Rango_KM__c, QL);
                }
            }
            
            //Procesar los bultos
            for (Seguimiento_de_descuento_real__c s: records) {
                //Si los bultos son de servicio estandar:
                if(s.Servicio__c == 'STD-T'){
                    //Si los bultos son de cobertura paquetexpress:
                    if(s.Linea__c == 'PREPAGO_NORMAL'){
                        if(s.Tarifa_de_Bulto__c == 'S' || s.Tarifa_de_Bulto__c == 'TS'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('TS').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('TS').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('TS').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T0'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T0').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T0').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T0').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T1'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T1').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T1').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T1').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T2'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T2').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T2').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T2').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T3'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T3').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T3').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T3').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T4'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T4').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T4').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T4').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T5'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T5').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T5').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T5').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T6'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T6').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T6').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T6').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T7'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T7').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T7').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T7').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                }
                            }
                        }
                    }
                    //Si los bultos son de cobertura extendida (Zona plus)
                    if(s.Linea__c == 'PREPAGO_ZE'){
                        if(s.Tarifa_de_Bulto__c == 'S' || s.Tarifa_de_Bulto__c == 'TS'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('TS ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('TS ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('TS ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('TS ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T0'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T0 ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T0 ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T0 ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('T0 ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T1'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T1 ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T1 ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T1 ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('T1 ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T2'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T2 ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T2 ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T2 ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('T2 ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T3'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T3 ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T3 ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T3 ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('T3 ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T4'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T4 ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T4 ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T4 ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('T4 ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T5'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T5 ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T5 ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T5 ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('T5 ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T6'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T6 ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T6 ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T6 ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('T6 ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        } else if(s.Tarifa_de_Bulto__c == 'T7'){
                            for(String keyRange: listRange){
                                if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                                    quotes.get('T7 ZP').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                                    quotes.get('T7 ZP').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                                    quotes.get('T7 ZP').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                                    quotes.get('T7 ZP').get(keyRange).ZonaPlus__c = true;
                                }
                            }
                        }
                    }
                } else if(s.Servicio__c == 'SEG-A12'){
                    for(String keyRange: listRange){
                    	if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                        	quotes.get('A12').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                            quotes.get('A12').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                            quotes.get('A12').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                        }
                    }
                } else if(s.Servicio__c == 'SEG-DS'){
                    for(String keyRange: listRange){
                    	if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                        	quotes.get('DS').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                            quotes.get('DS').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                            quotes.get('DS').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                        }
                    }
                } else if(s.Servicio__c == 'SEG-2D'){
                    for(String keyRange: listRange){
                    	if(s.Rango_Kms__c == ObtieneRangoKM(keyRange)){
                        	quotes.get('2D').get(keyRange).SBQQ__Quantity__c += Decimal.valueOf(s.Bultos__c);
                            quotes.get('2D').get(keyRange).PackWeightAVG__c += Decimal.valueOf(s.Peso_de_bultos__c);
                            quotes.get('2D').get(keyRange).PackVolAVG__c += Decimal.valueOf(s.Volumen_de_bultos__c);
                        }
                    }
                }
            }
            //Inicia proceso de recotización en base a las cantidades y volumenes recolectados de la frecuencia real.
            for(String keyFee : this.listFee){
                for(String keyRange : this.listRange){
                    decFlete = 0;
                    decRAD = 0;
                    decEAD = 0;
                    decACK = 0;
                    decSEG = 0;
                    decTarifaLlena = 0;
                    if(this.quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c != null &&this.quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0){
                        if(keyFee != 'A12' && keyFee != 'DS' && keyFee != '2D'){
                            decFlete = this.wp.mapTarifarioT.get('TARIFA ' + keyFee).get(keyRange).Flete__c;
                            if(keyFee != 'TS' && keyFee != 'TS ZP'){
                                if(this.blnRAD)
                                    decRAD = decFlete * (ObjCostos.EAD__c / 100);
                                if(this.blnEAD && !this.quotes.get(keyFee).get(keyRange).ZonaPlus__c)
                                    decEAD = decFlete * (ObjCostos.RAD__c / 100);
                            }
                            if(this.blnACK)
                                decACK = this.wp.mapACK.get(this.strtipoAcuse);
                            if(this.quotes.get(keyFee).get(keyRange).ZonaPlus__c)
                                decEAD = ObjCostos.EntregaDomicilioZonaPlus__c;
                            decTarifaLlena = decFlete + decRAD + decEAD + decACK + decSEG;
                            if(this.mapTarifas.containsKey(keyFee) && this.mapTarifas.get(keyFee).containsKey(keyRange)){
                                if(!this.quotes.get(keyFee).get(keyRange).ZonaPlus__c)
                                    decTotalpropuesta = this.mapTarifas.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c * this.quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                                else {
                                    if(this.mapTarifasZP.containsKey(keyFee) && this.mapTarifasZP.get(keyFee).containsKey(keyRange))
                                        decTotalpropuesta = this.mapTarifasZP.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c * this.quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                                    else decTotalpropuesta = ObjCostos.EntregaDomicilioZonaPlus__c * this.quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                                }
                            } else {
                                decTotalpropuesta = decFlete *  this.quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                            }
                            this.quotes.get(keyFee).get(keyRange).SBQQ__NetPrice__c = this.quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c * decTarifaLlena;
                            this.quotes.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c = decTotalpropuesta * this.quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                            this.quotes.get(keyFee).get(keyRange).SBQQ__Discount__c = (this.quotes.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c / this.quotes.get(keyFee).get(keyRange).SBQQ__NetPrice__c) - 1;
                        }
                    }
                }
            }
        } catch(Exception ex){
            System.debug('Error en execute BatchSeguimiento3b: ' + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        try {
        //Crear registros de Frecuencia real
        List<FrecuenciaDeEnvios__c> borrar2 = new List<FrecuenciaDeEnvios__c>();
        borrar2 = [SELECT Id, Cuenta__c, Tipo__c, RecordType.Name
                   FROM FrecuenciaDeEnvios__c
                   WHERE Cuenta__c =: AccId
                   AND Tipo__c = 'Prepago'
                   AND RecordType.Name = 'Frecuencia Real'];
        
            Id tipo = [SELECT Id, Name FROM RecordType WHERE Name = 'Frecuencia Real'].Id;
            
        for(String keyFee: listFee){
            for(String keyRange: listRange){
                FrecuenciaDeEnvios__c fr = new FrecuenciaDeEnvios__c();
                fr.Cuenta__c = AccId;
                fr.RecordTypeId = tipo;
                fr.Tipo__c = 'Prepago';
                fr.Rango__c = keyRange;
                fr.Tarifa__c = keyFee;
                fr.Bultos__c = quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                fr.Peso__c = quotes.get(keyFee).get(keyRange).PackWeightAVG__c;
                fr.Volumen__c = quotes.get(keyFee).get(keyRange).PackVolAVG__c;
                fr.Zona_Plus__c = quotes.get(keyFee).get(keyRange).ZonaPlus__c;
                fr.Total_tarifa_llena__c = quotes.get(keyFee).get(keyRange).SBQQ__NetPrice__c;
                fr.Total_propuesta__c = quotes.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c;
                //fr.Mes__c = 
                //fr.Anio__c = ;
                
                if(quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c != 0 && quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c != null){
                    insertFrecuencias.add(fr);}
            }
        }
            
            if(insertFrecuencias.size()>0){
            	if(borrar2.size()>0) { Delete borrar2; }
            	Insert insertFrecuencias;
        	}
       
        Account theAcc = [SELECT Id, Id_SIpWeb__c, Name FROM Account WHERE Id=: AccId];
        
        //Email de resultados
        User U = [SELECT Id, Email  FROM User WHERE Id = :System.UserInfo.getUserId()];
        //Tablero de QA
        //String strLink = 'https://paquetexpress--qa2020.lightning.force.com/lightning/r/Dashboard/01Z7i000000Ia93EAC/view?queryScope=userFolders&fv0=' + theAcc.Id_SIpWeb__c;
        //String strLink = 'https://paquetexpress--qa2020.lightning.force.com/lightning/r/Dashboard/01Z2E000001ZhkKUAS/view?queryScope=userFolders'; //Link temporal para ver los datos
        String strLink = 'https://paquetexpress--qa2020.lightning.force.com/lightning/r/Account/'+AccId+'/view'; //Link temporal para pruebas
        //Tablero de Producción
        //String strLink = 'https://paquetexpress.lightning.force.com/lightning/r/Dashboard/01Z2E000001ZhkKUAS/view?queryScope=userFolders&fv0=' + theAcc.Id_SIpWeb__c;
        List<string> toAddress = new List<string>{U.Email};
        String strTemplate = '<hr color="purple" Style="border:15px;"/><br><br>El procesamiento del reporte seguimiento al descuento real prepago para el cliente ' + theAcc.Name + ' ha terminado.<br/> Para ver los resultados <a href="'+ strLink +'"><span style="color:#0066FF" wfd-id="2">clic aquí</span>.<br><br><hr color="purple" Style="border:15px;"/>';
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setTemplateId(et.Id);
        mail.setToAddresses(toAddress);
        mail.setSubject('Seguimiento al descuento real: ' + theAcc.Name);
        mail.setHTMLBody(strTemplate);
        // mail.setTargetObjectId(primaryContact);
        mail.setWhatId('a162f000000RFQe');
        mail.setSaveAsActivity(false);
        mail.setUseSignature(false);
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        allmsg.add(mail);

        
            Messaging.sendEmail(allmsg,false);
            return;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
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
    public static List<SBQQ__QuoteLine__c> queryQuoteItem(String strIdAccount, Date FechaInicio, Date FechaFin){
        return [SELECT SBQQ__QUOTE__R.NAME, SBQQ__QUOTE__R.Servicios_adicionales__c, SBQQ__Quote__r.Acuse__c, TARIFA__C, RANGO_KM__C, SBQQ__CUSTOMERPRICE__C, ACK__C, ZonaPlus__c FROM SBQQ__QUOTELINE__C 
                WHERE SBQQ__QUOTE__R.FECHA_DE_AUTORIZADA__C >= :Fechainicio AND SBQQ__QUOTE__R.FECHA_DE_AUTORIZADA__C <= :FechaFin
                AND SBQQ__QUOTE__R.SBQQ__ACCOUNT__C = :strIdAccount AND SBQQ__QUOTE__R.Tipo_de_documentacion__c = 'Guías prepagadas'
                ORDER BY SBQQ__QUOTE__R.Fecha_de_autorizada__c ASC NULLS FIRST];
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
