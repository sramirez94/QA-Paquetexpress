public class ctrl_internacional {
    
    public static String   descripcion     {get; set;}
    public static String   tipoError       {get; set;}
    public static String   paisDestino     {get; set;}
    public static String   cp              {get; set;}
    public integer  cantidad               {get; set;}
    public static decimal   volumen        {get; set;}
    public static decimal   largo          {get; set;}
    public static decimal   alto           {get; set;}
    public static decimal   ancho          {get; set;}
    public static decimal   Tp             {get; set;}
    public static decimal   dimencion     {get; set;}
    public static decimal   peso          {get; set;}
    public static decimal  pesoBascula   {get; set;}
    public static string    tipo          {get; set;}
    public static decimal   tarifaSA      {get; set;}
    public static decimal  tarifaEX      {get; set;}
    public static decimal  tarifaES      {get; set;}
    public static decimal   subtotal      {get; set;}
    public static decimal  subtotalEX      {get; set;}
    public static decimal  subtotalES      {get; set;}
    public static decimal  totalS          {get; set;}
    public static decimal  totalE          {get; set;}
    public static decimal  totalES         {get; set;}
    public static decimal   iva           {get; set;}
    public static decimal   ivaEX           {get; set;}
    public static decimal   ivaES           {get; set;}
    public String   strQuoteId            {get; set;}
    public String   strLeadId             {get; set;}
    public String   strCaseId             {get; set;}
    public static String   strAccId              {get; set;}
    public static String   strOppId              {get; set;}
    public String   profileObj            {get; set;}
    public static String   strQuoteName          {get;set;}
    public static String   strIdQuote      {get; set;}
    public static String SuccessMessage          {get;set;}
    public static Boolean blnSuccess             {get;set;}
    public Ctrl_InternacionalController wrapper {get; set;}
   public List<SelectOption> Paises             {get;set;}
   public List<SelectOption> tipos              {get;set;}
   public List<pais__c> listPaises              {get;set;}
    
   public ctrl_internacional(){ 
      blnSuccess = false;
      this.paises = new List<SelectOption>();
      this.tipos = new List<SelectOption>();
		this.profileObj = getProfileObj();
      this.listPaises = queryPaises();
      for(pais__c Pais : this.listPaises){
         this.Paises.add(new SelectOption(Pais.Abreviacion__c, Pais.Name));
      }
      /*this.Paises.add(new SelectOption('AF',  'Afganistán'));
      this.Paises.add(new SelectOption('DE',  'Alemania'));
      this.Paises.add(new SelectOption('AD',  'Andorra'));
      this.Paises.add(new SelectOption('U1',  'Estados Unidos desde el interior'));
      this.Paises.add(new SelectOption('U2',  'Estados Unidos desde frontera'));
      this.Paises.add(new SelectOption('US',  'Estados Unidos'));
      this.Paises.add(new SelectOption('CA',  'Canadá'));*/

      this.tipos.add(new SelectOption('ENV', 'Sobre de cartón'));
      this.tipos.add(new SelectOption('PKG', 'Bolsa plastificada'));
      this.tipos.add(new SelectOption('BOX', 'Otro empaque'));
   }

    /*String jsonBody = '{/n' + 
            ' "opportunityId" : " ' +opp.Id+' " , \n' +
            ' "opportunityName" : " '+opp.Name+' " ,\n' + 
            ' "accountName" : "'+opp.Account.Name+'", \n' +
            ' "closeDate" : "'+String.ValueOf(opp.CloseDate).mid(0,10)+'",\n' + 
            ' "amount" : "'+opp.Amount+'",\n}';*/
   
    
      public static void deserialize() {    
         System.debug('Tipo: ' + Tipo);     
         System.debug('País: ' + paisDestino);
    String jsonBody = '{\n' + 
   '"header": {\n' +
      '"security": {\n' +
         '"user": "SALESFORCE",\n' +
         '"token": "325746796331582000000"\n' +
      '}\n' +
   '},\n' +
   '"body": {\n' +
      '"request": {\n' +
         '"data": {\n' +
            '"datetime":"2020-01-13 21:11:11",\n' +
            '"serviceDetail": {\n' +
               '"datetime":"2020-01-13 21:11:11",\n' +
               '"serviceType": "01",\n' +
               '"insuredType": "B",\n' +
               '"declaredValue": 100\n' +
            '},\n' +
               '"clientAddrOrig": {\n' +
               '"country":null,\n' +
               '"state":null,\n' +
               '"city":null,\n' +
               '"colony":null,\n' +
               '"street":null,\n' +
               '"zipcode":"81200",\n' +
               '"zone":null,\n' +
               '"phonenumber":null,\n' +
               '"brnc":"LMM01",\n' +
               '"place":"place"\n' + 
            '},\n' +
            '"clientAddrDest": {\n' +
               '"country":"'+paisDestino+'" ,\n' +
               '"state":"CA",\n' +
               '"city":null,\n' +
               '"colony":null,\n' +
               '"street":null,\n' +
               '"zipcode":" '+cp+' ",\n' +
               '"zone":null,\n' +
               '"phonenumber":null,\n' +
               '"brnc":null,\n' +
               '"place":null\n' +
            '},\n' +
            '"packageList": [\n' +
               '{\n' +
               '"description":"",\n' +
               '"sequence":1,\n' +
               '"quantity":1,\n' +
               '"packagingCode":"03",\n' +
               '"weight":'+peso+',\n' +
               '"width":'+ancho+',\n' +
               '"length":'+largo+',\n' +
               '"height":'+alto+',\n' +
               '"volume":0.0,\n' +
               '"insuredValue":0,\n' +
               '"declaredValue":0, \n' +
               '"wrapId":"'+tipo+'"\n' +  
               '} \n' +
            '],\n' +
            '"quoteServiceList": [\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} \n' +
            '],\n' +
            '"otherServiceList": [\n' +  
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} ,\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} ,\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' + 
               '} \n' +
            '],\n' +
            '"aditionalDataList": [\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null,\n' +
                  '"aditionalData1": null,\n' +
                  '"aditionalData2": null,\n' +
                  '"aditionalData3": null,\n' +
                  '"aditionalData4":null\n' +
               '}\n' +
            ']\n' +
         '},\n' +
         '"objectDTO": null\n' +
      '},\n' +
      '"response": null\n' +
        '}\n' +
