public class ctrl_ResPlantilla {
	
   //variable globales, listas y mapas que podemos usar dentro y fuera de nuestra clase
    Public String                                      EnabledClass           {get; set;}
	public String 				                       indexDeducItem         {get; set;}
    public String                                      strIdQuote             {get; set;}
    public String                                      strTempleateId         {get; set;}
    public Templeate__c                                objtempleate           {get; set;}
    public List<TempleateLine__c>                      listPlantillaLineItems {get; set;} 
    public Map<String, Tarifario_general_terrestre__c> mapTarifas             {get; set;}
    public Map<String, Map<String, TempleateLine__c>>  mapLines	              {get; set;}
    public Map<String, Map<String, TempleateLine__c>>  mapLinesZP             {get; set;}  
    public Map<String, Map<String, TempleateLine__c>>  mapQuotesT7            {get; set;}
    public Set<STring>                                 setTarifas             {get; set;}
    public Boolean                                 	   blnRAD                 {get; set;}
    public Boolean                                 	   blnEAD                 {get; set;}
    public Boolean                                 	   blnEZP                 {get; set;}
   
    //contructor de nuestra clase que nos permite
    public ctrl_ResPlantilla(ApexPages.StandardController stdController){
        this.strIdQuote = stdController.getId();
        
        //consultamos nuestro nuestro objeto template.
        objtempleate = queryTempleate();

		if(String.isNotBlank(objtempleate.ServiciosAdicionales__c)){ // RAD; EAD; EAD ZONA PLUS; Seguro; Acuse Empresa; Acuse Interno; Acuse XT
			String[] servicios = objtempleate.ServiciosAdicionales__c.split(';');
			/*
			 * "RAD"
			 * "EAD"
			 * "EAD ZONA PLUS"
			 * "Seguro"
			 * "Acuse Empresa"
			 * "Acuse Interno"
			 * "Acuse XT"
			 */
			for(String strService : servicios){
				if(strService == 'RAD')
					blnRAD = true;
                if(strService == 'EAD')
					blnEAD = true;
             
			}
		}     

        //consultamos nuestra lista relacionada al objeto template
        listPlantillaLineItems = queryTempleateLine(objtempleate.Id);
    	      
        cambioTarifas();    
       
        //llamamos nuestras variables globales y mapas
		this.strTempleateId = objtempleate.Id; 
        this.EnabledClass = 'enabled';  
        this.mapLinesZP = new Map<String, Map<String, TempleateLine__c>>();
        this.setTarifas = new Set<String>();
            
        //cramos un bucle for que añade la tarifa y el rango de kilometros
        crearMapaLines();
        
        //lista que hace un select al objeto tarifario general terrestre y devuelve el valor de sus campos
        //que estan en el mapa de setTarifas
        List<Tarifario_general_terrestre__c> listTarifas = [SELECT Id, Tarifa__c, PesoMaximo__c, VolumenMaximo__c 
        FROM Tarifario_general_terrestre__c WHERE Year__c = null AND RangoKM__c = '0-400' AND Tarifa__c IN: setTarifas];
        
        //llamamos a nuestro mapa de tarifas y creamos un bucle para asignar la tarifa a nuestra lista
        this.mapTarifas = new Map<String, Tarifario_general_terrestre__c>();
        for(Tarifario_general_terrestre__c item : listTarifas)
          mapTarifas.put(item.Tarifa__c, item); 
        
        this.mapQuotesT7 = new Map<String, Map<String, TempleateLine__c>>();
        for(TempleateLine__c Line : listPlantillaLineItems){
            if(Line.Tarifa__c.contains('TARIFA T7-'))
            if(!mapQuotesT7.containsKey(Line.Tarifa__c))
				mapQuotesT7.put(Line.Tarifa__c, new Map<String, TempleateLine__c>{Line.Rango_KM__c => Line} );
			else if(!mapQuotesT7.get(Line.Tarifa__c).containsKey(Line.Rango_KM__c))
				mapQuotesT7.get(Line.Tarifa__c).put(Line.Rango_KM__c, Line);
          }
        
         for(TempleateLine__c  objDeduc: this.listPlantillaLineItems){
            decimal PrecioVol    = 0;
            decimal PrecioWeight = 0;
			if(objDeduc.Tarifa__c == 'TARIFA T7' && objtempleate.TipoCotizacion__c == 'byDimension'){
                 if(mapQuotesT7.containsKey(objDeduc.Tarifa__c+'-P') && mapQuotesT7.get(objDeduc.Tarifa__c+'-P').containsKey(objDeduc.Rango_KM__c)
                 && mapQuotesT7.containsKey(objDeduc.Tarifa__c+'-V') && mapQuotesT7.get(objDeduc.Tarifa__c+'-V').containsKey(objDeduc.Rango_KM__c)){
					 PrecioWeight =  mapQuotesT7.get(objDeduc.Tarifa__c+'-P').get(objDeduc.Rango_KM__c).CustomerPrice__c * objDeduc.Weight__c;
					 PrecioVol = mapQuotesT7.get(objDeduc.Tarifa__c+'-V').get(objDeduc.Rango_KM__c).CustomerPrice__c * objDeduc.Vol__c;
					 if(PrecioWeight > PrecioVol)
					 	objDeduc.CustomerPrice__c = PrecioWeight;
					 else
						 objDeduc.CustomerPrice__c = PrecioVol;
        	 }        
          }   
        }
         
    }

