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
    public List<SBQQ__QuoteLine__c> partidas = new List<SBQQ__QuoteLine__c>();
    public Map<String, Map<String, SBQQ__QuoteLine__c>> quotes = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public List<String> listRange = new List<String> {
            '0-400', '401-800', '801-1200', '1201-1600', '1601-2000', '2001-2400', 'Más de 2400'
    };
    public List<String> listFee = new List<String> {
            'TS', 'T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7',
            'TS ZP', 'T0 ZP', 'T1 ZP', 'T2 ZP', 'T3 ZP', 'T4 ZP', 'T5 ZP', 'T6 ZP', 'T7 ZP',
            'A12', 'DS', '2DS'
    };
    public BatchSeguimientoODC1(String AccountId, String Inicio, String Fin){
        this.AccId      = AccountId;
        this.Inicioo    = Inicio;
        this.Fiin       = Fin;
        for(String Fee:listFee){
            quotes.put(Fee, new Map<String, SBQQ__QuoteLine__c>());
            for(String Range:listRange){
                SBQQ__QuoteLine__c q = new SBQQ__QuoteLine__c();
                q.SBQQ__Quantity__c = 0;
                q.PackWeightAVG__c = 0;
                q.PackVolAVG__c = 0;
                quotes.get(Fee).put(Range, q);
            }
        }
        if(!test.isRunningTest()){
            query = 'SELECT Id, Name, SBQQ__Account__c, Fecha_de_autorizada__c, SBQQ__Status__c, SBQQ__Account__r.ParentId, Tipo_de_documentacion__c, PAQ_TipoServicio__c FROM SBQQ__Quote__c ' +
                    'WHERE (SBQQ__Account__c = \'' + AccId + '\' OR SBQQ__Account__r.ParentId = \'' + AccId + '\') ' +
                    'AND SBQQ__Status__c = \'Approved\' ' +
                    'AND Tipo_de_documentacion__c = \'Documentación Remota\' ' +
                    'AND Modelo_de_tarifas__c = \'Costos fijos por Tarifas: Por Destinos / Por rangos de km\''+
                    'ORDER BY Fecha_de_autorizada__c ASC NULLS FIRST';
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
                partidas = [SELECT SBQQ__Quote__c, Tarifa__c, ZonaPlus__c, SBQQ__Quantity__c, Rango_KM__c, PackWeightAVG__c, PackVolAVG__c,
                            SBQQ__CustomerTotal__c, SBQQ__NetTotal__c, SBQQ__AdditionalDiscount__c, Destiny__c,
                            SBQQ__Quote__r.Name, SBQQ__Quote__r.Servicios_adicionales__c, SBQQ__Quote__r.Fecha_de_autorizada__c
                            FROM SBQQ__QuoteLine__c 
                            WHERE SBQQ__Quote__c =: q.Id];
                for(SBQQ__QuoteLine__c p:partidas){
                    if(q.PAQ_TipoServicio__c == 'Estándar terrestre (STD)'){
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
                    } else if(q.PAQ_TipoServicio__c == 'Servicio Express Garantizado (SEG)'){
    
                    }
                }
            }
        }catch(Exception ex){
            System.System.debug('Ocurrió error en execute de BatchSeguimientoODC1: '+ ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    global void finish(Database.BatchableContext bc){
        
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
        else return '';
    }
}
