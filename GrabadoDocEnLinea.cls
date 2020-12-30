public class GrabadoDocEnLinea {
    public Id owner                         {get;set;}
    public Id Id                            {get;set;}
    public SBQQ__Quote__c cas               {get;set;}
    public string tipoDocumentacion         {get;set;}
    public Id cuenta                        {get;set;}
    public string idSipWeb                  {get;set;}
    public date fechaVigencia               {get;set;}
    public Boolean grabadoUnico             {get;set;}
    public Boolean confirmacionGrabadoUnico {get;set;}
    public String aprvUser                  {get;set;}
    public String orgnSite                  {get;set;}
    public String destSite                  {get;set;}
    public String factor                    {get;set;}
    public String serviceId                 {get;set;}
    public String refrServiceId             {get;set;}
    public String trifType                  {get;set;}
    public String pieceMulti                {get;set;}
    public GrabadoDocEnLinea (ApexPages.StandardController controller){
        this.aprvUser       = '';
        this.destSite       = '';
        this.orgnSite       = '';
        this.factor         = '';
        this.serviceId      = '';
        this.refrServiceId  = '';
        this.trifType       = '';
        this.pieceMulti     = '';
        try{
            this.cas                    = (SBQQ__Quote__c) controller.getRecord();
            this.Id                     = cas.Id;
            idSipWeb                    = cas.SBQQ__Account__r.Id_SIpWeb__c;
            owner                       = cas.OwnerId;
            cuenta                      = cas.SBQQ__Account__c;
            tipoDocumentacion           = cas.Tipo_de_documentacion__c;
            fechaVigencia               = cas.Flujo_del_mes__c;
            grabadoUnico                = cas.Descuento_prepago_unico__c;
            confirmacionGrabadoUnico    = cas.Confirmacion_de_Grabado_Unico__c;
            if(ObtieneInfoResponse(cas))
                System.debug('ejecutó correctamente');
            else System.debug('error al obtener response');
        }catch (Exception ex){
            System.debug('Error en el constructor ' +ex.getLineNumber()+' '+EX.getMessage());
        }
    }
    public Boolean ObtieneInfoResponse(SBQQ__Quote__c cotizacion){
        Boolean resultado = false;
        try{
            if(cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c)|| Test.isRunningTest()){
                String endpoint = Label.Grabado_DocLinea;
                String userSipweb = '';
                User u = [SELECT Id_Sipweb__c, FederationIdentifier FROM User WHERE Id=:System.UserInfo.getUserId()];
                if(!System.isScheduled()){
                    if(!String.isEmpty(u.Id_Sipweb__c))
                        userSipweb = u.Id_Sipweb__c;
                    else
                        userSipweb = u.FederationIdentifier;
                }
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
                ddP.clntId = '1145777';
                req.data = ddP;
                bdp.request = req;
                rdp.body = bdp;
                if(ObtieneInfoSipweb(JSON.serialize(rdp), endpoint, cotizacion)){
                    System.debug('obtuvo info sipweb');
                }
                resultado = true;
            }
        }catch (Exception ex){
            System.debug('Error al obtener response '+ex.getLineNumber()+' '+EX.getMessage());
        }
        return resultado;
    }
    public Boolean ObtieneInfoSipweb(String body, String endpoint,SBQQ__Quote__c cotizacion){
        try{
            Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
            GrabadoBtnController grab = new GrabadoBtnController(sc);
            HttpResponse res = grab.consultaAPIPOST(body,endpoint);
            String respuesta = res.getBody().replace('time','timeR');
            return ProcesaResponse(res,cotizacion);
        }catch (Exception ex){
            System.debug('ObtieneInfoSipweb: '+ex.getLineNumber()+' '+ex.getMessage());
            return false;
        }
    }
    public Boolean ProcesaResponse(HTTPResponse res,SBQQ__Quote__c cotizacion){
        try{
            String Respuesta = res.getBody();
            respuesta = respuesta.replace('time', 'timeR');
            DefinicionesServiciosGrabado.responseODC rg = (DefinicionesServiciosGrabado.responseODC)JSON.deserializeStrict(respuesta, DefinicionesServiciosGrabado.responseODC.class);
            this.aprvUser   = rg.body.response.data.aprvUser;
            this.trifType   = rg.body.response.data.trifType;
            this.pieceMulti = rg.body.response.data.pieceMulti;
            return true;
        }catch (Exception ex){
            System.debug('ProcesaResponse ' + ex.getLineNumber() + ' ' + ex.getMessage());
            return false;
        }
    }
    public static void procesarDL(SBQQ__Quote__c cotizacion){
        //System.debug('ejecuta constructor');
		Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
        Boolean cotizacionVigente = true;
        GrabadoBtnController gbc = new GrabadoBtnController(sc);
        if(cotizacion.Flujo_del_mes__c!=null)
        	cotizacionVigente = cotizacion.Flujo_del_mes__c<=Date.today();
        Boolean crearUsuario = gbc.crearUsuarioWeb(cotizacion);
        if(crearUsuario && cotizacionVigente){
            switch on (cotizacion.Modelo_de_tarifas__c){
                when 'Tarifario abierto de piso'{
                    grabadoTarifarioAbierto(cotizacion);
                }
                when else{
                    grabadoTarifarioC(cotizacion);
                }
            }
        }
        else if(!cotizacionVigente)
            gbc.publicarEvento(false,'Vigencia para cotización '+ cotizacion.Name +' expirada.');
    }
    public static void grabadoTarifarioAbierto(SBQQ__Quote__c cotizacion){
        //System.debug('ejecuta grabadoTarifarioAbierto');
        ObjDocEnLinea ode = new ObjDocEnLinea();
        ObjDocEnLinea.security s = new ObjDocEnLinea.security();
        s.user = '';
        s.token = '';
		ObjDocEnLinea.header h = new ObjDocEnLinea.header();
        h.security = s;
        ObjDocEnLinea.documentacionRemota dr = new ObjDocEnLinea.documentacionRemota();
        dr.header = h;
        ObjDocEnLinea.dataDRemota data = new ObjDocEnLinea.dataDRemota();
        data.aprvUser = '';
        data.clntId = '';
        data.pieceMulti = '';
        data.ptpConfig = null;
        data.trifType = 'A';
        data.kmConfig = null;
        List<ObjDocEnLinea.servicesTrifDtl> lstServiceTrifList = new List<ObjDocEnLinea.servicesTrifDtl>();
		List<ObjDocEnLinea.serviceTrif> lstServiceTrif = new List<ObjDocEnLinea.serviceTrif>(); 
        List<ObjDocEnLinea.ptpServicesTrif> ptpSvcList = new List<ObjDocEnLinea.ptpServicesTrif>();
        for(Integer z=0;z<z;z++){
            ObjDocEnLinea.ptpServicesTrif ptp = new ObjDocEnLinea.ptpServicesTrif();
            for(Integer y=0;y<y;y++){
                ObjDocEnLinea.servicesTrifDtl servDtil = new ObjDocEnLinea.servicesTrifDtl();
                for(Integer x=0;x<x;x++){
                    ObjDocEnLinea.serviceTrif nodoServiceTrif = new ObjDocEnLinea.serviceTrif(); 
                    nodoServiceTrif.discount = 0;
                    nodoServiceTrif.factor = null;
                    nodoServiceTrif.factorValue = null;
                    nodoServiceTrif.refServiceId = null;
                    nodoServiceTrif.serviceId = null;
                    nodoServiceTrif.servicesCant = null;
                    nodoServiceTrif.trifAmntBase = 0;
                    nodoServiceTrif.trifAmount = 0;
                    lstServiceTrif.add(nodoServiceTrif);
                }
                ObjDocEnLinea.servicesTrifDtl listaNodosServiceTrif = new ObjDocEnLinea.servicesTrifDtl();
                //listaNodosServiceTrif.serviceTrif =lstServiceTrif;
                //listaNodosServiceTrif.slabNo = '';
                lstServiceTrifList.add(listaNodosServiceTrif);
            }
            ptp.orgnSite = null;
            ptp.destSite = null;
            ptp.serviceTrif = null;
        	ptp.servicesTrifDtl = lstServiceTrifList;            
            ptpSvcList.add(ptp);
        }
        data.ptpConfig = ptpSvcList;
        ObjDocEnLinea.kmServicesTrif kmS = new ObjDocEnLinea.kmServicesTrif();
       // kmS.servicesTrifDtl;
		ObjDocEnLinea.requestDRemota r = new ObjDocEnLinea.requestDRemota();
        r.data = data;
 		ObjDocEnLinea.bodyDRemota body = new ObjDocEnLinea.bodyDRemota();
        body.request = r;
        dr.body = body;
        dr.header = h;
        System.debug(JSON.serialize(dr));
    }
    public static void grabadoTarifarioC(SBQQ__Quote__c cotizacion){    
        //System.debug('ejecuta grabadoTarifarioC');
		List<ObjDocEnLinea.serviceTrif> lstServiceTrif = new List<ObjDocEnLinea.serviceTrif>();
        for(Integer x=0;x<x;x++){
			ObjDocEnLinea.serviceTrif nodoServiceTrif = new ObjDocEnLinea.serviceTrif(); 
        	nodoServiceTrif.trifAmount = 0;
        	nodoServiceTrif.trifAmntBase = 0;
        	nodoServiceTrif.discount = 0;
            nodoServiceTrif.factorValue = null;
            nodoServiceTrif.serviceId = null;
            nodoServiceTrif.refServiceId = null;
            nodoServiceTrif.factor = null;
			nodoServiceTrif.servicesCant =null;
            lstServiceTrif.add(nodoServiceTrif);
        }
    }
    public void iniciarGrabado(SBQQ__Quote__c cotizacion){
        try{
            if((cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c))|| Test.isRunningTest()){
                if(cotizacion.SBQQ__Status__c=='Approved'){
                    if(cotizacion.SBQQ__Opportunity2__r.StageName=='Cerrada/Ganada' || Test.isRunningTest()){
                        ValidacionDocLinea(cotizacion);
                    }
                }
            }
        }catch(Exception ex){
            System.debug('validacionEnPiso: '+ex.getLineNumber()+' '+ex.getMessage());
            //publicarEvento(false,'No se pudo realizar el grabado');            
        }
    }
    public void ValidacionDocLinea(SBQQ__Quote__c cotizacion){
        System.debug('entra');
    }

}