	private void crearMapaLines() {
		this.mapLines = new Map<String, Map<String, TempleateLine__c>>();
		for(TempleateLine__c line : this.listPlantillaLineItems){
			setTarifas.add(line.Tarifa__c);
			if(!line.Zona_Plus__c){
				if(!mapLines.containsKey(line.Tarifa__c))
					mapLines.put(line.Tarifa__c, new Map<String, TempleateLine__c>{ line.Rango_KM__c => line });
				else
					mapLines.get(line.Tarifa__c).put(line.Rango_KM__c , line);
			} else{
				if(!mapLinesZP.containsKey(line.Tarifa__c))
					mapLinesZP.put(line.Tarifa__c, new Map<String, TempleateLine__c>{ line.Rango_KM__c => line });
				else
					mapLinesZP.get(line.Tarifa__c).put(line.Rango_KM__c , line);
			}
		}
	}
    
   //consulta a nuestra lista relacionada para traer el valos de sus campos
	public List<TempleateLine__c> queryTempleateLine(String templeateId){
		List<TempleateLine__c> listPlantillaLineItems = new List<TempleateLine__c>();
		try{
			listPlantillaLineItems = [SELECT Id
			, Quantity__c
			, EditMode__c
            , Disable__c
			, Tarifa__c
			, Weight__c
			, Vol__c
			, Rango_KM__c
			, Pack_Seg__c
			, Zona_Plus__c
            , TarifaDominante__c
			, CustomerPrice__c
			FROM TempleateLine__c where Templeate__c =: templeateId  ORDER BY CreatedDate];
		}
		catch (Exception ex){
			System.debug(ex.getMessage());
		}
		return listPlantillaLineItems;
	}
	
    //consulta a nuestro objeto que debuelve el valos de sus campos 
	public Templeate__c queryTempleate(){
		Templeate__c objPlantilla = new Templeate__c();
		try{
			objPlantilla = [SELECT Id
			, ServiciosAdicionales__c
			, Acuse__c
			, Electronicas__c
			, Impresas__c
            , TipoCotizacion__c
			FROM Templeate__c where Quote__c =: this.strIdQuote ORDER BY CreatedDate DESC LIMIT 1];
		}
		catch (Exception ex){
			System.debug(ex.getMessage());
		}
		return objPlantilla;
	}    
    
    public Account queryCuenta(String strAccId){
		Account objcuenta = new Account();
		try{
			objcuenta = [SELECT
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
        //, Numero_de_facturacion__c
        , Phone
        , Email_de_factura__c
        , Nombre_representante_legal__c
        , Colonia_Facturaci_n__c        
        FROM Account WHERE Id =: strAccId];
		}
		catch (Exception ex){
			System.debug(ex.getMessage());
		}
		return  objcuenta;
	}
    
