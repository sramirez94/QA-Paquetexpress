/*
 * Created by Fran on 10/07/2020.
 */
public class TempleateTriggerHandler {
    public String   strId                                                   {get; set;}
    public Incremento_Anual__c  objincremento                               {get; set;}
    public Map<Decimal, Decimal> mapGuide                                   {get;set;}
    public Boolean blnByDimension                                           {get;set;}
    public Boolean blnCostoBaseGMP                                          {get;set;}
    public Map<Decimal,  Map<String, map<String, Decimal>>> mapBlocksServ   {get;set;}
    public Map<String, Block> mapBlocks                                     {get;set;}
    public Map<Decimal, Map<String, Decimal>> mapRangesByBlock              {get;set;}
    public Map<String, Block> mapService                                    {get;set;}
    public map<String, map<String, Decimal>> mapBlockAdic                   {get;set;}
    Map<String, Map<String, Decimal>> mapRespaldo                           {get;set;}
    public Map<String, QuoteWP>  mapTotalByRange                            {get;set;}
    public List<String> listRangeDestiny                                    {get;set;}
    public Boolean blnRAD                                                   {get;set;}
    public Boolean blnEAD                                                   {get;set;}
    public Boolean blnACK                                                   {get;set;}
    public Boolean blnSEG                                                   {get;set;}
    public Boolean blnZP                                                    {get;set;}
	public TempleateTriggerHandler(){
    }

