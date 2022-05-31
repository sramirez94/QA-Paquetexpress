/**
 * @description       : Clase que consume un servicio para validar si la cuenta se encuentra en las listas negras del SAT
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com)
 * @Project           : Paquetexpress SEF
 * @Created Date      : 30-05-2022
**/
public class ConsultaBlackList {
    public static void getResultBlackList(String strNombre, String strPaterno, String strMaterno, String strRFC, String strRazonSoc, Boolean blnPersonaMoral) {
        String cookies                      = '';
        String qnid                         = '';
        String qkey                         = '';
        String quid                         = '';
        String strNombreEncode              = '';
        String strPaternoEncode             = '';
        String strMaternoEncode             = '';
        String strRFCEncode                 = '';
        String strRazonSocEncode            = '';
        String strEndPoint                  = '';
        Http http                           = new Http();
        HttpRequest request                 = new HttpRequest();
        HttpResponse response               = new HttpResponse();
        Dom.Document doc                    = new Dom.Document();
        //Dom.XMLNode address                 = new Dom.XMLNode();
        WS_Paquetexpress__mdt mdtDatosWS    = WS_Paquetexpress__mdt.getInstance('BlackList');
        if(mdtDatosWS != null){
            //Consumo para obtener los cookies necesarios para la consulta.
            System.debug('Endpoint: ' + mdtDatosWS.URL__c + 'access?var1=' + mdtDatosWS.Usuario__c + '&var2=' + mdtDatosWS.Contrasena__c);
            request.setEndpoint(mdtDatosWS.URL__c + 'access?var1=' + mdtDatosWS.Usuario__c + '&var2=' + mdtDatosWS.Contrasena__c);
            request.setMethod('GET');
            request.setTimeout(20000);
            response = http.send(request);
            cookies = response.getHeader('Set-Cookie');
            qnid = cookies.subString(cookies.indexOf('qnid='), cookies.indexOf('qkey=')).remove('qnid=').remove('; path=/;');
            qkey = cookies.subString(cookies.indexOf('qkey='), cookies.indexOf('quid=')).remove('qkey=').remove('; path=/;');
            quid = cookies.subString(cookies.indexOf('quid='), cookies.length()).remove('quid=').remove('; path=/');
            System.debug('Cookies: ' + cookies);
            System.debug('qnid: ' + qnid);
            System.debug('qkey: ' + qkey);
            System.debug('quid: ' + quid);
            //Consumo para validar al cliente
            http = new Http();
            request = new HttpRequest();
            if(blnPersonaMoral){
                if(strRazonSoc != null && strRazonSoc != ''){
                    strRazonSocEncode = EncodingUtil.urlEncode(strRazonSoc, 'UTF-8');
                    strRFCEncode = EncodingUtil.urlEncode(strRFC, 'UTF=8');
                    strEndPoint = mdtDatosWS.URL__c + 'pepse?razonsoc=' + strRazonSocEncode + '&rfc=' + strRFCEncode;
                } else {
                    System.debug('Error por falta de rfc');
                }
            } else {
                strNombreEncode = strNombre != null?EncodingUtil.urlEncode(strNombre, 'UTF-8'):'';
                strPaternoEncode = strPaterno != null?EncodingUtil.urlEncode(strPaterno, 'UTF-8'):'';
                strMaternoEncode = strMaterno != null?EncodingUtil.urlEncode(strMaterno, 'UTF-8'):'';
                strEndPoint = mdtDatosWS.URL__c + 'pepsp?nombre=' + strNombreEncode + '&paterno=' + strPaternoEncode + '&Materno=' + strMaternoEncode + '&rfc=' + EncodingUtil.urlEncode(strRFC, 'UTF-8');
            }
            request.setEndpoint(strEndPoint);
            request.setMethod('GET');
            request.setTimeout(20000);
            request.setHeader('Cookie', 'qkey=' + qkey + '; qnid=' + qnid + '; quid=' + quid);
            response = new HttpResponse();
            response = http.send(request);
            System.debug('Cuerpo: ' + response.getBody());
            XmlStreamReader reader = response.getXMLStreamReader();
            System.debug('data: ' + reader);
            //Dom.Document doc = response.getBodyDocument();
            doc.load(response.getBody());
            Dom.XMLNode XML = doc.getRootElement();
            System.debug('nombre: ' + XML.getName());
            System.debug('contenido: ' + XML.getChildElements()[1]);
            Dom.XMLNode Body = XML.getChildElements()[0];
            List<Dom.XMLNode> lstChild = body.getChildElements();
            System.debug('Cuerpo es nulo: ' + lstChild.size());
            for(Dom.XMLNode child : lstChild){
                if(child.getText() != null && child.getText() != ''){
                    System.debug('Nombre: ' + child.getName() + '. Elemento: ' + child.getText());
                }
            }
        }
    }
}
