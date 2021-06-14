/**
 * @description       : Obtiene la frecuencia autorizada del reporte de descuento real costos fijos por tarifa
 * @author            : Salvador Ramírez López (sramirez@freewayconsulting.com)
**/
global class BatchSeguimientoODC1 implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful{
    public String query;
    public String AccId;
    public String Inicioo;
    public String Fiin;
    public String Quote;
    public List<SBQQ__QuoteLine__c> partidas                    = new List<SBQQ__QuoteLine__c>();
    public List<FrecuenciaDeEnvios__c> insertFrecuencias        = new List<FrecuenciaDeEnvios__c>();
    public Map<String, Map<String, SBQQ__QuoteLine__c>> quotes  = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public Map<String, Map<String, Decimal>> mapFlete           = new Map<String, Map<String, Decimal>>();
    public List<String> listRange                               = new List<String>(); //{'0-400', '401-800', '801-1200', '1201-1600', '1601-2000', '2001-2400', 'Más de 2400'};
    public List<String> listFee                                 = new List<String>(); /*{'TS', 'T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7',
                                                                                    'TS ZP', 'T0 ZP', 'T1 ZP', 'T2 ZP', 'T3 ZP', 'T4 ZP', 'T5 ZP', 'T6 ZP', 'T7 ZP',
                                                                                    'A12', 'DS', '2DS'};*/
    public BatchSeguimientoODC1(String AccountId, String Inicio, String Fin){
        this.AccId      = AccountId;
        this.Inicioo    = Inicio;
        this.Fiin       = Fin;
        /*for(String Fee:listFee){
            quotes.put(Fee, new Map<String, SBQQ__QuoteLine__c>());
            for(String Range:listRange){
                SBQQ__QuoteLine__c q = new SBQQ__QuoteLine__c();
                q.SBQQ__Quantity__c = 0;
                q.PackWeightAVG__c = 0;
                q.PackVolAVG__c = 0;
                quotes.get(Fee).put(Range, q);
            }
        }*/
        if(!test.isRunningTest()){
            query = 'SELECT Id, Name, SBQQ__Account__c, Fecha_de_autorizada__c, SBQQ__Status__c, SBQQ__Account__r.ParentId, Tipo_de_documentacion__c, PAQ_TipoServicio__c FROM SBQQ__Quote__c ' +
                    'WHERE (SBQQ__Account__c = \'' + AccId + '\' OR SBQQ__Account__r.ParentId = \'' + AccId + '\') ' +
                    'AND SBQQ__Status__c = \'Approved\' ' +
                    'AND Tipo_de_documentacion__c = \'Documentación Remota\' ' +
                    'AND Modelo_de_tarifas__c = \'Costos fijos por Tarifas: Por Destinos / Por rangos de km\''+
                    'AND FECHA_DE_AUTORIZADA__C <> NULL ' + //Borrar cuando se pase a producción ya que en QA hay cotizaciones que no tienen fecha de autorización, pero en producción todas deben tenerla
                    'ORDER BY Fecha_de_autorizada__c DESC NULLS FIRST';
        } else {
            query = 'SELECT Id, Name, SBQQ__Account__c, Fecha_de_autorizada__c, SBQQ__Status__c, SBQQ__Account__r.ParentId, ' +
                    'Tipo_de_documentacion__c, PAQ_TipoServicio__c FROM SBQQ__Quote__c ' +
                    'WHERE SBQQ__Account__c = \'' + AccId + '\'';
        }
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug(query);
    	return Database.getQueryLocator(query);	
    }
    global void execute(Database.BatchableContext bc, List<SBQQ__Quote__c> records){
        try{
            String strTarifa    = '';
            String strRangeDest = '';
            for (SBQQ__Quote__c q: records) {
                quote = q.Id;
                partidas = [SELECT SBQQ__Quote__c, SBQQ__CustomerPrice__c, Tarifa__c, ZonaPlus__c, SBQQ__Quantity__c, Rango_KM__c, PackWeightAVG__c, PackVolAVG__c,
                            SBQQ__CustomerTotal__c, SBQQ__NetTotal__c, SBQQ__AdditionalDiscount__c, Destiny__c,
                            SBQQ__Quote__r.Name, SBQQ__Quote__r.Servicios_adicionales__c, SBQQ__Quote__r.Fecha_de_autorizada__c
                            FROM SBQQ__QuoteLine__c 
                            WHERE SBQQ__Quote__c =: q.Id];
                for(SBQQ__QuoteLine__c p:partidas){
                    if(!(p.Tarifa__c == 'TARIFA T7' && p.ZonaPlus__c)){
                        strTarifa       = '';
                        strRangeDest    = '';
                        if(p.ZonaPlus__c && p.Destiny__c != null){
                            strTarifa = getTarifa(p.Tarifa__c) + ' ZP ' + p.Destiny__c;
                        } else if(p.ZonaPlus__c && p.Destiny__c == null){
                            strTarifa = getTarifa(p.Tarifa__c) + ' ZP';
                        } else if(!p.ZonaPlus__c && p.Destiny__c != null){
                            strTarifa = getTarifa(p.Tarifa__C) + ' ' + p.Destiny__c;
                        } else if(!p.ZonaPlus__c && p.Destiny__c == null){
                            strTarifa = getTarifa(p.Tarifa__C);
                        }
                        if(p.Destiny__c != null)
                            strRangeDest = p.Destiny__c;
                        else strRangeDest = p.Rango_KM__c;
                        if(!quotes.containsKey(strTarifa))
                            quotes.put(strTarifa, new Map<String, SBQQ__QuoteLine__c>());
                        if(!quotes.get(strTarifa).containsKey(strRangeDest))
                            quotes.get(strTarifa).put(strRangeDest, p);
                        if(!this.listRange.contains(strRangeDest))
                            this.listRange.add(strRangeDest);
                        if(!this.listFee.contains(strTarifa))
                            this.listFee.add(strTarifa);
                        if(!this.mapFlete.containsKey(p.Tarifa__c))
                            this.mapFlete.put(p.Tarifa__c, new Map<String, Decimal>());
                        if(!this.mapFlete.get(p.Tarifa__c).containsKey(strRangeDest))
                            this.mapFlete.get(p.Tarifa__c).put(strRangeDest, p.SBQQ__CustomerPrice__c);
                    }
                }
            }
            //System.debug('cotización id: ' + quote);
        }catch(Exception ex){
            System.System.debug('Ocurrió error en execute de BatchSeguimientoODC1: '+ ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    global void finish(Database.BatchableContext bc){
        try{
            List<FrecuenciaDeEnvios__c> borrar2 = new List<FrecuenciaDeEnvios__c>();
            borrar2 = [SELECT Id, Cuenta__c, Tipo__c, RecordType.Name FROM FrecuenciaDeEnvios__c WHERE Cuenta__c =: AccId  AND RecordType.Name = 'Frecuencia Cotizada'];
            Id tipo = [SELECT Id, Name FROM RecordType WHERE Name = 'Frecuencia Cotizada'].Id;
            for(String keyFee: listFee){
                for(String keyRange: listRange){
                    if(quotes.containsKey(keyFee) && quotes.get(keyFee).containsKey(keyRange)){
                        if(quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c != 0 && quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c != null){
                            FrecuenciaDeEnvios__c fr = new FrecuenciaDeEnvios__c();
                            fr.Cuenta__c = AccId;
                            fr.RecordTypeId = tipo;
                            fr.Tipo__c = 'DOC_LINEA';
                            fr.Rango__c = keyRange;
                            fr.Tarifa__c = keyFee;
                            fr.Bultos__c = quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                            if(!keyFee.contains('T7') || !keyFee.contains('DS') || !keyFee.contains('DS') || !keyFee.contains('2DS') || !keyFee.contains('A12')){
                                fr.Peso__c = getPeso(keyFee);
                                fr.Volumen__c = getVolumen(keyFee);
                            } else {
                                fr.Peso__c = quotes.get(keyFee).get(keyRange).PackWeightAVG__c;
                                fr.Volumen__c = quotes.get(keyFee).get(keyRange).PackVolAVG__c;
                            }
                            fr.Zona_Plus__c = quotes.get(keyFee).get(keyRange).ZonaPlus__c;
                            fr.Total_tarifa_llena__c = quotes.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                            fr.Total_propuesta__c = quotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                            fr.Servicios__c = quotes.get(keyFee).get(keyRange).SBQQ__Quote__r.Servicios_adicionales__c;
                            fr.Cotizacion__c = quotes.get(keyFee).get(keyRange).SBQQ__Quote__r.Name;
                            fr.Fecha_de_Aprobacion__c = quotes.get(keyFee).get(keyRange).SBQQ__Quote__r.Fecha_de_autorizada__c;
                            insertFrecuencias.add(fr);
                        }
                    }
                }
            }
            if(insertFrecuencias.size()>0){
            	if(borrar2.size()>0 && borrar2 != null) { 
                    Delete borrar2; 
                }
                for(Database.SaveResult resDeducUPD : Database.insert(this.insertFrecuencias, false)){
                    if(resDeducUPD.isSuccess())
                        System.debug('Se guardaron correctamente los cambios. BatchSeguimientoODC1');
                    else {
                        for(Database.Error insError: resDeducUPD.getErrors())
                            System.debug('Error al guardar datos de partidas de cotización BatchSeguimientoODC1: ' + insError.getMessage());
                    }
                }
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Terminó el proceso, revisar los datos.'));
        	}
            if(!test.isRunningTest()){
                BatchSeguimientoODC2 batch3 = new BatchSeguimientoODC2(AccId, Inicioo, Fiin, quote, this.mapFlete); 
                database.executeBatch(batch3);
            }
        } catch (Exception ex){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ocurrió error en finish de BatchSeguimientoODC1: '+ ex.getLineNumber()+' '+ex.getMessage()));
            System.System.debug('Ocurrió error en finish de BatchSeguimientoODC1: '+ ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public static String getTarifa(String tarifa){
        if(tarifa == 'TARIFA SOBRE')
            return 'TS';
        else if(tarifa == 'TARIFA T0')
            return 'T0';
        else if(tarifa == 'TARIFA T1')
            return 'T1';
        else if(tarifa == 'TARIFA T2')
            return 'T2';
        else if(tarifa == 'TARIFA T3')
            return 'T3';
        else if(tarifa == 'TARIFA T4')
            return 'T4';
        else if(tarifa == 'TARIFA T5')
            return 'T5';
        else if(tarifa == 'TARIFA T6')
            return 'T6';
        else if(tarifa == 'TARIFA T7-V')
            return 'T7V';
        else if(tarifa == 'TARIFA T7-P')
            return 'T7P';
        else if(tarifa == 'TARIFA T7')
            return 'T7P';
        else if(tarifa == 'SEG-DS')
            return 'DS';
        else if(tarifa == 'SEG-2D')
            return '2DS';
        else if(tarifa == 'SEG-A12')
            return 'A12';
        else return '';
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
}