'}';
        System.debug(jsonBody);
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://apiqa.paquetexpress.com.mx/SalesForceRestFul/api/quote/getQuotationItl');
        request.setHeader('Content-Type', 'application/json; charset=utf-8');
        request.setMethod('POST');
        request.setBody(jsonBody);
        HttpResponse response = h.send(request);
          
       if (response.getStatusCode() != 200) {
       System.debug('Error: ' +
        response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('EXITO!!'); 
				System.debug(response.getBody());
           //wrapper = (Ctrl_InternacionalController) JSON.deserializeStrict(response.getBody(), Ctrl_InternacionalController.class);
            JSON2Apex m = JSON2Apex.parse(response.getBody());
            System.debug(m.Body.Response.Data.ShipmentDetail.ShipmentList[0].wrapId);  
            System.debug(m.Body.Response.Data.shipmentAmount.shipAmnt);
            tarifaSA = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].slabSubTotal;
            subtotal = m.Body.Response.Data.shipmentAmount.subTotalAmnt;
            iva = m.Body.Response.Data.shipmentAmount.taxAmnt;
            totalS = m.Body.Response.Data.shipmentAmount.totalAmnt;
            tipo = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].wrapId;
            pesoBascula = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].weight;
            volumen = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].volume;
            descripcion = m.Body.Response.messages[0].description;
            String datos = '{\n'+   
            ' "Pais de destino" : " ' +paisDestino+' " , \n' +
            ' "CP destino" : " '+cp+' " ,\n' + 
            ' "Peso" : '+peso+', \n' +
            ' "Largo" : '+largo+', \n' +
            ' "Alto" : '+alto+',\n' + 
            ' "Ancho" : '+ancho+',\n' +
            ' "Tipo" : " '+tipo+' ",\n' +
            ' "Peso Bascula" : '+pesoBascula+' }';
            System.debug(datos);

            //Asignación de solo 2 decimales a los subtotales
            subtotal = subtotal.setScale(2);
            iva      = iva.setScale(2);
            totalS   = totalS.setScale(2);
            tarifaSA = tarifaSA.setScale(2);
            volumen  = volumen.setScale(2);
        }  
          
         
      }
    
    public static void deserializeDos() {         
    String jsonBody = '{\n' + 
   '"header": {\n' +
      '"security": {\n' +
         '"user": "SALESFORCE",\n' +
         '"token": "325746796331582000000"\n' +
      '}\n' +
   '},\n' +
   '"body": {\n' +
      '"request": {\n' +
         '"data": {\n' +
            '"datetime":"2020-01-13 21:11:11",\n' +
            '"serviceDetail": {\n' +
               '"datetime":"2020-01-13 21:11:11",\n' +
               '"serviceType": "02",\n' +
               '"insuredType": "B",\n' +
               '"declaredValue": 100\n' +
            '},\n' +
               '"clientAddrOrig": {\n' +
               '"country":null,\n' +
               '"state":null,\n' +
               '"city":null,\n' +
               '"colony":null,\n' +
               '"street":null,\n' +
               '"zipcode":"81200",\n' +
               '"zone":null,\n' +
               '"phonenumber":null,\n' +
               '"brnc":"LMM01",\n' +
               '"place":"place"\n' + 
            '},\n' +
            '"clientAddrDest": {\n' +
               '"country":"'+paisDestino+'" ,\n' +
               '"state":"CA",\n' +
               '"city":null,\n' +
               '"colony":null,\n' +
               '"street":null,\n' +
               '"zipcode":" '+cp+' ",\n' +
               '"zone":null,\n' +
               '"phonenumber":null,\n' +
               '"brnc":null,\n' +
               '"place":null\n' +
            '},\n' +
            '"packageList": [\n' +
               '{\n' +
               '"description":"",\n' +
               '"sequence":1,\n' +
               '"quantity":1,\n' +
               '"packagingCode":"03",\n' +
               '"weight":'+peso+',\n' +
               '"width":'+ancho+',\n' +
               '"length":'+largo+',\n' +
               '"height":'+alto+',\n' +
               '"volume":0.0,\n' +
               '"insuredValue":0,\n' +
               '"declaredValue":0, \n' +
               '"wrapId":"'+tipo+'"\n' +  
               '} \n' +
            '],\n' +
            '"quoteServiceList": [\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} \n' +
            '],\n' +
            '"otherServiceList": [\n' +  
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} ,\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} ,\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' + 
               '} \n' +
            '],\n' +
            '"aditionalDataList": [\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null,\n' +
                  '"aditionalData1": null,\n' +
                  '"aditionalData2": null,\n' +
                  '"aditionalData3": null,\n' +
                  '"aditionalData4":null\n' +
               '}\n' +
            ']\n' +
         '},\n' +
         '"objectDTO": null\n' +
      '},\n' +
      '"response": null\n' +
        '}\n' +
