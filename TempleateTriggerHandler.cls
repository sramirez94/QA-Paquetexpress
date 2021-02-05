/*
 * Created by Fran on 10/07/2020.
 */
public class TempleateTriggerHandler {
    public String   strId         {get; set;}
    public Incremento_Anual__c  objincremento  {get; set;}
	public TempleateTriggerHandler(){
    }

	public void syncQuote(List<Templeate__c> listNewTempleates){
        try{  
        this.strId = listNewTempleates[0].Quote__c;
        
		List<TempleateLine__c> listTempleateLines = new List<TempleateLine__c>();
		Set<Id> setIdQuotes = new Set<Id>();
        Set<Id> setIdincremento = new Set<Id>();
		Map<Id, List<SBQQ__QuoteLine__c>> mapQLines = new Map<Id, List<SBQQ__QuoteLine__c>>();
		Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesT7 = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
		Map<String, Map<String, SBQQ__QuoteLine__c>> mapQLinesPAQ = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
		Map<Id, SBQQ__Quote__c> mapQuotes = new Map<Id, SBQQ__Quote__c>();
		Map<String, Decimal> mapACK = new Map<String, Decimal>();
        Map<String, Decimal> mapACKK = new Map<String, Decimal>();
        Map<String, Decimal> mapRAD = new Map<String, Decimal>();
        Map<String, Decimal> mapZPL = new Map<String, Decimal>();
        Map<String, Decimal> mapZPLL = new Map<String, Decimal>();
        Map<String, Map<String, decimal>> mapQLinesResiduo = new Map<String, Map<String, decimal>>();
        Map<String, Decimal> mapResiduo = new Map<String, Decimal>();
            
	 	for(Templeate__c objTempleate : listNewTempleates)
			setIdQuotes.add(objTempleate.Quote__c);
		
		for(SBQQ__Quote__c objQuote : queryQuote(setIdQuotes))
			mapQuotes.put(objQuote.Id, objQuote);

		for(SBQQ__QuoteLine__c objQLine : queryQuoteLines(setIdQuotes)) {
            if(!(objQLine.Tarifa__c == 'TARIFA T7' && objQLine.ZonaPlus__c)){
                if (mapQLines.containsKey(objQLine.SBQQ__Quote__c))
                    mapQLines.get(objQLine.SBQQ__Quote__c).add(objQLine);
                else
                    mapQLines.put(objQLine.SBQQ__Quote__c, new List<SBQQ__QuoteLine__c>{ objQLine });
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
            }
		}
             
        
		List<Incremento_Anual__c> listIncremento = queryIncremento(setIdincremento);
        List<Excepciones_de_incremento__c> listIncrementoExe = queryIncrementoExe();
		TempleateLine__c objTempleateLine;
		Decimal decCustomerPricePAQ = 0;
        
		for(Templeate__c objTempleate : listNewTempleates){         
			for(SBQQ__QuoteLine__c objQLine : mapQLines.get(objTempleate.Quote__c)){                
                if(objQLine.ZonaPlus__c && mapQLinesPAQ.containsKey(objQLine.Tarifa__c) && mapQLinesPAQ.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c)){
					decCustomerPricePAQ = mapQLinesPAQ.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c;
                }
               else if(objQLine.ZonaPlus__c && mapQLinesPAQ.containsKey(objQLine.Tarifa__c) && mapQLinesPAQ.get(objQLine.Tarifa__c).containsKey(objQLine.Destiny__c)){
					decCustomerPricePAQ = mapQLinesPAQ.get(objQLine.Tarifa__c).get(objQLine.Destiny__c).SBQQ__CustomerPrice__c;
                }
               
                
               if((mapQuotes.get(objTempleate.Quote__c).Tipo_de_documentacion__c == 'Guías prepagadas')){ 
				if(listIncremento.size() > 0 && objTempleate.FechaCreacionCotizacion__c.year() < System.today().year() && objTempleate.Fecha_sugar__c == null)             
					for(Incremento_Anual__c IncYear : listIncremento){                       
						if(mapQuotes.get(objTempleate.Quote__c).Tipo_de_documentacion__c == 'Guías prepagadas' && objTempleate.FechaCreacionCotizacion__c.year() < Integer.valueOf(IncYear.Anio__c) )
                        {                                          
                            for(Excepciones_de_incremento__c incEXE: listIncrementoExe){                            
                                if(incEXE.Incremento_Anual__c == incYear.id){
                                 incyear.Incremento_anual_prepago__c = incEXE.Incremento_prepago__c;                                    
                                }
                            }
                                if(IncYear.Incremento_anual_prepago__c == NULL){
                                IncYear.Incremento_anual_prepago__c = 0;
                            }

							objQLine.SBQQ__CustomerPrice__c = (objQLine.SBQQ__CustomerPrice__c * (IncYear.Incremento_anual_prepago__c /  100)) + objQline.SBQQ__CustomerPrice__c;							
							
                            if(mapQuotesT7.containsKey(objQLine.Tarifa__c) && mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c)){
								mapQuotesT7.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c;	
                    			
							}
							if(objQLine.ZonaPlus__c)
							decCustomerPricePAQ = ((decCustomerPricePAQ * IncYear.Incremento_anual_prepago__c) / 100) + decCustomerPricePAQ;
                            } 												
					}
                else if(listIncremento.size() > 0 && objTempleate.FechaCreacionCotizacion__c.year() <= System.today().year() && objTempleate.Fecha_sugar__c != null)            
					for(Incremento_Anual__c IncYear : listIncremento){                       
						if(mapQuotes.get(objTempleate.Quote__c).Tipo_de_documentacion__c == 'Guías prepagadas' && objTempleate.Fecha_sugar__c.year() < Integer.valueOf(IncYear.Anio__c))
                        {                                          
                            for(Excepciones_de_incremento__c incEXE: listIncrementoExe){                            
                                if(incEXE.Incremento_Anual__c == incYear.id){
                                 incyear.Incremento_anual_prepago__c = incEXE.Incremento_prepago__c;                                    
                                }
                            }
                                if(IncYear.Incremento_anual_prepago__c == NULL){
                                IncYear.Incremento_anual_prepago__c = 0;
                            }

							objQLine.SBQQ__CustomerPrice__c = (objQLine.SBQQ__CustomerPrice__c * (IncYear.Incremento_anual_prepago__c /  100)) + objQline.SBQQ__CustomerPrice__c;							
							
                            if(mapQuotesT7.containsKey(objQLine.Tarifa__c) && mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c)){
								mapQuotesT7.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c;	
                    			
							}
							if(objQLine.ZonaPlus__c)
							decCustomerPricePAQ = ((decCustomerPricePAQ * IncYear.Incremento_anual_prepago__c) / 100) + decCustomerPricePAQ;
                        } 
                    } 
               }
                
               if((mapQuotes.get(objTempleate.Quote__c).Tipo_de_documentacion__c == 'Documentación Remota')){   
                    if(listIncremento.size() > 0 && objTempleate.FechaCreacionCotizacion__c.year() < System.today().year() && objTempleate.Fecha_sugar__c == null)             
                        for(Incremento_Anual__c IncYear : listIncremento){
                            if((mapQuotes.get(objTempleate.Quote__c).Tipo_de_documentacion__c == 'Documentación Remota') 
                            && objTempleate.FechaCreacionCotizacion__c.year() < Integer.valueOf(IncYear.Anio__c))
                            {
                                for(Excepciones_de_incremento__c incEXE: listIncrementoExe){                            
                                    if(incEXE.Incremento_Anual__c == incYear.id){
                                    incyear.Incremento_anual_remota__c = incEXE.Incremento_remota__c;                                    
                                    }
                                }
                                    if(IncYear.Incremento_anual_remota__c == NULL){
                                    IncYear.Incremento_anual_remota__c = 0;
                                }
                                objQLine.SBQQ__CustomerPrice__c = (objQLine.SBQQ__CustomerPrice__c * (IncYear.Incremento_anual_remota__c / 100)) + objQline.SBQQ__CustomerPrice__c;
                                
                                if(objQLine.ZonaPlus__c)
                                    decCustomerPricePAQ = ((decCustomerPricePAQ * IncYear.Incremento_anual_remota__c) / 100) + decCustomerPricePAQ;
                                
                                if(mapQuotesT7.containsKey(objQLine.Tarifa__c) && mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c))
                                    mapQuotesT7.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c;
                            }
                        }                
                    else if(listIncremento.size() > 0 && objTempleate.FechaCreacionCotizacion__c.year() <= System.today().year() && objTempleate.Fecha_sugar__c != null)            
                        for(Incremento_Anual__c IncYear : listIncremento){                       
                            if(mapQuotes.get(objTempleate.Quote__c).Tipo_de_documentacion__c == 'Documentación Remota' && objTempleate.Fecha_sugar__c.year() < Integer.valueOf(IncYear.Anio__c))
                            {                                          
                                for(Excepciones_de_incremento__c incEXE: listIncrementoExe){                            
                                    if(incEXE.Incremento_Anual__c == incYear.id){
                                        incyear.Incremento_anual_remota__c= incEXE.Incremento_remota__c;                                    
                                    }
                                }
                                    if(IncYear.Incremento_anual_remota__c == NULL){
                                        IncYear.Incremento_anual_remota__c = 0;
                                }

                                objQLine.SBQQ__CustomerPrice__c = (objQLine.SBQQ__CustomerPrice__c * (IncYear.Incremento_anual_remota__c /  100)) + objQline.SBQQ__CustomerPrice__c;							
                                
                                if(mapQuotesT7.containsKey(objQLine.Tarifa__c) && mapQuotesT7.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c)){
                                    mapQuotesT7.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c;	
                                    
                                }
                                if(objQLine.ZonaPlus__c)
                                    decCustomerPricePAQ = ((decCustomerPricePAQ * IncYear.Incremento_anual_remota__c) / 100) + decCustomerPricePAQ;
                            } 
                        } 
                }

				objTempleateLine = new TempleateLine__c(
						Templeate__c = objTempleate.Id
						, Quantity__c = objQLine.SBQQ__Quantity__c
						, Tarifa__c = objQLine.Tarifa__c
						, TarifaDominante__c = objQLine.TarifaDominante__c
						, Weight__c = objQLine.Weight__c
						, Vol__c = objQLine.Vol__c / 1000000
						, Rango_KM__c = objQLine.Rango_KM__c
						, Destiny__c = objQLine.Destiny__c
						, Pack_Seg__c = objQLine.Pack_Seg__c
						, Zona_Plus__c = objQLine.ZonaPlus__c
                        ,Guia__c = objQLine.GUIA__c
						, ACK__c = 0
						, EAD__c = 0
						, RAD__c = 0
						, SEG__c = objQLine.SEG__c
						, CustomerPrice__c = objQLine.SBQQ__CustomerPrice__c
						, FLETE__c = 0
                        , fleteE__c = objQLine.FLETE__c
                        , ACKES__c = objQLine.ACK__c
                        ,KG_ADICIONAL__c = objQline.KG_ADICIONAL__c
                        
				);
				if(objQLine.Tarifa__c == 'TARIFA T7'){
					objTempleateLine.Vol__c = objQLine.PackVolAVG__c;
					objTempleateLine.Weight__c = objQLine.PackWeightAVG__c;
					if(mapQuotesT7.containsKey(objQLine.Tarifa__c+'-P') && mapQuotesT7.get(objQLine.Tarifa__c+'-P').containsKey(objQLine.Rango_KM__c)
							&& mapQuotesT7.containsKey(objQLine.Tarifa__c+'-V') && mapQuotesT7.get(objQLine.Tarifa__c+'-V').containsKey(objQLine.Rango_KM__c))
						objTempleateLine.CustomerPrice__c = getDominantPrice(
							mapQuotesT7.get(objQLine.Tarifa__c+'-P').get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c * objQLine.PackWeightAVG__c
								, mapQuotesT7.get(objQLine.Tarifa__c+'-V').get(objQLine.Rango_KM__c).SBQQ__CustomerPrice__c * objQLine.PackVolAVG__c
						);
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
                
               
                
                 //TARIFA ESTARDAR SOLA            
           
               if(!objTempleateLine.Zona_Plus__c && String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && !mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('EAD Zona plus')){                 
                    objTempleateLine.FLETE__c = Ctrl_pantalla_ww.getFlete(objQLine.SBQQ__CustomerPrice__c, mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c, objTempleateLine);
                    objTempleateLine.RAD__c = Ctrl_pantalla_ww.getRAD(objTempleateLine.FLETE__c);
                    objTempleateLine.EAD__c = objTempleateLine.EAD__c =  Ctrl_pantalla_ww.getEAD(objTempleateLine.FLETE__c, objTempleateLine);
                   
                   objTempleateLine.FLETE__c = objTempleateLine.FLETE__c.setScale(2);
                   decimal suma = objTempleateLine.FLETE__c.setScale(2) + objTempleateLine.RAD__c.setScale(2) + objTempleateLine.EAD__c.setScale(2) + objTempleateLine.ACK__c.setScale(2) + objTempleateLine.SEG__c.setScale(2);
                           
                   if(suma > objTempleateLine.CustomerPrice__c.setScale(2)){
                       if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                         
                           objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c - 0.01;
                          
                       }
                       else if(suma < objTempleateLine.CustomerPrice__c.setScale(2)){
                           if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                            objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c + 0.01;
                          
                       }
                       else{
                           objTempleateLine.FLETE__c = objTempleateLine.FLETE__c;
                   }
                   
                decimal	suma2 = objTempleateLine.FLETE__c.setScale(2) + objTempleateLine.RAD__c.setScale(2) + objTempleateLine.EAD__c.setScale(2) + objTempleateLine.ACK__c.setScale(2) + objTempleateLine.SEG__c.setScale(2);
               
                   	 if(suma2 < objTempleateLine.CustomerPrice__c.setScale(2)){
                       if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                          
                           objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c + 0.01;
                         
                       }
                       else if(suma2 > objTempleateLine.CustomerPrice__c.setScale(2)){
                           if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                            objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c - 0.01;
                           
                       }
                        else{
                       objTempleateLine.FLETE__c = objTempleateLine.FLETE__c;
                   }
                  
                }  
                
                //TARIFA ESTANDAR Y TARIFA ZONA PLUS JUNTAS
                else if(!objTempleateLine.Zona_Plus__c){//ESTANDAR  
                    if( objTempleateLine.Tarifa__c == 'TARIFA T7-P')
                    {
                        objTempleateLine.FLETE__c = Ctrl_pantalla_ww.getFlete(objQLine.SBQQ__CustomerPrice__c, mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c, objTempleateLine);
                        
                        objTempleateLine.FLETE__c = objTempleateLine.FLETE__c.setScale(2);
          			 
                    decimal suma = objTempleateLine.FLETE__c.setScale(2) + objTempleateLine.RAD__c.setScale(2) + objTempleateLine.EAD__c.setScale(2) + objTempleateLine.ACK__c.setScale(2) + objTempleateLine.SEG__c.setScale(2);
                   	
                   if(suma > objTempleateLine.CustomerPrice__c.setScale(2)){
                   if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                       objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c - 0.01;
                   }
                   else if(suma < objTempleateLine.CustomerPrice__c.setScale(2)){
                       if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                        objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c + 0.01;
                   }
                   else{
                       objTempleateLine.FLETE__c = objTempleateLine.FLETE__c;
                   }
                   
                 decimal	suma2 = objTempleateLine.FLETE__c.setScale(2) + objTempleateLine.RAD__c.setScale(2) + objTempleateLine.EAD__c.setScale(2) + objTempleateLine.ACK__c.setScale(2) + objTempleateLine.SEG__c.setScale(2);
               
                   	 if(suma2 < objTempleateLine.CustomerPrice__c.setScale(2)){
                         if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                             objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c + 0.01;     
                       }
                       else if(suma2 > objTempleateLine.CustomerPrice__c.setScale(2)){
                           if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                            objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c - 0.01;
                       }
                       else{
                           objTempleateLine.FLETE__c = objTempleateLine.FLETE__c;
                       }                                     
                    }
                    
                    if(String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('RAD') && objTempleateLine.Tarifa__c != 'TARIFA T7-P')
                    {
				     objTempleateLine.RAD__c = Ctrl_pantalla_ww.getRADS(objTempleateLine);						
                       if(!mapRAD.containsKey(objQLine.Rango_KM__c))
                           mapRAD.put(objQLine.Rango_KM__c, objTempleateLine.RAD__c);
                       else{
                            objTempleateLine.RAD__c = mapRAD.get(objQLine.Rango_KM__c);
                            }
                            mapQLinesPAQ.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).RAD__c = objTempleateLine.RAD__c;
                        }
                    else
                    {
                        objTempleateLine.RAD__c = Ctrl_pantalla_ww.getRAD(objTempleateLine.FLETE__c);
                       
                    }
					if(String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('EAD') && objTempleateLine.Tarifa__c != 'TARIFA T7-P')
                    {
                    objTempleateLine.EAD__c = Ctrl_pantalla_ww.getEADS(objTempleateLine);
                        if(!mapZPLL.containsKey(objQLine.Rango_KM__c))
                        mapZPLL.put(objQLine.Rango_KM__c, objTempleateLine.EAD__c);
                        else{
                        objTempleateLine.EAD__c = mapZPLL.get(objQLine.Rango_KM__c);
                      }
                    }
                    else{
                         objTempleateLine.EAD__c = objTempleateLine.EAD__c =  Ctrl_pantalla_ww.getEAD(objTempleateLine.FLETE__c, objTempleateLine);
                    }
                                      
                    if( objTempleateLine.Tarifa__c != 'TARIFA T7-P'){
                        objTempleateLine.FLETE__c = (objTempleateLine.CustomerPrice__c  - objTempleateLine.ACK__c - objTempleateLine.SEG__c - objTempleateLine.EAD__c - objTempleateLine.RAD__c);                          
						
                    decimal sumar = objTempleateLine.FLETE__c + objTempleateLine.RAD__c + objTempleateLine.EAD__c + objTempleateLine.ACK__c + objTempleateLine.SEG__c; 
                    system.debug('SUMA sin escala ' + sumar);
                        
                        objTempleateLine.FLETE__c = objTempleateLine.FLETE__c;                               
                       
                        objTempleateLine.FLETE__c = objTempleateLine.FLETE__c.setScale(2);                        
                        
                        objTempleateLine.RAD__c = objTempleateLine.RAD__c;
                       
                        
                        objTempleateLine.RAD__c = objTempleateLine.RAD__c.setScale(2);                        
                      
                        
                        objTempleateLine.EAD__c = objTempleateLine.EAD__c;
                       
                        objTempleateLine.EAD__c = objTempleateLine.EAD__c.setScale(2);                        
                  
                        
                        objTempleateLine.ACK__c = objTempleateLine.ACK__c;
                       
                        objTempleateLine.ACK__c = objTempleateLine.ACK__c.setScale(2);                        
                       
                   
                    decimal suma = objTempleateLine.FLETE__c.setScale(2) + objTempleateLine.RAD__c.setScale(2) + objTempleateLine.EAD__c.setScale(2) + objTempleateLine.ACK__c.setScale(2) + objTempleateLine.SEG__c.setScale(2);
                 
                   
                        
                if(suma > objTempleateLine.CustomerPrice__c){
                   if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                    objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c - 0.01;                     
                   }
                   else if(suma < objTempleateLine.CustomerPrice__c){
                      if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                        objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c + 0.01;                      
                   }
                   else{
                       objTempleateLine.FLETE__c = objTempleateLine.FLETE__c;
                   }
                   
               decimal	suma2 = objTempleateLine.FLETE__c.setScale(2) + objTempleateLine.RAD__c.setScale(2) + objTempleateLine.EAD__c.setScale(2) + objTempleateLine.ACK__c.setScale(2) + objTempleateLine.SEG__c.setScale(2);
               	
                   	 if(suma2 < objTempleateLine.CustomerPrice__c ){
                         if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                             objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c + 0.01;     
                       }
                       else if(suma2 > objTempleateLine.CustomerPrice__c){
                           if(mapResiduo.containsKey(objQLine.Rango_KM__c))
                            objTempleateLine.FLETE__c =  objTempleateLine.FLETE__c - 0.01;
                       }
                       else{
                           objTempleateLine.FLETE__c = objTempleateLine.FLETE__c;
                       }                                     
                    }
                    if(mapQLinesPAQ.containsKey(objQLine.Tarifa__c) && mapQLinesPAQ.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c))
                    {
						mapQLinesPAQ.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).FLETE__c = objTempleateLine.FLETE__c;
                    }
                                        
                }       
                else if(mapQLinesPAQ.containsKey(objQLine.Tarifa__c) && mapQLinesPAQ.get(objQLine.Tarifa__c).containsKey(objQLine.Rango_KM__c)){//ZONA PLUS
                    objTempleateLine.FLETE__c = mapQLinesPAQ.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).FLETE__c;
					objTempleateLine.RAD__c = mapQLinesPAQ.get(objQLine.Tarifa__c).get(objQLine.Rango_KM__c).RAD__c;
                    objTempleateLine.EAD__c = Ctrl_pantalla_ww.getEADOS(objTempleateLine.FLETE__c, objTempleateLine);
                    if(!mapZPL.containsKey(objQLine.Rango_KM__c))                     
                        mapZPL.put(objQLine.Destiny__c, objTempleateLine.EAD__c);                       
                    else{
                        objTempleateLine.EAD__c = mapZPL.get(objQLine.Rango_KM__c);
                      }
                }
                // TARIFA ZONA PLUS SOLA
                else{   
                    if(String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('Acuse')){             
                        objTempleateLine.ACK__c  = Ctrl_pantalla_ww.getAcuses(objTempleateLine);
                    if(!mapACKK.containsKey(objQLine.Rango_KM__c))
                            mapACKK.put(objQLine.Rango_KM__c, objTempleateLine.ACK__c);
                            else{
                                objTempleateLine.ACK__c = mapACKK.get(objQLine.Rango_KM__c);
                              }
                }
                if(String.isNotBlank(mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c) && mapQuotes.get(objQLine.SBQQ__Quote__c).Servicios_adicionales__c.contains('EAD')){
                         objTempleateLine.EAD__c =  Ctrl_pantalla_ww.getEAD(objTempleateLine.FLETE__c, objTempleateLine);
                          if(!mapZPL.containsKey(objQLine.Rango_KM__c))
                            mapZPL.put(objQLine.Rango_KM__c, objTempleateLine.EAD__c);
                            else{
                                objTempleateLine.EAD__c = mapZPL.get(objQLine.Rango_KM__c);
                              }
                 }  
                    	 objTempleateLine.FLETE__c = (objTempleateLine.CustomerPrice__c  - objTempleateLine.ACK__c - objTempleateLine.SEG__c - objTempleateLine.EAD__c) / 1.11;
                         objTempleateLine.RAD__c =  objTempleateLine.FLETE__c * 0.11;
                    }
                 
				listTempleateLines.add(objTempleateLine);
			}
		 }
      

		for(Database.SaveResult insTempLine : Database.insert(listTempleateLines, false))
			if(!insTempLine.isSuccess())
				for(Database.Error errINSTempL : insTempLine.getErrors())
					System.debug(LoggingLevel.ERROR, errINSTempL.getMessage());
                }
        catch (Exception ex){
        System.debug(ex.getMessage());
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
		FROM SBQQ__QuoteLine__c
		WHERE SBQQ__Quote__c IN: setIdQuotes];
	}
}
