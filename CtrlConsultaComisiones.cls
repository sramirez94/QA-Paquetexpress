/**
**/
public class CtrlConsultaComisiones {
    @AuraEnabled(cacheable=true)
    public static String CallValidaEjecutivoComisiones(String FechaIni, String FechaFin, String FederationId){
        try{
            System.debug('entró. Ejecutivo: ' + FederationId);
            HttpResponse response = new HttpResponse();
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://sf.paquetexpress.com.mx/SalesForceRestFul/api/report/v1/ventas/executive');  
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(generaJSONBodyConsultaComision(FederationId, FechaIni, FechaFin));
            response = http.send(request);
            if(response.getStatusCode() != 200){
                return 'Error: ' + response.getStatusCode() + '. ' + response.getStatus();
            } else {
                return response.getBody();
            }
        }catch(Exception ex){
            System.debug('Error: ' + ex.getMessage() + '. Line: ' + ex.getLineNumber());
            return 'Error: ' + ex.getMessage();
        }
    }
    public static String generaJSONBodyConsultaComision (String ejecutivo, String periodoInicio, String periodoFin){

        JSONGenerator gen 	= JSON.createGenerator(true);
        
        SecurityObj SecObj	= new SecurityObj ('SALESFORCE', '325746796331582000000' /*CallWS_Token2.callGeneraToken('SALESFORCE', '1234')*/);
		DataObj   	DataObj	= new DataObj (ejecutivo, periodoInicio, periodoFin);
     
        gen.writeStartObject();	
        		
        	gen.writeFieldName('header');
				gen.writeStartObject();		

        			gen.writeFieldName('security');
                    gen.writeObject(SecObj);
					gen.writeStringField('output', 'JSON');
                gen.writeEndObject();
        
        	gen.writeFieldName('body');
        
        	gen.writeStartObject();	
        		gen.writeFieldName('request');
        			gen.writeStartObject();	
                        gen.writeFieldName('data');
                        gen.writeObject(DataObj); 
        				gen.writeNullField('objectDTO');
                    gen.writeEndObject();
        			gen.writeNullField('response');
        	gen.writeEndObject();
        	
        gen.writeEndObject();
        System.debug(gen.getAsString());
        
        return gen.getAsString();
    }
    public class SecurityObj{
        public String user;
        public String token;
        public String password;
        public Integer type;
        
        public SecurityObj (String user, String token){
            system.debug('TOKEN: ' + token);
            this.password	= '';
        	this.type		= 1;    
            this.user 		= user;
            this.token 		= token;
        }
    }
   
    public class DataObj {
		
        public String executiveId;
        public String initPeriod;
        public String endPeriod;
        
        public DataObj(String ejecutivo, String periodoInicio, String periodoFin){
            
            System.debug('Periodo Inicio: ' +  periodoInicio);
            System.debug('Periodo Inicio: ' +  periodoFin);
            
            executiveId = ejecutivo; 		//'GYANEZ';//ejecutivo;            
            initPeriod 	= periodoInicio; 	//'201904';//periodoInicio;
            endPeriod 	= periodoFin;	 	//'201904';//periodoFin;
        }
	}
}