    public Opportunity queryOpp(String strOppId){
		Opportunity objOpp = new Opportunity();
		try{
			objOpp = [SELECT Tipo_de_paquetes__c
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
		catch (Exception ex){
			System.debug(ex.getMessage());
		}
		return  objOpp;
	}
    
    //metodo para asignar el nombre correspodiente a las tarifas
     public void cambioTarifas(){
        for(TempleateLine__c line: listPlantillaLineItems){
            if(line.Tarifa__c == 'TARIFA SOBRE')
                line.Tarifa__c = 'TS';
             if(line.Tarifa__c == 'TS')
                Line.Weight__c = 1;
            if(line.Tarifa__c == 'TS')
                Line.Vol__c = 0.0001;
            if(line.Tarifa__c == 'TARIFA T0')
                line.Tarifa__c = 'T0';
            if(line.Tarifa__c == 'T0')
                Line.Weight__c = 5;
            if(line.Tarifa__c == 'T0')
                Line.Vol__c = 0.01;
            if(line.Tarifa__c == 'TARIFA T1')
                line.Tarifa__c = 'T1';
            if(line.Tarifa__c == 'T1')
                Line.Weight__c = 10;
            if(line.Tarifa__c == 'T1')
                Line.Vol__c = 0.0225;
            if(line.Tarifa__c == 'TARIFA T2')
                line.Tarifa__c = 'T2';
            if(line.Tarifa__c == 'T2')
                Line.Weight__c = 20;
            if(line.Tarifa__c == 'T2')
                Line.Vol__c = 0.048;
            if(line.Tarifa__c == 'TARIFA T3')
                line.Tarifa__c = 'T3';
            if(line.Tarifa__c == 'T3')
                Line.Weight__c = 30;
            if(line.Tarifa__c == 'T3')
                Line.Vol__c = 0.075;
            if(line.Tarifa__c == 'TARIFA T4')
                line.Tarifa__c = 'T4';
            if(line.Tarifa__c == 'T4')
                Line.Weight__c = 40;
             if(line.Tarifa__c == 'T4')
                Line.Vol__c = 0.1440;
            if(line.Tarifa__c == 'TARIFA T5')
                line.Tarifa__c = 'T5';
            if(line.Tarifa__c == 'T5')
                Line.Weight__c = 50;
            if(line.Tarifa__c == 'T5')
                Line.Vol__c = 0.2450;
            if(line.Tarifa__c == 'TARIFA T6')
                line.Tarifa__c = 'T6';
            if(line.Tarifa__c == 'T6')
                Line.Weight__c = 60;
            if(line.Tarifa__c == 'T6')
                Line.Vol__c = 0.3200;
            if(line.Tarifa__c == 'SEG-DS')
                line.Tarifa__c = 'DS';
            if(line.Tarifa__c == 'SEG-2D')
                line.Tarifa__c = '2D';
            if(line.Tarifa__c == 'SEG-A12')
                line.Tarifa__c = 'A12';
         }
        
    }
    
    public void NTarifas(){
        for(TempleateLine__c line: listPlantillaLineItems){
            if(line.Tarifa__c == 'TS')
                line.Tarifa__c = 'TARIFA SOBRE';
             if(line.Tarifa__c == 'TARIFA SOBRE')
                Line.Weight__c = 1;
            if(line.Tarifa__c == 'TARIFA SOBRE')
                Line.Vol__c = 0.0001;
            if(line.Tarifa__c == 'TARIFA T0')
                line.Tarifa__c = 'TARIFA T0';
            if(line.Tarifa__c == 'TARIFA T0')
                Line.Weight__c = 5;
            if(line.Tarifa__c == 'TARIFA T0')
                Line.Vol__c = 0.01;
            if(line.Tarifa__c == 'T1')
                line.Tarifa__c = 'TARIFA T1';
            if(line.Tarifa__c == 'TARIFA T1')
                Line.Weight__c = 10;
            if(line.Tarifa__c == 'T1')
                Line.Vol__c = 0.0225;
            if(line.Tarifa__c == 'T2')
                line.Tarifa__c = 'TARIFA T2';
            if(line.Tarifa__c == 'TARIFA T2')
                Line.Weight__c = 20;
            if(line.Tarifa__c == 'TARIFA T2')
                Line.Vol__c = 0.048;
            if(line.Tarifa__c == 'T3')
                line.Tarifa__c = 'TARIFA T3';
            if(line.Tarifa__c == 'TARIFA T3')
                Line.Weight__c = 30;
            if(line.Tarifa__c == 'TARIFA T3')
                Line.Vol__c = 0.075;
            if(line.Tarifa__c == 'T4')
                line.Tarifa__c = 'TARIFA T4';
            if(line.Tarifa__c == 'TARIFA T4')
                Line.Weight__c = 40;
             if(line.Tarifa__c == 'TARIFA T4')
                Line.Vol__c = 0.0144;
            if(line.Tarifa__c == 'T5')
                line.Tarifa__c = 'TARIFA T5';
            if(line.Tarifa__c == 'TARIFA T5')
                Line.Weight__c = 50;
            if(line.Tarifa__c == 'TARIFA T5')
                Line.Vol__c = 0.0245;
            if(line.Tarifa__c == 'T6')
                line.Tarifa__c = 'TARIFA T6';
            if(line.Tarifa__c == 'TARIFA T6')
                Line.Weight__c = 60;
            if(line.Tarifa__c == 'TARIFA6')
                Line.Vol__c = 0.032;
            if(line.Tarifa__c == 'T7')
            if(line.Tarifa__c == 'SEG-DS')
                line.Tarifa__c = 'DS';
            if(line.Tarifa__c == 'SEG-2D')
                line.Tarifa__c = '2D';
            if(line.Tarifa__c == 'SEG-A12')
                line.Tarifa__c = 'A12';
         }
        
    }
 /*   
    public void removerTemplate(){
		for	(TempleateLine__c item: this.listPlantillaLineItems)
			if(item.Id == this.indexDeducItem)
				item.Disable__c = !item.Disable__c;
    }
    
   
   public void GuardarTemplate(){
        list<string> ids = new list<string>();
       for	(String strTarifa: this.mapLines.keySet())
            for	(String strRango: this.mapLines.get(strTarifa).keySet())
             	if(this.mapLines.get(strTarifa).get(strRango).Disable__c)
             		ids.add(this.mapLines.get(strTarifa).get(strRango).Id);

	   for(String strTarifaZP : this.mapLinesZP.keySet())
		   for(String strRango: this.mapLinesZP.get(strTarifaZP).keySet())
			   if(this.mapLinesZP.get(strTarifaZP).get(strRango).Disable__c)
				   ids.add(this.mapLinesZP.get(strTarifaZP).get(strRango).Id);

       for(Database.DeleteResult resSave : Database.delete(ids, true)){
		   if(!resSave.isSuccess())
			   for(Database.Error insError: resSave.getErrors())
				   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, insError.getMessage()));
	   }
	   this.listPlantillaLineItems = queryTempleateLine(this.strTempleateId);
	   crearMapaLines();
	   cambioTarifas();
   }
     
    
	public void editTemplate(){  
		for	(TempleateLine__c item: this.listPlantillaLineItems)        
			if(item.Id == this.indexDeducItem)
				item.EditMode__c = !item.EditMode__c;
	}
    

    
       public Decimal getDominantPrice(Decimal decWeigth, Decimal decVol){   
           if(decVol > decWeigth)       
			return  decVol;
		else
			return decWeigth;
	}
    
 
    
     public boolean validaPyV(TempleateLine__c obj){
        if ((obj.Tarifa__c == 'TARIFA T7') && (Obj.Weight__c < 61 && Obj.Vol__c < 0.3200)){ 
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'El peso no puede ser menor de 60 kilos o el volumen no puede ser menor de 0.3200.'));
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
        
        if(validaPyV(objDeduc))
            return;
        else{
            decimal PrecioVol    = 0;
            decimal PrecioWeight = 0;
            if(objDeduc.Tarifa__c == 'TARIFA T7' && objtempleate.TipoCotizacion__c == 'byDimension'){
                 if(mapQuotesT7.containsKey(objDeduc.Tarifa__c+'-P') && mapQuotesT7.get(objDeduc.Tarifa__c+'-P').containsKey(objDeduc.Rango_KM__c)
                 && mapQuotesT7.containsKey(objDeduc.Tarifa__c+'-V') && mapQuotesT7.get(objDeduc.Tarifa__c+'-V').containsKey(objDeduc.Rango_KM__c)){
					 PrecioWeight =  mapQuotesT7.get(objDeduc.Tarifa__c+'-P').get(objDeduc.Rango_KM__c).CustomerPrice__c * objDeduc.Weight__c;
					 PrecioVol = mapQuotesT7.get(objDeduc.Tarifa__c+'-V').get(objDeduc.Rango_KM__c).CustomerPrice__c * objDeduc.Vol__c;
					 if(PrecioWeight > PrecioVol)
					 	objDeduc.CustomerPrice__c = PrecioWeight;
					 else
						 objDeduc.CustomerPrice__c = PrecioVol;
        	 }        
         }   
      }       
		objDeduc.EditMode__c = false;
		Database.SaveResult resDeducUPD = Database.update(objDeduc, false);
        if(!resDeducUPD.isSuccess()){           
                    for(Database.Error insError: resDeducUPD.getErrors())
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, insError.getMessage()));
       		}    
       			     this.listPlantillaLineItems = queryTempleateLine(this.strTempleateId);
       	
   		 }*/
}
