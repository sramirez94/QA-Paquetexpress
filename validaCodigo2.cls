public with sharing class validaCodigo2 {
    public class CodigoPostal {
        @InvocableVariable(required=true)
        public String codigoPostal;
        @InvocableVariable(required=true)
        public String tipo;        
        
    }
    
    public class Respuesta{
        @InvocableVariable(required=true)
        public Boolean valido; 
        @InvocableVariable(required=true)
        public String mensaje;         
    }    
    @InvocableMethod(label='Valida codigo postal2')
    public static List<Respuesta> validaCodigo(List<CodigoPostal> cp) {
        String mensajes = '';
        mensajes = 'entró a la función. ';
        List<Respuesta> respuesta 		= new List<Respuesta>();
        Respuesta resp = new Respuesta();
        HttpRequest req 				= new HttpRequest();
        mensajes += 'Inicializó. tipo: ' + cp[0].tipo + '. ';
        if(cp[0].tipo == 'Origen'){
            req.setEndpoint(Label.URL_VALIDA_CP + cp[0].codigoPostal + Label.URL_VALIDACP_ORIGEN_END);    
        }else if(cp[0].tipo == 'Destino'){
            req.setEndpoint(Label.URL_VALIDA_CP + cp[0].codigoPostal + Label.URL_VALIDACP_DESTINO_END);    
        }
        mensajes += 'Endpoint: ' + Label.URL_VALIDA_CP + cp[0].codigoPostal + Label.URL_VALIDACP_ORIGEN_END + '. ';
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Http http = new Http(); 
        mensajes += ' Termina de inicializar. ';
        try{
            HttpResponse res = http.send(req);
            mensajes += ' Hace el llamado. Resultado: ' + res.getStatusCode() + '. ';
            if (res.getStatusCode() == 200) {
                Map<String, Object> json 		= (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                Map<String, Object> body 		= (map<String,Object>) json.get('body');
                Map<String, Object> response 	= (map<String,Object>) body.get('response');
                List<Object> data 				= (list<Object>) response.get('data');
                List<Object> messages 			= (list<Object>) response.get('messages'); 
                mensajes += '. Respuesta: ' + response.get('success') + '. ';
                if(response.get('success') == true && data.size() > 0){
                    resp.valido = true;
                    resp.mensaje = '';
                }else if(response.get('success') == false && data.size() == 0){
                    resp.valido = false;
                    map<String,Object> message =  (map<String,Object>) messages[0];
                    resp.mensaje = String.valueOf(message.get('description'));                    
                }                   
                respuesta.add(resp);
                System.debug(LoggingLevel.DEBUG,'Obtención de datos correcto: ' + res.getBody());
            }else{
                mensajes += 'Response: ' + res.getBody();
                resp.valido = false;
                resp.mensaje = '';
                respuesta.add(resp);                
                System.debug(LoggingLevel.DEBUG,'Obtención de datos correcto: ' + res.getBody());
            }
            generaSolicitudEmail(mensajes);
        }catch(Exception ex){
            resp.valido = false;
            resp.mensaje = 'Error al obtener los datos validacion CP ' + ex.getMessage() +'Line: '+ ex.getLineNumber();
            respuesta.add(resp); 
            System.debug(LoggingLevel.ERROR,'Error al obtener los datos validacion CP ' + ex.getMessage() +'Line: '+ ex.getLineNumber());    
        }
        return respuesta;
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
            mail.setToAddresses(new String[] { 'sramirez@freewayconsulting.com' });
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
}