	public void syncQuote(List<Templeate__c> listNewTempleates){
        try{
            //Variables declaradas solo para el uso en el método
            this.strId = listNewTempleates[0].Quote__c;
            String strRangeDest                                         = '';
            String strTipoDoc                                           = ''; //Tipo de documentación de la cotización
            List<TempleateLine__c> listTempleateLines                   = new List<TempleateLine__c>();
            //Salvador Ramírez (sramirez@freewayconsulting.com) 04/03/2022: Lista con las tarifas predeterminadas
            List<String> listFee                                        = new List<String>{'TARIFA SOBRE', 'TARIFA T0', 'TARIFA T1', 'TARIFA T2', 'TARIFA T3', 'TARIFA T4', 'TARIFA T5', 'TARIFA T6', 'TARIFA T7-P','TARIFA T7-V'};
            Set<Id> setIdQuotes                                         = new Set<Id>();
            Set<Id> setIdincremento                                     = new Set<Id>();
            //Map<String, List<SBQQ__QuoteLine__c>> mapQLines             = new Map<String, List<SBQQ__QuoteLine__c>>();
            Map<String, Map<String, SBQQ__QuoteLine__c>> mapQLines      = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
            Map<String, Map<String, SBQQ__QuoteLine__c>> mapQLinesZP    = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
            Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesT7    = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
            Map<String, Map<String, SBQQ__QuoteLine__c>> mapQLinesPAQ   = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
            Map<Id, SBQQ__Quote__c> mapQuotes                           = new Map<Id, SBQQ__Quote__c>();
            Map<String, Decimal> mapACK                                 = new Map<String, Decimal>();
            Map<String, Decimal> mapACKK                                = new Map<String, Decimal>();
            Map<String, Decimal> mapZPL                                 = new Map<String, Decimal>();
            Map<String, Decimal> mapResiduo                             = new Map<String, Decimal>();
            Map<String, Map<String, Decimal>> mapFlete                  = new Map<String, Map<String, Decimal>>();
            Map<String, Map<String, Decimal>> mapSubTotalZP             = new Map<String, Map<String, Decimal>>();
            Map<String, Decimal> mapRAD                                 = new Map<String, Decimal>();
            Map<String, Decimal> mapEAD                                 = new Map<String, Decimal>();
            Map<String, Decimal> mapFleteSobre                          = new Map<String, Decimal>();
            Map<String, Decimal> mapFleteSobreZP                        = new Map<String, Decimal>();
            Decimal decSEG                                              = 0;
            //Variables globales
            this.blnCostoBaseGMP                                        = false;
            this.blnRAD                                                 = false;
            this.blnEAD                                                 = false;
            this.blnACK                                                 = false;
            this.blnSEG                                                 = false;
            this.blnZP                                                  = false;
            this.mapGuide                                               = new Map<Decimal, Decimal>();
            this.mapBlocksServ                                          = new Map<Decimal, Map<String, map<String, Decimal>>>();
            this.mapBlocks                                              = new Map<String, Block>();
            this.mapRangesByBlock                                       = new Map<Decimal, Map<String, Decimal>>();
            this.mapService                                             = new Map<String, Block>{'ADD' => new Block('ADD',0,0,0), 'ACK' => new Block('ACK',0,0,0), 'ZP' => new Block('ZP',0,0,0)};
            this.mapBlockAdic                                           = new map<String, map<String, Decimal>>();
            this.mapTotalByRange                                        = new Map<String, QuoteWP>();
            //Salvador Ramírez (sramirez@freewayconsulting.com) 04/03/2022: Lista con los rangos de KM predeterminados
            this.listRangeDestiny                                       = new List<String>{'0-400', '401-800', '801-1200', '1201-1600', '1601-2000', '2001-2400', 'Más de 2400'};
            this.mapRespaldo                                            = new Map<String, Map<String, Decimal>>();
            for(Templeate__c objTempleate : listNewTempleates){
                setIdQuotes.add(objTempleate.Quote__c);
            }
            for(SBQQ__Quote__c objQuote : queryQuote(setIdQuotes)){
                mapQuotes.put(objQuote.Id, objQuote);
                strTipoDoc = objQuote.Tipo_de_documentacion__c; //Se respalda el tipo de documentación.
                if((objQuote.Modelo_de_tarifas__c == 'Guía multipieza: Por Destinos / Por rangos de km') || (objQuote.Modelo_de_tarifas__c == 'Costo base más excedente: Por Destinos / Por rangos de km'))
                    this.blnCostoBaseGMP = true;
                if(objQuote.TipoCotizacion__c == 'byDimension')
                    this.blnByDimension = true;
                if(objQuote.Acuse__c != null && String.isNotBlank(objQuote.Acuse__c))
                    this.blnACK = true;
                if(String.isNotBlank(objQuote.Servicios_adicionales__c)){
                    for (String strKeyService : objQuote.Servicios_adicionales__c.split(';')){
                        switch on strKeyService {
                            when 'RAD' {
                                this.blnRAD = true;
                            }
                            when 'EAD' {
                                this.blnEAD = true;
                            }
                            when 'EAD Zona plus'{
                                this.blnZP = true;
                            }
                            when 'Seguro' {this.blnSEG = true;}
                        }
                    }
                }
            }
            List<Incremento_Anual__c> listIncremento = queryIncremento(setIdincremento);
            List<Excepciones_de_incremento__c> listIncrementoExe = queryIncrementoExe();
            TempleateLine__c objTempleateLine;
            Decimal decCustomerPricePAQ = 0;
            for(SBQQ__QuoteLine__c objQLine : queryQuoteLines(setIdQuotes)) {
                strRangeDest = '';
                if(!(objQLine.Tarifa__c == 'TARIFA T7' && objQLine.ZonaPlus__c)){
                    if(objQLine.Destiny__c != null)
                        strRangeDest = objQLine.Destiny__c;
                    else strRangeDest = objQLine.Rango_KM__c;
                    if(!objQLine.ZonaPlus__c){
                        if(!mapQLines.containsKey(objQLine.Tarifa__c)){
                            mapQLines.put(objQLine.Tarifa__c, new Map<String, SBQQ__QuoteLine__c>{strRangeDest => objQline});
                        } else if(mapQLines.containsKey(objQLine.Tarifa__c)){
                            mapQLines.get(objQLine.Tarifa__c).put(strRangeDest, objQLine);
                        }
                    } else {
                        if(!mapQLinesZP.containsKey(objQLine.Tarifa__c)){
                            mapQLinesZP.put(objQLine.Tarifa__c, new Map<String, SBQQ__QuoteLine__c>{strRangeDest => objQline});
                        } else if(mapQLinesZP.containsKey(objQLine.Tarifa__c)){
                            mapQLinesZP.get(objQLine.Tarifa__c).put(strRangeDest, objQLine);
                        }
                    }
                    if(!objQLine.ZonaPlus__c && !mapQLinesPAQ.containsKey(objQLine.Tarifa__c))
                        mapQLinesPAQ.put(objQLine.Tarifa__c, new Map<String, SBQQ__QuoteLine__c>{objQLine.Rango_KM__c => objQLine});
                    else if(!objQLine.ZonaPlus__c && mapQLinesPAQ.containsKey(objQLine.Tarifa__c))
                        mapQLinesPAQ.get(objQLine.Tarifa__c).put(objQLine.Rango_KM__c , objQLine);
                    //T7 Quotes
                    if(objQLine.Tarifa__c.contains('TARIFA T7-')){
                        if(!mapQuotesT7.containsKey(objQLine.Tarifa__c))
                            mapQuotesT7.put(objQLine.Tarifa__c, new Map<String, SBQQ__QuoteLine__c>{ objQLine.Rango_KM__c => objQLine} );
                        else if(!mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c))
                            mapQuotesT7.get(objQLine.Tarifa__c).put(objQLine.Rango_KM__c, objQLine);
                    }
                    if(objQline.SEG__c > 0 && objQline.SEG__c != null)decSEG = objQline.SEG__c;
                    if(!this.listRangeDestiny.contains(strRangeDest)){
                        this.listRangeDestiny.add(strRangeDest);
                    }
                    //Salvador Ramírez (sramirez@freewayconsulting.com) 04/03/2022: Si alguna tarifa de las que vienen en la cotización no está en las predeterminadas se agrega
                    if(!listFee.contains(objQLine.Tarifa__c)){
                        listFee.add(objQLine.Tarifa__c);
                    }
                    if(this.blnCostoBaseGMP){
                        //Incremento anual para cotizaciones de costo base más excedente y multipieza
                        if(objQLine.CreatedDate.year() < System.today().year() && listIncremento.size() > 0){
                            for(Incremento_Anual__c incYear : listIncremento){
                                if(objQline.CreatedDate.year() < Integer.valueOf(incyear.Anio__c)){
                                    for(Excepciones_de_incremento__c incEXE: listIncrementoExe){if(incEXE.Incremento_Anual__c == incYear.id){incyear.Incremento_anual_remota__c = incEXE.Incremento_remota__c;}}
                                    if(objQLine.KG_ADICIONAL__c != null && objQLine.KG_ADICIONAL__c != 0){
                                        objQLine.KG_ADICIONAL__c = (objQLine.KG_ADICIONAL__c * (IncYear.Incremento_anual_remota__c / 100)) + objQLine.KG_ADICIONAL__c;
                                    }
                                    if(IncYear.Incremento_anual_remota__c == NULL){IncYear.Incremento_anual_remota__c = 0;}
                                    if(objQLine.Flete__c > 0){
                                        objQLine.Flete__c = (objQLine.Flete__c * (IncYear.Incremento_anual_remota__c / 100)) + objQline.Flete__c;
                                    }
                                    if(objQline.ZonaPlus__c && objQLine.Tarifa__c != 'TARIFA T7' && objQLine.EAD__c > 0){objQLine.EAD__c = (objQLine.EAD__c * (IncYear.Incremento_anual_remota__c / 100)) + objQline.EAD__c;}
                                }
                            }
                        }
                        if(!this.mapGuide.containsKey(objQLine.PackWeightAVG__c))
                            this.mapGuide.put(objQLine.PackWeightAVG__c, objQLine.PackVolAVG__c);
                        if(!mapRangesByBlock.containsKey(objQLine.PackWeightAVG__c))
                            mapRangesByBlock.put(objQLine.PackWeightAVG__c, new Map<String, Decimal>{strRangeDest => objQLine.FLETE__c});
                        else if(!mapRangesByBlock.get(objQLine.PackWeightAVG__c).containsKey(strRangeDest))
                            mapRangesByBlock.get(objQLine.PackWeightAVG__c).put(strRangeDest, objQLine.FLETE__c);
                        if(!this.mapService.get('ADD').mapRanges.containsKey(strRangeDest)){
                            this.mapService.get('ADD').mapRanges.put(strRangeDest, objQLine.KG_ADICIONAL__c);
                        }
                        if(!this.mapService.get('ACK').mapRanges.containsKey(strRangeDest)){
                            this.mapService.get('ACK').mapRanges.put(strRangeDest, objQLine.ACK__c);
                        }
                        if(objQLine.ZonaPlus__c && objQLine.Tarifa__c != 'TARIFA T7')
                            this.mapService.get('ZP').mapRanges.put(strRangeDest, objQLine.EAD__c);
                    } else {
                        //Se realiza un caso especial para cuando la cotización solo contenga servicio de entrega a domicilio y ningún otro o solo tenga EAD y todos los servicios excepto RAD
                        if((objQline.ZonaPlus__c && blnEAD && !blnRAD && !blnSEG && !blnACK) || (objQline.ZonaPlus__c && blnEAD && !blnRAD && blnSEG && blnACK) || (objQline.ZonaPlus__c && blnEAD && !blnRAD && blnSEG && !blnACK) || (objQline.ZonaPlus__c && blnEAD && !blnRAD && !blnSEG && blnACK)){
                            if(!mapSubTotalZP.containsKey(objQLine.Tarifa__c)){
                                mapSubTotalZP.put(objQLine.Tarifa__c, new Map<String, Decimal>());
                            }
                            if(!mapSubTotalZP.get(objQLine.Tarifa__c).containsKey(strRangeDest)){
                                mapSubTotalZP.get(objQLine.Tarifa__c).put(strRangeDest, objQline.SBQQ__CustomerPrice__c);
                            }
                            if(!mapFleteSobreZP.containsKey(strRangeDest)){
                                mapFleteSobreZP.put(strRangeDest, objQline.SBQQ__CustomerPrice__c);
                            }
                        } else if(!objQLine.ZonaPlus__c && blnEAD && !blnRAD){
                            //Se respalda primero el cálculo del flete de la tarifa sobre. En este caso es escencial ya que primero se deben tomar los costos de zona plus
                            //Pero por cuestiones de la forma en que se guardan los datos no es posible.
                            if(objQLine.Tarifa__c == 'TARIFA SOBRE'){
                                if(!mapFleteSobre.containsKey(strRangeDest)){
                                    mapFleteSobre.put(strRangeDest, (objQline.SBQQ__CustomerPrice__c / 1.11));
                                }
                            }
                        }
                    }
                }
            }
           //aqui comienza el desarrollo para los calculos de plantillas de costo base y guia multipieza
            if(this.blnCostoBaseGMP){
                Integer blockCounter = 1;
                Decimal decRespaldoFlete = 0;
                System.debug('mapRangesByBlock: ' + mapRangesByBlock);
                for(Decimal decW : this.mapGuide.keySet()){
                    this.mapBlocks.put('BLOQUE '+ blockCounter, new Block('BLOQUE '+ blockCounter, decW, this.mapGuide.get(decW), this.mapGuide.get(decW) * 200) );
                    this.mapBlocks.get('BLOQUE '+ blockCounter).mapRanges = mapRangesByBlock.get(decW);
                    this.mapRespaldo.put('BLOQUE ' + blockCounter, new Map<String, Decimal>());
                    for(String keyRange: this.listRangeDestiny){
                        Decimal decFlete = 0;
                        if(mapRangesByBlock.get(decW).containsKey(keyRange)){
                            if(!this.mapBlocksServ.containsKey(decW)) {
                                this.mapBlocksServ.put(decW, new map<String, map<String, Decimal>>());
                                this.mapBlocksServ.get(decW).put('FLT', new map<String, Decimal>());
                                this.mapBlocksServ.get(decW).put('RAD', new map<String, Decimal>());
                                this.mapBlocksServ.get(decW).put('EAD', new map<String, Decimal>());
                                this.mapBlocksServ.get(decW).put('ADD', new Map<String, Decimal>());
                            }
                            decRespaldoFlete = mapRangesByBlock.get(decW).get(keyRange);
                            mapRespaldo.get('BLOQUE ' + blockCounter).put(keyRange, mapRangesByBlock.get(decW).get(keyRange));
                            if(blockCounter > 1){
                                System.debug('decw: ' + decw + '. KeyRange: ' + keyRange);
                                if(this.blnRAD && this.blnEAD)
                                    decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange)) / 1.22;
                                else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD))
                                    decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange)) / 1.11;
                                else if(!this.blnRAD && !this.blnEAD)
                                    decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange));
                            } else {
                                System.debug('decw: ' + decw + '. KeyRange: ' + keyRange + 'decRespaldoFlete: ' + decRespaldoFlete);
                                if(this.blnRAD && this.blnEAD)
                                    decFlete = decRespaldoFlete / 1.22;
                                else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD))
                                    decFlete = decRespaldoFlete / 1.11;
                                else if(!this.blnRAD && !this.blnEAD)
                                    decFlete = decRespaldoFlete;
                            }
                            if(!this.mapBlocksServ.get(decW).get('FLT').containsKey(keyRange)){
                                this.mapBlocksServ.get(decW).get('FLT').put(keyRange, (decFlete));
                            }
                            if(!this.mapBlocksServ.get(decW).get('RAD').containsKey(keyRange)){
                                this.mapBlocksServ.get(decW).get('RAD').put(keyRange, (decFlete * 0.11));
                            }
                            if(!this.mapBlocksServ.get(decW).get('EAD').containsKey(keyRange)){
                                this.mapBlocksServ.get(decW).get('EAD').put(keyRange, (decFlete * 0.11));
                            }
                            if(!this.mapBlocksServ.get(decW).get('ADD').containsKey(keyRange)){
                                Decimal decTotalAdic = 0;
                                if(this.blnRAD)
                                    decTotalAdic += this.mapBlocksServ.get(decW).get('RAD').get(keyRange);
                                if(this.blnEAD)
                                    decTotalAdic += this.mapBlocksServ.get(decW).get('EAD').get(keyRange);
                                decTotalAdic += decFlete;
                                this.mapBlocksServ.get(decW).get('ADD').put(keyRange, decTotalAdic);
                            }
                        }
                    }
                    blockCounter++;
                }
                this.mapBlockAdic.put('ADD', new map<String, Decimal>());
                this.mapBlockAdic.put('EAD', new map<String, Decimal>());
                this.mapBlockAdic.put('RAD', new map<String, Decimal>());
                this.mapBlockAdic.put('TOT', new map<String, Decimal>());
                for(String keyRange: this.listRangeDestiny){
                    this.mapTotalByRange.put(keyRange, new QuoteWP());
                    Decimal decFlete = 0;
                    if(!this.mapBlockAdic.get('ADD').containsKey(keyRange) && this.mapService.get('ADD').mapRanges.containsKey(keyRange)){
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
                }
            }
            //mapeo de plantillas dependiendo si son por rango de kilometros o destinos y le asigna el subtotal.
            Integer contador = 0;
            String strTarifaResp = '';
            Templeate__c objTempleate = listNewTempleates[0];
            for(String strTarifa : listFee){
                for(String strRange : listRangeDestiny){
                    if(mapQLines.containsKey(strTarifa) && mapQLines.get(strTarifa).containsKey(strRange)){
                        SBQQ__QuoteLine__c objQLine = mapQLines.get(strTarifa).get(strRange);
                        if(mapQLines.get(strTarifa).get(strRange).ZonaPlus__c && mapQLinesPAQ.containsKey(strTarifa) && mapQLinesPAQ.containsKey(strTarifa) && mapQLinesPAQ.get(strTarifa).containsKey(strRange)){decCustomerPricePAQ = mapQLinesPAQ.get(strTarifa).get(strRange).SBQQ__CustomerPrice__c;}
                        //Código de incremento anual
                        if((listIncremento.size() > 0 && objTempleate.FechaCreacionCotizacion__c.year() < System.today().year() && objTempleate.Fecha_sugar__c == null) || (listIncremento.size() > 0 && objTempleate.FechaCreacionCotizacion__c.year() <= System.today().year() && objTempleate.Fecha_sugar__c != null)){
                            for(Incremento_Anual__c IncYear : listIncremento){
                                if((objTempleate.FechaCreacionCotizacion__c.year() < Integer.valueOf(IncYear.Anio__c) || (objTempleate.Fecha_sugar__c != null && objTempleate.Fecha_sugar__c.year() < Integer.valueOf(IncYear.Anio__c))) ) {
                                    for(Excepciones_de_incremento__c incEXE: listIncrementoExe){
                                        if(incEXE.Incremento_Anual__c == incYear.id){
                                            if(strTipoDoc == 'Guías prepagadas'){
                                                incyear.Incremento_anual_prepago__c = incEXE.Incremento_prepago__c;
                                            } else if(strTipoDoc == 'Documentación Remota'){
                                                incyear.Incremento_anual_remota__c = incEXE.Incremento_remota__c;
                                            }
                                        }
                                    }
                                    if(strTipoDoc == 'Guías prepagadas'){
                                        if(IncYear.Incremento_anual_prepago__c == NULL){
                                            IncYear.Incremento_anual_prepago__c = 0;
                                        }
                                        objQLine.SBQQ__CustomerPrice__c = (objQLine.SBQQ__CustomerPrice__c * (IncYear.Incremento_anual_prepago__c /  100)) + objQline.SBQQ__CustomerPrice__c;
                                        if(mapQuotesT7.containsKey(objQLine.Tarifa__c) && mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c)){
                                            mapQuotesT7.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c;
                                        }
                                        if(objQLine.ZonaPlus__c)
                                            decCustomerPricePAQ = ((decCustomerPricePAQ * IncYear.Incremento_anual_prepago__c) / 100) + decCustomerPricePAQ;
                                    } else if(strTipoDoc == 'Documentación Remota'){
                                        if(objQLine.KG_ADICIONAL__c != null && objQLine.KG_ADICIONAL__c != 0){
                                            objQLine.KG_ADICIONAL__c = (objQLine.KG_ADICIONAL__c * (IncYear.Incremento_anual_remota__c / 100)) + objQLine.KG_ADICIONAL__c;
                                        }
                                        if(IncYear.Incremento_anual_remota__c == NULL){IncYear.Incremento_anual_remota__c = 0;}
                                        if(objQLine.SBQQ__CustomerPrice__c > 0){
                                            objQLine.SBQQ__CustomerPrice__c = (objQLine.SBQQ__CustomerPrice__c * (IncYear.Incremento_anual_remota__c / 100)) + objQline.SBQQ__CustomerPrice__c;
                                        }
                                        if(objQLine.ZonaPlus__c)decCustomerPricePAQ = ((decCustomerPricePAQ * IncYear.Incremento_anual_remota__c) / 100) + decCustomerPricePAQ;
                                        if(mapQuotesT7.containsKey(objQLine.Tarifa__c) && mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c))
                                            mapQuotesT7.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c;
                                    }
                                }
                            }
                        }
                        //Partidas de la nueva plantilla
                        objTempleateLine = new TempleateLine__c(
                            Templeate__c = objTempleate.Id
                            , Quantity__c = objQLine.SBQQ__Quantity__c
                            , Tarifa__c = objQLine.Tarifa__c
                            , Bloque__c = ''
                            , TarifaDominante__c = objQLine.TarifaDominante__c
                            , Weight__c = objQLine.Weight__c
                            , Vol__c = objQLine.Vol__c / 1000000
                            , Rango_KM__c = objQLine.Rango_KM__c
                            , Destiny__c = objQLine.Destiny__c
                            , Pack_Seg__c = objQLine.Pack_Seg__c
                            , Zona_Plus__c = objQLine.ZonaPlus__c
                            , Guia__c = objQLine.GUIA__c
                            , ACK__c = 0
                            , EAD__c = 0
                            , RAD__c = 0
                            , SEG__c = decSEG
                            , CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c.setScale(2)
                            , FLETE__c = 0
                            , fleteE__c = objQLine.FLETE__c
                            , ACKES__c = objQLine.ACK__c
                            ,KG_ADICIONAL__c = objQline.KG_ADICIONAL__c
                        );
                        if(this.blnCostoBaseGMP){
                            if(objQLine.Tarifa__C.contains('TARIFA T7_'))objTempleateLine.Tarifa__C = 'TARIFA T7';else objTempleateLine.Tarifa__c = objQLine.Tarifa__c;
                        }
                        //cualculo para ver el peso predominante del t7 si es por volumen o por kilogramo
                        if(objQLine.Tarifa__c == 'TARIFA T7'){
                            objTempleateLine.Vol__c = objQLine.PackVolAVG__c;
                            objTempleateLine.Weight__c = objQLine.PackWeightAVG__c;
                            if(mapQuotesT7.containsKey(objQLine.Tarifa__c+'-P') && mapQuotesT7.get(objQLine.Tarifa__c+'-P').containsKey(objQLine.Rango_KM__c)
                                    && mapQuotesT7.containsKey(objQLine.Tarifa__c+'-V') && mapQuotesT7.get(objQLine.Tarifa__c+'-V').containsKey(objQLine.Rango_KM__c))
                                objTempleateLine.CustomerPrice__c = getDominantPrice(mapQuotesT7.get(objQLine.Tarifa__c+'-P').get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c, mapQuotesT7.get(objQLine.Tarifa__c+'-V').get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c);
                        }
                        if(String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('Acuse')){
                            objTempleateLine.ACK__c  = Ctrl_pantalla_ww.getAcuse(objQLine.SBQQ__CustomerPrice__c, objQLine.ZonaPlus__c, decCustomerPricePAQ);
                        }
                        else if(String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && !mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('Acuse')){
                            objTempleateLine.ACK__c = 0;
                        }
                        if(objTempleateLine.Tarifa__c != 'TARIFA T7-P'){
                            if(!mapACK.containsKey(objQLine.Rango_KM__c))
                                mapACK.put(objQLine.Rango_KM__c, objTempleateLine.ACK__c);
                            else{
                                objTempleateLine.ACK__c = mapACK.get(objQLine.Rango_KM__c);
                                objTempleateLine.ACK__c = objTempleateLine.ACK__c.setScale(2);
                            }
                        }
                        else{
                            objTempleateLine.ACK__c = 0;
                        }
                        if(!this.blnCostoBaseGMP){ //Salvador Ramírez (sramirez@freewayconsulting.com): Si no es una cotización de costo base más excedente o de guía multipieza (Es por costos fijos por tarifa)
                            strRangeDest = '';
                            if(objTempleateLine.Destiny__c != null)
                                strRangeDest = objTempleateLine.Destiny__c;
                            else strRangeDest = objTempleateLine.Rango_KM__c;
                            if(!(objTempleateLine.Tarifa__C == 'TARIFA T7' && objTempleateLine.Zona_Plus__c)){ //Salvador Ramírez (sramirez@freewayconsulting.com): Si no es una tarifa t7 que sea zona plus
                                if(strTarifaResp == '') //Salvador Ramírez (sramirez@freewayconsulting.com): Si aún no se respalda la tarifa anterior
                                    contador = 0; //Salvador Ramírez (sramirez@freewayconsulting.com): El contador se queda en 0
                                else if(strTarifaResp != objTempleateLine.Tarifa__c) //Salvador Ramírez (sramirez@freewayconsulting.com): Si ya se respaldó la tarifa anterior se compara con la actual
                                    contador++; //Salvador Ramírez (sramirez@freewayconsulting.com): Si es diferente se le suma 1 al contador, esto para solo para saber si es la primer tarifa en pasar o son superiores, esto para saber si el flete debe dividirse entre 1.22 o 1.11
                                if((objTempleateLine.Tarifa__C == 'TARIFA T7-P' || objTempleateLine.Tarifa__C == 'TARIFA T7-V' || objTempleateLine.Tarifa__C == 'TARIFA T7') || !this.blnZP){
                                    if(this.blnRAD && this.blnEAD)
                                        contador = 0;
                                    else if((this.blnRAD && !this.blnEAD) || (!this.blnRAD && this.blnEAD))
                                        contador = 1;
                                    objTempleateLine.FLETE__c = Ctrl_pantalla_ww.getFlete(objQLine.SBQQ__CustomerPrice__c, mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c, objTempleateLine, 0);
                                } else if(this.blnZP) {
                                    if(!mapFlete.containsKey(objTempleateLine.Tarifa__c)) //Salvador Ramírez (sramirez@freewayconsulting.com): Si el mapa no tiene la tarifa
                                        mapFlete.put(objTempleateLine.Tarifa__c, new Map<String, Decimal>()); //Salvador Ramírez (sramirez@freewayconsulting.com): Se crea un nuevo registro de mapa con esa tarifa
                                    if((!blnACK && blnSEG) || (blnACK & !blnSEG)){
                                        if((blnEAD && !blnRAD && !blnACK && blnSEG) || (blnEAD && !blnRAD && !blnSEG && blnACK)) {
                                            if(contador == 0){
                                                if(!mapFlete.get(objTempleateLine.Tarifa__c).containsKey(strRangeDest)){
                                                    objTempleateLine.Flete__c = (objQLine.SBQQ__CustomerPrice__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c) / 1.11;
                                                    mapFlete.get(objTempleateLine.Tarifa__c).put(strRangeDest, objTempleateLine.Flete__c);
                                                } else objTempleateLine.Flete__c =  mapFlete.get(objTempleateLine.Tarifa__c).get(strRangeDest);
                                                if(!mapZPL.containsKey(strRangeDest)){
                                                    mapZPL.put(strRangeDest, (mapSubTotalZP.get(objTempleateLine.Tarifa__c).get(strRangeDest) - objTempleateLine.Flete__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c));
                                                }
                                            } else {
                                                objTempleateLine.Flete__c = mapSubTotalZP.get(objTempleateLine.Tarifa__c).get(strRangeDest) - mapZPL.get(strRangeDest) - objTempleateLine.SEG__c - objTempleateLine.ACK__c;
                                            }
                                        } else {
                                            if(!mapFlete.get(objTempleateLine.Tarifa__c).containsKey(strRangeDest)){ //Salvador Ramírez (sramirez@freewayconsulting.com): Si el mapa ya tiene la tarifa pero no tiene el rango de km
                                                if(mapEAD.containsKey(strRangeDest)) //Salvador Ramírez (sramirez@freewayconsulting.com): Si hay un rango de km con costo de EAD
                                                    objQLine.SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c - mapEAD.get(strRangeDest); //Salvador Ramírez (sramirez@freewayconsulting.com): Se le resta al subtotal
                                                if(mapRAD.containsKey(strRangeDest))
                                                    objQLine.SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c - mapRAD.get(strRangeDest);
                                                if(contador == 0) //Salvador Ramírez (sramirez@freewayconsulting.com): Si es la primera vez que se hace el recorrido, es decir, la primer tarifa deberá calcular el flete dividiendo entre 1.22
                                                    objTempleateLine.FLETE__c = Ctrl_pantalla_ww.getFlete(objQLine.SBQQ__CustomerPrice__c, mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c, objTempleateLine, contador); //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene el costo del flete
                                                else objTempleateLine.FLETE__c = objQLine.SBQQ__CustomerPrice__c - objTempleateLine.ACK__c - objTempleateLine.SEG__c; //En caso de que sea mayor al primer recorrido entonces deberá calcular el flete restando el rAD, EAD, Acuse y seguro
                                                mapFlete.get(objTempleateLine.Tarifa__c).put(strRangeDest, objTempleateLine.FLETE__c); //Salvador Ramírez (sramirez@freewayconsulting.com): Se respalda en su rango de km el costo que tuvo el flete
                                            } else objTempleateLine.FLETE__c = mapFlete.get(objTempleateLine.Tarifa__c).get(strRangeDest);
                                        }
                                    } else if((!blnACK && !blnSEG) || (blnACK && blnSEG)){
                                        if((blnEAD && blnRAD)){
                                            if(!mapFlete.get(objTempleateLine.Tarifa__C).containsKey(strRangeDest)){
                                                if(mapEAD.containsKey(strRangeDest) && mapRAD.containsKey(strRangeDest))
                                                    objTempleateLine.Flete__c = objQLine.SBQQ__CustomerPrice__c - mapEAD.get(strRangeDest) - mapRAD.get(strRangeDest) - objTempleateLine.SEG__c - objTempleateLine.ACK__c;
                                                else  objTempleateLine.FLETE__c = Ctrl_pantalla_ww.getFlete(objQLine.SBQQ__CustomerPrice__c, mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c, objTempleateLine, 0);
                                                mapFlete.get(objTempleateLine.Tarifa__C).put(strRangeDest, objTempleateLine.FLETE__c);
                                            } else objTempleateLine.FLETE__c = mapFlete.get(objTempleateLine.Tarifa__C).get(strRangeDest);
                                        } else if((blnEAD && !blnRAD && !blnACK && !blnSEG) || (blnEAD && !blnRAD && blnSEG && blnACK)){
                                            if(contador == 0){
                                                if(!mapFlete.get(objTempleateLine.Tarifa__c).containsKey(strRangeDest)){
                                                    objTempleateLine.Flete__c = (objQLine.SBQQ__CustomerPrice__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c) / 1.11;
                                                    mapFlete.get(objTempleateLine.Tarifa__c).put(strRangeDest, objTempleateLine.Flete__c);
                                                } else {
                                                    objTempleateLine.Flete__c =  mapFlete.get(objTempleateLine.Tarifa__c).get(strRangeDest);
                                                }
                                                if(!mapZPL.containsKey(strRangeDest)){
                                                    mapZPL.put(strRangeDest, (mapSubTotalZP.get(objTempleateLine.Tarifa__c).get(strRangeDest) - objTempleateLine.Flete__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c));
                                                }
                                            } else {
                                                if(mapSubTotalZP.containsKey(objTempleateLine.Tarifa__c) && mapSubTotalZP.get(objTempleateLine.Tarifa__c).containsKey(strRangeDest)){
                                                    objTempleateLine.Flete__c = mapSubTotalZP.get(objTempleateLine.Tarifa__c).get(strRangeDest) - mapZPL.get(strRangeDest).setScale(2) - objTempleateLine.SEG__c - objTempleateLine.ACK__c;
                                                }
                                            }
                                        } else if(!blnEAD && blnRAD){
                                            if(mapRAD.containsKey(strRangeDest))
                                                objTempleateLine.Flete__c = objQLine.SBQQ__CustomerPrice__c - mapRAD.get(strRangeDest);
                                        }
                                    }
                                } else if (!this.blnZP) {
                                    if(!this.blnEAD && this.blnRAD && this.blnACK && this.blnSEG){
                                        //Sin entrega a domicilio
                                        objTempleateLine.Flete__c = objQLine.SBQQ__CustomerPrice__c -  objTempleateLine.SEG__c - objTempleateLine.ACK__c;
                                    } else if ((this.blnEAD && this.blnRAD && this.blnACK && this.blnSEG) || (this.blnRAD && this.blnEAD && this.blnSEG && !this.blnACK)){
                                        //Todos los servicios
                                        objTempleateLine.Flete__c = (objQLine.SBQQ__CustomerPrice__c -  objTempleateLine.SEG__c - objTempleateLine.ACK__c) / 1.22;
                                    }
                                }
                                if(this.blnRAD){ //Salvador Ramírez (sramirez@freewayconsulting.com): Si es una cotización con RAD
                                    if((objTempleateLine.Tarifa__C == 'TARIFA T7-P' || objTempleateLine.Tarifa__C == 'TARIFA T7-V' || objTempleateLine.Tarifa__C == 'TARIFA T7') || !this.blnZP){
                                        objTempleateLine.RAD__c = Ctrl_pantalla_ww.getRAD(objTempleateLine.FLETE__c);
                                    } else if(this.blnZP) {
                                        if(!blnSEG && blnRAD && blnEAD && blnACK){
                                            if(!objQline.ZonaPlus__c){
                                                if(!mapRAD.containsKey(strRangeDest)){
                                                    objTempleateLine.RAD__c = Ctrl_pantalla_ww.getRAD(objTempleateLine.FLETE__c); //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene el costo por RAD
                                                    mapRAD.put(strRangeDest, objTempleateLine.RAD__c);//Salvador Ramírez (sramirez@freewayconsulting.com): Se respalda en el mapa con su tarifa y su rango de km
                                                } else {
                                                    objTempleateLine.RAD__c = mapRAD.get(strRangeDest);
                                                }
                                            } else {
                                                if(contador == 0){
                                                    if(mapRAD.containsKey(strRangeDest)){
                                                        objTempleateLine.RAD__c = mapRAD.get(strRangeDest);
                                                    } else {
                                                        objTempleateLine.RAD__c = Ctrl_pantalla_ww.getRAD(objTempleateLine.FLETE__c);
                                                    }
                                                } else {
                                                    objTempleateLine.RAD__c = objQLine.SBQQ__CustomerPrice__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c - objTempleateLine.FLETE__c - mapZPL.get(strRangeDest);
                                                }
                                            }
                                        } else {
                                            if(!mapRAD.containsKey(strRangeDest)){
                                                objTempleateLine.RAD__c = Ctrl_pantalla_ww.getRAD(objTempleateLine.FLETE__c); //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene el costo por RAD
                                                mapRAD.put(strRangeDest, objTempleateLine.RAD__c);//Salvador Ramírez (sramirez@freewayconsulting.com): Se respalda en el mapa con su tarifa y su rango de km
                                            } else objTempleateLine.RAD__c = mapRAD.get(strRangeDest);
                                        }
                                    } else if(!this.blnZP) {
                                        objTempleateLine.RAD__c = objTempleateLine.Flete__c * 0.11;
                                    }
                                }
                                if(this.blnEAD){ //Salvador Ramírez (sramirez@freewayconsulting.com): Si se está usando EAD
                                    if(!objQline.ZonaPlus__c){ //Salvador Ramírez (sramirez@freewayconsulting.com): Si no es un registro con zona plus (Esto porque la zona plus es considerada un tipo de EAD que se calcula diferente)
                                        if((objTempleateLine.Tarifa__C == 'TARIFA T7-P' || objTempleateLine.Tarifa__C == 'TARIFA T7-V' || objTempleateLine.Tarifa__C == 'TARIFA T7') || !this.blnZP){
                                            objTempleateLine.EAD__c = Ctrl_pantalla_ww.getEAD(objTempleateLine.FLETE__c, objTempleateLine);
                                        } else if(this.blnZP) {
                                            if((blnEAD && !blnRAD && !blnACK && !blnSEG) || (blnEAD && !blnRAD && blnACK && blnSEG) || (blnEAD && !blnRAD && !blnACK && blnSEG) || (blnEAD && !blnRAD && !blnSEG && blnACK)){
                                                if(contador == 0)
                                                    objTempleateLine.EAD__c = Ctrl_pantalla_ww.getEAD(objTempleateLine.FLETE__c, objTempleateLine);
                                                else objTempleateLine.EAD__c = objQLine.SBQQ__CustomerPrice__c - objTempleateLine.FLETE__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c;
                                            } else {
                                                if(!mapEAD.containsKey(strRangeDest)){ //Salvador Ramírez (sramirez@freewayconsulting.com): si el mapa que respalda el costo de EAD no tiene ese rango de km
                                                    objTempleateLine.EAD__c = Ctrl_pantalla_ww.getEAD(objTempleateLine.FLETE__c, objTempleateLine); //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene el costo por EAD de ese rango
                                                    mapEAD.put(strRangeDest, objTempleateLine.EAD__C); //Salvador Ramírez (sramirez@freewayconsulting.com): Se respalda en el mapa
                                                } else  objTempleateLine.EAD__c = mapEAD.get(strRangeDest); //Salvador Ramírez (sramirez@freewayconsulting.com): Si ya existe en el mapa entonces se le asigna el costo del rango de km que actualmente se está recorriendo
                                            }
                                        } else if(!this.blnZP){
                                            objTempleateLine.EAD__c = objQLine.SBQQ__CustomerPrice__c - objTempleateLine.FLETE__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c - objTempleateLine.RAD__c;
                                        }
                                    }
                                }
                                strTarifaResp = objTempleateLine.Tarifa__c;//Salvador Ramírez (sramirez@freewayconsulting.com): Se respalda la tarifa para la siguiente vuelta del recorrido
                            }
                        } else {
                            //Salvador Ramírez (sramirez@freewayconsulting.com): Si es una cotización de costo base más excedente
                            if(!objTempleateLine.Zona_Plus__c && String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && !mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('EAD Zona plus')){
                                if(this.blnCostoBaseGMP){
                                    strRangeDest = '';
                                    if(objQLine.Destiny__c != null)
                                        strRangeDest = objQLine.Destiny__c;
                                    else strRangeDest = objQLine.Rango_KM__c;
                                    objTempleateLine.FLETE__c = this.mapBlocksServ.get(objQLine.PackWeightAVG__c).get('FLT').get(strRangeDest).setScale(2);
                                    if(this.blnRAD)
                                        objTempleateLine.RAD__c   = this.mapBlocksServ.get(objQLine.PackWeightAVG__c).get('RAD').get(strRangeDest).setScale(2);
                                    if(this.blnEAD)
                                        objTempleateLine.EAD__c   = this.mapBlocksServ.get(objQLine.PackWeightAVG__c).get('EAD').get(strRangeDest).setScale(2);
                                    objTempleateLine.KG_ADICIONAL__c = this.mapBlocksServ.get(objQLine.PackWeightAVG__c).get('ADD').get(strRangeDest).setScale(2);
                                    objTempleateLine.FleteAdic__c    = this.mapBlockAdic.get('ADD').get(strRangeDest).setScale(2);
                                    if(this.mapBlockAdic.get('RAD').containsKey(strRangeDest) && this.blnRAD)
                                        objTempleateLine.RADAdic__c      = this.mapBlockAdic.get('RAD').get(strRangeDest).setScale(2);
                                    if(this.mapBlockAdic.get('EAD').containsKey(strRangeDest) && this.blnEAD)
                                        objTempleateLine.EADAdic__c      = this.mapBlockAdic.get('EAD').get(strRangeDest).setScale(2);
                                    objTempleateLine.TotalAdic__c        = this.mapBlockAdic.get('TOT').get(strRangeDest).setScale(2);
                                    objTempleateLine.PackWeightAVG__c = objQLine.PackWeightAVG__c;
                                    objTempleateLine.PackVolAVG__c = objQLine.PackVolAVG__c;
                                    objTempleateLine.CustomerPrice__c = objQLine.FLETE__c;
                                }
                            }
                            //TARIFA ESTANDAR Y TARIFA ZONA PLUS JUNTAS
                            else if(!objTempleateLine.Zona_Plus__c){//ESTANDAR
                                if( objTempleateLine.Tarifa__c != 'TARIFA T7-P'){
                                    if(this.blnCostoBaseGMP){
                                        strRangeDest = '';
                                        if(objQLine.Destiny__c != null)strRangeDest = objQLine.Destiny__c;
                                        else strRangeDest = objQLine.Rango_KM__c;
                                        objTempleateLine.FLETE__c = this.mapBlocksServ.get(objQLine.PackWeightAVG__c).get('FLT').get(strRangeDest).setScale(2);
                                        if(this.blnRAD)
                                            objTempleateLine.RAD__c   = this.mapBlocksServ.get(objQLine.PackWeightAVG__c).get('RAD').get(strRangeDest).setScale(2);
                                        if(this.blnEAD)objTempleateLine.EAD__c   = this.mapBlocksServ.get(objQLine.PackWeightAVG__c).get('EAD').get(strRangeDest).setScale(2);
                                        objTempleateLine.KG_ADICIONAL__c = this.mapBlocksServ.get(objQLine.PackWeightAVG__c).get('ADD').get(strRangeDest).setScale(2);
                                        objTempleateLine.FleteAdic__c    = this.mapBlockAdic.get('ADD').get(strRangeDest).setScale(2);
                                        if(this.mapBlockAdic.get('RAD').containsKey(strRangeDest) && this.blnRAD)
                                            objTempleateLine.RADAdic__c      = this.mapBlockAdic.get('RAD').get(strRangeDest).setScale(2);
                                        if(this.mapBlockAdic.get('EAD').containsKey(strRangeDest) && this.blnEAD)objTempleateLine.EADAdic__c      = this.mapBlockAdic.get('EAD').get(strRangeDest).setScale(2);
                                        objTempleateLine.TotalAdic__c        = this.mapBlockAdic.get('TOT').get(strRangeDest).setScale(2);
                                        objTempleateLine.PackWeightAVG__c = objQLine.PackWeightAVG__c;
                                        objTempleateLine.PackVolAVG__c = objQLine.PackVolAVG__c;
                                        objTempleateLine.CustomerPrice__c = objQLine.FLETE__c;
                                    }
                                }
                            }
                            else if(mapQLinesPAQ.containsKey(objQLine.Tarifa__c) && mapQLinesPAQ.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c)){//ZONA PLUS
                                strRangeDest = '';
                                if(objQLine.Destiny__c != null)
                                    strRangeDest = objQLine.Destiny__c;
                                else strRangeDest = objQLine.Rango_KM__c;
                                if(this.blnCostoBaseGMP){
                                    if(objQLine.Tarifa__c != 'TARIFA T7')
                                        objTempleateLine.EAD__c = objTempleateLine.EAD__c = this.mapService.get('ZP').mapRanges.get(strRangeDest);
                                }
                            }
                        }
                        listTempleateLines.add(objTempleateLine);
                    }
                }
            }
            for(String strTarifa : listFee){
                for(String strRange : listRangeDestiny){
                    if(mapQLinesZP.containsKey(strTarifa) && mapQLinesZP.get(strTarifa).containsKey(strRange)){
                        SBQQ__QuoteLine__c objQLine = mapQLinesZP.get(strTarifa).get(strRange);
                        if(objQLine.ZonaPlus__c && mapQLinesPAQ.containsKey(strTarifa) && mapQLinesPAQ.containsKey(strTarifa) && mapQLinesPAQ.get(strTarifa).containsKey(strRange)){
                            decCustomerPricePAQ = mapQLinesPAQ.get(strTarifa).get(strRange).SBQQ__CustomerPrice__c;
                        }
                        //Código de incremento anual
                        if((listIncremento.size() > 0 && objTempleate.FechaCreacionCotizacion__c.year() < System.today().year() && objTempleate.Fecha_sugar__c == null) || (listIncremento.size() > 0 && objTempleate.FechaCreacionCotizacion__c.year() <= System.today().year() && objTempleate.Fecha_sugar__c != null)){
                            for(Incremento_Anual__c IncYear : listIncremento){
                                if((objTempleate.FechaCreacionCotizacion__c.year() < Integer.valueOf(IncYear.Anio__c) || objTempleate.Fecha_sugar__c.year() < Integer.valueOf(IncYear.Anio__c)) ) {
                                    for(Excepciones_de_incremento__c incEXE: listIncrementoExe){
                                        if(incEXE.Incremento_Anual__c == incYear.id){
                                            if(strTipoDoc == 'Guías prepagadas'){
                                                incyear.Incremento_anual_prepago__c = incEXE.Incremento_prepago__c;
                                            } else if(strTipoDoc == 'Documentación Remota'){
                                                incyear.Incremento_anual_remota__c = incEXE.Incremento_remota__c;
                                            }
                                        }
                                    }
                                    if(strTipoDoc == 'Guías prepagadas'){
                                        if(IncYear.Incremento_anual_prepago__c == NULL){
                                            IncYear.Incremento_anual_prepago__c = 0;
                                        }
                                        objQLine.SBQQ__CustomerPrice__c = (objQLine.SBQQ__CustomerPrice__c * (IncYear.Incremento_anual_prepago__c /  100)) + objQline.SBQQ__CustomerPrice__c;
                                        if(mapQuotesT7.containsKey(objQLine.Tarifa__c) && mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c)){
                                            mapQuotesT7.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c;
                                        }
                                        if(objQLine.ZonaPlus__c)
                                            decCustomerPricePAQ = ((decCustomerPricePAQ * IncYear.Incremento_anual_prepago__c) / 100) + decCustomerPricePAQ;
                                    } else if(strTipoDoc == 'Documentación Remota'){
                                        if(objQLine.KG_ADICIONAL__c != null && objQLine.KG_ADICIONAL__c != 0){
                                            objQLine.KG_ADICIONAL__c = (objQLine.KG_ADICIONAL__c * (IncYear.Incremento_anual_remota__c / 100)) + objQLine.KG_ADICIONAL__c;
                                        }
                                        if(IncYear.Incremento_anual_remota__c == NULL){
                                            IncYear.Incremento_anual_remota__c = 0;
                                        }
                                        if(objQLine.SBQQ__CustomerPrice__c > 0){
                                            objQLine.SBQQ__CustomerPrice__c = (objQLine.SBQQ__CustomerPrice__c * (IncYear.Incremento_anual_remota__c / 100)) + objQline.SBQQ__CustomerPrice__c;
                                        }
                                        if(objQLine.ZonaPlus__c)
                                            decCustomerPricePAQ = ((decCustomerPricePAQ * IncYear.Incremento_anual_remota__c) / 100) + decCustomerPricePAQ;
                                        if(mapQuotesT7.containsKey(objQLine.Tarifa__c) && mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c))
                                            mapQuotesT7.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c;
                                    }
                                }
                            }
                        }
                        //Partidas de la nueva plantilla
                        objTempleateLine = new TempleateLine__c(
                            Templeate__c = objTempleate.Id
                            , Quantity__c = objQLine.SBQQ__Quantity__c
                            , Tarifa__c = objQLine.Tarifa__c
                            , Bloque__c = ''
                            , TarifaDominante__c = objQLine.TarifaDominante__c
                            , Weight__c = objQLine.Weight__c
                            , Vol__c = objQLine.Vol__c / 1000000
                            , Rango_KM__c = objQLine.Rango_KM__c
                            , Destiny__c = objQLine.Destiny__c
                            , Pack_Seg__c = objQLine.Pack_Seg__c
                            , Zona_Plus__c = true
                            , Guia__c = objQLine.GUIA__c
                            , ACK__c = 0
                            , EAD__c = 0
                            , RAD__c = 0
                            , SEG__c = decSEG
                            , CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c.setScale(2)
                            , FLETE__c = 0
                            , fleteE__c = objQLine.FLETE__c
                            , ACKES__c = objQLine.ACK__c
                            ,KG_ADICIONAL__c = objQline.KG_ADICIONAL__c
                        );
                        if(String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('Acuse')){
                            objTempleateLine.ACK__c  = Ctrl_pantalla_ww.getAcuse(objQLine.SBQQ__CustomerPrice__c, objQLine.ZonaPlus__c, objQLine.SBQQ__CustomerPrice__c);
                        }
                        else if(String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && !mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('Acuse')){
                            objTempleateLine.ACK__c = 0;
                        }
                        if(objTempleateLine.Tarifa__c != 'TARIFA T7-P'){
                            if(!mapACK.containsKey(objQLine.Rango_KM__c))
                                mapACK.put(objQLine.Rango_KM__c, objTempleateLine.ACK__c);
                            else{
                                objTempleateLine.ACK__c = mapACK.get(objQLine.Rango_KM__c);
                                objTempleateLine.ACK__c = objTempleateLine.ACK__c.setScale(2);
                            }
                        }
                        else{
                            objTempleateLine.ACK__c = 0;
                        }
                        if(!this.blnCostoBaseGMP){
                            if(!(objTempleateLine.Tarifa__C == 'TARIFA T7' && objTempleateLine.Zona_Plus__c)){
                                if(!mapZPL.containsKey(strRange)){
                                    mapZPL.put(strRange, ((objQLine.SBQQ__CustomerPrice__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c) * .50));
                                }
                                if(!blnRAD && blnEAD){
                                    objTempleateLine.Flete__c = mapSubTotalZP.get(objTempleateLine.Tarifa__c).get(strRange) - objTempleateLine.SEG__c - objTempleateLine.ACK__c - mapZPL.get(strRange);
                                } else {
                                    if(mapFlete.containsKey(objTempleateLine.Tarifa__c) && mapFlete.get(objTempleateLine.Tarifa__c).containsKey(strRange)){
                                        objTempleateLine.Flete__c = mapFlete.get(objTempleateLine.Tarifa__c).get(strRange);
                                    } else {
                                        if(!blnRAD){
                                            objTempleateLine.Flete__c = objQLine.SBQQ__CustomerPrice__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c - mapZPL.get(strRange);
                                        } else {
                                            objTempleateLine.Flete__c = (objQLine.SBQQ__CustomerPrice__c - objTempleateLine.SEG__c - objTempleateLine.ACK__c - mapZPL.get(strRange)) / 1.11;
                                        }
                                    }
                                }
                                if(mapRAD.containsKey(strRange)){
                                    objTempleateLine.RAD__c = mapRAD.get(strRange);
                                } else {
                                    objTempleateLine.RAD__c = objTempleateLine.Flete__c * 0.11;
                                }
                                if(!mapZPL.containsKey(strRange)){
                                    objTempleateLine.EAD__C = objTempleateLine.CustomerPrice__c - objTempleateLine.Flete__c - objTempleateLine.RAD__c - objTempleateLine.ACK__c - objTempleateLine.SEG__c;
                                    mapZPL.put(strRange, objTempleateLine.EAD__C);
                                } else{
                                    objTempleateLine.EAD__C = mapZPL.get(strRange);
                                }
                            }
                        }
                        listTempleateLines.add(objTempleateLine);
                    }
                }
            }
            for(Database.SaveResult insTempLine : Database.insert(listTempleateLines, false))
                if(!insTempLine.isSuccess())
                    for(Database.Error errINSTempL : insTempLine.getErrors())
                        System.debug(LoggingLevel.ERROR, errINSTempL.getMessage());
        }catch (Exception ex){
            System.debug('syncQuote: ' + ex.getMessage() +'. ' + ex.getLineNumber());
        }
	}

	public Decimal getDominantPrice(Decimal decWeigth, Decimal decVol){
        try{
            if(decVol > decWeigth)
                return  decVol;
            else
                return decWeigth;
        }  catch (Exception ex){
            System.debug(ex.getMessage());
            return 0;
        }

	}

	public List<Incremento_Anual__c> queryIncremento(Set<Id> setIdincremento){
		List<Incremento_Anual__c> listINC = new List<Incremento_Anual__c>();
		try{
			listINC = [SELECT Id, Activar_incremento_general__c, Anio__c, Incremento_anual_prepago__c, Incremento_anual_remota__c FROM Incremento_Anual__c ORDER BY Anio__c ASC];
		} catch(Exception ex){
			System.debug(LoggingLevel.ERROR, ex.getMessage());
		}
		return listINC;
	}
    public List<Excepciones_de_incremento__c> queryIncrementoExe(){
		List<Excepciones_de_incremento__c> listINCEXE = new List<Excepciones_de_incremento__c>();
		try{
            string Idcuenta = [SELECT SBQQ__Account__c FROM SBQQ__Quote__c WHERE id =: strId].SBQQ__Account__c;
			listINCEXE = [SELECT Id, Cuenta__c, Incremento_Anual__c, Incremento_prepago__c, Incremento_remota__c, Name FROM Excepciones_de_incremento__c WHERE Cuenta__c =: Idcuenta];
		} catch(Exception ex){
			System.debug(LoggingLevel.ERROR, ex.getMessage());
		}
		return listINCEXE;
	}

	public List<SBQQ__Quote__c> queryQuote(Set<Id> setIdQuotes){
		return  [SELECT
		Id
		, Servicios_adicionales__c
		, Acuse__c
		, Electronicas__c
		, Impresas__c
		, Tipo_de_documentacion__c
        , TipoCotizacion__c
        , Modelo_de_tarifas__c
		FROM SBQQ__Quote__c
		WHERE Id IN: setIdQuotes];
	}

	public List<SBQQ__QuoteLine__c> queryQuoteLines(Set<Id> setIdQuotes){
		return [SELECT
		Id
		, SBQQ__Quantity__c
		, Tarifa__c
		, Rango_KM__c
		, Pack_Seg__c
		, ZonaPlus__c
		, ACK__c
		, EAD__c
		, RAD__c
		, SEG__c
		, SBQQ__CustomerPrice__c
		, FLETE__c
		, Weight__c
		, Vol__c
		, SBQQ__Quote__c
		, TarifaDominante__c
		, PackWeightAVG__c
		, PackVolAVG__c
        ,Guia__c
        ,KG_ADICIONAL__c
        , Destiny__c
        , SBQQ__Description__c
        , CreatedDate
		FROM SBQQ__QuoteLine__c
		WHERE SBQQ__Quote__c IN: setIdQuotes ];
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
}
