global class BatchSeguimientoCBME2 implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    public String query;
    public String AccId;
    public Map<String, Map<String, Decimal>> mapFrecuencias = new Map<String, Map<String, Decimal>>();
    public BatchSeguimientoCBME2(String AccountId, String Inicio, String Fin, String Modelo) {
        this.AccId = AccountId;
        Query = 'SELECT Id, Name, Servicios_adicionales__c, Fecha_de_autorizada__c FROM SBQQ__Quote__c WHERE (SBQQ__Account__c = \'' + AccountId + '\' OR SBQQ__Account__r.ParentId = \'' + AccountId + '\') ' +
        + 'AND Fecha_de_autorizada__c >= '+Inicio+' and Fecha_de_autorizada__c <= '+Fin+' AND SBQQ__Status__c = \'Approved\' AND Modelo_de_tarifas__c = \'' + Modelo + '\'';
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //System.debug('consulta: '+ query);
        return Database.getQueryLocator(this.Query);	
    }
    global void execute(Database.BatchableContext bc, List<SBQQ__Quote__c> records){
        try{
            for(SBQQ__Quote__c objQuote : records){
                for(SBQQ__QuoteLine__c objQLine : [SELECT Id, ZonaPlus__c, PackWeightAVG__c, PackVolAVG__c, Tarifa__c, SBQQ__Quantity__c, Rango_KM__c, Destiny__c, Flete__c, RAD__c, EAD__c, ACK__C FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :objQuote.Id]){

                }
            }
        } catch(Exception ex){
            System.debug('escribir mensaje de error');
        }
    }
}
