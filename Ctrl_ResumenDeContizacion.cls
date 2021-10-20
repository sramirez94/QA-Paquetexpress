/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-19-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   05-19-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class Ctrl_ResumenDeContizacion {

    public boolean Sipweb  					{get;set;}
    public boolean ServicioEstandar 		{get;set;}
    public boolean ServicioExpress 			{get;set;}
    public boolean GuiasPrepagadas 			{get;set;}
    public boolean DocumentacionEnLinea	 	{get;set;}
    public boolean ServiciosEspeciales 		{get;set;}
	public Wrapper wp                       {get;set;}
    public List<String> listFee             {get; set;}
    public List<String> listFeeZP           {get; set;}
    public List<String> listEXP             {get; set;}
    public Map<String, String> mapEXP       {get; set;}
    public Set<String> lEXP                 {get; set;}
    public Set<String> listGuide            {get; set;}
    public List<String> listRange           {get; set;}
    public List<String> listRangeDestiny    {get; set;}
    public List<String> listSS              {get; set;}
    public List<String> listRangeT7         {get;set;}
    public List<String> listRangeProp       {get; set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesZP {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesEXP {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapQuotesT7ZP {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapQuotesT7ZPByRange {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapPropuestaT7ZP {get;set;}
    public Map<String, Map<String, Map<String, SBQQ__QuoteLine__c>>> mapQuotesOD {get;set;}
    public Map<String, QuoteWP>  mapTotalByRange {get; set;}
    public Map<String, QuoteWP>  mapTotalByFee {get; set;}
    public Map<String, QuoteWP>  mapTotalByRangeZP {get; set;}
    public Map<String, QuoteWP>  mapTotalByFeeZP {get; set;}
    public Map<String, Map<String, QuoteWP>>  mapTotalByRangeEXP {get; set;}
	public Map<String, QuoteWP>  mapTotalByFeeEXP {get; set;}
	public Map<String, Map<String, QuoteWP>>  mapTotalByFeeOD {get; set;}
    public Map<String, Decimal> mapT7W {get; set;}
    public Map<String, Decimal> mapT7V {get; set;}
    public Map<String, Decimal> mapTotal {get; set;}
    public Map<String, Decimal> mapTotalZP {get; set;}
    public Map<String, Decimal> mapTotalDiscFee {get; set;}
    public Map<String, Decimal> mapTotalDiscFeeZP {get; set;}
    public Map<String, Decimal> mapTotalDiscEXP {get; set;}
    public Map<String, Decimal> mapTotalesT7ZP {get; set;}
    public Map<String, Decimal> mapDescT7ZP {get;set;}
    public Map<String, Map<String, Decimal>> mapFrecc {get; set;}
    public Map<String, Map<String, Map<String, Decimal>>> mapFreccOD {get; set;}
    
    public Boolean blnRAD {get; set;}
    public Boolean blnEAD {get; set;}
    public Boolean blnZP {get; set;}
    public Boolean blnSEG {get; set;}
    public Boolean blnACK {get; set;}
    public Boolean blnDS {get; set;}
    public Boolean bln2D {get; set;}
    public Boolean blnA12 {get; set;}
    public Decimal discDS {get; set;}
    public Decimal disc2D {get; set;}
    public Decimal discA12 {get; set;}
    public Decimal totalSTD {get; set;}
    public Decimal totalSTDZP {get; set;}
    
    public String lastGuide {get; set;}
    public boolean T7ZonaPlus {get;set;}
    public String strId {get;set;}
    public boolean CBME {get;set;}
    public boolean T7ZP{get;set;}
    public boolean blnGMP {get; set;}
    public String strOrigen {get;set;}
    public Decimal descGral {get; set;}
    public Decimal totalPaq {get; set;}
    public Decimal porcFrec {get; set;}
    public Decimal decMontoTotalT7ZP {get; set;}
    public Decimal totalAmountQZP {get;set;}
    public Decimal decTotProp {get;set;}
    public Integer IntAnioVigencia {get;set;}
    public String strFechaVigencia {get;set;}

    public Ctrl_ResumenDeContizacion (ApexPages.StandardController sc){
		Decimal coutFee = 0;
		Decimal countFeeZP = 0;
        Decimal total = 0;
        Decimal totalZP = 0;
        Decimal amount = 0;
        Decimal amountZP = 0;
        Decimal totalAmount = 0;
        Decimal totalAmountZP = 0;
        Decimal totalAmountQ = 0;
        Decimal totalAmountSeg = 0;
        Decimal totalAmountSegZP = 0;
        lastGuide = '0';
		Map<String, String> mapSSOption = new Map<String, String>();
        this.blnRAD = false;
        this.blnEAD = false;
        this.blnZP = false;
        this.blnSEG = false;
        this.blnACK = false;
        this.blnDS = false;
        this.bln2D = false;
        this.blnA12 = false;
        this.blnGMP = false;
        this.T7ZonaPlus = false;
        this.CBME = false;
        this.strId = '';
        this.strOrigen = '';
        this.descGral = 0;
        this.totalPaq = 0;
        this.porcFrec = 0;
        this.decMontoTotalT7ZP = 0;
        this.totalAmountQZP = 0;
        this.decTotProp = 0;
		this.listFee = new List<String> {
			'TARIFA SOBRE'
			, 'TARIFA T0'
			, 'TARIFA T1'
			, 'TARIFA T2'
			, 'TARIFA T3'
			, 'TARIFA T4'
			, 'TARIFA T5'
			, 'TARIFA T6'
			, 'TARIFA T7'
        };
        this.listFeeZP = new List<String> {
                'TARIFA SOBRE'
                , 'TARIFA T0'
                , 'TARIFA T1'
                , 'TARIFA T2'
                , 'TARIFA T3'
                , 'TARIFA T4'
                , 'TARIFA T5'
                , 'TARIFA T6'
                };
		this.listEXP = new List<String>{
			'SEG-DS'
			, 'SEG-2D'
			, 'SEG-A12'
		};
        this.mapEXP = new Map<String, String>{
                'SEG-DS' => 'SERVICIO EXPRESS GARANTIZADO - DIA SIGUIENTE (ONE DAY)'
                , 'SEG-2D' => 'SERVICIO EXPRESS GARANTIZADO - DOS DIAS SIGUIENTES (TWO DAYS)'
                , 'SEG-A12' => 'SERVICIO EXPRESS GARANTIZADO - ANTES DE MEDIO DIA  (MID DAY)'
                };
        this.lEXP = new Set<String>();
        this.listGuide = new Set<String>();
		this.listRange = new List<String> {
            '0-400'
            , '401-800'
            , '801-1200'
            , '1201-1600'
            , '1601-2000'
            , '2001-2400'
            , 'Más de 2400'
        };
        this.listSS = new List<String> {
                'Maniobras'
                , 'EAD con cita'
                , 'EAD a Detalle'
                , 'Special Packing'
                , 'Pick&Pack'
                , 'Cruce Fronterizo'
        };
        this.Sipweb                  = false;
        this.ServicioEstandar        = false;
        this.ServicioExpress         = false;
        this.GuiasPrepagadas         = false;
        this.DocumentacionEnLinea    = false;
        this.ServiciosEspeciales     = false;
        this.T7ZP                    = false;
        this.wp                      = new Wrapper();
        this.mapQuotes               = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesZP             = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesEXP            = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesOD             = new Map<String, Map<String, Map<String, SBQQ__QuoteLine__c>>>();
        this.mapTotalByRange         = new Map<String, QuoteWP>();
        this.mapTotalByRangeZP       = new Map<String, QuoteWP>();
        this.mapTotalByRangeEXP      = new Map<String, Map<String, QuoteWP>>();
		this.mapTotalByFee           = new Map<String, QuoteWP>();
		this.mapTotalByFeeZP         = new Map<String, QuoteWP>();
		this.mapTotalByFeeEXP        = new Map<String, QuoteWP>();
		this.mapTotalByFeeOD        = new Map<String, Map<String, QuoteWP>>();
        this.mapT7W                  = new Map<String, Decimal>();
        this.mapT7V                  = new Map<String, Decimal>();
        this.mapTotal                = new Map<String, Decimal>();
        this.mapTotalZP              = new Map<String, Decimal>();
        this.mapTotalDiscFee         = new Map<String, Decimal>();
        this.mapTotalDiscFeeZP       = new Map<String, Decimal>();
        this.mapTotalDiscEXP         = new Map<String, Decimal>();
        this.mapFrecc                = new Map<String, Map<String, Decimal>>();
        this.mapFreccOD              = new Map<String, Map<String, Map<String, Decimal>>>();
        this.listRangeDestiny        = new List<String>();
        this.mapQuotesT7ZP           = new Map<String, SBQQ__QuoteLine__c>();
        this.mapQuotesT7ZPByRange    = new Map<String, SBQQ__QuoteLine__c>();
        this.mapPropuestaT7ZP        = new Map<String, SBQQ__QuoteLine__c>();
        this.listRangeT7             = new List<String>();
        this.listRangeProp           = new List<String>();
        this.mapTotalesT7ZP          = new Map<String, Decimal>();
        this.mapDescT7ZP             = new Map<String, Decimal>();
        this.IntAnioVigencia         = 0;
        this.strFechaVigencia        = '';

        this.mapTotalZP.put('Disc', 0);
        this.mapTotal.put('Disc', 0);
        this.mapTotal.put('Full', 0);
        this.mapTotalZP.put('Full', 0);
        this.mapTotal.put('Quote', 0);
        this.mapTotalZP.put('Quote', 0);
        this.IntAnioVigencia = System.Date.today().year();
        this.strFechaVigencia = '31/12/' + String.valueOf(IntAnioVigencia);

        for(String keyFee: this.listFee){
            this.mapTotalByFee.put(keyFee, new QuoteWP());
            this.mapTotalByFeeZP.put(keyFee, new QuoteWP());
            this.mapTotalDiscFee.put(keyFee, 0);
            this.mapTotalDiscFeeZP.put(keyFee, 0);
            for(String keyRange: this.listRange){
                if(!this.mapQuotes.containsKey(keyFee))
                    this.mapQuotes.put(keyFee, new Map<String, SBQQ__QuoteLine__c>{
                    keyRange => new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0)
                    });
                else if(!this.mapQuotes.get(keyFee).containsKey(keyRange))
                    this.mapQuotes.get(keyFee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));

                if(keyFee != 'TARIFA T7')
                    if(!this.mapQuotesZP.containsKey(keyFee))
                        this.mapQuotesZP.put(keyFee, new Map<String, SBQQ__QuoteLine__c>{keyRange => new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0)});
                    else if(!this.mapQuotesZP.get(keyFee).containsKey(keyRange))
                        this.mapQuotesZP.get(keyFee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));
            }
        }
        for(String keyRange: this.listRange)
            for (String fee : new List<String>{ 'TARIFA T7-P', 'TARIFA T7-V'})
                if(!this.mapQuotes.containsKey(fee))
                    this.mapQuotes.put(fee, new Map<String, SBQQ__QuoteLine__c>{keyRange => new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0)});
                else if(!this.mapQuotes.get(fee).containsKey(keyRange))
                    this.mapQuotes.get(fee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));

        System.debug(LoggingLevel.DEBUG, 'mapQuotes :' + JSON.serialize(this.mapQuotes));

		for(String keyFee: this.listEXP){
			this.mapTotalByFeeEXP.put(keyFee, new QuoteWP());
			this.mapTotalDiscEXP.put(keyFee, 0);
			for(String keyRange: this.listRange){
                if(!mapTotalByRangeEXP.containsKey(keyFee))
                    mapTotalByRangeEXP.put(keyFee,
                            new Map<String, QuoteWP>{
                            keyRange
                            => new QuoteWP()
                            }
                    );
                else
                    mapTotalByRangeEXP.get(keyFee).put(keyRange, new QuoteWP());
				if(!this.mapQuotesEXP.containsKey(keyFee))
					this.mapQuotesEXP.put(keyFee, new Map<String, SBQQ__QuoteLine__c>{keyRange => new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0)});
				else if(!this.mapQuotesEXP.get(keyFee).containsKey(keyRange))
					this.mapQuotesEXP.get(keyFee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));
			}
		}

        this.wp.objQuote = queryQuote(sc.getId());
        if(wp.objQuote.OriginCity__c != null)
            this.strOrigen = wp.objQuote.OriginCity__c;
        if(wp.objQuote.PAQ_DescuentoGlobal__c != null)
            this.wp.objQuote.PAQ_DescuentoGlobal__c = wp.objQuote.PAQ_DescuentoGlobal__c / 100;

        if(this.wp.objQuote.Tipo_de_documentacion__c == 'Guías prepagadas' || this.wp.objQuote.Tipo_de_documentacion__c == 'En Piso-Sipweb'){
            for(String keyRange: this.listRange){
                this.mapTotalByRange.put(keyRange, new QuoteWP());
                this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
                this.mapT7W.put(keyRange, 0);
                this.mapT7V.put(keyRange, 0);
            }
            for(String keyFee: this.listEXP){
                this.mapTotalByFeeEXP.put(keyFee, new QuoteWP());
                this.mapTotalDiscEXP.put(keyFee, 0);

                for(String keyRange: this.listRange){
                    if(!mapTotalByRangeEXP.containsKey(keyFee))
                        mapTotalByRangeEXP.put(keyFee,
                                new Map<String, QuoteWP>{
                                keyRange
                                => new QuoteWP()
                                }
                        );
                    else
                        mapTotalByRangeEXP.get(keyFee).put(keyRange, new QuoteWP());
                    if(!this.mapQuotesEXP.containsKey(keyFee))
                        this.mapQuotesEXP.put(keyFee, new Map<String, SBQQ__QuoteLine__c>{keyRange => new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0)});
                    else if(!this.mapQuotesEXP.get(keyFee).containsKey(keyRange))
                        this.mapQuotesEXP.get(keyFee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));
                }
            }
        }
        strId = sc.getId();
        if(this.wp.objQuote.Modelo_de_tarifas__c == 'Tarifario abierto de piso'
                && this.wp.objQuote.TipoCotizacion__c == 'Por convenio'){
            this.Sipweb = true;
            if(this.wp.objQuote.PAQ_TipoServicio__c.contains('Estándar terrestre (STD)'))
                this.ServicioEstandar = true;
            if (this.wp.objQuote.PAQ_TipoServicio__c.contains('Servicio Express Garantizado (SEG)'))
              this.ServicioExpress = true;
        }
        else if(this.wp.objQuote.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'){
            if(this.wp.objQuote.Tipo_de_documentacion__c == 'Documentación Remota')
                this.DocumentacionEnLinea = true;
            else if(this.wp.objQuote.Tipo_de_documentacion__c == 'Guías prepagadas')
                this.GuiasPrepagadas = true;
            if(this.wp.objQuote.PAQ_TipoServicio__c.contains('Estándar terrestre (STD)'))
                this.ServicioEstandar = true;
            if (this.wp.objQuote.PAQ_TipoServicio__c.contains('Servicio Express Garantizado (SEG)'))
                this.ServicioExpress = true;
        }else if(this.wp.objQuote.Modelo_de_tarifas__c == 'Tarifa T7 zona plus'){
            this.T7ZonaPlus = true;
        }else if(this.wp.objQuote.Modelo_de_tarifas__c == 'Costo base más excedente: Por Destinos / Por rangos de km')
            this.CBME = true;
        else if (this.wp.objQuote.Modelo_de_tarifas__c == 'Guía multipieza: Por Destinos / Por Rangos de km')
            this.blnGMP = true;
        doRedireccionamiento();
        if (String.isNotBlank(this.wp.objQuote.Acuse__c))
            this.blnACK = true;
        if(String.isNotBlank(wp.objQuote.SBQQ__Account__c))
            this.wp.objAccount = queryAccount(wp.objQuote.SBQQ__Account__c);
        if(String.isNotBlank(wp.objQuote.SBQQ__Opportunity2__c))
            this.wp.objOpp = queryOpp(wp.objQuote.SBQQ__Opportunity2__c);

        this.wp.listQuoteItem = queryQuoteItem(sc.getId());

        if(String.isNotBlank(this.wp.objQuote.Servicios_adicionales__c))
            for (String strKeyService : this.wp.objQuote.Servicios_adicionales__c.split(';')){
                switch on strKeyService {
                    when 'RAD' {
                        this.blnRAD = true;
                        //System.debug(LoggingLevel.DEBUG, 'this.blnRAD: ' + this.blnRAD);
                    }
                    when 'EAD' {
                        this.blnEAD = true;
                       // System.debug(LoggingLevel.DEBUG, 'this.blnEAD: ' + this.blnEAD);
                    }
                    when 'Seguro' {
                        this.blnSEG = true;
                       // System.debug(LoggingLevel.DEBUG, 'this.blnSEG: ' + this.blnSEG);
                    }
                    /*when 'Acuse Interno' {
                        this.blnACK = true;
                       // System.debug(LoggingLevel.DEBUG, 'this.blnACK: ' + this.blnACK);
                    }
                    when 'Acuse Empresa' {
                        this.blnACK = true;
                        // System.debug(LoggingLevel.DEBUG, 'this.blnACK: ' + this.blnACK);
                    }
                    when 'Acuse XT' {
                        this.blnACK = true;
                       // System.debug(LoggingLevel.DEBUG, 'this.blnACK: ' + this.blnACK);
                    }*/
                }
        }
        Set<String> setRange = new Set<String>();
        Integer indexOD = 0;
        Decimal decTotNormal = 0;
        Decimal descuento = 0;
        Boolean blnCotizaT7 = false;
        for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItem){
            descuento = 0;
            if(String.isNotBlank(quoteItem.Destiny__c)){
                if(quoteItem.Tarifa__c == 'TARIFA T7' && quoteItem.ZonaPlus__c && (quoteItem.SBQQ__Description__c == 'Destino' || quoteItem.SBQQ__Description__c == 'Propuesta'))
                    quoteItem.Rango_KM__c = quoteItem.Destiny__c + ' (' + quoteItem.Rango_KM__c + ')';
                else if(quoteItem.Tarifa__c == 'TARIFA T7' && !quoteItem.ZonaPlus__c)
                    quoteItem.Rango_KM__c = quoteItem.Destiny__c + ' (' + quoteItem.Rango_KM__c + ')';
                else if(quoteItem.Tarifa__c == 'TARIFA SOBRE' || quoteItem.Tarifa__c == 'TARIFA T0' || quoteItem.Tarifa__c == 'TARIFA T1' || quoteItem.Tarifa__c == 'TARIFA T2' || quoteItem.Tarifa__c == 'TARIFA T3' || quoteItem.Tarifa__c == 'TARIFA T4' ||
                        quoteItem.Tarifa__c == 'TARIFA T5' || quoteItem.Tarifa__c == 'TARIFA T6' ||quoteItem.Tarifa__c == 'TARIFA T7-P' || quoteItem.Tarifa__c == 'TARIFA T7-V')
                    quoteItem.Rango_KM__c = quoteItem.Destiny__c + ' (' + quoteItem.Rango_KM__c + ')';
            }
            setRange.add(quoteItem.Rango_KM__c);
            if(quoteItem.Tarifa__c == 'TARIFA T7' && quoteItem.ZonaPlus__c){
                if(quoteItem.SBQQ__Description__c == null || quoteItem.SBQQ__Description__c == 'Destino'){
                    this.mapQuotesT7ZP.put(quoteItem.Destiny__c, quoteItem);
                    this.mapQuotesT7ZPByRange.put(quoteItem.Rango_KM__c, quoteItem);
                    this.listRangeT7.add(quoteItem.Destiny__c);
                    this.totalPaq +=quoteItem.SBQQ__Quantity__c;
                    this.decMontoTotalT7ZP += quoteItem.SBQQ__SpecialPrice__c;
                    blnCotizaT7 = true;
                    this.T7ZP = true;
                } else if(quoteItem.SBQQ__Description__c == 'Propuesta'){
                    if(quoteItem.FLETE__c != null)
                        decTotNormal += quoteItem.FLETE__c;
                    if(quoteItem.GUIA__c != null)
                        decTotProp += quoteItem.GUIA__c;
                    this.mapPropuestaT7ZP.put(quoteItem.Rango_KM__c, quoteItem);
                    this.listRangeProp.add(quoteItem.Rango_KM__c);
                    if(quoteItem.GUIA__c > 0 && quoteItem.FLETE__c > 0)
                        descuento = ((quoteItem.GUIA__c / quoteItem.FLETE__c) - 1) * 100;
                    this.mapDescT7ZP.put(quoteItem.Rango_KM__c, descuento);
                } 
                if(this.mapQuotesT7ZP != null){
                    listRangeT7.sort();
                    
                }
                    
            } else {
                if(quoteItem.Tarifa__c != 'TARIFA T7-V' && quoteItem.Tarifa__c != 'TARIFA T7-P'){
                    if(quoteItem.Tarifa__c == 'TARIFA SOBRE'){
                        if(wp.perSob == 0)
                            wp.perSob = quoteItem.DiscountFlete__c;
                    }
                    else if (quoteItem.Tarifa__c != 'SEG-DS' && quoteItem.Tarifa__c != 'SEG-2D' && quoteItem.Tarifa__c != 'SEG-A12'){
                        if(wp.perPack == 0)
                            wp.perPack = quoteItem.DiscountFlete__c;
                    }
                    if(quoteItem.ZonaPlus__c){
                        if(wp.perZP == 0)
                            wp.perZP = quoteItem.DiscountDelivery__c;
                        if(this.blnEAD)
                            this.blnZP = true;
                        if(quoteItem.SEG__c != null)
                            totalAmountSegZP += quoteItem.SEG__c * quoteItem.SBQQ__Quantity__c;
                    }
                    else{
                        if(wp.perEAD == 0)
                            wp.perEAD = quoteItem.DiscountDelivery__c;
                        if(quoteItem.SEG__c != null)
                            totalAmountSeg += quoteItem.SEG__c  * quoteItem.SBQQ__Quantity__c;
                    }
                    if(wp.perRAD == 0)
                        wp.perRAD = quoteItem.DiscountRecolection__c;
                    if(wp.perACK == 0)
                        wp.perACK = quoteItem.DiscountAcuse__c;
                    if(wp.perSEG == 0)
                        wp.perSEG = quoteItem.DiscountSEG__c;
                    //System.debug(LoggingLevel.DEBUG, 'quoteItem.GUIA__c : ' + quoteItem.GUIA__c);
                    if(this.wp.objQuote.Tipo_de_documentacion__c == 'Guías prepagadas' || this.wp.objQuote.Tipo_de_documentacion__c == 'En Piso-Sipweb' || (this.wp.objQuote.Tipo_de_documentacion__c == 'Documentación Remota' && quoteItem.Tarifa__c !='SEG-DS' && quoteItem.Tarifa__c !='SEG-2D' && quoteItem.Tarifa__c !='SEG-A12' )){
                        if(this.mapQuotes.containsKey(quoteItem.Tarifa__c) && !quoteItem.ZonaPlus__c) {
                            this.mapQuotes.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                        }
                        if(this.mapQuotesZP.containsKey(quoteItem.Tarifa__c) && quoteItem.ZonaPlus__c){
                            this.mapQuotesZP.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                        }
                    } else if(this.wp.objQuote.Tipo_de_documentacion__c == 'Documentación Remota' && (quoteItem.Tarifa__c =='SEG-DS' || quoteItem.Tarifa__c =='SEG-2D' || quoteItem.Tarifa__c =='SEG-A12'  )){
                        if(!this.mapQuotesOD.containsKey(quoteItem.Tarifa__c)){
                            this.mapQuotesOD.put(quoteItem.Tarifa__c, new Map<String, Map<String, SBQQ__QuoteLine__c>>{ String.valueOf(quoteItem.GUIA__c) => new Map<String, SBQQ__QuoteLine__c>{quoteItem.Rango_KM__c => quoteItem } });
                           // this.listRangeOD.put(quoteItem.Tarifa__c, new Map<String, List<String>>{ String.valueOf(quoteItem.GUIA__c) => new List<String>{quoteItem.Rango_KM__c} });
                        }else if(!this.mapQuotesOD.get(quoteItem.Tarifa__c).containsKey(String.valueOf(quoteItem.GUIA__c))){
                            this.mapQuotesOD.get(quoteItem.Tarifa__c).put(String.valueOf(quoteItem.GUIA__c), new Map<String, SBQQ__QuoteLine__c>{quoteItem.Rango_KM__c => quoteItem });
                            //this.listRangeOD.get(quoteItem.Tarifa__c).put(String.valueOf(quoteItem.GUIA__c), new List<String>{quoteItem.Rango_KM__c});
                        }else if (!this.mapQuotesOD.get(quoteItem.Tarifa__c).get(String.valueOf(quoteItem.GUIA__c)).containsKey(quoteItem.Rango_KM__c)){
                            this.mapQuotesOD.get(quoteItem.Tarifa__c).get(String.valueOf(quoteItem.GUIA__c)).put(quoteItem.Rango_KM__c, quoteItem);
                            //this.listRangeOD.get(quoteItem.Tarifa__c).get(String.valueOf(quoteItem.GUIA__c)).add(quoteItem.Rango_KM__c);
                        }
    
                    }
    
                    if(quoteItem.Tarifa__c == 'TARIFA T7'){
                        if(quoteItem.PackWeightAVG__c != null)
                            this.mapT7W.put(quoteItem.Rango_KM__c, quoteItem.PackWeightAVG__c);
                        if(quoteItem.PackVolAVG__c != null)
                            this.mapT7V.put(quoteItem.Rango_KM__c, quoteItem.PackVolAVG__c);
                    }
    
                    if(quoteItem.ZonaPlus__c){
                        if(this.mapTotalDiscFeeZP.containsKey(quoteItem.Tarifa__c))
                            this.mapTotalDiscFeeZP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);
    
                    }
                    else if(quoteItem.Tarifa__c != 'SEG-DS' && quoteItem.Tarifa__c != 'SEG-2D' && quoteItem.Tarifa__c != 'SEG-A12') {
                        if(this.mapTotalDiscFee.containsKey(quoteItem.Tarifa__c))
                            this.mapTotalDiscFee.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);
    
                    }
    
                    if(quoteItem.Tarifa__c == 'SEG-DS'){
                        this.blnDS = true;
                        this.discDS = quoteItem.SBQQ__Discount__c;
                        if(quoteItem.SBQQ__VolumeDiscount__c != 0)
                            mapTotalDiscEXP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);
                        lEXP.add(quoteItem.Tarifa__c);
                        listGuide.add(String.valueOf(quoteItem.GUIA__c));
                    }
    
                    if(quoteItem.Tarifa__c == 'SEG-2D'){
                        this.bln2D = true;
                        this.disc2D = quoteItem.SBQQ__Discount__c;
                        if(quoteItem.SBQQ__VolumeDiscount__c != 0)
                            mapTotalDiscEXP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);
                        lEXP.add(quoteItem.Tarifa__c);
                        listGuide.add(String.valueOf(quoteItem.GUIA__c));
                    }
    
                    if(quoteItem.Tarifa__c == 'SEG-A12'){
                        this.blnA12 = true;
                        this.discA12 = quoteItem.SBQQ__Discount__c;
                        if(quoteItem.SBQQ__VolumeDiscount__c != 0)
                            mapTotalDiscEXP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);
                        lEXP.add(quoteItem.Tarifa__c);
                        listGuide.add(String.valueOf(quoteItem.GUIA__c));
                    }
    
                    if(this.blnDS || this.bln2D || this.blnA12){
                        if(Decimal.valueOf(lastGuide) < quoteItem.GUIA__c)
                            this.lastGuide = String.valueOf(quoteItem.GUIA__c);
                        this.ServicioExpress = true;
                        if(this.wp.objQuote.Tipo_de_documentacion__c == 'Guías prepagadas' || this.wp.objQuote.Tipo_de_documentacion__c == 'En Piso-Sipweb'){
                            if(mapQuotesEXP.containsKey(quoteItem.Tarifa__c))
                                this.mapQuotesEXP.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                            else
                                this.mapQuotesEXP.put(quoteItem.Tarifa__c, new Map<String, SBQQ__QuoteLine__c> {quoteItem.Rango_KM__c => quoteItem});
                        }
                    }
    
                } else if(this.mapQuotes.containsKey(quoteItem.Tarifa__c) && quoteItem.SBQQ__Quantity__c > 0)
                    this.mapQuotes.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                else
                    this.mapQuotes.put(quoteItem.Tarifa__c , new Map<String, SBQQ__QuoteLine__c> {quoteItem.Rango_KM__c => quoteItem});
            }
            

        }
        
        //System.debug(LoggingLevel.DEBUG, 'mapQuotes :' + JSON.serialize(this.mapQuotes));
        this.listRangeDestiny.addAll(setRange);

        for(String keyRange: this.listRangeDestiny){
            this.mapTotalByRange.put(keyRange, new QuoteWP());
            this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
            this.mapT7W.put(keyRange, 0);
            this.mapT7V.put(keyRange, 0);
            this.mapTotalesT7ZP.put(keyRange, 0);
        }
        for(String keyRange: this.listRangeT7){
            if (this.mapTotalesT7ZP.containsKey(this.mapQuotesT7ZP.get(keyRange).Rango_KM__c) && this.mapTotalesT7ZP.get(this.mapQuotesT7ZP.get(keyRange).Rango_KM__c) == 0)
                this.mapTotalesT7ZP.put(this.mapQuotesT7ZP.get(keyRange).Rango_KM__c,  this.mapQuotesT7ZP.get(keyRange).SBQQ__Quantity__c);
            else if(this.mapTotalesT7ZP.get(this.mapQuotesT7ZP.get(keyRange).Rango_KM__c) != 0){
                Decimal tempRangeCount = this.mapTotalesT7ZP.get(this.mapQuotesT7ZP.get(keyRange).Rango_KM__c);
                this.mapTotalesT7ZP.put(this.mapQuotesT7ZP.get(keyRange).Rango_KM__c, 0);
                this.mapTotalesT7ZP.put(this.mapQuotesT7ZP.get(keyRange).Rango_KM__c, tempRangeCount + this.mapQuotesT7ZP.get(keyRange).SBQQ__Quantity__c);
            }
        }

        for(String keyFee: this.listFee){
            for(String keyRange: this.listRangeDestiny){
                if(this.mapQuotes.get(keyFee).containsKey(keyRange) &&  this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0){
                    total += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                    if(this.mapQuotes.containsKey(keyFee) && this.mapQuotes.get(keyFee).containsKey(keyRange)){
                        if(this.mapQuotes.get(keyFee).get(keyRange).SBQQ__NetTotal__c != null)
                            totalAmount += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                        if(keyFee != 'TARIFA T7' && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                            totalAmountQ += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                        else if(keyFee == 'TARIFA T7' && this.wp.objQuote.TipoCotizacion__c == 'byDelivery' && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                            totalAmountQ += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                        else if(keyFee == 'TARIFA T7' && this.wp.objQuote.TipoCotizacion__c == 'byDimension' && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                            totalAmountQ += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;

                    }
                } else if(!this.mapQuotes.get(keyFee).containsKey(keyRange))
                    this.mapQuotes.get(keyFee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0, SBQQ__NetPrice__c = 0));

                if(keyFee == 'TARIFA T7'){
                    if(this.mapQuotes.get(keyFee).get(keyRange).PackWeightAVG__c != null)
                        this.mapT7W.put(keyRange, this.mapQuotes.get(keyFee).get(keyRange).PackWeightAVG__c);

                    if(this.mapQuotes.get(keyFee).get(keyRange).PackVolAVG__c != null)
                        this.mapT7V.put(keyRange, this.mapQuotes.get(keyFee).get(keyRange).PackVolAVG__c);

                }

                if(keyFee != 'TARIFA T7' && this.mapQuotesZP.get(keyFee).containsKey(keyRange) && this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0){
                    totalZP +=  this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                    if(this.mapQuotesZP.containsKey(keyFee) && this.mapQuotesZP.get(keyFee).containsKey(keyRange))
                    if(this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__NetTotal__c != null){
                        totalAmountZP += this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                        if(this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                            totalAmountQZP += this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                    }
                } else if( keyFee != 'TARIFA T7' && !this.mapQuotesZP.get(keyFee).containsKey(keyRange))
                    this.mapQuotesZP.get(keyFee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0, SBQQ__NetPrice__c = 0));

            }

        }
        if(decTotProp > 0 && decTotNormal > 0){
            descGral = ((decTotProp / decTotNormal) - 1) * 100;
            if(decTotNormal > 0)
                totalAmountZP += decTotNormal;
            if(decTotProp > 0)
                totalAmountQZP += decTotProp;
        }
        this.totalSTD = total;
        totalZP += totalPaq;
        this.totalSTDZP = totalZP;

        for(String keyFee: this.listFee){
            coutFee = 0;
            countFeeZP = 0;
            amount = 0;
            amountZP = 0;
            for(String keyRange: this.listRangeDestiny) {
                coutFee += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c ;
                if(keyFee != 'TARIFA T7' && this.mapQuotes.containsKey(keyFee) && this.mapQuotes.get(keyFee).containsKey(keyRange) && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                    amount += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                else if(keyFee == 'TARIFA T7' && this.wp.objQuote.TipoCotizacion__c == 'byDelivery' && this.mapQuotes.containsKey(keyFee) && this.mapQuotes.get(keyFee).containsKey(keyRange) && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                    amount += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                else if(keyFee == 'TARIFA T7' && this.wp.objQuote.TipoCotizacion__c == 'byDimension' && this.mapQuotes.containsKey(keyFee) && this.mapQuotes.get(keyFee).containsKey(keyRange) && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__SpecialPrice__c != null)
                    amount += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__SpecialPrice__c;
                if (keyFee != 'TARIFA T7'){
                    countFeeZP += this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                    if(this.mapQuotesZP.containsKey(keyFee) && this.mapQuotesZP.get(keyFee).containsKey(keyRange) && this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                        amountZP += this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                }
                
            }
            this.mapTotalByFee.put(keyFee, new QuoteWP(coutFee, total, amount));
            if(keyFee != 'TARIFA T7')
                this.mapTotalByFeeZP.put(keyFee, new QuoteWP(countFeeZP, totalZP, amountZP));
        }

        for(String keyFee: this.listFee){
            //System.debug('keyFee : ' + keyFee);
            for(String keyRange: this.listRangeDestiny){
                //System.debug('keyRange : ' + keyRange);
                if (this.mapTotalByRange.containsKey(keyRange) && this.mapTotalByRange.get(keyRange).totalPaquetes == 0)
                    this.mapTotalByRange.put(keyRange, new QuoteWP(this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c, total, 0));
                else if(!this.mapTotalByRange.containsKey(keyRange))
                    this.mapTotalByRange.put(keyRange, new QuoteWP());
                else if(this.mapTotalByRange.get(keyRange).totalPaquetes != 0){
                    Decimal tempRangeCount = this.mapTotalByRange.get(keyRange).totalPaquetes;
                    this.mapTotalByRange.put(keyRange, new QuoteWP(tempRangeCount + this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c, total, 0));
                }
                if(keyFee != 'TARIFA T7'){
                    if (this.mapTotalByRangeZP.containsKey(keyRange) && this.mapTotalByRangeZP.get(keyRange).totalPaquetes == 0)
                        this.mapTotalByRangeZP.put(keyRange, new QuoteWP(this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c, totalZP, 0));
                    else if (!this.mapTotalByRangeZP.containsKey(keyRange))
                            this.mapTotalByRangeZP.put(keyRange,new QuoteWP());
                    else if(this.mapTotalByRangeZP.get(keyRange).totalPaquetes != 0){
                        Decimal tempRangeCountZP = this.mapTotalByRangeZP.get(keyRange).totalPaquetes;
                        this.mapTotalByRangeZP.put(keyRange,  new QuoteWP( tempRangeCountZP + this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c, totalZP, 0));
                    }
                }
            }

        }
        Decimal paquetes = 0;
        for(String keyRange: this.listRangeDestiny){
            if(this.mapTotalesT7ZP != null){
                if(this.mapTotalesT7ZP.get(keyRange) > 0){
                    if (this.mapTotalByRangeZP.containsKey(keyRange) && this.mapTotalByRangeZP.get(keyRange).totalPaquetes == 0)
                        this.mapTotalByRangeZP.put(keyRange, new QuoteWP(this.mapTotalesT7ZP.get(keyRange), totalZP, 0));
                    else if (!this.mapTotalByRangeZP.containsKey(keyRange))
                        this.mapTotalByRangeZP.put(keyRange,new QuoteWP());
                    else if(this.mapTotalByRangeZP.get(keyRange).totalPaquetes != 0){
                        Decimal RespaldoConteo = this.mapTotalByRangeZP.get(keyRange).totalPaquetes;
                        this.mapTotalByRangeZP.put(keyRange,  new QuoteWP( RespaldoConteo + this.mapTotalesT7ZP.get(keyRange), totalZP, 0));
                    }
                    paquetes += this.mapTotalByRangeZP.get(keyRange).totalPaquetes;
                }
                
            }
        }
        if(paquetes > 0)
            porcFrec = totalPaq / paquetes * 100;
        
        // System.debug(LoggingLevel.DEBUG, 'totalAmount:BEFORE ' + totalAmount);
        // System.debug(LoggingLevel.DEBUG, 'totalAmountQ:BEFORE ' + totalAmountQ);
		for(String keyFee : this.listEXP ) {
            if(this.wp.objQuote.Tipo_de_documentacion__c == 'Guías prepagadas' || this.wp.objQuote.Tipo_de_documentacion__c == 'En Piso-Sipweb'){
                for (String keyRange : this.listRangeDestiny) {
                    if (this.mapQuotesEXP.containsKey(keyFee) &&
                            this.mapQuotesEXP.get(keyFee).containsKey(keyRange) &&
                            this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0
                    ) {
                        total += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                        this.mapTotalByFeeEXP.get(keyFee).totalPaquetes +=
                                this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                        if (this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c != null) {
                            totalAmount += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                            this.mapTotalByFeeEXP.get(keyFee).totalNormal +=
                                    this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                        }
                        if (this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null) {
                            totalAmountQ += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                            this.mapTotalByFeeEXP.get(keyFee).totalAmount +=
                                    this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                        }
                        if (this.mapQuotesEXP.get(keyFee).get(keyRange).SEG__c != null) {
                            // totalAmountSeg += this.mapQuotesEXP.get(keyFee).get(keyRange).SEG__c;
                            // System.debug(LoggingLevel.DEBUG, 'totalAmountSeg :' + totalAmountSeg);
                            this.mapTotalByFeeEXP.get(keyFee).totalSEG +=
                                    this.mapQuotesEXP.get(keyFee).get(keyRange).SEG__c;
                        }
                    } else if (this.mapQuotesEXP.containsKey(keyFee) &&
                            !this.mapQuotesEXP.get(keyFee).containsKey(keyRange))
                        this.mapQuotesEXP.get(keyFee).put(keyRange,
                                new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0,
                                        SBQQ__Discount__c = 0));
                }

                for (String keyRange : this.listRangeDestiny)
                    if (this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0 &&
                            this.mapTotalByFeeEXP.get(keyFee).totalPaquetes > 0 &&
                            this.mapTotalByRangeEXP.get(keyFee).containsKey(keyRange))
                        this.mapTotalByRangeEXP.get(keyFee).get(keyRange).frecPaquetes = (
                        this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c /
                        this.mapTotalByFeeEXP.get(keyFee).totalPaquetes) * 100 ;
                    else if (!this.mapTotalByRangeEXP.get(keyFee).containsKey(keyRange))
                        this.mapTotalByRangeEXP.get(keyFee).put(keyRange, new QuoteWP());

                if (this.mapTotalByFeeEXP.get(keyFee).totalNormal > 0)
                    this.mapTotalByFeeEXP.get(keyFee).totalDiscount = (
                    (this.mapTotalByFeeEXP.get(keyFee).totalAmount - this.mapTotalByFeeEXP.get(keyFee).totalSEG) /
                    (this.mapTotalByFeeEXP.get(keyFee).totalNormal - this.mapTotalByFeeEXP.get(keyFee).totalSEG) - 1) * 100;
            }else if(this.mapQuotesOD.containsKey(keyFee)){
                this.mapTotalByFeeOD.put(keyFee, new Map<String, QuoteWP>());
                for(String guide: this.mapQuotesOD.get(keyFee).keySet()){
                    this.mapTotalByFeeOD.get(keyFee).put(guide, new QuoteWP());
                    for(String keyRange: this.mapQuotesOD.get(keyFee).get(guide).keySet()){
                        if(this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__Quantity__c > 0){
                            total += this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__Quantity__c;
                            this.mapTotalByFeeOD.get(keyFee).get(guide).totalPaquetes += this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__Quantity__c;
                            if(this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__NetTotal__c != null){
                                totalAmount += this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__NetTotal__c;
                                this.mapTotalByFeeOD.get(keyFee).get(guide).totalNormal += this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__NetTotal__c;
                            }
                            if(this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__CustomerTotal__c != null){
                                totalAmountQ += this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__CustomerTotal__c;
                                this.mapTotalByFeeOD.get(keyFee).get(guide).totalAmount += this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__CustomerTotal__c;
                            }
                            if (this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SEG__c != null) {
                                this.mapTotalByFeeOD.get(keyFee).get(guide).totalSEG += this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SEG__c * this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__Quantity__c;
                            }
                        } else if(this.mapQuotesOD.containsKey(keyFee)
                                && this.mapQuotesOD.get(keyFee).containsKey(guide)
                                && !this.mapQuotesOD.get(keyFee).get(guide).containsKey(keyRange))

                            this.mapQuotesOD.get(keyFee).get(guide).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__NetPrice__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));
                    }
                }
            }
        }

        Decimal fltFrecc = 0;
        for(String keyFee : this.listEXP ){
            if(this.wp.objQuote.Tipo_de_documentacion__c == 'Documentación Remota'){
                for(String keyRange: this.listRangeDestiny){
                    fltFrecc = 0;
                    if(this.mapQuotesEXP.containsKey(keyFee) && this.mapQuotesEXP.get(keyFee).containsKey(keyRange) && this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0 && this.mapTotalByFeeEXP.containsKey(keyFee) && this.mapTotalByFeeEXP.get(keyFee).totalPaquetes > 0)
                        fltFrecc = (this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c / this.mapTotalByFeeEXP.get(keyFee).totalPaquetes) * 100;
                    if(!this.mapFrecc.containsKey(keyFee))
                        this.mapFrecc.put(keyFee, new Map<String, Decimal>{ keyRange =>  fltFrecc});
                    else
                        this.mapFrecc.get(keyFee).put(keyRange, fltFrecc);
                }
                if(this.mapQuotesOD.containsKey(keyFee))
                for(String guide: this.mapQuotesOD.get(keyFee).keySet()){
                    for(String keyRange: this.mapQuotesOD.get(keyFee).get(guide).keySet()){
                        fltFrecc = 0;
                        if(this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__Quantity__c > 0 && this.mapTotalByFeeOD.get(keyFee).get(guide).totalPaquetes > 0)
                            fltFrecc = this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__Quantity__c / this.mapTotalByFeeOD.get(keyFee).get(guide).totalPaquetes * 100;
                        if(!this.mapFreccOD.containsKey(keyFee))
                            this.mapFreccOD.put(keyFee, new Map<String, Map<String, Decimal>> { guide => new Map<String, Decimal>{ keyRange => fltFrecc }});
                        else if (this.mapFreccOD.containsKey(keyFee) && !this.mapFreccOD.get(keyFee).containsKey(guide))
                            this.mapFreccOD.get(keyFee).put(guide, new Map<String, Decimal>{ keyRange => fltFrecc });
                        else if(this.mapFreccOD.containsKey(keyFee) && this.mapFreccOD.get(keyFee).containsKey(guide) && !this.mapFreccOD.get(keyFee).get(guide).containsKey(keyRange))
                            this.mapFreccOD.get(keyFee).get(guide).put(keyRange, fltFrecc);

                    }
                    if(this.mapTotalByFeeOD.get(keyFee).get(guide).totalNormal > 0)
                        this.mapTotalByFeeOD.get(keyFee).get(guide).totalDiscount = ((this.mapTotalByFeeOD.get(keyFee).get(guide).totalAmount - this.mapTotalByFeeOD.get(keyFee).get(guide).totalSEG) / (this.mapTotalByFeeOD.get(keyFee).get(guide).totalNormal - this.mapTotalByFeeOD.get(keyFee).get(guide).totalSEG) -1) * 100;
                }
            }
            else {
                for(String keyRange: this.listRange){
                    fltFrecc = 0;
                    if(this.mapQuotesEXP.containsKey(keyFee) && this.mapQuotesEXP.get(keyFee).containsKey(keyRange) && this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0 && this.mapTotalByFeeEXP.containsKey(keyFee) && this.mapTotalByFeeEXP.get(keyFee).totalPaquetes > 0)
                        fltFrecc = (this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c / this.mapTotalByFeeEXP.get(keyFee).totalPaquetes) * 100;
                    if(!this.mapFrecc.containsKey(keyFee))
                        this.mapFrecc.put(keyFee, new Map<String, Decimal>{ keyRange =>  fltFrecc});
                    else
                        this.mapFrecc.get(keyFee).put(keyRange, fltFrecc);
                }
                if(this.mapQuotesOD.containsKey(keyFee))
                for(String guide: this.mapQuotesOD.get(keyFee).keySet()){
                    for(String keyRange: this.mapQuotesOD.get(keyFee).get(guide).keySet()){
                        fltFrecc = 0;
                        if(this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__Quantity__c > 0 && this.mapTotalByFeeOD.get(keyFee).get(guide).totalPaquetes > 0)
                            fltFrecc = this.mapQuotesOD.get(keyFee).get(guide).get(keyRange).SBQQ__Quantity__c / this.mapTotalByFeeOD.get(keyFee).get(guide).totalPaquetes * 100;
                        if(!this.mapFreccOD.containsKey(keyFee))
                            this.mapFreccOD.put(keyFee, new Map<String, Map<String, Decimal>> { guide => new Map<String, Decimal>{ keyRange => fltFrecc }});
                        else if (this.mapFreccOD.containsKey(keyFee) && !this.mapFreccOD.get(keyFee).containsKey(guide))
                            this.mapFreccOD.get(keyFee).put(guide, new Map<String, Decimal>{ keyRange => fltFrecc });
                        else if(this.mapFreccOD.containsKey(keyFee) && this.mapFreccOD.get(keyFee).containsKey(guide) && !this.mapFreccOD.get(keyFee).get(guide).containsKey(keyRange))
                            this.mapFreccOD.get(keyFee).get(guide).put(keyRange, fltFrecc);

                    }
                    if(this.mapTotalByFeeOD.get(keyFee).get(guide).totalNormal > 0)
                        this.mapTotalByFeeOD.get(keyFee).get(guide).totalDiscount = ((this.mapTotalByFeeOD.get(keyFee).get(guide).totalAmount - this.mapTotalByFeeOD.get(keyFee).get(guide).totalSEG) / (this.mapTotalByFeeOD.get(keyFee).get(guide).totalNormal - this.mapTotalByFeeOD.get(keyFee).get(guide).totalSEG) -1) * 100;
                }
            }
        }

		Decimal disc = 0;
        this.mapTotal.put('Full', totalAmount);
        this.mapTotal.put('Quote', totalAmountQ);
        /*System.debug(LoggingLevel.DEBUG, 'totalAmount :' + totalAmount);
        System.debug(LoggingLevel.DEBUG, 'totalAmountQ :' + totalAmountQ);
        System.debug(LoggingLevel.DEBUG, 'totalAmountSeg :' + totalAmountSeg);*/
        if(totalAmount > 0 )
			disc = ((totalAmountQ - totalAmountSeg) / (totalAmount - totalAmountSeg) - 1);
        //System.debug(LoggingLevel.DEBUG, 'disc :' + disc);

		this.mapTotal.put('Disc', disc);

		Decimal discZP = 0;
        this.mapTotalZP.put('Full', totalAmountZP);
        this.mapTotalZP.put('Quote', totalAmountQZP);
		if(totalAmountZP > 0 )
			discZP = ((totalAmountQZP - totalAmountSegZP)/ (totalAmountZP - totalAmountSegZP) - 1);

		this.mapTotalZP.put('Disc', discZP);

		mapSSOption = getPicklistValues('PAQ_SpecialService__c', 'Option__c');

		for(PAQ_SpecialService__c itemSS : querySS(this.wp.objQuote.Id)){
            if(String.isNotBlank(itemSS.Destiny__c))
                itemSS.RangoKM__c = itemSS.Destiny__c + ' ('+ itemSS.RangoKM__c +')';
            this.ServiciosEspeciales = true;
			itemSS.Option__c = mapSSOption.get(itemSS.Option__c);
            SS service = new SS(itemSS.MainDesinations__c, itemSS.Potencial__c);
            service.mapRanges.put(itemSS.RangoKM__c, itemSS);
            if(!this.wp.mapSS.containsKey(itemSS.Name))
                this.wp.mapSS.put(itemSS.Name, service);
            else
                this.wp.mapSS.get(itemSS.Name).mapRanges.put(itemSS.RangoKM__c, itemSS);
		}

        for(String strName : this.listSS){
            if(this.wp.mapSS.containsKey(strName)){
                for(String keyRange : listRangeDestiny){
                    if( !this.wp.mapSS.get(strName).mapRanges.containsKey(keyRange)){
                        this.wp.mapSS.get(strName).mapRanges.put(keyRange, new PAQ_SpecialService__c(Amount__c = 0, Option__c = '') );
                    }
                }
            }
            else{
                SS service = new SS ('', 0);
                for(String keyRange : listRangeDestiny){
                    service.mapRanges.put(keyRange, new PAQ_SpecialService__c(Amount__c = 0, Option__c = '') );
                }
                this.wp.mapSS.put(strName, service);
            }
        }
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Cantidad: ' + this.mapTotalesT7ZP));
        // System.debug(LoggingLevel.DEBUG, 'mapSS: ' + JSON.serialize(this.wp.mapSS) );
    }
    
    public Pagereference doRedireccionamiento(){
        if(this.T7ZonaPlus){
            PageReference pageRef = new PageReference('/apex/PAQ_COTResumenT7ZP?=&id=' + strId);
            pageRef.setRedirect(true);
            return pageRef;
        }else if(this.CBME){
            PageReference pageRef = new PageReference('/apex/PAQ_COTResumenCotizacionEXC_PAG?=&id=' + strId);
            pageRef.setRedirect(true);
            return pageRef;
        }else if (this.blnGMP){
            PageReference pageRef = new PageReference('/apex/PAQ_COTResumenCotizacionGMP_PAG?=&id=' + strId);
            pageRef.setRedirect(true);
            return pageRef;
        }
        else  return null;
    }
    
    public static SBQQ__Quote__c queryQuote(String strQuoteId){
        return [SELECT Id
        , Acuse__c
        , Modelo_de_tarifas__c
        , Servicios_adicionales__c
        , PAQ_TipoServicio__c
        , OriginPostalCode__c
        , SBQQ__ShippingPostalCode__c
        , OriginCity__c
        , SBQQ__ShippingCity__c
        , OriginState__c
        , SBQQ__ShippingState__c
        , Tipo_de_documentacion__c
        , TipoCotizacion__c
        , AVRDeliveryACK__c
        , AVRPackByDelivery__c
        , Descuento_por_linea_o_rangokm__c
        , SBQQ__Status__c
        , SBQQ__Opportunity2__c
        , SBQQ__Account__c
        , CreatedDate
        , LastModifiedDate
        , Owner.Name
        , Name
        , Paquetes_Mensuales__c
        , Ingreso_Mensual__c
        , SBQQ__NetAmount__c
        , Descuento_Global__c
        , TarifaLlenaMensual__c
        , PAQ_DescuentoGlobal__c
        , Plaza__c
        FROM SBQQ__Quote__c
        WHERE Id =: strQuoteId];
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
        WHERE SBQQ__Quote__c =: strQuoteId
        ORDER BY Tarifa__c, Rango_KM__c];
    }

    public static Account queryAccount(String strAccId){
        return [SELECT
        Name
        , Plaza_Envio__r.Name
        , Industry
        , Giro__c
        , RecordType.Name
        , Descripcion_de_la_mercancia__pc
        FROM Account WHERE Id =: strAccId];
    }

    public static Opportunity queryOpp(String strOppId){
        return [SELECT Tipo_de_paquetes__c
                , Tipo_de_comercio__c
                , Tratamiento_operativo__c
                , Forma_de_pago__c
                , Modelo_de_negocios__c
                , Mercanc_a__c
                , Contra_qui_n_competimos__c
                , Tipo_de_embalaje__c
                , Principal_destino1__r.Name
                , Principal_destino2__r.Name
                , Principal_destino_3__r.Name
                , Principal_destino_4__r.Name
                , Principal_destino_5__r.Name
                , Descripci_n_de_la_mercanc_a__c
                , Type
                FROM Opportunity
                WHERE Id =: strOppId];
    }

	public static List<PAQ_SpecialService__c> querySS (String strIdQuote){
		List<PAQ_SpecialService__c> listSS = new List<PAQ_SpecialService__c>();
		try{
			listSS = [SELECT Id, Name, Amount__c, Option__c, Potencial__c, MainDesinations__c, RangoKM__c, Destiny__c FROM PAQ_SpecialService__c WHERE Quote__c =: strIdQuote];
		} catch (Exception ex){
			System.debug(ex.getMessage());
		}
		return listSS;
	}

	public static Map<String, String> getPicklistValues( String strSObject, String strFieldSelected ){
		Schema.SObjectType objType                                  = Schema.getGlobalDescribe().get( strSObject );
		Schema.DescribeSObjectResult objDescribe                    = objType.getDescribe();
		Map<String, Schema.SObjectField> mapFieldsByName            = new Map<String, Schema.SObjectField>( objDescribe.fields.getMap() );

		Map<String, String> lstPicklist                              = new Map<String, String>();

		if( mapFieldsByName.containsKey( strFieldSelected ) ){
			List<Schema.PicklistEntry> lstPicklistValues            = mapFieldsByName.get( strFieldSelected ).getDescribe().getPickListValues();
			for( Schema.PicklistEntry rowValue : lstPicklistValues ){
				lstPicklist.put( rowValue.getValue(), rowValue.getLabel());
			}
		}

		return lstPicklist;
	}

    public class Wrapper {
        public SBQQ__Quote__c           objQuote            {get; set;}
        public Account					objAccount			{get; set;}
        public Opportunity				objOpp  			{get; set;}

        public List<SBQQ__QuoteLine__c> 	listQuoteItem   {get; set;}
		public Map<String,SS>				mapSS          	{get; set;}

        public Decimal perPack {get; set;}
        public Decimal perSob  {get; set;}
        public Decimal perEAD  {get; set;}
        public Decimal perZP   {get; set;}
        public Decimal perRAD  {get; set;}
        public Decimal perACK  {get; set;}
        public Decimal perSEG  {get; set;}

        public Wrapper (){
            this.listQuoteItem      = new List<SBQQ__QuoteLine__c>();
			this.mapSS				= new Map<String, SS>();
            perPack = 0;
            perSob = 0;
            perEAD = 0;
            perZP = 0;
            perRAD = 0;
            perACK = 0;
            perSEG = 0;
        }
    }

    public class QuoteWP{
        public Decimal totalPaquetes {get; set;}
        public Decimal frecPaquetes {get; set;}
        public Decimal totalAmount {get; set;}
        public Decimal totalNormal {get; set;}
        public Decimal totalSEG {get; set;}
        public Decimal totalDiscount {get; set;}

        public QuoteWP (){
            this.totalPaquetes = 0;
            this.frecPaquetes = 0;
            this.totalAmount = 0;
            this.totalNormal = 0;
            this.totalSEG = 0;
            this.totalDiscount = 0;
        }

		public QuoteWP(Decimal totalPaquetes, Decimal total, Decimal totalAmount){
			this.totalPaquetes = totalPaquetes;
            if(total > 0)
			    this.frecPaquetes = (totalPaquetes / total) * 100;
            else
                this.frecPaquetes = 0;

            this.totalAmount = totalAmount;
            /*System.debug('totalPaquetes : ' + this.totalPaquetes);
            System.debug('total : ' + total);
            System.debug('frecPaquetes : ' + this.frecPaquetes);*/
		}
    }

	public class SS{
		public String	MainDestinies 	{get; set;}
		public Decimal	Potential		{get; set;}
		public Map<String, PAQ_SpecialService__c> mapRanges {get; set;}
		public SS(String strMainDest, Decimal decPot){
			this.mapRanges = new Map<String, PAQ_SpecialService__c>();
			this.Potential = decPot;
			this.MainDestinies = strMainDest;
		}
	}
}