'}';
        System.debug(jsonBody);
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://apiqa.paquetexpress.com.mx/SalesForceRestFul/api/quote/getQuotationItl');
        request.setHeader('Content-Type', 'application/json; charset=utf-8');
        request.setMethod('POST');
        request.setBody(jsonBody);
        HttpResponse response = h.send(request);
          
       if (response.getStatusCode() != 200) {
       System.debug('Error: ' +
        response.getStatusCode() + ' ' + response.getStatus());
        } else { 
        System.debug('EXITO!!'); 
				System.debug(response.getBody());
           //wrapper = (Ctrl_InternacionalController) JSON.deserializeStrict(response.getBody(), Ctrl_InternacionalController.class);
            JSON2Apex m = JSON2Apex.parse(response.getBody());
            System.debug(m.Body.Response.Data.ShipmentDetail.ShipmentList[0].wrapId);  
            System.debug(m.Body.Response.Data.shipmentAmount.shipAmnt);
            tarifaEX = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].slabSubTotal;
            subtotalEX = m.Body.Response.Data.shipmentAmount.subTotalAmnt;
            ivaEX = m.Body.Response.Data.shipmentAmount.taxAmnt;
            totalE = m.Body.Response.Data.shipmentAmount.totalAmnt;
            tipo = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].wrapId;
            pesoBascula = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].weight;
            volumen = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].volume;
            descripcion = m.Body.Response.messages[0].description;
            String datos = '{\n'+   
            ' "Pais de destino" : " ' +paisDestino+' " , \n' +
            ' "CP destino" : " '+cp+' " ,\n' + 
            ' "Peso" : '+peso+', \n' +
            ' "Largo" : '+largo+', \n' +
            ' "Alto" : '+alto+',\n' + 
            ' "Ancho" : '+ancho+',\n' +
            ' "Tipo" : " '+tipo+' ",\n' +
            ' "Peso Bascula" : '+pesoBascula+' }';
            System.debug(datos);
            subtotalEX  = subtotalEX.setScale(2);
            ivaEX       = ivaEX.setScale(2);
            totalE      = totalE.setScale(2);
            tarifaEX    = tarifaEX.setScale(2);
            volumen     = volumen.setScale(2);
        }  
          
         
      }
    
   /* public static void deserializeTres() {         
    String jsonBody = '{\n' + 
   '"header": {\n' +
      '"security": {\n' +
         '"user": "SALESFORCE",\n' +
         '"token": "325746796331582000000"\n' +
      '}\n' +
   '},\n' +
   '"body": {\n' +
      '"request": {\n' +
         '"data": {\n' +
            '"datetime":"2020-01-13 21:11:11",\n' +
            '"serviceDetail": {\n' +
               '"datetime":"2020-01-13 21:11:11",\n' +
               '"serviceType": "03",\n' +
               '"insuredType": "B",\n' +
               '"declaredValue": 100\n' +
            '},\n' +
               '"clientAddrOrig": {\n' +
               '"country":null,\n' +
               '"state":null,\n' +
               '"city":null,\n' +
               '"colony":null,\n' +
               '"street":null,\n' +
               '"zipcode":"81200",\n' +
               '"zone":null,\n' +
               '"phonenumber":null,\n' +
               '"brnc":"LMM01",\n' +
               '"place":"place"\n' + 
            '},\n' +
            '"clientAddrDest": {\n' +
               '"country":"'+paisDestino+'" ,\n' +
               '"state":"CA",\n' +
               '"city":null,\n' +
               '"colony":null,\n' +
               '"street":null,\n' +
               '"zipcode":" '+cp+' ",\n' +
               '"zone":null,\n' +
               '"phonenumber":null,\n' +
               '"brnc":null,\n' +
               '"place":null\n' +
            '},\n' +
            '"packageList": [\n' +
               '{\n' +
               '"description":"",\n' +
               '"sequence":1,\n' +
               '"quantity":1,\n' +
               '"packagingCode":"03",\n' +
               '"weight":'+peso+',\n' +
               '"width":'+ancho+',\n' +
               '"length":'+largo+',\n' +
               '"height":'+alto+',\n' +
               '"volume":0.0,\n' +
               '"insuredValue":0,\n' +
               '"declaredValue":0, \n' +
               '"wrapId":"BOX"\n' +  
               '} \n' +
            '],\n' +
            '"quoteServiceList": [\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} \n' +
            '],\n' +
            '"otherServiceList": [\n' +  
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} ,\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' +
               '} ,\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null\n' + 
               '} \n' +
            '],\n' +
            '"aditionalDataList": [\n' +
               '{\n' +
                  '"id": null,\n' +
                  '"description": null,\n' +
                  '"aditionalData1": null,\n' +
                  '"aditionalData2": null,\n' +
                  '"aditionalData3": null,\n' +
                  '"aditionalData4":null\n' +
               '}\n' +
            ']\n' +
         '},\n' +
         '"objectDTO": null\n' +
      '},\n' +
      '"response": null\n' +
        '}\n' +
'}';
        System.debug(jsonBody);
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://apiqa.paquetexpress.com.mx/SalesForceRestFul/api/quote/getQuotationItl');
        request.setHeader('Content-Type', 'application/json; charset=utf-8');
        request.setMethod('POST');
        request.setBody(jsonBody);
        HttpResponse response = h.send(request);
          
       if (response.getStatusCode() != 200) {
       System.debug('Error: ' +
        response.getStatusCode() + ' ' + response.getStatus());
        } else { 
        System.debug('EXITO!!'); 
				System.debug(response.getBody());
           //wrapper = (Ctrl_InternacionalController) JSON.deserializeStrict(response.getBody(), Ctrl_InternacionalController.class);
            JSON2Apex m = JSON2Apex.parse(response.getBody());
            System.debug(m.Body.Response.Data.ShipmentDetail.ShipmentList[0].wrapId);  
            System.debug(m.Body.Response.Data.shipmentAmount.shipAmnt);
            tarifaES = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].slabSubTotal;
            subtotalEX = m.Body.Response.Data.shipmentAmount.subTotalAmnt;
            ivaES = m.Body.Response.Data.shipmentAmount.srvcAmnt;
            totalES = m.Body.Response.Data.shipmentAmount.totalAmnt;
            tipo = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].wrapId;
            pesoBascula = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].weight;
            volumen = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].volume;
            String datos = '{\n'+   
            ' "Pais de destino" : " ' +paisDestino+' " , \n' +
            ' "CP destino" : " '+cp+' " ,\n' + 
            ' "Peso" : '+peso+', \n' +
            ' "Largo" : '+largo+', \n' +
            ' "Alto" : '+alto+',\n' + 
            ' "Ancho" : '+ancho+',\n' +
            ' "Peso Bascula" : '+pesoBascula+' }';
            System.debug(datos);
            
            
        }  
          
         
      }*/
    
    public static void crearCotizacion () {
         try {
             deserialize();
             deserializeDos();
            
             SBQQ__Quote__c cotizacion = new  SBQQ__Quote__c();
             DmlWrapper wp = new DmlWrapper();
             String strlink = '';
             //List<SBQQ__Quote__c> cotizacion = new  List<SBQQ__Quote__c>{ new SBQQ__Quote__c (RecordTypeId = '0123D000001U1YRQA0',CP__c = this.cp ,iva__c = this.iva, pais__c = this.paisDestino)};
             
             cotizacion.RecordTypeId = '0123D000001U1YRQA0';
             cotizacion.CP__c = cp;
             cotizacion.iva__c = iva.setScale(2);
             cotizacion.pais__c = paisDestino;
             cotizacion.Subtotal__c = subtotal.setScale(2);          
             cotizacion.TotalExpedite__c = totalE.setScale(2);
             cotizacion.TotalSa__c = totalS.setScale(2);
             cotizacion.Alto__c = alto.setScale(2);
             cotizacion.ancho__c = ancho.setScale(2);
             cotizacion.Tipo_de_paquete__c = tipo;
             cotizacion.largo__c = largo.setScale(2);
             cotizacion.peso__c = peso.setScale(2);
             cotizacion.TPeso__c = pesoBascula.setScale(2);
             cotizacion.dimension__c = volumen.setScale(2);
             cotizacion.SubtotalEx__c = subtotalEX;
             cotizacion.SBQQ__Opportunity2__c = strOppId;
             cotizacion.SBQQ__Account__c = strAccId;
             cotizacion.IvaEx__c = ivaEx;
             cotizacion.Tipo_de_paquete__c = tipo;
             cotizacion.Saver__c = tarifaSA;
             cotizacion.Expedite__c = tarifaEX;
             
                        
              //insert cotizacion; 
              Database.SaveResult quoteInsResult = Database.insert(cotizacion, false);
            if(quoteInsResult.isSuccess()){
               strIdQuote = quoteInsResult.getId();
               SuccessMessage = 'Se ha guardado la cotización exitosamente.';
               strlink = 'https://paquetexpress--qa2020.lightning.force.com/lightning/r/SBQQ__Quote__c/'+ strIdQuote +'/view';
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.confirm, 'Se ha guardado la cotización exitosamente. Ver: <a href="' + strlink + '"> Aquí </a> ' ));
               blnSuccess = true;   
            }
          } catch(Exception e) {
              System.debug('The following exception has occurred: ' + e.getMessage());
          } 
          
    }
    public static String getProfileObj(){
		return [SELECT Name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name;
	}
   public static SBQQ__Quote__c QueryQuote(String Id){
      return [SELECT Id, Name FROM SBQQ__Quote__c WHERE ID = :Id];
   }
   public static List<pais__c> queryPaises(){
      return [SELECT Abreviacion__c, Name FROM pais__c ORDER BY Name];
   }
   public class DmlWrapper{
      public SBQQ__Quote__c 			objQuote  		{get; set;}
      public DmlWrapper (){

      }
  }
}
