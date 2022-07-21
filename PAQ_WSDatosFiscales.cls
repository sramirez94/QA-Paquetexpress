/**
 * @description       : 
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com
**/
public class PAQ_WSDatosFiscales {
    @future(callout=true)
    public static void CallWS_DatosFiscales(String strRFC){
        try {
            System.debug('RFC: ' + strRFC);
            if(strRFC != null && strRFC != 'XAXX010101000'){ //Si no mandaron un RFC no va a realizar ninguna operación
                SolicitaDatos objSol = new SolicitaDatos();
                Security objSec = new Security();
                Data objData = new Data();
                request objRequest = new request();
                body body = new body();
                header header = new header();
                HttpResponse res = new HttpResponse();
                List<Account> lstAccounts = new List<Account>();
                List<Schema.PicklistEntry> entries  = new List<Schema.PicklistEntry>();
                WS_Paquetexpress__mdt datosConexion = WS_Paquetexpress__mdt.getInstance('DatosFiscales');
                objDatosFiscales objDF;
                lstAccounts = [SELECT Id, RazonSocial__c, RegimenCapital__c, Nombres__c, ApellidoPaterno__c, ApellidoMaterno__c, BillingStreet, NumeroInterior__c, Numero_de_facturacion__c,
                                BillingPostalCode, Regimen_fiscal_CCP__c, Uso_de_cfdi_CCP__c, BillingState, BillingCity FROM Account WHERE RFC__c =:strRFC];
                if(datosConexion != null){ //Si no hay datos de conexión no procede con el resto de la consulta
                    objSec.token = datosConexion.Contrasena__c;
                    objSec.user = datosConexion.Usuario__c;
                    objData.RFC = strRFC;
                    objRequest.data = objData;
                    body.request = objRequest;
                    header.Security = objSec;
                    objSol.header = header;
                    objSol.body = body;
                    res = consultaAPIPOST(JSON.serialize(objSol), datosConexion.URL__c);
                    objDF = objDatosFiscales.parse(res.getBody());
                    if(objDF != null){
                        if(!objDF.body.response.success){
                            System.debug('Error: ' + objDF.body.response.messages[0].description);
                            publicarEvento(false, 'Error actualizando cuentas: ' + objDF.body.response.messages[0].description);
                        } else {
                            if(objDF.body.response.data != null){
                                for(Account ac : lstAccounts){
                                    if(objDF.body.response.data.clntType == 'M'){
                                        ac.RazonSocial__c = objDF.body.response.data.businessName;
                                        ac.RegimenCapital__c = objDF.body.response.data.capitalRegm;
                                    } else {
                                        ac.Nombres__c = objDF.body.response.data.firstName;
                                        ac.ApellidoPaterno__c = objDF.body.response.data.lastName1;
                                        ac.ApellidoMaterno__c = objDF.body.response.data.lastsname2;
                                    }
                                    ac.BillingStreet = objDF.body.response.data.street;
                                    ac.NumeroInterior__c = objDF.body.response.data.noInt;
                                    if(objDF.body.response.data.noExt != null){
                                        ac.Numero_de_facturacion__c = Decimal.ValueOf(objDF.body.response.data.noExt);
                                    }
                                    ac.BillingPostalCode = objDF.body.response.data.zipCode;
                                    entries = Account.Uso_de_cfdi_CCP__c.getDescribe().getPickListValues();
                                    for(Schema.PicklistEntry p : entries){
                                        if(p.getLabel().contains(objDF.body.response.data.usoCFDI)){
                                            ac.Uso_de_cfdi_CCP__c = p.getLabel();
                                            System.debug('Uso cfdi: ' + p.getLabel());
                                            break;
                                        }
                                    }
                                    //Obtiene el régimen fiscal en base a la clave recibida en el request
                                    entries  = Account.Regimen_fiscal_CCP__c.getDescribe().getPickListValues();
                                    for(Schema.PicklistEntry p : entries){
                                        if(p.getLabel().contains(objDF.body.response.data.regmFisc)){
                                            ac.Regimen_fiscal_CCP__c = p.getLabel();
                                            System.debug('Regimen: ' + p.getLabel());
                                            break;
                                        }
                                    }
                                    ac.BillingState = objDF.body.response.data.state;
                                    ac.Municipio_Delegaci_n_Sector_facturacion__c = objDF.body.response.data.municipality;
                                    ac.Colonia_Facturaci_n__c = objDF.body.response.data.colony;
                                    ac.BillingCity = objDF.body.response.data.city;
                                }
                                System.debug('Datos: ' + lstAccounts);
                                for (Database.SaveResult updt : Database.update(lstAccounts, false)) {
                                    if (!updt.isSuccess()){
                                        for (Database.Error ssErr : updt.getErrors()){
                                            System.debug('Error actualizando cuentas: ' + ssErr.getMessage());
                                            publicarEvento(false, 'Error actualizando cuentas: ' + ssErr.getMessage());
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                publicarEvento(false, 'Imposible actualizar datos fiscales de la cuenta, esta no cuenta con RFC');
            }
        } catch (Exception ex) {
            System.debug('Error: ' + ex.getMessage() + '. Línea: ' + ex.getlineNumber());
            publicarEvento(false, 'Error: ' + ex.getMessage());
        }
    }
    public static void publicarEvento(Boolean EjecucionCorrecta, String mensaje){
        try{
            System.debug('Publicando evento...');
            String mensajeFinal;
            List<ResultadoGrabado__e> inkEvents = new List<ResultadoGrabado__e>();
            if(mensaje==null)
                mensajeFinal = 'Grabado exitoso';
            else
                mensajeFinal = mensaje;
            System.debug('mensaje final: ' + mensajeFinal);
            inkEvents.add(new ResultadoGrabado__e(Mensaje__c=mensajeFinal, Usuario__c=System.UserInfo.getUserId()
                                                  , Ejecucion_correcta__c = EjecucionCorrecta));
            List<Database.SaveResult> results = EventBus.publish(inkEvents);
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    System.debug('Successfully published event.');
                } else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Error returned: ' +
                                     err.getStatusCode() +
                                     ' - ' +
                                     err.getMessage());
                    }
                }
            }
        }catch(Exception ex){
            System.debug('publicarEvento: '+ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public static HTTPResponse consultaAPIPOST(String body, String endpoint){
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('endpoint: ' + endpoint);
        System.debug('Body: '+body);
        request.setEndpoint(endpoint);
        request.setBody(body);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(60000);
        HttpResponse res = h.send(request);
        return res;
    }
    public class SolicitaDatos{
        public header header;
        public body body;
    }
    public class header{
        public Security security;
    }
    public class Security{
        public String token {get;set;}
        public String user  {get;set;}
    }
    public class body {
        public request request;
    }
    public class request {
        public data data;
    }
    public class data {
        public String rfc {get;set;}
    }
}
