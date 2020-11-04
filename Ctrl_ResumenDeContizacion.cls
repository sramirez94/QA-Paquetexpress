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
    public List<String> listRange           {get; set;}
    public List<String> listSS              {get; set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesZP {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesEXP {get;set;}
    public Map<String, QuoteWP>  mapTotalByRange {get; set;}
    public Map<String, QuoteWP>  mapTotalByFee {get; set;}
    public Map<String, QuoteWP>  mapTotalByRangeZP {get; set;}
    public Map<String, QuoteWP>  mapTotalByFeeZP {get; set;}
    public Map<String, Map<String, QuoteWP>>  mapTotalByRangeEXP {get; set;}
	public Map<String, QuoteWP>  mapTotalByFeeEXP {get; set;}
    public Map<String, Decimal> mapT7W {get; set;}
    public Map<String, Decimal> mapT7V {get; set;}
    public Map<String, Decimal> mapTotal {get; set;}
    public Map<String, Decimal> mapTotalZP {get; set;}
    public Map<String, Decimal> mapTotalDiscFee {get; set;}
    public Map<String, Decimal> mapTotalDiscFeeZP {get; set;}
    public Map<String, Decimal> mapTotalDiscEXP {get; set;}
    public Map<String, Map<String, Decimal>> mapFrecc {get; set;}
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
        Decimal totalAmountQZP = 0;
        Decimal totalAmountSeg = 0;
        Decimal totalAmountSegZP = 0;
		Map<String, String> mapSSOption = new Map<String, String>();

        this.blnRAD = false;
        this.blnEAD = false;
        this.blnZP = false;
        this.blnSEG = false;
        this.blnACK = false;
        this.blnDS = false;
        this.bln2D = false;
        this.blnA12 = false;

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
        this.wp                      = new Wrapper();

        this.mapQuotes               = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesZP             = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesEXP            = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapTotalByRange         = new Map<String, QuoteWP>();
        this.mapTotalByRangeZP       = new Map<String, QuoteWP>();
        this.mapTotalByRangeEXP      = new Map<String, Map<String, QuoteWP>>();
		this.mapTotalByFee           = new Map<String, QuoteWP>();
		this.mapTotalByFeeZP         = new Map<String, QuoteWP>();
		this.mapTotalByFeeEXP        = new Map<String, QuoteWP>();
        this.mapT7W                  = new Map<String, Decimal>();
        this.mapT7V                  = new Map<String, Decimal>();
        this.mapTotal                = new Map<String, Decimal>();
        this.mapTotalZP              = new Map<String, Decimal>();
        this.mapTotalDiscFee         = new Map<String, Decimal>();
        this.mapTotalDiscFeeZP       = new Map<String, Decimal>();
        this.mapTotalDiscEXP         = new Map<String, Decimal>();
        this.mapFrecc                = new Map<String, Map<String, Decimal>>();

        this.mapTotalZP.put('Disc', 0);
        this.mapTotal.put('Disc', 0);
        this.mapTotal.put('Full', 0);
        this.mapTotalZP.put('Full', 0);
        this.mapTotal.put('Quote', 0);
        this.mapTotalZP.put('Quote', 0);

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
                else
                    for (String fee : new List<String>{ 'TARIFA T7-P', 'TARIFA T7-V'})
                        if(!this.mapQuotes.containsKey(fee))
                            this.mapQuotes.put(fee, new Map<String, SBQQ__QuoteLine__c>{keyRange => new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0)});
                        else if(!this.mapQuotes.get(fee).containsKey(keyRange))
                            this.mapQuotes.get(fee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));
            }
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
		//System.debug(JSON.serialize(this.mapTotalByRangeEXP));

        for(String keyRange: this.listRange){
            this.mapTotalByRange.put(keyRange, new QuoteWP());
            this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
            this.mapT7W.put(keyRange, 0);
            this.mapT7V.put(keyRange, 0);
        }

        this.wp.objQuote = queryQuote(sc.getId());

        if(wp.objQuote.PAQ_DescuentoGlobal__c != null)
            this.wp.objQuote.PAQ_DescuentoGlobal__c = wp.objQuote.PAQ_DescuentoGlobal__c / 100;

        if(this.wp.objQuote.Tipo_de_documentacion__c == 'Guías prepagadas' || this.wp.objQuote.Tipo_de_documentacion__c == 'En Piso-Sipweb'){
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
        }
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

        for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItem){
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

                if(this.mapQuotes.containsKey(quoteItem.Tarifa__c) && !quoteItem.ZonaPlus__c) {
                    this.mapQuotes.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                }
                if(this.mapQuotesZP.containsKey(quoteItem.Tarifa__c) && quoteItem.ZonaPlus__c){
                    this.mapQuotesZP.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                }

                if(quoteItem.Tarifa__c == 'TARIFA T7'){
                    if(quoteItem.PackWeightAVG__c != null)
                        this.mapT7W.put(quoteItem.Rango_KM__c, quoteItem.PackWeightAVG__c);
                    if(quoteItem.PackVolAVG__c != null)
                        this.mapT7V.put(quoteItem.Rango_KM__c, quoteItem.PackVolAVG__c);
                }

                if(quoteItem.Tarifa__c == 'TARIFA T7-P' && this.mapT7W.get(quoteItem.Rango_KM__c) == 0)
                    this.mapT7W.put(quoteItem.Rango_KM__c, quoteItem.PackWeightAVG__c);

                if(quoteItem.Tarifa__c == 'Tarifa T7-V' && this.mapT7V.get(quoteItem.Rango_KM__c) == 0)
                    this.mapT7V.put(quoteItem.Rango_KM__c, quoteItem.PackVolAVG__c);



                if(quoteItem.ZonaPlus__c){
                    if(this.mapTotalDiscFeeZP.containsKey(quoteItem.Tarifa__c))
                        this.mapTotalDiscFeeZP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);

                }
                else if(quoteItem.Tarifa__c != 'SEG-DS' || quoteItem.Tarifa__c != 'SEG-2D' || quoteItem.Tarifa__c != 'SEG-A12') {
                    if(this.mapTotalDiscFee.containsKey(quoteItem.Tarifa__c))
                        this.mapTotalDiscFee.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);

                }

				//System.debug(LoggingLevel.DEBUG, 'Tarifa: '+ quoteItem.Tarifa__c);

                if(quoteItem.Tarifa__c == 'SEG-DS'){
                    this.blnDS = true;
                    this.discDS = quoteItem.SBQQ__Discount__c;
                    if(quoteItem.SBQQ__VolumeDiscount__c != 0)
                        mapTotalDiscEXP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);
                }

                if(quoteItem.Tarifa__c == 'SEG-2D'){
                    this.bln2D = true;
                    this.disc2D = quoteItem.SBQQ__Discount__c;
                    if(quoteItem.SBQQ__VolumeDiscount__c != 0)
                        mapTotalDiscEXP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);
                }

                if(quoteItem.Tarifa__c == 'SEG-A12'){
                    this.blnA12 = true;
                    this.discA12 = quoteItem.SBQQ__Discount__c;
                    if(quoteItem.SBQQ__VolumeDiscount__c != 0)
                        mapTotalDiscEXP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);
                }

				if(this.blnDS || this.bln2D || this.blnA12){
					this.ServicioExpress = true;
					if(mapQuotesEXP.containsKey(quoteItem.Tarifa__c))
						this.mapQuotesEXP.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
					else
						this.mapQuotesEXP.put(quoteItem.Tarifa__c, new Map<String, SBQQ__QuoteLine__c> {quoteItem.Rango_KM__c => quoteItem});
				}

            } else if(this.mapQuotes.containsKey(quoteItem.Tarifa__c))
                this.mapQuotes.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
            else
                this.mapQuotes.put(quoteItem.Tarifa__c , new Map<String, SBQQ__QuoteLine__c> {quoteItem.Rango_KM__c => quoteItem});

        }



        for(String keyFee: this.listFee){
            for(String keyRange: this.listRange){
                if(this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0){
                    total += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                    if(this.mapQuotes.containsKey(keyFee) && this.mapQuotes.get(keyFee).containsKey(keyRange)){
                        if(this.mapQuotes.get(keyFee).get(keyRange).SBQQ__NetTotal__c != null)
                            totalAmount += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                        if(keyFee != 'TARIFA T7' && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                            totalAmountQ += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                        else if (keyFee == 'TARIFA T7' && wp.objQuote.TipoCotizacion__c == 'byDelivery' && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                            totalAmountQ += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                        else if(this.mapQuotes.get(keyFee).get(keyRange).QuoteTotal__c != null)
                            totalAmountQ += (this.mapQuotes.get(keyFee).get(keyRange).QuoteTotal__c);
                    }
                }




                if(keyFee != 'TARIFA T7' && this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0){
                    totalZP +=  this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                    if(this.mapQuotesZP.containsKey(keyFee) && this.mapQuotesZP.get(keyFee).containsKey(keyRange))
                        if(this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__NetTotal__c != null){
                            totalAmountZP += this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                        if(this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                            totalAmountQZP += this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                    }
                }

            }
		}

        this.totalSTD = total;
        this.totalSTDZP = totalZP;

        for(String keyFee: this.listFee){
            coutFee = 0;
            countFeeZP = 0;
            amount = 0;
            amountZP = 0;
            for(String keyRange: this.listRange) {
                coutFee += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c ;
                if(this.mapQuotes.containsKey(keyFee) && this.mapQuotes.get(keyFee).containsKey(keyRange) && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null)
                    amount += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
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
            for(String keyRange: this.listRange){
                //System.debug('keyRange : ' + keyRange);
                if (this.mapTotalByRange.get(keyRange).totalPaquetes == 0)
                    this.mapTotalByRange.put(keyRange, new QuoteWP(this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c, total, 0));
                else{
                    Decimal tempRangeCount = this.mapTotalByRange.get(keyRange).totalPaquetes;
                    this.mapTotalByRange.put(keyRange, new QuoteWP(tempRangeCount + this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c, total, 0));
                }
                if(keyFee != 'TARIFA T7'){
                    if (this.mapTotalByRangeZP.get(keyRange).totalPaquetes == 0)
                        this.mapTotalByRangeZP.put(keyRange, new QuoteWP(this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c, totalZP, 0));
                    else{
                        Decimal tempRangeCountZP = this.mapTotalByRangeZP.get(keyRange).totalPaquetes;
                        this.mapTotalByRangeZP.put(keyRange,  new QuoteWP( tempRangeCountZP + this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c, totalZP, 0));
                    }
                }

            }

        }
        // System.debug(LoggingLevel.DEBUG, 'totalAmount:BEFORE ' + totalAmount);
        // System.debug(LoggingLevel.DEBUG, 'totalAmountQ:BEFORE ' + totalAmountQ);
		for(String keyFee : this.listEXP ){
			for(String keyRange: this.listRange){
				if(this.mapQuotesEXP.containsKey(keyFee)
					&& this.mapQuotesEXP.get(keyFee).containsKey(keyRange)
                    && this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0
                ){
					System.debug(LoggingLevel.DEBUG, 'keyFee: '+ keyFee);
					total += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
					this.mapTotalByFeeEXP.get(keyFee).totalPaquetes += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                    System.debug(LoggingLevel.DEBUG, 'keyRange: '+ keyRange);
					if(this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c != null){
						totalAmount += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                        this.mapTotalByFeeEXP.get(keyFee).totalNormal += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                    }
                    System.debug(LoggingLevel.DEBUG, 'totalNormal: ' + this.mapTotalByFeeEXP.get(keyFee).totalNormal);
					if(this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null){
						totalAmountQ += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                        this.mapTotalByFeeEXP.get(keyFee).totalAmount += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                    }
                    System.debug(LoggingLevel.DEBUG, 'totalAmountQ: ' + this.mapTotalByFeeEXP.get(keyFee).totalAmount);
                    if(this.mapQuotesEXP.get(keyFee).get(keyRange).SEG__c != null){
                        // totalAmountSeg += this.mapQuotesEXP.get(keyFee).get(keyRange).SEG__c;
                        // System.debug(LoggingLevel.DEBUG, 'totalAmountSeg :' + totalAmountSeg);
                        this.mapTotalByFeeEXP.get(keyFee).totalSEG += this.mapQuotesEXP.get(keyFee).get(keyRange).SEG__c;
                    }
				}
			}

            for(String keyRange: this.listRange)
                if(this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0 && this.mapTotalByFeeEXP.get(keyFee).totalPaquetes > 0)
                    this.mapTotalByRangeEXP.get(keyFee).get(keyRange).frecPaquetes = (this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c / this.mapTotalByFeeEXP.get(keyFee).totalPaquetes ) * 100 ;

            if(this.mapTotalByFeeEXP.get(keyFee).totalNormal > 0)
                this.mapTotalByFeeEXP.get(keyFee).totalDiscount = ((this.mapTotalByFeeEXP.get(keyFee).totalAmount - this.mapTotalByFeeEXP.get(keyFee).totalSEG) / (this.mapTotalByFeeEXP.get(keyFee).totalNormal - this.mapTotalByFeeEXP.get(keyFee).totalSEG) -1) * 100;
		}

        Decimal fltFrecc = 0;
        for(String keyFee : this.listEXP ){
            for(String keyRange: this.listRange){
                fltFrecc = 0;
                if(this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0 && this.mapTotalByFeeEXP.get(keyFee).totalPaquetes > 0)
                    fltFrecc = (this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c / this.mapTotalByFeeEXP.get(keyFee).totalPaquetes) * 100;
                if(!this.mapFrecc.containsKey(keyFee))
                    this.mapFrecc.put(keyFee, new Map<String, Decimal>{ keyRange =>  fltFrecc});
                else
                    this.mapFrecc.get(keyFee).put(keyRange, fltFrecc);
            }
        }

		Decimal disc = 0;
        this.mapTotal.put('Full', totalAmount);
        this.mapTotal.put('Quote', totalAmountQ);
        System.debug(LoggingLevel.DEBUG, 'totalAmountSeg :' + totalAmountSeg);
		if(totalAmount > 0 )
			disc = ((totalAmountQ - totalAmountSeg) / (totalAmount - totalAmountSeg) - 1) * 100;

		this.mapTotal.put('Disc', disc);

		Decimal discZP = 0;
        this.mapTotalZP.put('Full', totalAmountZP);
        this.mapTotalZP.put('Quote', totalAmountQZP);
		if(totalAmountZP > 0 )
			discZP = ((totalAmountQZP - totalAmountSegZP)/ (totalAmountZP - totalAmountSegZP) - 1) * 100;

		this.mapTotalZP.put('Disc', discZP);

		mapSSOption = getPicklistValues('PAQ_SpecialService__c', 'Option__c');

		for(PAQ_SpecialService__c itemSS : querySS(this.wp.objQuote.Id)){
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
                for(String keyRange : listRange){
                    if( !this.wp.mapSS.get(strName).mapRanges.containsKey(keyRange)){
                        this.wp.mapSS.get(strName).mapRanges.put(keyRange, new PAQ_SpecialService__c(Amount__c = 0, Option__c = '') );
                    }
                }
            }
            else{
                SS service = new SS ('', 0);
                for(String keyRange : listRange){
                    service.mapRanges.put(keyRange, new PAQ_SpecialService__c(Amount__c = 0, Option__c = '') );
                }
                this.wp.mapSS.put(strName, service);
            }
        }

        //System.debug(LoggingLevel.DEBUG, 'mapSS: ' + JSON.serialize(this.wp.mapSS) );
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
        FROM SBQQ__QuoteLine__c
        WHERE SBQQ__Quote__c =: strQuoteId
        ORDER BY CreatedDate ASC];
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
			listSS = [SELECT Id, Name, Amount__c, Option__c, Potencial__c, MainDesinations__c, RangoKM__c FROM PAQ_SpecialService__c WHERE Quote__c =: strIdQuote];
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