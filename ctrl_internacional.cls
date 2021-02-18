public class ctrl_internacional {
    
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
    public String   strAccId              {get; set;}
    public String   strOppId              {get; set;}
    public String   profileObj            {get; set;} 
    public String   strIdQuote      {get; set;}
    public Ctrl_InternacionalController wrapper {get; set;}
    
    public ctrl_internacional(){ 
        this.strIdQuote = '';
		this.profileObj = getProfileObj();
   }
    /*String jsonBody = '{/n' + 
            ' "opportunityId" : " ' +opp.Id+' " , \n' +
            ' "opportunityName" : " '+opp.Name+' " ,\n' + 
            ' "accountName" : "'+opp.Account.Name+'", \n' +
            ' "closeDate" : "'+String.ValueOf(opp.CloseDate).mid(0,10)+'",\n' + 
            ' "amount" : "'+opp.Amount+'",\n}';*/
   
    
      public static void deserialize() {         
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
            tarifaSA = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].slabSubTotal;
            subtotal = m.Body.Response.Data.shipmentAmount.subTotalAmnt;
            iva = m.Body.Response.Data.shipmentAmount.srvcAmnt;
            totalS = m.Body.Response.Data.shipmentAmount.totalAmnt;
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
            tarifaEX = m.Body.Response.Data.ShipmentDetail.ShipmentList[0].slabSubTotal;
            subtotalEX = m.Body.Response.Data.shipmentAmount.subTotalAmnt;
            ivaEX = m.Body.Response.Data.shipmentAmount.srvcAmnt;
            totalE = m.Body.Response.Data.shipmentAmount.totalAmnt;
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
             
             cotizacion.IvaEx__c = ivaEx;
             
             cotizacion.Saver__c = tarifaSA;
             cotizacion.Expedite__c = tarifaEX;
             
                        
              insert cotizacion; 
          } catch(Exception e) {
              System.debug('The following exception has occurred: ' + e.getMessage());
          } 
          
    }
    public static String getProfileObj(){
		return [SELECT Name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name;
	}
}
