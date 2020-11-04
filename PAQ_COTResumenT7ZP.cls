/*Creada: 04/11/2020 Creó: Salvador Ramírez López. Proyecto: Paquetexpress. Descripción: Clase controlador del resumen de cotización de T7 zona plus*/
public class PAQ_COTResumenT7ZP_CTR {
    public Wrapper wp                                                       {get; set;}
    public Map<Integer, SBQQ__QuoteLine__c> mapQuotesRAD                    {get; set;}
    public Map<Integer, SBQQ__QuoteLine__c> mapQuotesEAD                    {get; set;}
    public List<Integer> listDestiny                                        {get; set;}
    public List<Integer> listOrigen                                         {get; set;}
    public String strOrigen                                                 {get; set;}
    public Decimal decTotalRAD                                              {get; set;}
    public Decimal decTotalEAD                                              {get; set;}
    public Decimal decTotalRADEX                                            {get; set;}
    public Decimal decTotalEADEX                                            {get; set;}
    public PAQ_COTResumenT7ZP_CTR(ApexPages.StandardController sc) {
        this.wp                     = new Wrapper();
        this.wp.objQuote            = queryQuote(sc.getId());
        this.strOrigen              = this.wp.objQuote.OriginCity__c;
        this.wp.strDestiny          = QueryObtieneDestino(sc.getId(), this.strOrigen);
        this.wp.listQuoteItemRAD    = queryQuoteItemRAD(sc.getId(), this.strOrigen);
        this.wp.listQuoteItemEAD    = queryQuoteItemEAD(sc.getId(), this.wp.strDestiny);
        this.mapQuotesRAD           = new Map<Integer, SBQQ__QuoteLine__c>();
        this.mapQuotesEAD           = new Map<Integer, SBQQ__QuoteLine__c>();
        this.listDestiny            = new list<Integer>();
        this.listOrigen             = new list<Integer>();
        this.decTotalRAD            = 0;
        this.decTotalEAD            = 0;
        this.decTotalRADEX          = 0;
        this.decTotalEADEX          = 0;
        this.wp.mapCS = queryCustomSetting([SELECT Id FROM Profile Where Name = 'System Administrator' OR Name = 'Administrador del sistema'].Id);
        for(CapacidadSucursal__c tender : queryTender())
            wp.mapTender.put(tender.Name, tender);
        Integer i = 0;
        for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItemRAD){
            this.listOrigen.add(i+=1);
            this.mapQuotesRAD.put(i,quoteItem);
        }
        Integer x = 0;
        for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItemEAD){
            this.listDestiny.add(x += 1);
            this.mapQuotesEAD.put(x,quoteItem);
        }
        CalculaTotalesRADyEAD();
        this.decTotalRADEX = CalculaEspecialRADyEAD(this.wp.listQuoteItemRAD);
        this.decTotalEADEX = CalculaEspecialRADyEAD(this.wp.listQuoteItemEAD);
    }
    public void CalculaTotalesRADyEAD(){
        for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItemRAD)
            this.decTotalRAD += this.wp.mapCS.get('AEZP') * quoteItem.SBQQ__Quantity__c;
        for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItemEAD)
            this.decTotalEAD += this.wp.mapCS.get('AEZP') * quoteItem.SBQQ__Quantity__c;
    }
    public Decimal CalculaEspecialRADyEAD(List<SBQQ__QuoteLine__c> Datos){
        Decimal decVolWeight        = 0;
        Decimal decExVolWeight      = 0;
        Decimal decDominantWeight   = 0;
        Decimal decExWeight         = 0;
        Decimal total               = 0;
        for(SBQQ__QuoteLine__c quoteItem : Datos){
            decExWeight = quoteItem.Weight__c - 60;
            decVolWeight = quoteItem.Vol__c / this.wp.mapCS.get('CPV');
            decExVolWeight = decVolWeight - 60;
            decDominantWeight = getMAX(decExVolWeight, decExWeight);
            if(quoteItem.Weight__c > 60)
                 total += this.wp.mapTender.get(quoteItem.Destiny__c).Costo__c * decDominantWeight * quoteItem.SBQQ__Quantity__c;
        }
        return total;
    }
    public Decimal getMAX(Decimal decNum1, Decimal decNum2){
        return Math.max(decNum1, decNum2);
    }
    public static Map<String, Decimal> queryCustomSetting(String pid){
		Map<String, Decimal> mapCS = new Map<String, Decimal>();
		Cotizador__c CSObj = Cotizador__c.getInstance(pid);
		mapCS.put('AEZP', CSObj.EntregaDomicilioZonaPlus__c);
		mapCS.put('SEG', CSObj.SeguroMillarDeclarado__c);
		mapCS.put('IVA', CSObj.IVA__c);
		mapCS.put('EAD', CSObj.EAD__c);
		mapCS.put('RAD', CSObj.RAD__c);
		mapCS.put('CPV', CSObj.CoeficientePV__c);
		mapCS.put('MinEAD', CSObj.MinEAD__c);
		mapCS.put('MinRAD', CSObj.MinRAD__c);
		return mapCS;
	}
    public static SBQQ__Quote__c queryQuote(String strQuoteId){
        return [SELECT PAQ_TipoServicio__c, OriginCity__c, SBQQ__Status__c, CreatedDate, Name, Paquetes_Mensuales__c, Ingreso_Mensual__c, SBQQ__NetAmount__c, Descuento_Global__c, TarifaLlenaMensual__c, PAQ_DescuentoGlobal__c, Plaza__c, owner.Name
        FROM SBQQ__Quote__c WHERE Id = :strQuoteId];
    }
    public String QueryObtieneDestino(String strQuoteId, String strOrigen){
        SBQQ__QuoteLine__c QL;
        QL = [SELECT Destiny__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :strQuoteId AND Destiny__c <> :strOrigen LIMIT 1];
        return QL.Destiny__c;
    }
    public static List<SBQQ__QuoteLine__c> queryQuoteItemRAD(String strQuoteId, String strRAD){
        return [SELECT SBQQ__Quantity__c, SBQQ__CustomerTotal__c, SBQQ__CustomerPrice__c, SBQQ__NetPrice__c, SBQQ__NetTotal__c, QuoteTotal__c, Tarifa__c, Width__c, Weight__c, Large__c, High__c, ZonaPlus__c, Destiny__c, SBQQ__Description__c, Vol__c
        FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :strQuoteId AND Destiny__c = :strRAD ORDER BY CreatedDate ASC];
    }
    public static List<SBQQ__QuoteLine__c> queryQuoteItemEAD(String strQuoteId, String strEAD){
        return [SELECT SBQQ__Quantity__c, SBQQ__CustomerTotal__c, SBQQ__CustomerPrice__c, SBQQ__NetPrice__c, SBQQ__NetTotal__c, QuoteTotal__c, Tarifa__c, Width__c, Weight__c, Large__c, High__c, ZonaPlus__c, Destiny__c, SBQQ__Description__c, Vol__c
        FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :strQuoteId AND Destiny__c = :strEAD ORDER BY CreatedDate ASC];
    }
    public static List<CapacidadSucursal__c> queryTender(){
		return [SELECT Name, Costo__c, Nivel__c, OP__c FROM CapacidadSucursal__c];
	}
    public class Wrapper {
        public SBQQ__Quote__c                       objQuote            {get; set;}
        public Boolean				                blnZP          	    {get; set;}
        public String                               strDestiny          {get; set;}
        public List<SBQQ__QuoteLine__c>             listQuoteItemRAD    {get; set;}
        public List<SBQQ__QuoteLine__c>             listQuoteItemEAD    {get; set;}
        public Map<String, Decimal>                 mapCS               {get; set;}
        public Map<String, CapacidadSucursal__c>    mapTender			{get; set;}
        public Wrapper (){
            this.blnZP              = false;
            this.strDestiny         = '';
            this.listQuoteItemRAD   = new List<SBQQ__QuoteLine__c>();
            this.listQuoteItemEAD   = new List<SBQQ__QuoteLine__c>();
            this.mapCS		        = new Map<String, Decimal>();
            this.mapTender		    = new Map<String, CapacidadSucursal__c>();
        }
    }
}
