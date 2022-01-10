/**
 * @description       : 
 * @author            : Salvador Ramírez López (sramirez@freewayconsulting.com)
 * @group             : 
 * @last modified on  : 01-07-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   05-02-2021   Salvador Ramírez López (sramirez@freewayconsulting.com)   Initial Version
**/
public class consultaTarifasWW_CTR {
    public static String strBody {get;set;}
    public consultaTarifasWW_CTR(ApexPages.StandardController controller) {
        strBody = '';
    }
    @AuraEnabled
    public static String CargaInfoSipweb(String idSipweb){
        ObjDocEnLinea.ptpServicesTrif ptpConfig                     = new ObjDocEnLinea.ptpServicesTrif();
        ObjDocEnLinea.kmServicesTrif kmConfig                       = new ObjDocEnLinea.kmServicesTrif();
        System.debug('id recibido: ' + idSipweb);
        if(ObtieneInfoResponse(idSipweb)){
            System.debug('body: ' + strBody);
            return strBody;
        } else {
            return '';
        }
        
    }
    public static Boolean ObtieneInfoResponse(String idSipweb){
        Boolean resultado   = false;
        String endpoint     = Label.Grabado_DocLinea; //QA
        //String endpoint     = 'https://sf.paquetexpress.com.mx/SalesForceRestFul/api/agreements/getDetail';
        //GrabadoBtnController gr = new GrabadoBtnController(StandarC);
        try{
            if(idSipweb!=null && !String.isEmpty(idSipweb)|| Test.isRunningTest()){
                DefinicionesServiciosGrabado.requestDRemota rdp = new DefinicionesServiciosGrabado.requestDRemota();
                DefinicionesServiciosGrabado.header rdpH = new DefinicionesServiciosGrabado.header();            
                DefinicionesServiciosGrabado.security sec = new DefinicionesServiciosGrabado.security();
                DefinicionesServiciosGrabado.requestDataODC ddP = new DefinicionesServiciosGrabado.requestDataODC();
                DefinicionesServiciosGrabado.requestODC req = new DefinicionesServiciosGrabado.requestODC();
                DefinicionesServiciosGrabado.bodyRequestODC bdp = new DefinicionesServiciosGrabado.bodyRequestODC();
                sec.user = 'SALESFORCE';
                sec.token = '325746796331582000000';
                rdpH.security = sec;    
                rdp.header= rdpH;
                ddP.clntId = idSipweb;
                req.data = ddP;
                bdp.request = req;
                rdp.body = bdp;
                if(ObtieneInfoSipweb(JSON.serialize(rdp), endpoint)){
                    System.debug('obtuvo info sipweb');
                }
                //iniciarGrabado(cotizacion);
                resultado = true;
            }
        }catch (Exception ex){
            System.debug('Error al obtener response '+ex.getLineNumber()+' '+EX.getMessage());
            //gr.publicarEvento(false, 'Error al obtener response: ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
        return resultado;
    }
    public static Boolean ObtieneInfoSipweb(String body, String endpoint){
        try{
            if(Test.isRunningTest()){
                HttpResponse res = consultaAPIPOST(body,endpoint);
                strBody = res.getBody().replace('time','timeR');
                return true;
            } else {
                HttpResponse res = consultaAPIPOST(body,endpoint);
                strBody = res.getBody().replace('time','timeR');
                return true;
            }
        }catch (Exception ex){
            System.debug('ObtieneInfoSipweb: '+ex.getLineNumber()+' '+ex.getMessage());
            return false;
        }
    }
    public static Boolean ProcesaResponse(HTTPResponse res){
        //Salvador Ramírez (sranmirez@freewayconsulting.com):Función para procesar el response al consultar los convenios que tiene el cliente en sipweb
        //GrabadoBtnController gr = new GrabadoBtnController(StandarC);
        try{
            String Respuesta    = res.getBody();
            strBody = respuesta.replace('time', 'timeR');
            return true;
        }catch (Exception ex){
            System.debug('ProcesaResponse ' + ex.getLineNumber() + ' ' + ex.getMessage());
            //gr.publicarEvento(false, 'Error al procesar información obtenida de sipweb.');
            return false;
        }
    }
    public void AsignaResponseTest(ObjDocEnLinea.documentacionRemota DR){
        try{

            //CargaInfoSipweb();
        }catch (exception ex){
            System.debug('AsignaResponseTest ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
    }
    
    public static HttpResponse consultaAPIPOST(String body, String endpoint){
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('Body: '+body);
        request.setEndpoint(endpoint);
        request.setBody(body);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(60000);      
        HttpResponse res = h.send(request);
        return res;        
    }
}
