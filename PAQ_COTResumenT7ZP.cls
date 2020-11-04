public class PAQ_COTResumenT7ZP_CTR {
    public Wrapper wp                                                       {get; set;}
    public PAQ_COTResumenT7ZP_CTR(ApexPages.StandardController sc) {
        this.wp                      = new Wrapper();
        this.wp.objQuote = queryQuote(sc.getId());
        this.wp.strDestiny = QueryObtieneDestino(sc.getId());
    }
    public static SBQQ__Quote__c queryQuote(String strQuoteId){
        return [SELECT PAQ_TipoServicio__c, OriginCity__c, SBQQ__Status__c, CreatedDate, Name, Paquetes_Mensuales__c, Ingreso_Mensual__c, SBQQ__NetAmount__c, Descuento_Global__c, TarifaLlenaMensual__c, PAQ_DescuentoGlobal__c, Plaza__c, owner.Name
        FROM SBQQ__Quote__c WHERE Id = :strQuoteId];
    }
    public String QueryObtieneDestino(String strQuoteId){
        SBQQ__QuoteLine__c QL;
        QL = [SELECT Destiny__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :strQuoteId AND Destiny__c <> null];
        return QL.Destiny__c;
    }
    public class Wrapper {
        public SBQQ__Quote__c           objQuote            {get; set;}
        public Boolean				    blnZP          	    {get; set;}
        public String                   strDestiny          {get; set;}
        public Wrapper (){
            this.blnZP      = false;
            this.strDestiny = '';
        }
    }
}
