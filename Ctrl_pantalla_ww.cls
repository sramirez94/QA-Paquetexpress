public class Ctrl_pantalla_ww {
    
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
    public List<String> listRangeDestiny    {get; set;}
    public List<String> listSS              {get; set;}
    public Set<String> listGuide            {get; set;}
    public Set<String> lEXP                 {get; set;}
    public List<String> listRangeT7         {get;set;}
    public List<String> listRangeProp       {get; set;}
    
    public Map<String, String> mapEXP       {get; set;}
    public Map<String, Map<String, Map<String, Decimal>>> mapFreccOD {get; set;}   
    public boolean T7ZonaPlus {get;set;}
    public String strId {get;set;}
    public boolean CBME {get;set;}
    public boolean blnGMP {get; set;}   
    public Decimal descGral {get; set;}
    public Decimal totalPaq {get; set;}
    public Decimal porcFrec {get; set;}
    public Decimal decMontoTotalT7ZP {get; set;}
    public Decimal totalAmountQZP {get;set;}
    public Decimal decTotProp {get;set;}
        
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesZP {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesEXP {get;set;}
    public Map<String, Map<String, Map<String, SBQQ__QuoteLine__c>>> mapQuotesOD {get;set;}
    public Map<String, QuoteWP>  mapTotalByRange {get; set;}
    public Map<String, QuoteWP>  mapTotalByFee {get; set;}
    public Map<String, QuoteWP>  mapTotalByRangeZP {get; set;}
    public Map<String, QuoteWP>  mapTotalByFeeZP {get; set;}
    public Map<String, Map<String, QuoteWP>>  mapTotalByFeeOD {get; set;}
    public Map<String, Map<String, QuoteWP>>  mapTotalByRangeEXP {get; set;}
	public Map<String, QuoteWP>  mapTotalByFeeEXP {get; set;}
    public Map<String, Decimal> mapT7W {get; set;}
    public Map<String, Decimal> mapT7V {get; set;}
    public Map<String, Decimal> mapTotal {get; set;}
    public Map<String, Decimal> mapTotalZP {get; set;}
    public Map<String, Decimal> mapTotalDiscFee {get; set;}
    public Map<String, Decimal> mapTotalDiscFeeZP {get; set;}
    public Map<String, Decimal> mapTotalDiscEXP {get; set;}
    public Map<String, Decimal> mapWEXP {get; set;}
    public Map<String, Decimal> mapVEXP {get; set;}
    public Map<String, Map<String, Decimal>> mapFrecc {get; set;}    
    public Boolean blnRAD {get; set;}
    public Boolean blnEAD {get; set;}
    public Boolean blnZP {get; set;}
    public Boolean blnServZP {get; set;}
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
    public Decimal elPeso                                                   {get; set;}
    public Decimal elVol                                                    {get; set;}
    
        
    public List<String> listFeeInfo {get; set;}
    public List<String> listFeeInfo2 {get; set;}
    public Set<String> listRangeInfo {get; set;}
    public Set<String> listRangeInfo2 {get; set;}
    public Set<String> listRangeD     {get; set;}
    public Set<String> listServ       {get; set;}
    public Map<String, String> lastGuide {get; set;}
    
    //aqui empieza lo nuevo para costo base    
    public List<String> listFeeT7                                           {get; set;}
    public Map<Decimal, Decimal> mapGuide                                   {get; set;}   
    public List<Decimal> listKg30                                           {get; set;}
    public List<Decimal> listKg70                                           {get; set;}
    public List<Decimal> listKg70ZP                                         {get; set;}
    public Map<String, SBQQ__QuoteLine__c> mapQuotesT7ZP                    {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapQuotesT7ZPByRange             {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapPropuestaT7ZP                 {get;set;}
    public Map<String, Decimal>  mapTotalByRangeT7                          {get; set;}
    public Map<String, Decimal> mapTotalesT7ZP                              {get; set;}
    public Map<String, Decimal> mapDescT7ZP                                 {get; set;}
    public Map<String, Map<Decimal, String>> mapCircleClass                 {get; set;}
    public Decimal total                                                    {get; set;}
    public Decimal totalT7                                                  {get; set;}
    public Decimal totalZP                                                  {get; set;}
    public Map<String, Block> mapBlocks                                     {get; set;}
    public Map<String,  Map<String, map<String, Decimal>>> mapBlocksServ    {get; set;}
    public map<String, map<String, Decimal>> mapBlockAdic                   {get; set;}
    public Map<String, Block> mapService                                    {get; set;}
    public Map<Decimal, Map<String, Decimal>> mapDiscounts                  {get; set;}
    public Map<Decimal, Map<String, Decimal>> mapDiscountsT7ZP              {get; set;}
    public Decimal decSEG                                                   {get; set;}
    public Map<Decimal, String> mapTarifasName                              {get; set;}
    public Map<String, String> mapTarifasKey                                {get; set;}
    public string Id                                                        {get; set;}
    public Map<Decimal, Map<String, TempleateLine__c>> mapBloques           {get;set;}
    public List<Decimal> listBloques                                        {get;set;}

    public map<String, decimal> mapPruebas                                 {get;set;}
    public map<String, String> mapRangosByDest                              {get; set;}
    public boolean blnByDestiny                                             {get; set;}
    public List<string> listBlocksT7                                        {get; set;}
    public Map<String, Decimal> mapT7Vol                                    {get; set;}
    public List<string> listBlocksT7Desc                                    {get; set;}
    public boolean blnBloquesT7                                             {get; set;}
    public boolean T7ZP                                                     {get;set;}
    public String strOrigen                                                 {get;set;}
    public Decimal decVolumen                                               {get; set;}
    public Decimal decPeso													{get; set;}
    
    
    //para guia multipieza
    public Map<String, Decimal>  mapTotalByRangeGuia                        {get; set;}
    public Map<String, Decimal>  mapTotalByRangeGuiaZP                      {get; set;}
    public Decimal totalGuias                                               {get; set;}
    public Decimal totalGuiasZP                                             {get; set;}
    public Map<String, Decimal> mapTotalByFeeGuia                           {get; set;}
    public Map<String, Decimal> mapTotalByFeeGuiaZP                         {get; set;}
    
    
    //plantillas
    public String 				                 indexDeducItem 	       {get; set;}
    public String                                strIdQuote                {get; set;}
    public String                                strTempleateId            {get; set;}
    public List<TempleateLine__c>                listPlantillaLineItems    {get; set;}
    public Templeate__c                          objtempleate              {get; set;}
    public SBQQ__Quote__c                        objquote                  {get; set;}
    public List<PAQ_SpecialService__c>           listservices              {get; set;}
    public Map<String, Tarifas>                  mapTarifas                {get; set;}
    public Map<String, name>                     mapName                   {get; set;}
    public Map<String, List<TempleateLine__c>>   mapLines	               {get; set;}
    public Map<String, List<TempleateLine__c>>   mapLinesZP                {get; set;}
    public List<PAQ_SpecialService__c>           listSSS                   {get; set;}
    public Set<STring>                           setTarifas                {get; set;}
    public Set<STring>                           setName                   {get; set;}
    public String                                strTipoQuote              {get; set;}
    public Map<String, List<PAQ_SpecialService__c>> mapss				   {get; set;}
    public String lastGuide2 {get; set;}
    


    public Ctrl_pantalla_ww(ApexPages.StandardController sc){
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
        Decimal totalPaqGuia         = 0;
        Decimal totalPaqGuiaZP       = 0;
        lastGuide2 = '0';
		Map<String, String> mapSSOption = new Map<String, String>();

        this.lastGuide = new Map<String, String>{ 'SEG-DS' => '0', 'SEG-2D' => '0', 'SEG-A12' => '0' };
        this.blnRAD = false;
        this.blnEAD = false;
        this.blnZP = false;
        this.blnSEG = false;
        this.blnACK = false;
        this.blnDS = false;
        this.bln2D = false;
        this.blnA12 = false;
        this.blnServZP = false;
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
            //, 'TARIFA T7-P'
            //, 'TARIFA T7-V'
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
        this.lEXP = new Set<String>();
        this.mapEXP = new Map<String, String>{
                'SEG-DS' => 'SERVICIO EXPRESS GARANTIZADO - DIA SIGUIENTE (ONE DAY)'
                , 'SEG-2D' => 'SERVICIO EXPRESS GARANTIZADO - DOS DIAS SIGUIENTES (TWO DAYS)'
                , 'SEG-A12' => 'SERVICIO EXPRESS GARANTIZADO - ANTES DE MEDIO DIA  (MID DAY)'
                };
        this.listGuide = new Set<String>();
        this.listServ = new Set<String>();
        this.listRangeD = new Set<String>();        
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
        this.mapQuotesOD             = new Map<String, Map<String, Map<String, SBQQ__QuoteLine__c>>>();
        this.mapTotalByRange         = new Map<String, QuoteWP>();
        this.mapTotalByRangeZP       = new Map<String, QuoteWP>();
        this.mapTotalByRangeEXP      = new Map<String, Map<String, QuoteWP>>();
        this.mapTotalByFeeOD         = new Map<String, Map<String, QuoteWP>>();
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
        this.mapWEXP                 = new Map<String, Decimal>();
        this.mapVEXP                 = new Map<String, Decimal>();
        this.mapFrecc                = new Map<String, Map<String, Decimal>>();
        this.mapFreccOD              = new Map<String, Map<String, Map<String, Decimal>>>();
        this.listFeeInfo             = new List<String>();
        this.listFeeInfo2			 = new List<String>();
        this.listRangeInfo			 = new Set<String>();
        this.listRangeInfo2			 = new Set<String>();
        this.listRangeDestiny        = new List<String>();
        this.mapBlocks              = new Map<String, Block>();
        this.mapBlockAdic           = new map<String, map<String, Decimal>>();
        this.mapBlocksServ          = new Map<String, Map<String, map<String, Decimal>>>();
        this.mapService             = new Map<String, Block>{
                                        'ADD' => new Block('ADD',0,0,0)
                                        , 'ACK' => new Block('ACK',0,0,0)
                                        , 'ZP' => new Block('ZP',0,0,0)
                                    };                                        
        this.total                  = 0;
        this.totalT7                = 0;
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
        this.mapDiscounts           = new Map<Decimal, Map<String, Decimal>>();
        this.mapDiscountsT7ZP       = new Map<Decimal, Map<String, Decimal>>();
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
        this.listFeeT7              = new List<String>();
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
        this.listRangeProp           = new List<String>();
        this.mapT7Vol                = new Map<String, Decimal>();
        this.listBlocksT7Desc        = new list<String>();
        this.wp                      = new Wrapper();
       
        this.mapQuotes               = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesZP             = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesT7ZP           = new Map<String, SBQQ__QuoteLine__c>();
        this.mapQuotesT7ZPByRange    = new Map<String, SBQQ__QuoteLine__c>();
        this.mapPropuestaT7ZP        = new Map<String, SBQQ__QuoteLine__c>();
        this.mapTotalByRange         = new Map<String, QuoteWP>();
        this.mapTotalByRangeZP       = new Map<String, QuoteWP>();
        this.mapTotalByFee           = new Map<String, QuoteWP>();
        this.mapTotalByRangeT7       = new Map<String, Decimal>();
        this.mapTotalByFeeZP         = new Map<String, QuoteWP>();
        this.mapT7W                  = new Map<String, Decimal>();
        this.mapT7V                  = new Map<String, Decimal>();
        this.mapTotal                = new Map<String, Decimal>();
        this.mapTotalZP              = new Map<String, Decimal>();
        this.mapTotalDiscFee         = new Map<String, Decimal>();
        this.mapTotalDiscFeeZP       = new Map<String, Decimal>();
        this.mapTotalesT7ZP          = new Map<String, Decimal>();
        this.mapDescT7ZP             = new Map<String, Decimal>();
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
        this.listKg70ZP              = new List<Decimal>();
        this.listRangeT7             = new List<String>();
        this.blnByDestiny            = false;
        this.T7ZP                    = false;
        this.strOrigen               = '';
        this.decPeso                 = 0;
        this.decVolumen              = 0; 
        this.mapTotalByFeeGuia       = new Map<String, Decimal>();
        this.mapTotalByFeeGuiaZP     = new Map<String, Decimal>();
        this.mapTotalByRangeGuia     = new Map<String, Decimal>();
        this.mapTotalByRangeGuiaZP   = new Map<String, Decimal>();
        this.mapBloques              = new Map<Decimal,  Map<String, TempleateLine__c>>();
        this.listBloques             = new List<Decimal>();
        this.totalGuias             = 0;
        this.totalGuiasZP           = 0;
        
        this.blnGMP = false;
        this.T7ZonaPlus = false;
        this.CBME = false;
        this.strId = '';
        this.descGral = 0;
        this.totalPaq = 0;
        this.porcFrec = 0;
        this.decMontoTotalT7ZP = 0;
        this.totalAmountQZP = 0;
        this.decTotProp = 0;
        this.elPeso = 0;
        this.elVol 	= 0;
        
        
        this.mapTotalZP.put('Disc', 0);
        this.mapTotal.put('Disc', 0);
        this.mapTotal.put('Full', 0);
        this.mapTotalZP.put('Full', 0);
        this.mapTotal.put('Quote', 0);
        this.mapTotalZP.put('Quote', 0);        
        this.strIdQuote = sc.getId();
        
        objtempleate = queryTempleate();
        
        if(String.isNotBlank(objtempleate.ServiciosAdicionales__c)){ // RAD; EAD; EAD ZONA PLUS; Seguro; Acuse Empresa; Acuse Interno; Acuse XT
			String[] servicios = objtempleate.ServiciosAdicionales__c.split(';');
			for(String strService : servicios){
				if(strService == 'RAD')
					blnRAD = true;
                if(strService == 'EAD')
					blnEAD = true;
             
			}
		}   
        
        listSSS = querySSS(strIdQuote);
        listPlantillaLineItems = queryTempleateLine(objtempleate.Id);             
        this.listPlantillaLineItems = new List<TempleateLine__c>();
        this.blnZP = false;
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'La sumatoria del flete y los servicios no corresponde al subtotal. ' + suma.setScale(2)+' es diferente a '+ObjDeduc.CustomerPrice__c));
        for(TempleateLine__c line : queryTempleateLine(objtempleate.Id)){
            String strRangeDest = '';
            if(line.Zona_Plus__c )
                this.blnZP = true;
            /*if(String.isNotBlank(line.Destiny__c))
                line.Rango_KM__c = line.Destiny__c + ' (' + line.Rango_KM__c + ')';*/
            if(/*line.Quantity__c != 0 &&*/ !line.Zona_Plus__c){
                if(!this.mapBloques.containsKey(line.PackWeightAVG__c))
                    this.mapBloques.put(line.PackWeightAVG__c, new Map<String, TempleateLine__c>());
                if(!this.listBloques.contains(line.PackWeightAVG__c))
                    this.listBloques.add(line.PackWeightAVG__c);
                if(line.Destiny__c != null)
                    strRangeDest = line.Destiny__c;
                else strRangeDest = line.Rango_KM__c;
                if(!this.mapBloques.get(line.PackWeightAVG__c).containsKey(strRangeDest))
                    this.mapBloques.get(line.PackWeightAVG__c).put(strRangeDest, line);
                if(!this.listRangeDestiny.contains(strRangeDest))
                    this.listRangeDestiny.add(strRangeDest);
            }
            this.listPlantillaLineItems.add(line);
        }
		this.strTempleateId = objtempleate.Id;      
        this.mapLines       = new Map<String, List< TempleateLine__c>>();
        this.mapLinesZP     = new Map<String, List<TempleateLine__c>>();
        this.mapss          = new Map<String, List<PAQ_SpecialService__c>>();
        this.setTarifas     = new Set<String>();
        this.setName        = new Set<String>();
    
        
        for(PAQ_SpecialService__c liness:  listSSS){
        setName.add(liness.Name);
           if(!mapss.containsKey(liness.Name))
                mapss.put(liness.Name, new List<PAQ_SpecialService__c>{liness});
            else
                    mapss.get(liness.Name).add(liness);
        }
        
        for(TempleateLine__c line : listPlantillaLineItems){
            setTarifas.add(line.Tarifa__c);
            if(!line.Zona_Plus__c){
               if(line.Tarifa__c == 'TARIFA T7'){
                   if(line.ACK__c >= 66)
                   {
                       line.ACK__c = 65;
                       
                   }
                   else
                   {
                    line.ACK__c = line.ACK__c;  
                   }
                }
                if(line.Tarifa__c == 'TARIFA T7-V' ){
                   if(line.ACK__c >= 66)
                   {
                       line.ACK__c = 65;
                   }
                   else
                   {
                    line.ACK__c = line.ACK__c;  
                   }                
                  
                }
               if(line.Tarifa__c == 'TARIFA T7-P'){
                    line.ACK__c = 0;                
                }
                if(line.Tarifa__c == 'SEG-2D' || line.Tarifa__c == 'SEG-DS' || line.Tarifa__c == 'SEG-A12'){
                    line.FLETE__c = line.FLETE__c;
                }
                                
                if(!mapLines.containsKey(line.Tarifa__c))
                    mapLines.put(line.Tarifa__c, new List<TempleateLine__c>{line});
                else
                    mapLines.get(line.Tarifa__c).add(line);
            } else{
                if(!mapLinesZP.containsKey(line.Tarifa__c))
                    mapLinesZP.put(line.Tarifa__c, new List<TempleateLine__c>{line});
                    
                else
                    mapLinesZP.get(line.Tarifa__c).add(line);
            }
        }
        
    
 //CAALCULOS PARA Costos fijos por Tarifas: Por Destinos / Por rangos de km
 /*codigo nuevo inicio---------------------------------------------------------------------------------------------------------*/
     this.wp.objQuote = queryQuote(sc.getId());  
     this.wp.listQuoteItem = queryQuoteItem(sc.getId());     
        
        if(this.wp.objQuote.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'){        
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

        for(String keyRange: this.listRange){
            this.mapTotalByRange.put(keyRange, new QuoteWP());
            this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
            this.mapT7W.put(keyRange, 0);
            this.mapT7V.put(keyRange, 0);
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
            if (String.isNotBlank(this.wp.objQuote.Acuse__c))
                this.blnACK = true;
        }

        if(String.isNotBlank(wp.objQuote.SBQQ__Account__c))
            this.wp.objAccount = queryAccount(wp.objQuote.SBQQ__Account__c);
        if(String.isNotBlank(wp.objQuote.SBQQ__Opportunity2__c))
            this.wp.objOpp = queryOpp(wp.objQuote.SBQQ__Opportunity2__c);
        if(String.isNotBlank(wp.objQuote.Lead__c))
        	this.wp.objLead = queryLead(wp.objQuote.Lead__c);

        if(String.isNotBlank(this.wp.objQuote.Servicios_adicionales__c))
            for (String strKeyService : this.wp.objQuote.Servicios_adicionales__c.split(';')){
                switch on strKeyService {
                    when 'RAD' {
                        this.blnRAD = true;
                        
                    }
                    when 'EAD' {
                        this.blnEAD = true;
                       
                    }
                    when 'Seguro' {
                        this.blnSEG = true;
                      
                    }
                }
        }
        
		Set<String> setRange = new Set<String>();
        for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItem){
            if(quoteItem.Tarifa__c != 'TARIFA T7-V' && quoteItem.Tarifa__c != 'TARIFA T7-P'){
                if(quoteItem.Tarifa__c == 'TARIFA SOBRE'){
                    if(wp.perSob == 0)
                        wp.perSob = quoteItem.DiscountFlete__c;
                }
                else if (quoteItem.Tarifa__c != 'SEG-DS' || quoteItem.Tarifa__c != 'SEG-2D' || quoteItem.Tarifa__c != 'SEG-A12'){
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
                    wp.perSEG = quoteItem.DiscountSeg__c;

                if(this.mapQuotes.containsKey(quoteItem.Tarifa__c) && !quoteItem.ZonaPlus__c && String.isBlank(quoteItem.Destiny__c)) {
                    this.mapQuotes.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                }
                if(this.mapQuotesZP.containsKey(quoteItem.Tarifa__c) && quoteItem.ZonaPlus__c && String.isBlank(quoteItem.Destiny__c)){
                    this.mapQuotesZP.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
                }

                if(quoteItem.Tarifa__c == 'TARIFA T7' && String.isBlank(quoteItem.Destiny__c)){
                    if(quoteItem.PackWeightAVG__c != null)
                        this.mapT7W.put(quoteItem.Rango_KM__c, quoteItem.PackWeightAVG__c);
                    if(quoteItem.PackVolAVG__c != null)
                        this.mapT7V.put(quoteItem.Rango_KM__c, quoteItem.PackVolAVG__c);
                }

                if(quoteItem.Tarifa__c == 'TARIFA 7-P' && this.mapT7W.get(quoteItem.Rango_KM__c) == 0 && String.isBlank(quoteItem.Destiny__c))
                    this.mapT7W.put(quoteItem.Rango_KM__c, quoteItem.PackWeightAVG__c);

                if(quoteItem.Tarifa__c == 'Tarifa 7-V' && this.mapT7V.get(quoteItem.Rango_KM__c) == 0 && String.isBlank(quoteItem.Destiny__c))
                    this.mapT7V.put(quoteItem.Rango_KM__c, quoteItem.PackVolAVG__c);



                if(quoteItem.ZonaPlus__c){
                    if(this.mapTotalDiscFeeZP.containsKey(quoteItem.Tarifa__c))
                        this.mapTotalDiscFeeZP.put(quoteItem.Tarifa__c, quoteItem.SBQQ__VolumeDiscount__c);

                }
                else if(quoteItem.Tarifa__c != 'SEG-DS' || quoteItem.Tarifa__c != 'SEG-2D' || quoteItem.Tarifa__c != 'SEG-A12') {
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
                
                if(this.wp.objQuote.Tipo_de_documentacion__c == 'Documentación Remota' && (quoteItem.Tarifa__c =='SEG-DS' || quoteItem.Tarifa__c =='SEG-2D' || quoteItem.Tarifa__c =='SEG-A12'  )){
                    if(String.isNotBlank(quoteItem.Destiny__c))
                        quoteItem.Rango_KM__c = quoteItem.Destiny__c;
                    if(Decimal.valueOf(lastGuide.get(quoteItem.Tarifa__c)) < quoteItem.GUIA__c)
                        this.lastGuide.put(quoteItem.Tarifa__c, String.valueOf(quoteItem.GUIA__c));
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

				//System.debug(LoggingLevel.DEBUG, 'Tarifa: '+ quoteItem.Tarifa__c);

                if(quoteItem.Tarifa__c == 'SEG-DS'){
                    this.blnDS = true;
                    this.discDS = quoteItem.SBQQ__Discount__c;
                }

                if(quoteItem.Tarifa__c == 'SEG-2D'){
                    this.bln2D = true;
                    this.disc2D = quoteItem.SBQQ__Discount__c;
                }

                if(quoteItem.Tarifa__c == 'SEG-A12'){
                    this.blnA12 = true;
                    this.discA12 = quoteItem.SBQQ__Discount__c;
                }

				if(this.blnDS || this.bln2D || this.blnA12){
					this.ServicioExpress = true;
					if(mapQuotesEXP.containsKey(quoteItem.Tarifa__c) && String.isBlank(quoteItem.Destiny__c))
						this.mapQuotesEXP.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);
					else if( String.isBlank(quoteItem.Destiny__c))
						this.mapQuotesEXP.put(quoteItem.Tarifa__c, new Map<String, SBQQ__QuoteLine__c> {quoteItem.Rango_KM__c => quoteItem});
				}

                if(String.isNotBlank(quoteItem.Destiny__c)){
                    String keyRange = quoteItem.Destiny__c;
                    if(quoteItem.ZonaPlus__c)
                        this.listRangeInfo2.add(quoteItem.Destiny__c);
                    else
                        this.listRangeInfo.add(quoteItem.Destiny__c);
                    	setRange.add(quoteItem.Destiny__c);
                    //System.debug(LoggingLevel.DEBUG, 'keyRange '+ keyRange);
                    if(!this.listRange.contains(keyRange)){
                        //this.listRange = insertRange(quoteItem.Destiny__c, quoteItem.Rango_KM__c);
                        //System.debug(LoggingLevel.DEBUG, 'listRange '+ JSON.serialize(this.listRange));
                        for(String keyFee: this.listFee){
                            this.mapTotalByFee.put(keyFee, new QuoteWP());
                            this.mapTotalByFeeZP.put(keyFee, new QuoteWP());
                            this.mapTotalDiscFee.put(keyFee, 0);
                            this.mapTotalDiscFeeZP.put(keyFee, 0);
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

                        this.mapTotalByRange.put(keyRange, new QuoteWP());
                        this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
                        this.mapT7W.put(keyRange, 0);
                        this.mapT7V.put(keyRange, 0);

                        for(String keyFee: this.listEXP){
                            this.mapTotalByFeeEXP.put(keyFee, new QuoteWP());
                            this.mapTotalDiscEXP.put(keyFee, 0);
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
                    
                    if(this.mapQuotes.containsKey(quoteItem.Tarifa__c) && !quoteItem.ZonaPlus__c ) {
                        this.mapQuotes.get(quoteItem.Tarifa__c).put(keyRange, quoteItem);
                    }
                    if(this.mapQuotesZP.containsKey(quoteItem.Tarifa__c) && quoteItem.ZonaPlus__c ){
                        this.mapQuotesZP.get(quoteItem.Tarifa__c).put(keyRange, quoteItem);
                    }
                    if(quoteItem.Tarifa__c == 'TARIFA T7' ){
                        if(quoteItem.PackWeightAVG__c != null)
                            this.mapT7W.put(keyRange, quoteItem.PackWeightAVG__c);
                        if(quoteItem.PackVolAVG__c != null)
                            this.mapT7V.put(keyRange, quoteItem.PackVolAVG__c);
                    }
                    if(quoteItem.Tarifa__c == 'TARIFA 7-P' && this.mapT7W.get(keyRange) == 0 && String.isBlank(quoteItem.Destiny__c))
                        this.mapT7W.put(keyRange, quoteItem.PackWeightAVG__c);

                    if(quoteItem.Tarifa__c == 'Tarifa 7-V' && this.mapT7V.get(keyRange) == 0 && String.isBlank(quoteItem.Destiny__c))
                        this.mapT7V.put(keyRange, quoteItem.PackVolAVG__c);

                    if(quoteItem.Tarifa__c == 'SEG-DS'){
                        this.blnDS = true;
                        this.discDS = quoteItem.SBQQ__Discount__c;
                    }

                    if(quoteItem.Tarifa__c == 'SEG-2D'){
                        this.bln2D = true;
                        this.disc2D = quoteItem.SBQQ__Discount__c;
                    }

                    if(quoteItem.Tarifa__c == 'SEG-A12'){
                        this.blnA12 = true;
                        this.discA12 = quoteItem.SBQQ__Discount__c;
                    }

                    if(quoteItem.Tarifa__c == 'SEG-DS' || quoteItem.Tarifa__c == 'SEG-2D' || quoteItem.Tarifa__c == 'SEG-A12'){
                        this.ServicioExpress = true;
                        if(mapQuotesEXP.containsKey(quoteItem.Tarifa__c))
                            this.mapQuotesEXP.get(quoteItem.Tarifa__c).put(keyRange, quoteItem);
                        else
                            this.mapQuotesEXP.put(quoteItem.Tarifa__c, new Map<String, SBQQ__QuoteLine__c> {keyRange => quoteItem});
                    }
                } else {
                if(quoteItem.ZonaPlus__c)
                    this.listRangeInfo2.add(quoteItem.Rango_KM__c);
                else
                    this.listRangeInfo.add(quoteItem.Rango_KM__c);
                    setRange.add(quoteItem.Rango_KM__c);
                }
            } else if(this.mapQuotes.containsKey(quoteItem.Tarifa__c)){
                this.mapQuotes.get(quoteItem.Tarifa__c).put(quoteItem.Rango_KM__c, quoteItem);

            } else{
                this.mapQuotes.put(quoteItem.Tarifa__c , new Map<String, SBQQ__QuoteLine__c> {quoteItem.Rango_KM__c => quoteItem});

             }
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
                        else if(this.mapQuotes.get(keyFee).get(keyRange).QuoteTotal__c != null){
                            //System.debug(LoggingLevel.DEBUG, 'totalAmountQ: '+ this.mapQuotes.get(keyFee).get(keyRange).QuoteTotal__c);
                            totalAmountQ += (this.mapQuotes.get(keyFee).get(keyRange).QuoteTotal__c );
                        }
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
                if(this.mapQuotes.containsKey(keyFee) && this.mapQuotes.get(keyFee).containsKey(keyRange) && this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c != null)
                    amount += this.mapQuotes.get(keyFee).get(keyRange).SBQQ__Quantity__c * this.mapQuotes.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c;
                if (keyFee != 'TARIFA T7'){
                    countFeeZP += this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                    if(this.mapQuotesZP.containsKey(keyFee) && this.mapQuotesZP.get(keyFee).containsKey(keyRange) && this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c != null)
                        amountZP += this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__Quantity__c * this.mapQuotesZP.get(keyFee).get(keyRange).SBQQ__CustomerPrice__c;
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
        
        for(String keyFee : this.listEXP ) {
            if(this.mapQuotesOD.containsKey(keyFee)){
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
        
        
		for(String keyFee : this.listEXP ){
			for(String keyRange: this.listRange){
				if(this.mapQuotesEXP.containsKey(keyFee)
					&& this.mapQuotesEXP.get(keyFee).containsKey(keyRange)
                    && this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c > 0
                ){
					//System.debug(LoggingLevel.DEBUG, 'keyFee: '+ keyFee);
					total += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
					this.mapTotalByFeeEXP.get(keyFee).totalPaquetes += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                    //System.debug(LoggingLevel.DEBUG, 'keyRange: '+ keyRange);
					if(this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c != null){
						totalAmount += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                        this.mapTotalByFeeEXP.get(keyFee).totalNormal += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                    }
                    //System.debug(LoggingLevel.DEBUG, 'totalNormal: ' + this.mapTotalByFeeEXP.get(keyFee).totalNormal);
					if(this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c != null){
						totalAmountQ += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                        this.mapTotalByFeeEXP.get(keyFee).totalAmount += this.mapQuotesEXP.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                    }
                    //System.debug(LoggingLevel.DEBUG, 'totalAmountQ: ' + this.mapTotalByFeeEXP.get(keyFee).totalAmount);
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

		Decimal disc = 0;
        this.mapTotal.put('Full', totalAmount);
        this.mapTotal.put('Quote', totalAmountQ);
        //System.debug(LoggingLevel.DEBUG, 'totalAmountSeg :' + totalAmountSeg);
		if(totalAmount > 0 )
			disc = ((totalAmountQ - totalAmountSeg) / (totalAmount - totalAmountSeg) - 1) * 100;

		this.mapTotal.put('Disc', disc);

		Decimal discZP = 0;
        this.mapTotalZP.put('Full', totalAmountZP);
        this.mapTotalZP.put('Quote', totalAmountQZP);
		if(totalAmountZP > 0 )
			discZP = ((totalAmountQZP - totalAmountSegZP)/ (totalAmountZP - totalAmountSegZP) - 1) * 100;

		this.mapTotalZP.put('Disc', discZP);
        
        //Special Services
		mapSSOption = getPicklistValues('PAQ_SpecialService__c', 'Option__c');
		this.listRangeDestiny.addAll(setRange);
		for(PAQ_SpecialService__c itemSS : querySS(this.wp.objQuote.Id)){
            if(String.isNotBlank(itemSS.Destiny__c))
                itemSS.RangoKM__c = itemSS.Destiny__c;
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
        //System.debug(LoggingLevel.DEBUG, 'mapSS: ' + JSON.serialize(this.wp.mapSS) );
        
		for(String strName : this.listSS){
            for(String keyRange : listRangeDestiny){
        		if( this.wp.mapSS.get(strName).mapRanges.get(keyRange).Amount__c != 0){
                        	this.listRangeD.add(keyRange);
                            this.listServ.add(strName);
                        }
            }
        }
        
        for(String strFee : this.listFee){
            if(hasInfo(strFee)) {
                this.listFeeInfo.add(strFee);
            }
        }

        for(String strFee : this.listEXP)
            if(hasInfo(strFee))
                this.listFeeInfo.add(strFee);
        
        for(String strFee : this.listFee){
            if(strFee!='TARIFA T7' && hasInfo2(strFee)){
                this.listFeeInfo2.add(strFee);
            }  
        }
        }
    /*codigo nuevo termino---------------------------------------------------------------------------------------------------------*/  
        
        //CALCULOS PARA Costos fijos por Tarifas: Por Destinos / Por rangos de km con t7 zona plus
        if(this.wp.objQuote.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'){
       
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
                        decTotNormal += quoteItem.FLETE__c;
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
                            if(Decimal.valueOf(lastGuide2) < quoteItem.GUIA__c)
                                this.lastGuide2 = String.valueOf(quoteItem.GUIA__c);
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

            if(totalAmount > 0 )
                disc = ((totalAmountQ - totalAmountSeg) / (totalAmount - totalAmountSeg) - 1);

            this.mapTotal.put('Disc', disc);

            Decimal discZP = 0;
            this.mapTotalZP.put('Full', totalAmountZP);
            this.mapTotalZP.put('Quote', totalAmountQZP);
            if(totalAmountZP > 0 )
                discZP = ((totalAmountQZP - totalAmountSegZP)/ (totalAmountZP - totalAmountSegZP) - 1);

            this.mapTotalZP.put('Disc', discZP);
        
       
        } else if (this.wp.objQuote.Modelo_de_tarifas__c == 'Costo base más excedente: Por Destinos / Por rangos de km'){
            String strRangeDest = '';
            Map<Decimal, Map<String, Decimal>> mapRangesByBlock = new Map<Decimal, Map<String, Decimal>>();
            /*for(SBQQ__QuoteLine__c quoteItem : this.wp.listQuoteItem){
                strRangeDest = '';
                if(quoteItem.Tarifa__c == 'TARIFA T7' && quoteItem.ZonaPlus__c)
                    System.debug('datos para t7 zona plus');
                else {
                    if(quoteItem.Tarifa__c != 'TARIFA T7-V' && quoteItem.Tarifa__c != 'TARIFA T7-P'){
                        if(!this.mapGuide.containsKey(quoteItem.PackWeightAVG__c))
                            this.mapGuide.put(quoteItem.PackWeightAVG__c, quoteItem.PackVolAVG__c);
                        if(quoteItem.Destiny__c != null)
                            strRangeDest = quoteItem.Destiny__c;
                        else strRangeDest = quoteItem.Rango_KM__c;
                        if(!this.listRangeDestiny.contains(strRangeDest))
                            this.listRangeDestiny.add(strRangeDest);
                        if(!mapRangesByBlock.containsKey(quoteItem.PackWeightAVG__c))
                            mapRangesByBlock.put(quoteItem.PackWeightAVG__c, new Map<String, Decimal>{quoteItem.Rango_KM__c => quoteItem.FLETE__c});
                        else if(!mapRangesByBlock.get(quoteItem.PackWeightAVG__c).containsKey(quoteItem.Rango_KM__c))
                            mapRangesByBlock.get(quoteItem.PackWeightAVG__c).put(quoteItem.Rango_KM__c , quoteItem.FLETE__c);
                        if(!this.mapService.get('ADD').mapRanges.containsKey(quoteItem.Rango_KM__c))
                            this.mapService.get('ADD').mapRanges.put(quoteItem.Rango_KM__c, quoteItem.KG_ADICIONAL__c);
        
                        if(!this.mapService.get('ACK').mapRanges.containsKey(quoteItem.Rango_KM__c))
                            this.mapService.get('ACK').mapRanges.put(quoteItem.Rango_KM__c, quoteItem.ACK__c);
        
                        if(quoteItem.ZonaPlus__c)
                            this.mapService.get('ZP').mapRanges.put(quoteItem.Rango_KM__c, quoteItem.EAD__c);
                    }
                }
            }
            Integer blockCounter = 1;
            Decimal decRespaldoFlete = 0;
            Map<String, Map<String, Decimal>> mapRespaldo = new Map<String, Map<String, Decimal>>();
            System.debug('mapguide: ' + this.mapGuide);
            for(Decimal decW : this.mapGuide.keySet()){
                System.debug('entra iteración');
                this.mapBlocks.put('BLOQUE '+ blockCounter, new Block('BLOQUE '+ blockCounter, decW, this.mapGuide.get(decW), this.mapGuide.get(decW) * 200) );
                this.mapBlocks.get('BLOQUE '+ blockCounter).mapRanges = mapRangesByBlock.get(decW);
                mapRespaldo.put('BLOQUE ' + blockCounter, new Map<String, Decimal>());
                for(String keyRange: this.listRangeDestiny){
                    Decimal decFlete = 0;
                    if(!this.mapBlocksServ.containsKey('BLOQUE ' + blockCounter)) {
                        this.mapBlocksServ.put('BLOQUE ' + blockCounter, new map<String, map<String, Decimal>>());
                        this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('FLT', new map<String, Decimal>());
                        this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('RAD', new map<String, Decimal>());
                        this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('EAD', new map<String, Decimal>());
                        this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('ADD', new Map<String, Decimal>());
                    }
                    decRespaldoFlete = mapRangesByBlock.get(decW).get(keyRange);
                    system.debug('pruebas' + decRespaldoFlete);
                    mapRespaldo.get('BLOQUE ' + blockCounter).put(keyRange, mapRangesByBlock.get(decW).get(keyRange));
                    if(blockCounter > 1){
                        if(this.blnRAD && this.blnEAD)
                            decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange)) / 1.22;
                        else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD))
                            decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange)) / 1.11;
                        else if(!this.blnRAD && !this.blnEAD)
                            decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange));
                    } else {
                        if(this.blnRAD && this.blnEAD)
                            decFlete = mapRangesByBlock.get(decW).get(keyRange) / 1.22;
                        else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD))
                            decFlete = mapRangesByBlock.get(decW).get(keyRange) / 1.11;
                        else if(!this.blnRAD && !this.blnEAD)
                            decFlete = mapRangesByBlock.get(decW).get(keyRange);
                    }
                    if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('FLT').containsKey(keyRange)){
                        this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('FLT').put(keyRange, (decFlete));
                    }
                    if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('RAD').containsKey(keyRange)){
                        this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('RAD').put(keyRange, (decFlete * 0.11));
                    }
                    if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('EAD').containsKey(keyRange)){
                        this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('EAD').put(keyRange, (decFlete * 0.11));
                    }
                    if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('ADD').containsKey(keyRange)){
                        Decimal decTotalAdic = 0;
                        if(this.blnRAD)
                            decTotalAdic += this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('RAD').get(keyRange);
                        if(this.blnEAD)
                            decTotalAdic += this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('EAD').get(keyRange);
                        decTotalAdic += decFlete;
                        this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('ADD').put(keyRange, decTotalAdic);
                    }
                }
                blockCounter++;
            }
            System.debug('mapblocks: ' + this.mapBlocks);
            this.mapBlockAdic.put('ADD', new map<String, Decimal>());
            this.mapBlockAdic.put('EAD', new map<String, Decimal>());
            this.mapBlockAdic.put('RAD', new map<String, Decimal>());
            this.mapBlockAdic.put('TOT', new map<String, Decimal>());
            
            for(String keyRange: this.listRangeDestiny){
                this.mapTotalByRange.put(keyRange, new QuoteWP());
                this.mapTotalByRangeZP.put(keyRange, new QuoteWP());
                this.mapT7W.put(keyRange, 0);
                this.mapT7V.put(keyRange, 0);
                Decimal decFlete = 0;
                if(!this.mapBlockAdic.containsKey(keyRange)){
                    if(this.blnRAD && this.blnEAD){
                        decFlete = (this.mapService.get('ADD').mapRanges.get(keyRange) / 1.22);
                    }else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD)){
                        decFlete = (this.mapService.get('ADD').mapRanges.get(keyRange) / 1.11);
                    } else if(!this.blnRAD && !this.blnEAD){
                        decFlete = (this.mapService.get('ADD').mapRanges.get(keyRange));
                    }
                    this.mapBlockAdic.get('ADD').put(keyRange, decFlete);
                    this.mapBlockAdic.get('EAD').put(keyRange, decFlete * 0.11);
                    this.mapBlockAdic.get('RAD').put(keyRange, decFlete * 0.11);
                    if(this.blnRAD && this.blnEAD){
                        this.mapBlockAdic.get('TOT').put(keyRange, (this.mapBlockAdic.get('ADD').get(keyRange) + this.mapBlockAdic.get('RAD').get(keyRange) + this.mapBlockAdic.get('EAD').get(keyRange)));
                    }else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD)){
                        this.mapBlockAdic.get('TOT').put(keyRange, (this.mapBlockAdic.get('ADD').get(keyRange) + this.mapBlockAdic.get('RAD').get(keyRange)));
                    } else if(!this.blnRAD && !this.blnEAD){
                        this.mapBlockAdic.get('TOT').put(keyRange, (this.mapBlockAdic.get('ADD').get(keyRange)));
                    }
                }
            }*/
        }
    /*codigo nuevo termino---------------------------------------------------------------------------------------------------------*/     
                        
        List<Tarifario_general_terrestre__c> listTarifas = [SELECT Id, Tarifa__c, PesoMaximo__c, VolumenMaximo__c
        FROM Tarifario_general_terrestre__c WHERE Year__c = null AND RangoKM__c = '0-400' AND Tarifa__c IN: setTarifas];
        mapTarifas = new Map<String, Tarifas>();
        for(Tarifario_general_terrestre__c item : listTarifas){
            //Salvador: Se extiende el for para que ahora en vez de setear al objeto de tipo Tarifario_general_terrestre__c lo haga al wraper y este al mapa
            Tarifas objTarifa = new tarifas();
            objTarifa.strId            = Item.Id;
            objTarifa.strtarifa        = Item.Tarifa__C;          
            objTarifa.decPesoMaximo    = Item.PesoMaximo__c;
            objTarifa.decVolMaximo 	   = Item.VolumenMaximo__c;
            mapTarifas.put(Item.Tarifa__C, objTarifa); 
            
           
            if(objTarifa.strtarifa == 'TARIFA T0'){
                objTarifa.decVolMaximo =  0.01;
            }
            if(objTarifa.strtarifa == 'TARIFA T1'){
                objTarifa.decVolMaximo =  0.0225;
            }
            if(objTarifa.strtarifa == 'TARIFA T2'){
                objTarifa.decVolMaximo =  0.048;
            }
            if(objTarifa.strtarifa == 'TARIFA T3'){
                objTarifa.decVolMaximo =  0.075;
            }
            if(objTarifa.strtarifa == 'TARIFA T4'){
                objTarifa.decVolMaximo =  0.1440;
            }
            if(objTarifa.strtarifa == 'TARIFA T5'){
                objTarifa.decVolMaximo = 0.2450;
            }
            if(objTarifa.strtarifa == 'TARIFA T6'){
                objTarifa.decVolMaximo = 0.3200;
            }  
          
            //system.debug('objTarifa' + objTarifa);
        }
        
        
        for(TempleateLine__c line : listPlantillaLineItems){
            if (!mapTarifas.containsKey(line.Tarifa__c) && (line.zona_Plus__c || !line.zona_Plus__c)){
                Tarifas objTarifa   = new Tarifas();
                objTarifa.strtarifa = line.Tarifa__c;
                objTarifa.decWeight = line.Weight__c;
                objTarifa.decVol    = line.Vol__c;
                mapTarifas.put(line.Tarifa__c, objTarifa);
                
               if(objTarifa.strtarifa == 'TARIFA SOBRE'){
                    objTarifa.decVolMaximo =  0.0001;
                    objTarifa.decPesoMaximo = 1;
                    line.SEG__c = line.SEG__c;
                }
                
                 if(objTarifa.strtarifa == 'TARIFA T7'){
                objTarifa.decVolMaximo = line.Vol__c;
                objTarifa.decPesoMaximo = line.Weight__c;
               } 
                
                if(objTarifa.strtarifa == 'TARIFA T7-V'){
                objTarifa.decVolMaximo = 1;
            }  
             if(objTarifa.strtarifa == 'TARIFA T7-P'){
                objTarifa.decPesoMaximo = 1;
            }  
                
                
                if(objTarifa.strtarifa == 'SEG-2D' || objTarifa.strtarifa == 'SEG-DS' || objTarifa.strtarifa == 'SEG-A12'){
                    objTarifa.decVolMaximo =  line.Vol__c * 1000;
                    objTarifa.decPesoMaximo = line.Weight__c;
                }
                
            }
        } 
        //system.debug('objTarifa' + listPlantillaLineItems);
        
             
    }     
    
    public static List<PAQ_SpecialService__c> querySSS (String strIdQuote){
            List<PAQ_SpecialService__c> listSSS = new List<PAQ_SpecialService__c>();
            try{
                listSSS = [SELECT Id, Name, RangoKM__c, Amount__c, Option__c, Potencial__c, MainDesinations__c FROM PAQ_SpecialService__c WHERE Quote__c =: strIdQuote];
            } catch (Exception ex){
                System.debug(ex.getMessage());
            }
            return listSSS;
        }
                   
    public List<TempleateLine__c> queryTempleateLine(String templeateId){
        List<TempleateLine__c> listPlantillaLineItems = new List<TempleateLine__c>();
        try{
            if (strTipoQuote == 'byDelivery'){
                listPlantillaLineItems = [SELECT Id
                , Quantity__c
                , EditMode__c
                , Tarifa__c
                , Weight__c
                , Vol__c
                , Rango_KM__c
                , Pack_Seg__c
                , Zona_Plus__c
                , ACK__c
                , EAD__c
                , RAD__c
                , SEG__c
                , PackWeightAVG__c
                , PackVolAVG__c
                , CustomerPrice__c
                , TarifaDominante__c
                , FLETE__c
                ,Guia__c
                , fleteE__c
                , ACKES__c
                ,KG_ADICIONAL__c
                , Destiny__c
                FROM TempleateLine__c where Templeate__c =: templeateId  ORDER BY CreatedDate];
            } else {
                listPlantillaLineItems = [SELECT Id
                , Quantity__c
                , EditMode__c
                , Tarifa__c
                , Weight__c
                , Vol__c
                , Rango_KM__c
                , Pack_Seg__c
                , Zona_Plus__c
                , ACK__c
                , EAD__c
                , RAD__c
                , SEG__c
                , TarifaDominante__c
                , PackWeightAVG__c
                , PackVolAVG__c
                , CustomerPrice__c
                , FLETE__c
                ,Guia__c
                ,fleteE__c
                ,ACKES__c
                ,KG_ADICIONAL__c
                , Destiny__c
                FROM TempleateLine__c where Templeate__c =: templeateId  ORDER BY CreatedDate];
            }
            
        }
        catch (Exception ex){
            System.debug(ex.getMessage());
        }
        return listPlantillaLineItems;
    }
    
    public Templeate__c queryTempleate(){
        Templeate__c objPlantilla = new Templeate__c();
        try{
            objPlantilla = [SELECT Id
            , ServiciosAdicionales__c
            , Acuse__c
            , Electronicas__c
            , Impresas__c
            , TipoCotizacion__c
            , Fecha_sugar__c
            FROM Templeate__c where Quote__c =: this.strIdQuote ORDER BY CreatedDate DESC LIMIT 1];
        }
        catch (Exception ex){
            System.debug(ex.getMessage());
        }
        return objPlantilla;
    }
    
    //metodos involucrados en el problema que presentamos a soporte tecnico.
     
    public static Decimal getFlete(Decimal decCustomerPrice, String strServiciosAdd, TempleateLine__c objtempleateItem){
        Decimal decFlete = 0;
        
        if(!objtempleateItem.Zona_Plus__c)
        {
       if(objtempleateItem.Tarifa__c == 'TARIFA T7' &&  objtempleateItem.ACK__c >= 66){
        objtempleateItem.ACK__c = 65;
        }
        decFlete = objtempleateItem.CustomerPrice__c - objtempleateItem.ACK__c - objtempleateItem.SEG__c;
        if(String.isNotBlank(strServiciosAdd) && strServiciosAdd.contains('EAD') && strServiciosAdd.contains('RAD')){
            decFlete = decFlete / 1.22;
        
          
        }
         else if(String.isNotBlank(strServiciosAdd) && strServiciosAdd.contains('EAD') || strServiciosAdd.contains('RAD')){
            decFlete = decFlete / 1.11;
        }
        else if(string.isBlank(strServiciosAdd)){
            decFlete = decFlete;
        }
      }
        else if(objtempleateItem.Zona_Plus__c)
        {
        if(objtempleateItem.Tarifa__c == 'TARIFA T7' &&  objtempleateItem.ACK__c >= 66){
        objtempleateItem.ACK__c = 65;
        }
         decFlete = objtempleateItem.CustomerPrice__c - (objtempleateItem.ACK__c + objtempleateItem.SEG__c + objtempleateItem.EAD__c + objtempleateItem.RAD__c);
         if(string.isBlank(strServiciosAdd)){
            decFlete = decFlete;
        }
     }
      
        return decFlete;
    }
    
    public static Decimal getFletes(Decimal decCustomerPrice, String strServiciosAdd, TempleateLine__c objtempleateItem){
        Decimal decFlete = 0;
        
        if(!objtempleateItem.Zona_Plus__c)
        {
        decFlete = objtempleateItem.CustomerPrice__c - (objtempleateItem.ACK__c + objtempleateItem.SEG__c + objtempleateItem.EAD__c + objtempleateItem.RAD__c);
       if(string.isBlank(strServiciosAdd)){
            decFlete = decFlete;
        }
      }
        else if(objtempleateItem.Zona_Plus__c)
        {
         decFlete = objtempleateItem.CustomerPrice__c - (objtempleateItem.ACK__c + objtempleateItem.SEG__c + objtempleateItem.EAD__c + objtempleateItem.RAD__c);
         if(string.isBlank(strServiciosAdd)){
            decFlete = decFlete;
        }
     }
      
        return decFlete;
    }
      
    public static Decimal getAcuse(Decimal decCustomerPrice, Boolean blnIsZonaPlus, Decimal decCustomerPricePAQ){ //90
        Decimal decAcuse = 0;
        if(blnIsZonaPlus)
            decAcuse = decCustomerPricePAQ * 0.1;
        else
            decAcuse = decCustomerPrice * 0.1;

        return decAcuse;
    }
    
    public static Decimal getAcuses(TempleateLine__c objtempleateItem){ //90
        Decimal decAcuse = 0;
        if(!objtempleateItem.Zona_Plus__c)
        decAcuse = objtempleateItem.CustomerPrice__c * 0.1;
		else
        decAcuse = objtempleateItem.CustomerPrice__c * 0.1;
        return decAcuse;
    }

    public static Decimal getEAD(Decimal decFlete, TempleateLine__c objtempleateItem){ //90
        decimal decEad = 0;
        if(!objtempleateItem.Zona_Plus__c)
        decEad = decFlete * 0.11;
        else   
        decEad = (objtempleateItem.CustomerPrice__c - (objtempleateItem.ACK__c + objtempleateItem.SEG__c)) * .50;
        return  decEad;//5.82
    }
    
    public static Decimal getEADOS(Decimal decFlete, TempleateLine__c objtempleateItem){ //90
        decimal decEad = 0;
        if(!objtempleateItem.Zona_Plus__c)
        decEad = decFlete * 0.11;
        else   
        decEad = objtempleateItem.CustomerPrice__c - (objtempleateItem.FLETE__c + objtempleateItem.RAD__c + objtempleateItem.ACK__c + objtempleateItem.SEG__c);
        return  decEad;//5.82
    }

     public static Decimal getRAD(Decimal decFlete){ //90
        return decFlete * 0.11; //5.82
    }
    
     public static Decimal getRADS(TempleateLine__c objtempleateItem){ //90
        decimal decEad = 0;
         decEad = (objtempleateItem.CustomerPrice__c - objtempleateItem.ACK__c - objtempleateItem.SEG__c) * 0.09;
         return decEad; //5.82
    }
    
     public static Decimal getEADS(TempleateLine__c objtempleateItem){ //90
        decimal decEad = 0;
         decEad = (objtempleateItem.CustomerPrice__c - objtempleateItem.ACK__c - objtempleateItem.SEG__c) * 0.09;
         return decEad; //5.82
    }
    
    //fin de los metodos
    
    public void editTemplate(){
        for	(TempleateLine__c item: this.listPlantillaLineItems){
			if(item.Id == this.indexDeducItem)
				item.EditMode__c = !item.EditMode__c;
        }
    }
    
    public boolean ValidaSubtotalVsServ(TempleateLine__c objDeduc){
        //Método que valida si la suma de los servicios adicionales y el flete es igual al subtotal
        Decimal suma = objDeduc.ACK__c + objDeduc.FLETE__c + ObjDeduc.RAD__c + ObjDeduc.EAD__c + ObjDeduc.SEG__c; //Se suman los servicios adicionales y el flete
        if (suma.setScale(2) <> ObjDeduc.CustomerPrice__c){ //La sumatoria de los servicios y el flete no puede ser ni mayor ni menor que el subtotal
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'La sumatoria del flete y los servicios no corresponde al subtotal. ' + suma.setScale(2)+' es diferente a '+ObjDeduc.CustomerPrice__c));
        	return true;
        } else
            return false;
    }
    
	public void updateTemplate(){
		TempleateLine__c objDeduc;
        for	(TempleateLine__c item: this.listPlantillaLineItems){
			if(item.Id == this.indexDeducItem)
				objDeduc = item;
        }
        if (ValidaSubtotalVsServ(objDeduc))//Si el subtotal es diferente de la sumatoria de los servicios y el flete
            return; //Rompe el flujo para que no guarde nada
        objDeduc.EditMode__c = false;
		Database.SaveResult resDeducUPD = Database.update(objDeduc, false);
		if(resDeducUPD.isSuccess()) {
            this.listPlantillaLineItems = new List<TempleateLine__c>();
            for(TempleateLine__c line : queryTempleateLine(objtempleate.Id)){
                if(line.Zona_Plus__c )
                    this.blnZP = true;
              
                if(String.isNotBlank(line.Destiny__c))
                    line.Rango_KM__c = line.Destiny__c + ' (' + line.Rango_KM__c + ')';
                this.listPlantillaLineItems.add(line);
            }
            this.mapLines = new Map<String, List< TempleateLine__c>>();
            this.mapLinesZP = new Map<String, List<TempleateLine__c>>();
            for(TempleateLine__c line : listPlantillaLineItems){
                if(!line.Zona_Plus__c){
                    if(!mapLines.containsKey(line.Tarifa__c))
                        mapLines.put(line.Tarifa__c, new List<TempleateLine__c>{ line });
                    else
                        mapLines.get(line.Tarifa__c).add(line);
                } else{
                    if(!mapLinesZP.containsKey(line.Tarifa__c))
                        mapLinesZP.put(line.Tarifa__c, new List<TempleateLine__c>{ line });
                    else
                        mapLinesZP.get(line.Tarifa__c).add(line);
                }
            }
        }
        else
			for(Database.Error insError: resDeducUPD.getErrors())
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, insError.getMessage()));
    }
    
    public class cambio{
        public decimal peso;
        public decimal volumen;
        
    }
    
    public class Tarifas{
        //Salvador: Wrapper para sustituir al objeto "Tarifario_general_terrestre__c" y puedan mapearse tanto sus datos como de las tarifas express
        public string strId             {get;set;}
        public string strtarifa         {get;set;}
        public decimal decTarifa        {get;set;}
        public decimal decPesoMaximo    {get;set;}
        public decimal decVolMaximo     {get;set;}
        public decimal decWeight        {get;set;}
        public decimal decVol           {get;set;}
        public Tarifas(){
            this.strId           = '';
            this.strtarifa	     = '';
            this.decTarifa       = 0;
            this.decPesoMaximo   = 0;
            this.decVolMaximo    = 0;
            this.decWeight       = 0;
            this.decVol          = 0;
        }      
        
    }
    
    public class name{
        public string strId             {get;set;}
        public string strname           {get;set;}
        public string strRangoKm        {get;set;}
        public decimal decAmount        {get;set;}
        public string strOption         {get;set;}
       
         
        public name(){
            this.strId           = '';
            this.strname	     = '';
            this.strRangoKM      = '';
            this.decAmount       = 0;
            this.strOption       = '';
           
        }         
    }
    
    
    /*Recursos de costo base*/ 


    
    
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
        , Lead__r.Name
        , Paquetes_Mensuales__c
        , Ingreso_Mensual__c
        , SBQQ__NetAmount__c
        , Descuento_Global__c
        , TarifaLlenaMensual__c
        , SBQQ__PrimaryContact__r.Name
        , Electronicas__c
        , Impresas__c
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
        , Vol__c
        , DominantWeight__c
        , PaqPorGuia__c
        , PaqPromPorGuia__c 
        FROM SBQQ__QuoteLine__c
        WHERE SBQQ__Quote__c =: strQuoteId
        ORDER BY Rango_KM__c ASC];
    }

    public static Account queryAccount(String strAccId){
        return [SELECT
        Name
        , RFC__c
        , Plaza_Envio__r.Name
        , Industry
        , Giro__c
        , RecordType.Name
        , Descripcion_de_la_mercancia__pc
        , Sucursal__r.Name
        , Id_SIpWeb__c
        , BillingStreet
        , BillingCity
        , BillingPostalCode
        , BillingState
        , BillingCountry
        , Numero_de_facturacion__c
        , Phone
        , Email_de_factura__c
        , Nombre_representante_legal__c
        , Colonia_Facturaci_n__c        
        FROM Account WHERE Id =: strAccId];
    }

    public static Lead queryLead(String strLeadId){
        return [SELECT
        Consideraciones_especiales__c
        FROM Lead WHERE Id=:strLeadId
        ];
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
                , Consideraciones_especiales__c
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
    
   

     /*otros recursos*/ 
    public Boolean hasInfo(String keyFee){
        Boolean info = false;
        if(this.mapQuotes.containsKey(keyFee))
            for(String strRange :  this.mapQuotes.get(keyFee).keySet())
               if(this.mapQuotes.get(keyFee).get(strRange).SBQQ__CustomerPrice__c != 0)
                    info = true;
        if(this.mapQuotesEXP.containsKey(keyFee))
            for(String strRange :  this.mapQuotesEXP.get(keyFee).keySet())
                if(this.mapQuotesEXP.get(keyFee).get(strRange).SBQQ__CustomerPrice__c != 0)
                {
                    info = true;
                    this.mapWEXP.put(keyFee, this.mapQuotesEXP.get(keyFee).get(strRange).Weight__c);
                    if(this.mapQuotesEXP.get(keyFee).get(strRange).Vol__c != 0)
                        this.mapVEXP.put(keyFee, this.mapQuotesEXP.get(keyFee).get(strRange).Vol__c / 1000000);
                }
        return info;
    }
    
    public Boolean hasInfo2(String keyFee){
        Boolean info2 = false;
        for(String strRange :  this.mapQuotesZP.get(keyFee).keySet())
           if(this.mapQuotesZP.get(keyFee).get(strRange).SBQQ__CustomerPrice__c != 0)
                info2 = true;
        return info2;
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
        public Lead						objLead				{get; set;}
        public Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT       {get; set;}
        public Map<String, Decimal>                                     mapACK              {get; set;}
        public Map<String, Map<String, ServicioDomicilio__c>>           mapDomesticService  {get; set;}
        public Map<String, Decimal>                                     mapCS               {get; set;}

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
