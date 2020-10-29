public class PAQ_COTResumenCotizacionEXC_CTR {

    public Wrapper wp                                                       {get; set;}
    public List<String> listFee                                             {get; set;}
    public List<String> listFeeZP                                           {get; set;}
    public Map<Decimal, Decimal> mapGuide                                   {get; set;}
    public List<String> listRange                                           {get; set;}
    public List<String> listRangeDestiny                                    {get; set;}
    public List<Decimal> listKg30                                           {get; set;}
    public List<Decimal> listKg70                                           {get; set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes           {get; set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesZP         {get; set;}
    public Map<String, QuoteWP>  mapTotalByRange                            {get; set;}
    public Map<String, QuoteWP>  mapTotalByFee                              {get; set;}
    public Map<String, QuoteWP>  mapTotalByRangeZP                          {get; set;}
    public Map<String, QuoteWP>  mapTotalByFeeZP                            {get; set;}
    public Map<String, Decimal> mapT7W                                      {get; set;}
    public Map<String, Decimal> mapT7V                                      {get; set;}
    public Map<String, Decimal> mapTotal                                    {get; set;}
    public Map<String, Decimal> mapTotalZP                                  {get; set;}
    public Map<String, Decimal> mapTotalDiscFee                             {get; set;}
    public Map<String, Decimal> mapTotalDiscFeeZP                           {get; set;}
    public Map<String, Map<String, Decimal>> mapFrecc                       {get; set;}
    public Map<String, Map<Decimal, String>> mapCircleClass                 {get; set;}
    public Boolean blnRAD                                                   {get; set;}
    public Boolean blnEAD                                                   {get; set;}
    public Boolean blnZP                                                    {get; set;}
    public Boolean blnSEG                                                   {get; set;}
    public Boolean blnACK                                                   {get; set;}
    public Decimal totalSTD                                                 {get; set;}
    public Decimal totalSTDZP                                               {get; set;}
    public Decimal total                                                    {get; set;}
    public Decimal totalZP                                                  {get; set;}
    public Map<String, Block> mapBlocks                                     {get; set;}
    public Map<String, Block> mapService                                    {get; set;}
    public Map<Decimal, Map<String, Decimal>> mapDiscounts                  {get; set;}
    public Decimal decSEG                                                   {get; set;}
    public Map<Decimal, String> mapTarifasName                              {get; set;}
    public Map<String, String> mapTarifasKey                                {get; set;}
    public string Id                                                        {get; set;}
    //public map<String, Map<String, decimal>> mapProjEX                      {get; set;}
    public wpExcedente mapProjEX                                            {get; set;}
    public map<String, decimal> mapPruebas                                 {get;set;}
    public map<String, String> mapRangosByDest                              {get; set;}
    public boolean blnByDestiny                                             {get; set;}
    public List<string> listBlocksT7                                        {get; set;}
    public List<string> listBlocksT7Desc                                    {get; set;}
    public boolean blnBloquesT7                                             {get; set;}

    public PAQ_COTResumenCotizacionEXC_CTR (ApexPages.StandardController sc){
        this.Id                     = sc.getId();
        this.total                  = 0;
        this.totalZP                = 0;
        this.blnRAD                 = false;
        this.blnEAD                 = false;
        this.blnZP                  = false;
        this.blnSEG                 = false;
        this.blnACK                 = false;
        this.blnBloquesT7           = false;
        this.decSEG                 = 0;
        this.mapBlocks              = new Map<String, Block>();
        this.mapPruebas             = new Map<String, Decimal>();
        this.mapService             = new Map<String, Block>{
                                        'ADD' => new Block('ADD',0,0,0)
                                        , 'ACK' => new Block('ACK',0,0,0)
                                        , 'ZP' => new Block('ZP',0,0,0)
                                    };
        this.mapDiscounts           = new Map<Decimal, Map<String, Decimal>>();
        this.listFee                = new List<String> {
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
        this.listFeeZP              = new List<String> {
                                        'TARIFA SOBRE'
                                        , 'TARIFA T0'
                                        , 'TARIFA T1'
                                        , 'TARIFA T2'
                                        , 'TARIFA T3'
                                        , 'TARIFA T4'
                                        , 'TARIFA T5'
                                        , 'TARIFA T6'
                                    };
        this.mapGuide               = new Map<Decimal, Decimal>();
        this.listRange              = new List<String> {
                                        '0-400'
                                        , '401-800'
                                        , '801-1200'
                                        , '1201-1600'
                                        , '1601-2000'
                                        , '2001-2400'
                                        , 'Más de 2400'
                                     };
        this.mapTarifasName          = new Map<Decimal, String>();
        this.mapTarifasKey           = new Map<String, String>{
                                        'TARIFA SOBRE' => 'TS'
                                        , 'TARIFA T0' => 'T0'
                                        , 'TARIFA T1' => 'T1'
                                        , 'TARIFA T2' => 'T2'
                                        , 'TARIFA T3' => 'T3'
                                        , 'TARIFA T4' => 'T4'
                                        , 'TARIFA T5' => 'T5'
                                        , 'TARIFA T6' => 'T6'
                                        , 'TARIFA T7' => 'T7'
                                    };
        this.listBlocksT7            = new list<String>();
        this.listBlocksT7Desc        = new list<String>();
        this.wp                      = new Wrapper();
        this.mapProjEX               = new wpExcedente();
        this.mapQuotes               = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesZP             = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapTotalByRange         = new Map<String, QuoteWP>();
        this.mapTotalByRangeZP       = new Map<String, QuoteWP>();
        this.mapTotalByFee           = new Map<String, QuoteWP>();
        this.mapTotalByFeeZP         = new Map<String, QuoteWP>();
        this.mapT7W                  = new Map<String, Decimal>();
        this.mapT7V                  = new Map<String, Decimal>();
        this.mapTotal                = new Map<String, Decimal>();
        this.mapTotalZP              = new Map<String, Decimal>();
        this.mapTotalDiscFee         = new Map<String, Decimal>();
        this.mapTotalDiscFeeZP       = new Map<String, Decimal>();
        this.mapFrecc                = new Map<String, Map<String, Decimal>>();
        this.mapCircleClass          = new Map<String, Map<Decimal, String>>{
                                        'MAX' => new Map<Decimal, String>()
                                        , 'AVG' => new Map<Decimal, String>()
                                        , 'MAXZP' => new Map<Decimal, String>()
                                        , 'AVGZP' => new Map<Decimal, String>()
                                     };
        this.mapRangosByDest        = new Map<String, String>();
        this.listRangeDestiny        = new List<String>();
        this.listKg30                = new List<Decimal>();
        this.listKg70                = new List<Decimal>();
        this.blnByDestiny            = false;
        Decimal coutFee              = 0;
        Decimal countFeeZP           = 0;
        Decimal amount               = 0;
        Decimal amountZP             = 0;
        Decimal totalAmount          = 0;
        Decimal totalAmountZP        = 0;
        Decimal totalAmountQ         = 0;
        Decimal totalAmountQZP       = 0;
        Decimal totalAmountSeg       = 0;
        Decimal totalAmountSegZP     = 0;



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
            }
        }
        /*for(String keyRange: this.listRange)
            for (String fee : new List<String>{ 'TARIFA T7-P', 'TARIFA T7-V'})
                if(!this.mapQuotes.containsKey(fee))
                    this.mapQuotes.put(fee, new Map<String, SBQQ__QuoteLine__c>{keyRange => new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0)});
                else if(!this.mapQuotes.get(fee).containsKey(keyRange))
                    this.mapQuotes.get(fee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));

        for(String keyRange: this.listRange){
            if(!this.mapService.get('ADD').mapRanges.containsKey(keyRange))
                this.mapService.get('ADD').mapRanges.put(keyRange, 0);

            if(!this.mapService.get('ACK').mapRanges.containsKey(keyRange))
                this.mapService.get('ACK').mapRanges.put(keyRange, 0);

            if(quoteItem.ZonaPlus__c && !this.mapService.get('ZP').mapRanges.containsKey(keyRange))
                this.mapService.get('ZP').mapRanges.put(keyRange, 0);
        }
        /*System.debug(LoggingLevel.DEBUG, 'mapQuotes :' + JSON.serialize(this.mapQuotes));
        System.debug(LoggingLevel.DEBUG, 'mapQuotesZP :' + JSON.serialize(this.mapQuotemapQuotesZP));*/

        this.wp.objQuote = queryQuote(sc.getId());

        if(wp.objQuote.PAQ_DescuentoGlobal__c != null)
            this.wp.objQuote.PAQ_DescuentoGlobal__c = wp.objQuote.PAQ_DescuentoGlobal__c / 100;


        if (String.isNotBlank(this.wp.objQuote.Acuse__c))
            this.blnACK = true;
        if(String.isNotBlank(wp.objQuote.SBQQ__Account__c))
            this.wp.objAccount = queryAccount(wp.objQuote.SBQQ__Account__c);
        if(String.isNotBlank(wp.objQuote.SBQQ__Opportunity2__c))
            this.wp.objOpp = queryOpp(wp.objQuote.SBQQ__Opportunity2__c);

        this.wp.listQuoteItem = queryQuoteItem(sc.getId());

        if(String.isNotBlank(this.wp.objQuote.Servicios_adicionales__c)){
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
                    when 'EAD Zona plus'{
                        this.blnZP = true;
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
        }
        Set<String> setRange = new Set<String>();
        Integer indexOD = 0;
        Map<Decimal, Map<String, Decimal>> mapRangesByBlock = new Map<Decimal, Map<String, Decimal>>();
        for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItem){
            if(String.isNotBlank(quoteItem.Destiny__c)){
                this.mapRangosByDest.put(quoteitem.Destiny__c, quoteItem.Rango_KM__c);
                quoteItem.Rango_KM__c = quoteItem.Destiny__c;
                blnByDestiny = true;
            }
                
            setRange.add(quoteItem.Rango_KM__c);
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
                    /*if(this.blnEAD)
                        this.blnZP = true;*/
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

                if(quoteItem.ZonaPlus__c){
                    if(this.mapTotalDiscFeeZP.containsKey(quoteItem.Tarifa__c))
                        this.mapTotalDiscFeeZP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);

                }

                if(!this.mapGuide.containsKey(quoteItem.PackWeightAVG__c))
                    this.mapGuide.put(quoteItem.PackWeightAVG__c, quoteItem.PackVolAVG__c);

                if(!mapRangesByBlock.containsKey(quoteItem.PackWeightAVG__c))
                    mapRangesByBlock.put(quoteItem.PackWeightAVG__c, new Map<String, Decimal>{quoteItem.Rango_KM__c => quoteItem.FLETE__c});
                else if(!mapRangesByBlock.get(quoteItem.PackWeightAVG__c).containsKey(quoteItem.Rango_KM__c))
                    mapRangesByBlock.get(quoteItem.PackWeightAVG__c).put(quoteItem.Rango_KM__c , quoteItem.FLETE__c);

                if(!this.mapService.get('ADD').mapRanges.containsKey(quoteItem.Rango_KM__c))
                    this.mapService.get('ADD').mapRanges.put(quoteItem.Rango_KM__c, quoteItem.KG_ADICIONAL__c);

                if(!this.mapService.get('ACK').mapRanges.containsKey(quoteItem.Rango_KM__c))
                    this.mapService.get('ACK').mapRanges.put(quoteItem.Rango_KM__c, quoteItem.ACK__c);

                if(quoteItem.ZonaPlus__c && !this.mapService.get('ZP').mapRanges.containsKey(quoteItem.Rango_KM__c))
                    this.mapService.get('ZP').mapRanges.put(quoteItem.Rango_KM__c, quoteItem.EAD__c);
            }

            if(this.mapQuotes.containsKey(quoteItem.Tarifa__c) ){
                if(quoteItem.ZonaPlus__c)
                    this.mapQuotesZP.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                else
                    this.mapQuotes.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
            }
            else{
                if(quoteItem.ZonaPlus__c)
                    this.mapQuotesZP.put(quoteItem.Tarifa__c , new Map<String, SBQQ__QuoteLine__c> {quoteItem.Rango_KM__c => quoteItem});
                else
                    this.mapQuotes.put(quoteItem.Tarifa__c , new Map<String, SBQQ__QuoteLine__c> {quoteItem.Rango_KM__c => quoteItem});
            }
            if(this.blnSEG && this.decSEG == 0)
                this.decSEG = quoteItem.SEG__c;
        }
        

        //System.debug(LoggingLevel.DEBUG, 'mapQuotes :' + JSON.serialize(this.mapQuotes));
        this.listRangeDestiny.addAll(setRange);
        Integer blockCounter = 1;



        /*if(blnByDestiny){
            LlenaMapas(this.listRange);
        } else {
            LlenaMapas(this.listRangeDestiny);
        }*/
        

        
        

        
        /*for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItem){
            for(String keyRange: this.listRangeDestiny){

                if(!mapRangesByBlock.containsKey(quoteItem.PackWeightAVG__c))
                    mapRangesByBlock.put(quoteItem.PackWeightAVG__c, new Map<String, Decimal>{keyRange => quoteItem.FLETE__c});
                else if(!mapRangesByBlock.get(quoteItem.PackWeightAVG__c).containsKey(keyRange))
                    mapRangesByBlock.get(quoteItem.PackWeightAVG__c).put(keyRange , quoteItem.FLETE__c);

                
                if(!this.mapService.get('ADD').mapRanges.containsKey(keyRange))
                    this.mapService.get('ADD').mapRanges.put(keyRange, quoteItem.KG_ADICIONAL__c);

                if(!this.mapService.get('ACK').mapRanges.containsKey(keyRange))
                    this.mapService.get('ACK').mapRanges.put(keyRange, quoteItem.ACK__c);

                if(quoteItem.ZonaPlus__c && !this.mapService.get('ZP').mapRanges.containsKey(keyRange))
                    this.mapService.get('ZP').mapRanges.put(keyRange, quoteItem.EAD__c);


                if(this.mapQuotes.containsKey(quoteItem.Tarifa__c) ){
                    if(quoteItem.ZonaPlus__c)
                        this.mapQuotesZP.get(quoteItem.Tarifa__c).put(keyRange, quoteItem);
                    else
                        this.mapQuotes.get(quoteItem.Tarifa__c).put(keyRange, quoteItem);
                }
                else{
                    if(quoteItem.ZonaPlus__c)
                        this.mapQuotesZP.put(quoteItem.Tarifa__c , new Map<String, SBQQ__QuoteLine__c> {keyRange => quoteItem});
                    else
                        this.mapQuotes.put(quoteItem.Tarifa__c , new Map<String, SBQQ__QuoteLine__c> {keyRange => quoteItem});
                }
            }
        }*/

        for(Decimal decW : this.mapGuide.keySet()){
            this.mapBlocks.put('BLOQUE '+ blockCounter, new Block('BLOQUE '+ blockCounter, decW, this.mapGuide.get(decW), this.mapGuide.get(decW) * 200) );
            this.mapBlocks.get('BLOQUE '+ blockCounter).mapRanges = mapRangesByBlock.get(decW);
            blockCounter++;
        }
        for(String keyRange: this.listRangeDestiny){
            this.mapTotalByRange.put(keyRange, new QuoteWP());
            this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
            this.mapT7W.put(keyRange, 0);
            this.mapT7V.put(keyRange, 0);
        }
        /*for(String keyRange: this.listRange){
            this.mapTotalByRange.put(keyRange, new QuoteWP());
            this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
            this.mapT7W.put(keyRange, 0);
            this.mapT7V.put(keyRange, 0);
        }*/

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
                    if(this.mapQuotes.get(keyFee).get(keyRange).Weight__c != null)
                        this.mapT7W.put(keyRange, this.mapQuotes.get(keyFee).get(keyRange).Weight__c);

                    if(this.mapQuotes.get(keyFee).get(keyRange).Vol__c != null)
                        this.mapT7V.put(keyRange, this.mapQuotes.get(keyFee).get(keyRange).Vol__c);

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

        this.totalSTD = total;
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
            for(Tarifario_general_terrestre__c objTarifarioT: queryTarifarioTFull())
                if(!wp.mapTarifarioT.containsKey(objTarifarioT.Tarifa__c))
                    wp.mapTarifarioT.put(objTarifarioT.Tarifa__c, new Map<String, Tarifario_general_terrestre__c>{objTarifarioT.RangoKM__c => objTarifarioT});
                else if (!wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).containsKey(objTarifarioT.RangoKM__c))
                    wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).put(objTarifarioT.RangoKM__c, objTarifarioT);

            for (AcusePorGuia__mdt objACK : queryACK())
                wp.mapACK.put(objACK.Label, objACK.Amount__c);
            for(ServicioDomicilio__c objService : queryDomesticService()){
                if(!wp.mapDomesticService.containsKey(objService.Servicio__c))
                    wp.mapDomesticService.put(objService.Servicio__c, new Map<String, ServicioDomicilio__c>{objService.Tamanio__c => objService});
                else if(!wp.mapDomesticService.get(objService.Servicio__c).containsKey(objService.Tamanio__c))
                    wp.mapDomesticService.get(objService.Servicio__c).put(objService.Tamanio__c, objService);
            }
            wp.mapCS = queryCustomSetting([SELECT Id FROM Profile Where Name = 'System Administrator' OR Name = 'Administrador del sistema'].Id);
        }

        for(String keyFee: this.listFee){
            for(String keyRange: this.listRangeDestiny){
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

        Decimal disc = 0;
        this.mapTotal.put('Full', totalAmount);
        this.mapTotal.put('Quote', totalAmountQ);
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
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'mapDiscounts: ' + this.mapRangosByDest));
        calculateProjection();

    }

    private void calculateProjection() {
        Decimal firstBlock = 0;
        Decimal lastBlock = 0;
        List<Decimal> listBlocksW = new List<Decimal>();
        List<Decimal> listBlocksWReverse = new List<Decimal>();
        Map<Decimal, Block> mapBlocksByW = new Map<Decimal, Block>();
        String strTarifa = '';
        for(String strName : this.mapBlocks.keySet()){
            mapBlocksByW.put(this.mapBlocks.get(strName).decWeight, this.mapBlocks.get(strName));
            if(firstBlock == 0)
                firstBlock = this.mapBlocks.get(strName).decWeight;
            lastBlock = this.mapBlocks.get(strName).decWeight;
        }
        listBlocksW.addAll(mapBlocksByW.keySet());
        for(Integer j = listBlocksW.size() - 1; j > 0; j--)
            listBlocksWReverse.add(listBlocksW.get(j));
        Decimal keyBlock = 0;
        Block wpBlock;
        Decimal decSUMCustomerPrice = 0;
        Decimal decSUMCustomerPriceZP = 0;
        Decimal decSUMNetPrice = 0;
        Decimal decSUMNetPriceZP = 0;
        Decimal fltTotalQuote = 0;
        for(Integer i = 0; i <= 60; i++ ){
            decSUMCustomerPrice = 0;
            decSUMCustomerPriceZP = 0;
            decSUMNetPrice = 0;
            decSUMNetPriceZP = 0;
            String strfee = '';

            if (i == 0)
                strfee = 'TS';
            else if (i == 1)
                strfee = 'T0';
            else
                strfee = getTarifa(i);

            if(i <= firstBlock)
                keyBlock = firstBlock;
            else if(i > lastBlock)
                keyBlock = lastBlock;
            else
                for(Decimal decW : listBlocksWReverse)
                    if(i < decW)
                        keyBlock = decW;

            wpBlock = mapBlocksByW.get(keyBlock);

            SBQQ__QuoteLine__c range;
            SBQQ__QuoteLine__c rangeZP;
            for (String strRange : listRangeDestiny){
                Decimal ejemplo = 0;
                Decimal ejemplo2 = 0;
                Decimal ejemplo3 = 0;
                Decimal ejemplo4 = 0;
                Decimal ejemplo5 = 0;
                Decimal ejemplo6 = 0;
                String tarifa = '';
                Decimal fltGuia = 0;
                String strRango = '';
                Decimal decFlete = 0;
                if(blnByDestiny)
                    strRango = this.mapRangosByDest.get(strRange);
                else strRango = strRange;
                range = new SBQQ__QuoteLine__c (
                    FLETE__c = wpBlock.mapRanges.get(strRango)
                    , SBQQ__CustomerPrice__c = 0
                    , SBQQ__NetPrice__c = 0
                    , SBQQ__Quantity__c = 0
                    , KG_ADICIONAL__c = 0
                    , RAD__c = 0
                    , EAD__c = 0
                    , ACK__c = 0
                    , SEG__c = 0
                    , Pack_Seg__c = 0
                    , SBQQ__Discount__c = 0
                    , PackWeightAVG__c = keyBlock
                    , Tarifa__c = getTarifa(i)
                );
                if (range.Tarifa__c == 'TARIFA SOBRE')
                    tarifa = 'TARIFA TS';
                else tarifa = range.Tarifa__c;
                if(this.mapQuotes.get(range.Tarifa__c).get(strRange).GUIA__c != null)
                    fltGuia = this.mapQuotes.get(range.Tarifa__c).get(strRange).GUIA__c;
                /*if (i > lastBlock && this.mapQuotes.get(range.Tarifa__c).get(strRange).GUIA__c != null)
                    range.KG_ADICIONAL__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).GUIA__c * (i - lastBlock);*/
                if (i > lastBlock && this.mapQuotes.get(range.Tarifa__c).get(strRange).KG_ADICIONAL__c != null)
                    range.KG_ADICIONAL__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).KG_ADICIONAL__c;
                if(this.mapQuotes.get(range.Tarifa__c).get(strRange).ACK__C != null)
                    range.ACK__C = this.mapQuotes.get(range.Tarifa__c).get(strRange).ACK__C;
                if(this.mapQuotes.get(range.Tarifa__c).get(strRange).SEG__c != null)
                    range.SEG__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).SEG__c;
                if(this.wp.mapTarifarioT.get(tarifa).get(strRango).Flete__c != null)
                    decFlete = this.wp.mapTarifarioT.get(tarifa).get(strRango).Flete__c;
                if(this.blnRAD)
                    range.RAD__c = dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), decFlete);
                if(this.blnEAD)
                    range.EAD__c = dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), decFlete);
                Decimal fltQuoteAdKG = 0;
                
                if(range.Tarifa__c == 'TARIFA T0' || range.Tarifa__c == 'TARIFA T1')
                    range.SBQQ__Quantity__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).SBQQ__Quantity__c / 5;
                else if (range.Tarifa__c != 'TARIFA SOBRE' || range.Tarifa__c != 'TARIFA T0'|| range.Tarifa__c != 'TARIFA T1' || range.Tarifa__c != 'TARIFA T2')
                    range.SBQQ__Quantity__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).SBQQ__Quantity__c / 10;
                else range.SBQQ__Quantity__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).SBQQ__Quantity__c;
                if(i > lastBlock && this.mapQuotes.get(range.Tarifa__c).get(strRange).KG_ADICIONAL__c != null)
                    fltQuoteAdKG = this.mapQuotes.get(range.Tarifa__c).get(strRange).KG_ADICIONAL__c * (i - lastBlock);
                ejemplo = decFlete + this.wp.mapACK.get('Interno');
                ejemplo2 = decFlete  + range.RAD__c + range.EAD__c;
                if(blnACK)
                    ejemplo2 += this.wp.mapACK.get('Interno');
                ejemplo3 = decFlete + range.ACK__C + fltQuoteAdKG;
                ejemplo4 = range.SBQQ__Quantity__c * ejemplo2;
                //ejemplo5 = range.Flete__c * range.SBQQ__Quantity__c;
                fltGuia += fltQuoteAdKG;
                ejemplo5 = fltGuia * range.SBQQ__Quantity__c;
                range.SBQQ__NetPrice__c = ejemplo5;
                /*if(range.Tarifa__c == 'TARIFA T3'){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'flete: ' + decFlete));
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'RAD: ' + range.RAD__c));
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'EAD: ' + range.EAD__c));
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tarifa llena: ' + ejemplo2));
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Paquetes: ' + range.SBQQ__Quantity__c));
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tarifa propuesta: ' + fltGuia));
                }*/
                /*if(range.Tarifa__c == 'TARIFA SOBRE')
                    range.SBQQ__Discount__c = (range.Flete__c / decFlete) - 1;
                else range.SBQQ__Discount__c = (range.Flete__c / ejemplo2) - 1;*/
                range.SBQQ__Discount__c = (fltGuia / ejemplo2) - 1;

                decSUMCustomerPrice += ejemplo4;
                decSUMNetPrice += ejemplo5;
                rangeZP = new SBQQ__QuoteLine__c (
                        FLETE__c = 0
                        , SBQQ__CustomerPrice__c = 0
                        , SBQQ__Quantity__c = 0
                        , SBQQ__NetPrice__c = 0
                        , KG_ADICIONAL__c = 0
                        , RAD__c = 0
                        , EAD__c = 0
                        , ACK__c = 0
                        , SEG__c = 0
                        , Pack_Seg__c = 0
                        , SBQQ__Discount__c = 0
                        , PackWeightAVG__c = keyBlock
                        , Tarifa__c = getTarifa(i)
                );
                rangeZP.EAD__c = 208.5;
                Decimal TarifaLlenaZP = 0;
                Decimal FleteZP = 0;
                Decimal TarLlena2ZP = 0;
                Decimal TarifaPropuestaZP = 0;
                Decimal TarifaPropuesta2ZP = 0;
                Decimal AcuseZP = 0;
                Decimal fltQuoteAdKGZP = 0;
                Decimal prueba  = 0;
                Decimal decEAD = 0;
                if(this.wp.mapTarifarioT.get(tarifa).get(strRango).Flete__c != null)
                    FleteZP = this.wp.mapTarifarioT.get(tarifa).get(strRango).Flete__c;
                if(this.mapQuotesZP.get(range.Tarifa__c).get(strRange).RAD__c != null)
                    rangeZP.RAD__c = this.mapQuotesZP.get(range.Tarifa__c).get(strRange).RAD__c;
                if(this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).EAD__c != null)
                    decEAD = this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).EAD__c;
                if(this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).ACK__c != null)
                    AcuseZP = this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).ACK__c;
                rangeZP.ACK__C = this.wp.mapACK.get('Interno');
                TarifaLlenaZP = FleteZP + rangeZP.RAD__c + rangeZP.EAD__c + rangeZP.ACK__C;
                TarLlena2ZP = TarifaLlenaZP + rangeZP.RAD__c + rangeZP.EAD__c + rangezp.ACK__C;
                rangeZP.SBQQ__Quantity__c = rangeZP.RAD__c;
                if(i > lastBlock && this.mapQuotes.get(range.Tarifa__c).get(strRange).KG_ADICIONAL__c != null)
                    fltQuoteAdKGZP = this.mapQuotes.get(range.Tarifa__c).get(strRange).KG_ADICIONAL__c * (i - lastBlock);
                if(rangeZP.Tarifa__c == 'TARIFA T0' || rangeZP.Tarifa__c == ' TARIFA T1')
                    rangeZP.SBQQ__Quantity__c = this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).SBQQ__Quantity__c / 5;
                else if (rangeZP.Tarifa__c != 'TARIFA SOBRE' || rangeZP.Tarifa__c != 'TARIFA T0'|| rangeZP.Tarifa__c != 'TARIFA T1' || rangeZP.Tarifa__c != 'TARIFA T2')
                    rangeZP.SBQQ__Quantity__c = this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).SBQQ__Quantity__c / 10;
                else rangeZP.SBQQ__Quantity__c = this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).SBQQ__Quantity__c;
                prueba = fltGuia  + fltQuoteAdKGZP;
                TarifaPropuestaZP = fltGuia  + fltQuoteAdKGZP + decEAD;
                TarifaPropuesta2ZP = TarifaPropuestaZP + AcuseZP;
                rangeZP.SBQQ__CustomerPrice__c = this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).SBQQ__Quantity__c * TarifaLlenaZP;
                rangeZP.SBQQ__NetPrice__c = Tarifapropuesta2zp * this.mapQuotesZP.get(rangeZP.Tarifa__c).get(strRange).SBQQ__Quantity__c;
                rangeZP.SBQQ__Discount__c = Tarifapropuesta2zp / TarifaLlenaZP - 1;
                decSUMCustomerPriceZP += rangeZP.SBQQ__CustomerPrice__c;
                decSUMNetPriceZP += rangeZP.SBQQ__NetPrice__c;
            }
            if(this.mapDiscounts.containsKey(i) && this.mapDiscounts.get(i).containsKey('MaxDisc') && rangeZP.SBQQ__Discount__c < this.mapDiscounts.get(i).get('MaxDiscZP')){
                this.mapDiscounts.get(i).put('MaxDiscZP', rangeZP.SBQQ__Discount__c);
            }
            if(!this.mapDiscounts.containsKey(i)){
                this.mapDiscounts.put(i, new Map<String, Decimal>{
                    'MaxDisc' => range.SBQQ__Discount__c
                    , 'MaxDiscZP' => rangeZP.SBQQ__Discount__c
                    , 'AVGDisc' => 0
                    , 'AVGDiscZP' => 0
                });
                if(i == 0)
                    this.mapTarifasName.put(i, 'TS');
                else
                    this.mapTarifasName.put(i, this.mapTarifasKey.get(getTarifa(i)));
                if(i <= 30)
                    this.listKg30.add(i);
            }
            if(decSUMCustomerPrice > 0 && decSUMNetPrice > 0 && this.mapDiscounts.containsKey(i) && this.mapDiscounts.get(i).containsKey('AVGDisc'))
                this.mapDiscounts.get(i).put('AVGDisc', decSUMNetPrice / decSUMCustomerPrice - 1);

            if(decSUMCustomerPriceZP > 0 && decSUMNetPriceZP > 0 && this.mapDiscounts.containsKey(i) && this.mapDiscounts.get(i).containsKey('AVGDiscZP'))
                this.mapDiscounts.get(i).put('AVGDiscZP', decSUMNetPriceZP /decSUMCustomerPriceZP - 1);
        }
        // T7
        decSUMCustomerPrice = 0;
        decSUMNetPrice = 0;
        keyBlock = lastBlock;
        Integer i = 61;
        wpBlock = mapBlocksByW.get(keyBlock);

        SBQQ__QuoteLine__c range;
        String strRangeT7 = '';
        Integer intPeso = 0;
        Decimal decFleteW = 0;
        Decimal decFleteV = 0;
        Decimal decFleteDefinitivo = 0;
        Decimal decTotalNormal = 0;
        Decimal decTotalpropuesta = 0;
        for(Decimal decW : this.mapGuide.keySet()){
            intpeso = decW.intvalue();
            if(intpeso > 60){
                this.listBlocksT7.add('TARIFA T7_' + intpeso);
                this.listBlocksT7Desc.add('T7 ' + intpeso);
                blnBloquesT7 = true;
                for (String strRange : listRangeDestiny){
                    range = new SBQQ__QuoteLine__c (
                            FLETE__c = 0
                            , SBQQ__CustomerPrice__c = 0
                            , SBQQ__Quantity__c = 0
                            , SBQQ__NetPrice__c = 0
                            , KG_ADICIONAL__c = 0
                            , RAD__c = 0
                            , EAD__c = 0
                            , ACK__c = 0
                            , SEG__c = 0
                            , Pack_Seg__c = 0
                            , SBQQ__Discount__c = 0
                            , PackWeightAVG__c = keyBlock
                            , Tarifa__c = 'TARIFA T7_' + intpeso
                            , PackVolAVG__c = 0
                    );
                    if(this.mapQuotes.get(range.Tarifa__c).get(strRange).PackWeightAVG__c != null)
                        range.PackWeightAVG__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).PackWeightAVG__c;
                    if(this.mapQuotes.get(range.Tarifa__c).get(strRange).PackVolAVG__c != null)
                        range.PackVolAVG__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).PackVolAVG__c;
                    if(this.mapQuotes.get(range.Tarifa__c).get(strRange).Flete__c != null)
                        range.Flete__c = this.mapQuotes.get(range.Tarifa__c).get(strRange).Flete__c;
                    decFleteW = range.PackWeightAVG__c * this.wp.mapTarifarioT.get('TARIFA T7P').get(strRange).Flete__c;
                    decFleteV = this.wp.mapTarifarioT.get('TARIFA T7V').get(strRange).Flete__c * range.PackVolAVG__c;
                    if(decFleteV > decFleteW)
                        decFleteDefinitivo = decFleteV;
                    else decFleteDefinitivo = decFleteW;
                    if(this.blnRAD)
                        range.RAD__c = decFleteDefinitivo * 0.11;
                    if(this.blnEAD)
                        range.EAD__c = decFleteDefinitivo * 0.11;
                    range.SBQQ__CustomerPrice__c = decFleteDefinitivo + range.RAD__c + range.EAD__c;
                    decTotalNormal = this.mapQuotes.get(range.Tarifa__c).get(strRange).SBQQ__Quantity__c * range.SBQQ__CustomerPrice__c;
                    decTotalpropuesta = range.Flete__c * this.mapQuotes.get(range.Tarifa__c).get(strRange).SBQQ__Quantity__c;
                    range.SBQQ__Discount__c = range.Flete__c / range.SBQQ__CustomerPrice__c - 1;
                    decSUMCustomerPrice  += decTotalNormal;
                    decSUMNetPrice += decTotalpropuesta;
                    if(!this.mapDiscounts.containsKey(intpeso)){
                        this.mapDiscounts.put(intpeso, new Map<String, Decimal>{
                        'MaxDisc' => range.SBQQ__Discount__c
                        , 'MaxDiscZP' => 0
                        , 'AVGDisc' => 0
                        , 'AVGDiscZP' => 0
                        });
        
                        if(intpeso == 0)
                            this.mapTarifasName.put(intpeso, 'TS');
                        else
                            this.mapTarifasName.put(intpeso, 'T7 ' + intpeso);
                        this.listKg70.add(intpeso);
                    }
                    if(this.mapDiscounts.containsKey(intpeso) && this.mapDiscounts.get(intpeso).containsKey('MaxDisc') && range.SBQQ__Discount__c < this.mapDiscounts.get(intpeso).get('MaxDisc')){
                        this.mapDiscounts.get(intpeso).put('MaxDisc', range.SBQQ__Discount__c);
                    }
                }
                if(decSUMCustomerPrice > 0 && decSUMNetPrice > 0 && this.mapDiscounts.containsKey(intpeso) && this.mapDiscounts.get(intpeso).containsKey('AVGDisc'))
                    this.mapDiscounts.get(intpeso).put('AVGDisc', decSUMNetPrice / decSUMCustomerPrice - 1);
            }
        }
       for(Decimal decW: this.mapDiscounts.keySet()){
            this.mapCircleClass.get('MAX').put(decW , getClass(this.mapDiscounts.get(decW).get('MaxDisc')));
            this.mapCircleClass.get('AVG').put(decW , getClass(this.mapDiscounts.get(decW).get('AVGDisc')));
            this.mapCircleClass.get('MAXZP').put(decW , getClass(this.mapDiscounts.get(decW).get('MaxDiscZP')));
            this.mapCircleClass.get('AVGZP').put(decW , getClass(this.mapDiscounts.get(decW).get('AVGDiscZP')));
        }
    }

    public String getTarifa(Decimal decW) {
            if (decW == 0)
                return 'TARIFA SOBRE';
            else if (decW >= 1  && decW <= 5)
                return 'TARIFA T0';
            else if (decW > 5  && decW <= 10)
                return 'TARIFA T1';
            else if (decW > 10  && decW <= 20)
                return 'TARIFA T2';
            else if (decW > 20  && decW <= 30)
                return 'TARIFA T3';
            else if (decW > 30  && decW <= 40)
                return 'TARIFA T4';
            else if (decW > 40  && decW <= 50)
                return 'TARIFA T5';
            else if (decW > 50  && decW <= 60)
                return 'TARIFA T6';
            else if (decW < 60)
                return 'TARIFA T7';
            else
                return null;
    }

    public String nomTarifa(Decimal decW) {
        if (decW == 0)
            return 'TS';
        else if (decW >= 1  && decW <= 5)
            return 'T0';
        else if (decW > 5  && decW <= 10)
            return 'T1';
        else if (decW > 10  && decW <= 20)
            return 'T2';
        else if (decW > 20  && decW <= 30)
            return 'T3';
        else if (decW > 30  && decW <= 40)
            return 'T4';
        else if (decW > 40  && decW <= 50)
            return 'T5';
        else if (decW > 50  && decW <= 60)
            return 'T6';
        else if (decW < 60)
            return 'T7';
        else
            return null;
    }

    public String getClass(Decimal decW){
        String strClass;
        if(decW < 0 && decW > -0.401)
            strClass = 'green';
        else if(decW < -0.4 && decW > -0.601)
            strClass = 'yellow';
        else if(decW < -0.6)
            strClass = 'red';
        else if (decW >= 0)
            strClass = 'gray';
        return strClass;
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
        FROM SBQQ__QuoteLine__c
        WHERE SBQQ__Quote__c =: strQuoteId];
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

    public static double dominantFeeServiceDom(Decimal fltMinFee, decimal fltAmount){
        Decimal fltFee = fltAmount * 0.11;
        if(fltMinFee > fltFee)
            return fltMinFee;
        else
            return fltFee;
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

    public static List<ServicioDomicilio__c> queryDomesticService(){
        List<ServicioDomicilio__c> listService = new List<ServicioDomicilio__c>();
        try {
            listService = [SELECT Id
            , Name
            , CostoMinimo__c
            , CostoSobreFlete__c
            , Servicio__c
            , Tamanio__c
            , Guia__c
            , Paquete__c
            , RangoKM__c
            , PorKgBascula__c
            FROM ServicioDomicilio__c WHERE Year__c = null];
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage() + ' caused by: ' + ex.getCause());
        }
        return listService;
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
    public void  LlenaMapas(List<String> listRangos){
        /*for(String keyFee: this.listFee){
            this.mapTotalByFee.put(keyFee, new QuoteWP());
            this.mapTotalByFeeZP.put(keyFee, new QuoteWP());
            this.mapTotalDiscFee.put(keyFee, 0);
            this.mapTotalDiscFeeZP.put(keyFee, 0);
            for(String keyRange: listRangos){
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

        for(String keyRange: listRangos)
            for (String fee : new List<String>{ 'TARIFA T7-P', 'TARIFA T7-V'})
                if(!this.mapQuotes.containsKey(fee))
                    this.mapQuotes.put(fee, new Map<String, SBQQ__QuoteLine__c>{keyRange => new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0)});
                else if(!this.mapQuotes.get(fee).containsKey(keyRange))
                    this.mapQuotes.get(fee).put(keyRange, new SBQQ__QuoteLine__c(SBQQ__Quantity__c = 0, SBQQ__CustomerPrice__c = 0, SBQQ__Discount__c = 0));
        
        for(String keyRange: listRangos){
            this.mapTotalByRange.put(keyRange, new QuoteWP());
            this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
            this.mapT7W.put(keyRange, 0);
            this.mapT7V.put(keyRange, 0);
        }*/
    }

    public class Wrapper {
        public SBQQ__Quote__c           objQuote            {get; set;}
        public Account                  objAccount          {get; set;}
        public Opportunity              objOpp              {get; set;}
        public Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT       {get; set;}
        public List<SBQQ__QuoteLine__c>     listQuoteItem   {get; set;}
        public Map<String, Decimal>                                     mapACK              {get; set;}
        public Map<String, Map<String, ServicioDomicilio__c>>           mapDomesticService  {get; set;}
        public Map<String, Decimal>                                     mapCS               {get; set;}

        public Decimal perPack {get; set;}
        public Decimal perSob  {get; set;}
        public Decimal perEAD  {get; set;}
        public Decimal perZP   {get; set;}
        public Decimal perRAD  {get; set;}
        public Decimal perACK  {get; set;}
        public Decimal perSEG  {get; set;}

        public Wrapper (){
            this.listQuoteItem      = new List<SBQQ__QuoteLine__c>();
            perPack = 0;
            perSob = 0;
            perEAD = 0;
            perZP = 0;
            perRAD = 0;
            perACK = 0;
            perSEG = 0;
            this.mapACK             = new Map<String, Decimal>();
            this.mapTarifarioT      = new Map<String, Map<String, Tarifario_general_terrestre__c>>();
            this.mapDomesticService = new Map<String, Map<String, ServicioDomicilio__c>>();
            this.mapCS              = new Map<String, Decimal>();
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

    public class Block{
        public String       strName             {get; set;}
        public Decimal      decWeight           {get; set;}
        public Decimal      decVol              {get; set;}
        public Decimal      decVolWeight        {get; set;}
        public Map<String, Decimal> mapRanges   {get; set;}

        public Block(String paramName, Decimal paramWeight, Decimal paramVol, Decimal paramVolWeight){
            this.strName        = paramName;
            this.decWeight      = paramWeight;
            this.decVol         = paramVol;
            this.decVolWeight   = paramVolWeight;
            this.mapRanges      = new Map<String, Decimal>();
        }
    }

    public class wpExcedente{
        public String strKey                                {get; set;}
        public String strfee                                {get; set;}
        public Decimal fltMaxW                              {get; set;}
        public Decimal fltDisc                              {get; set;}
        public Decimal fltTotalNormal                       {get; set;}
        public Decimal fltTotalQuote                        {get; set;}
        public Map<String, Decimal> ranges    {get; set;}
        public wpExcedente(){
            this.strfee         = '';
            this.strKey         = '';
            this.fltDisc        = 0;
            this.fltMaxW        = 0;
            this.fltTotalQuote  = 0;
            this.ranges         = new Map<String, Decimal>();
        }
    }

}

//cambios para destinos
