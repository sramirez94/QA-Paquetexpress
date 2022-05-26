/**
 * @description       : Acción de apex para consumir el servicio de validación de RFC cuando se intente modificar o crear una cuenta.
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com)
 * @Created Date      : 25/05/2022
**/
public with sharing class validaRFC {
    @InvocableMethod(label='Valida RFC ante SAT')
    public Static List<Respuesta> validaRFC(List<RFC> lstRFC) {
        System.debug('RFC Recibido desde el flujo: ' + lstRFC[0].strRFC);
        validaRFC(lstRFC[0].strRFC);
        return null;
    }
    @future(callout = true)
    public static void ValidaRFC(String strRFC){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        ConsultaRFC objConsulta = new ConsultaRFC();
        header hd = new header();
        security sc = new security();
        body bd = new body();
        request rq = new request();
        data dt = new data();
        sc.user = 'WEBPAGE';
        sc.password = '';
        sc.token = label.TokenValidaRFC;
        hd.security = sc;
        dt.rfc = strRFC;
        rq.data = dt;
        bd.request = rq;
        objConsulta.header = hd;
        objConsulta.body = bd;
        request.setEndpoint(label.URL_Valida_RFC);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        String strJSON = JSON.serialize(objConsulta);
        request.setBody(strJSON);
        System.debug('json pet:' + strJSON);
        HttpResponse res = new HttpResponse();
        res = http.send(request);
        System.debug('respuesta: ' + res.getBody());
        ConsultaRFC resp = new ConsultaRFC();
        resp = (ConsultaRFC) System.JSON.deserialize(res.getBody(), ConsultaRFC.class);
        System.debug('valido: ' + resp.body.response.success);
    }
    public class RFC {
        @InvocableVariable(required=true)
        public String strRFC;
    }
    public class Respuesta{
        @InvocableVariable(required=true)
        public Boolean valido;
    }
    public class ConsultaRFC{
        public header header;
        public body body;
    }
    public class header{
        public Security security;
    }
    public class Security{
        public String user;
        public String password;
        public Integer type;
        public String token;
    }
    public class body{
        public request request;
        public response response;
    }
    public class request {
        public data data;
    }
    public class data{
        public String rfc;
    }
    public class response{
        public Boolean success;
        public List<messages> messages;
        public dataresponse data;
        public String objectDTO;
    }
    public class dataresponse{
        public String rfcGenerico;
    }
    public class messages{
        public String code;
        public String description;
        public String typeError;
    }
}
