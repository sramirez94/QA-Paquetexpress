public class CallWS_Cuentas {
    
    @future(callout=true)
    public static void callCuentas (String IdCuenta, String accion ){
        
        System.debug('Accion: ' +  accion);
        
        Account cuenta = [SELECT Id, Id_SIpWeb__c,  Name, RFC__c, comentarios__c, industry, Giro__c, 
                          BillingCountry, BillingState, Delegacion_o_municipio__c, BillingCity, BillingStreet, Numero_de_facturacion__c, Colonia_Facturaci_n__c, BillingPostalCode, Email_de_factura__c, Phone,
                          ShippingCountry, ShippingState, ShippingCity, ShippingStreet, Colonia__c, Numero__c, ShippingPostalCode, Municipio_Delegaci_n_Sector_facturacion__c, Sucursal__r.Name
                          
                          FROM Account 
                          WHERE Id =: IdCuenta];
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // TEST request.setEndpoint('https://apiqa.paquetexpress.com.mx/SalesForceRestFul/api/restful/v1/client');
        request.setEndpoint('https://sf.paquetexpress.com.mx/SalesForceRestFul/api/restful/v1/client');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(generaJSONBody(cuenta, accion));
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
            response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        
        generaSolicitudEmail('REQUEST:  \n\n ' + generaJSONBody(cuenta, accion) + 'RESPONSE: \n\n  '+ response.getBody());
        
        if(accion != 'update'){
            ObjetoCuenta cuentaObj = new ObjetoCuenta();
            cuentaObj = ObjetoCuenta.parse(response.getBody());
            if(CuentaObj.body.response.success == true){
                cuenta.Id_SIpWeb__c = ''+ CuentaObj.body.response.data.clntId;
                update cuenta;
                
            }
        }
        
    }
    
    public static void generaSolicitudEmail (String json){
        try{

            Blob body = Blob.valueOf(json);
                
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/txt');
            attach.setFileName('JSON_RESPONSE.txt');
            attach.setInline(false);
            attach.Body = body;
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            mail.setToAddresses(new String[] { 'nortiz@freewayconsulting.com' });
            mail.setSubject('Response Cuentas');
            mail.setHtmlBody('RESPUESTA CUENTAS');
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
                
            // Send the email
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
       }catch (Exception e){
                system.debug(e);
                System.debug(e.getlinenumber());
                System.debug(e.getCause());
                System.debug(e.getStackTraceString());
            }

    }
    
    
    public static String generaJSONBody (Account cuenta, String accion){
        System.debug('Accion: ' +  accion);
        JSONGenerator gen 	= JSON.createGenerator(true);
        SecurityObj SecObj	= new SecurityObj ('SALESFORCE', CallWS_Token.callGeneraToken('SALESFORCE', '1234'));
            DataObj   	DataObj	= new DataObj (cuenta, accion);
     
        gen.writeStartObject();	
        		
        	gen.writeFieldName('header');
				gen.writeStartObject();		

        			gen.writeFieldName('security');
                    gen.writeObject(SecObj);

                gen.writeEndObject();
        
        	gen.writeFieldName('body');
        
        	gen.writeStartObject();	
        		gen.writeFieldName('request');
        			gen.writeStartObject();	
                        gen.writeFieldName('data');
                        gen.writeObject(DataObj);           
                    gen.writeEndObject();
        	gen.writeEndObject();
        	
        gen.writeEndObject();
        System.debug(gen.getAsString());
        
        return gen.getAsString();
    }
    
    public class SecurityObj{
        public String user;
        public String token;
        
        public SecurityObj (String user, String token){
            system.debug('TOKEN: ' + token);
            this.user 		= user;
            this.token 		= token;
        }
    }
   
    public class DataObj {
		public String action;
        public String clntIdSF;
        public String clntId;
        public String clntName;
        public String taxId;
        public String clntType;
        public String bsnsLineId;
        public String bsnsSegId;
        public String comments;
        public String groupClntId;
        public String site;
        public String user;
        DireccionObj[] address;
        	

        
        public DataObj(Account cuenta, String accion){
            System.debug('Accion: ' +  accion);
            
        	this.action 		= accion;
            this.clntIdSF 		= cuenta.Id;
            this.clntId 		= cuenta.Id_SIpWeb__c;
            this.clntName 		= cuenta.name;//'ALFONSO FELIX';
            this.taxId			= cuenta.RFC__c;//'XAXX-010101-000';
            this.clntType 		= 'I';	//
            this.bsnsLineId 	= cuenta.Giro__c;			//'0099'; // SEGMENTO
            this.bsnsSegId 		= cuenta.Industry; 		// GIRO
            this.comments 		= cuenta.Comentarios__c;	//'COMENTARIOS DE PRUEBAS';
            this.groupClntId 	= 'null';
            if(cuenta.Sucursal__r.Name != null && cuenta.Sucursal__r.Name != ''){
            	this.site 			= (cuenta.Sucursal__r.Name).substring(0,3);    
            }else{
                this.site = 'MEX';
            }
            
            this.user 			= 'USERSALESFORCE';
            //this.address.add(new DireccionObj());
            this.address = new DireccionObj[]{new DireccionObj(cuenta, 'Fiscal')};
            this.address = new DireccionObj[]{new DireccionObj(cuenta, 'Envio')};
            
        }
	}
    
    public class DireccionObj{
        public String addressCodeSF;
        public String addressType;
        public String structuredAddress;
        public String country;
        public String state;
        public String delegation;
        public String city;
        public String strtName;
        public String drnr;
        public String colonyName;
        public String zipCode;
        public String mail;
        public String phoneNo;
        public String celPhone;
        public String comments;
        ContactoObj[] contacto;
        
        //BillingCountry, BillingState, Delegacion_o_municipio__c, BillingCity, BillingStreet, Numero_de_facturacion__c, Colonia_Facturaci_n__c, BillingPostalCode, Email_de_factura__c, Phone 
        
        public DireccionObj (Account acc, String tipo){
            if(tipo=='Fiscal'){
                
                this.addressCodeSF 			= '';
                this.addressType 			= 'FISCAL';
                this.structuredAddress 		= 'Y';
                this.country 				= acc.BillingCountry;
                this.state 					= acc.BillingState;
                this.delegation 			= acc.Municipio_Delegaci_n_Sector_facturacion__c; 
                this.city 					= acc.BillingCity;
                this.strtName 				= acc.BillingStreet;// 'GABRIEL LEYVA';
                this.drnr 					= ''+acc.Numero_de_facturacion__c; //'1023';
                this.colonyName 			= acc.Colonia_Facturaci_n__c; //'CENTRO';
                this.zipCode 				= acc.BillingPostalCode;//'81200';
                this.mail	 				= acc.Email_de_factura__c;//'DARJONA@PAQUETEXPRESS.COM.MX';
                this.phoneNo 				= acc.Phone; //'6688162500';
                this.celPhone 				= '';
                this.comments 				= ''; //'PRUEBA WS';
                this.contacto 				= new List<ContactoObj>();     
                
                
            }else if (tipo =='Envio'){
                //ShippingCountry, ShippingState, ShippingCity, ShippingStreet, Colonia__c, Numero__c, ShippingPostalCode
                this.addressCodeSF 			= '';
                this.addressType 			= 'SHIP';
                this.structuredAddress 		= 'Y';
                this.country 				= acc.ShippingCountry;
                this.state 					= acc.ShippingState;
                this.delegation 			= acc.Delegacion_o_municipio__c; 
                this.city 					= acc.ShippingCity;
                this.strtName 				= acc.ShippingStreet;// 'GABRIEL LEYVA';
                this.drnr 					= ''+acc.Numero__c; //'1023';
                this.colonyName 			= acc.Colonia__c; //'CENTRO';
                this.zipCode 				= acc.ShippingPostalCode;//'81200';
                this.mail	 				= acc.Email_de_factura__c;//'DARJONA@PAQUETEXPRESS.COM.MX';
                this.phoneNo 				= acc.Phone; //'6688162500';
                this.celPhone 				= '';
                this.comments 				= ''; //'PRUEBA WS';
                this.contacto 				= new List<ContactoObj>();     
                if(acc.Id != null){
                    List<Contact> contactList = [SELECT Id, Name, FirstName, LastName, phone, MobilePhone, accountId FROM Contact WHERE accountId =: acc.Id];
                    if(contactList.size()>0){
                        for(Contact c: contactList){
                            this.contacto.add(new ContactoObj(c, acc.Id));
                        }
                    }
                }
                
            }


            
            

        } 
        
    }

    public class ContactoObj{
        public String contactIdSF;
        public String contactName;
        public String phone;
        public String celPhone;
        
        public ContactoObj (Contact c, String IdCuenta){
            
             
           
            this.contactIdSF 			= IdCuenta; 							//'CONTACT_ID_SF';
            this.contactName 			= ''+c.FirstName +' '+ c.lastName; 		//'CONTACTO 1';
            this.phone 					= c.Phone; 								//'6688162500';
            this.celPhone 				= c.MobilePhone;	 					//'6688162500';            
        }
       
    }
    
    
}
