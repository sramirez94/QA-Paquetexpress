public class GrabadoDocEnLinea {
    public Wrapper wp                                   {get;set;}
    public Id owner                                     {get;set;}
    public Id Id                                        {get;set;}
    public SBQQ__Quote__c cas                           {get;set;}
    public string tipoDocumentacion                     {get;set;}
    public Id cuenta                                    {get;set;}
    public string idSipWeb                              {get;set;}
    public date fechaVigencia                           {get;set;}
    public Boolean grabadoUnico                         {get;set;}
    public Boolean confirmacionGrabadoUnico             {get;set;}
    public String aprvUser                              {get;set;}
    public String orgnSite                              {get;set;}
    public String destSite                              {get;set;}
    public String factor                                {get;set;}
    public String serviceId                             {get;set;}
    public String refrServiceId                         {get;set;}
    public String trifType                              {get;set;}
    public String pieceMulti                            {get;set;}
    public List<String> listTarifas                     {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapQuotes    {get;set;}
    public GrabadoDocEnLinea (ApexPages.StandardController controller){
        this.aprvUser       = '';
        this.destSite       = '';
        this.orgnSite       = '';
        this.factor         = '';
        this.serviceId      = '';
        this.refrServiceId  = '';
        this.trifType       = '';
        this.pieceMulti     = '';
        this.listTarifas    = new List<String>();
        this.wp             = new Wrapper();
        this.mapQuotes      = new Map<String,SBQQ__QuoteLine__c>();
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
        GrabadoBtnController gr;
        String strOrigen = '';
        try{
            if(cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c)|| Test.isRunningTest()){
                this.wp.listQuoteItem                                           = queryquoteitem(cotizacion.id);
                ObjDocEnLinea.documentacionRemota odc                           = new ObjDocEnLinea.documentacionRemota();
                ObjDocEnLinea.header header                                     = new ObjDocEnLinea.header();
                ObjDocEnLinea.security sec                                      = new ObjDocEnLinea.security();
                ObjDocEnLinea.bodyDRemota body                                  = new ObjDocEnLinea.bodyDRemota();
                ObjDocEnLinea.requestDRemota rq                                 = new ObjDocEnLinea.requestDRemota();
                ObjDocEnLinea.dataDRemota data                                  = new ObjDocEnLinea.dataDRemota();
                ObjDocEnLinea.kmServicesTrifList kmServicesTrif                 = new ObjDocEnLinea.kmServicesTrifList();
                ObjDocEnLinea.servicesTrifDtl servicesTrifDtl                   = new ObjDocEnLinea.servicesTrifDtl();
                ObjDocEnLinea.serviceTrif serviceTrif                           = new ObjDocEnLinea.serviceTrif();
                ObjDocEnLinea.kmServicesTrif kmServicesTrif1                    = new ObjDocEnLinea.kmServicesTrif();
                List<ObjDocEnLinea.serviceTrif> listserviceTrif                 = new List<ObjDocEnLinea.serviceTrif>();
                ObjDocEnLinea.servicesTrifDtlSub servicesTrifDtlSub             = new ObjDocEnLinea.servicesTrifDtlSub();
                list<ObjDocEnLinea.kmServicesTrifList> listkmServicesTrif       = new List<ObjDocEnLinea.kmServicesTrifList>();
                List<ObjDocEnLinea.servicesTrifDtlSub> listServicesTrifDtlS     = new List<ObjDocEnLinea.servicesTrifDtlSub>();
                List<ObjDocEnLinea.kmServicesTrif> listkmServicesTrif1          = new List<ObjDocEnLinea.kmServicesTrif>();
                List<ObjDocEnLinea.servicesTrifDtl> servicesTrifDtlList         = new List<ObjDocEnLinea.servicesTrifDtl>();
                strOrigen = queryObtieneOrigen(cotizacion.id);
                //30/12/2020 Salvador: Header y data
                sec.user    = 'USERSALESFORCE';
                sec.token   = '325746796331582000000';
                //30/12/2020 Salvador: Comienza creación del body
                data.quotation  = cotizacion.Name; //30/12/2020 Salvador: Nombre de la cotización, ej: Q-0245
                data.clntId     = cotizacion.SBQQ__Account__r.Id_SIpWeb__c; //30/12/2020 Salvador: Id de sipweb del cliente
                data.aprvUser   = this.aprvUser;
                data.trifType   = this.trifType;
                data.pieceMulti = this.pieceMulti;

                for(SBQQ__QuoteLine__c cot:this.wp.listQuoteItem){
                    if(!this.listTarifas.contains(cot.Tarifa__c))
                        this.listTarifas.add(cot.Tarifa__c);
                    if(!this.mapQuotes.containsKey(cot.Tarifa__c)){
                        this.mapQuotes.put(cot.Tarifa__c, cot);
                    }
                }    
                kmServicesTrif.fromKm                   = '0';
                kmServicesTrif.toKm                     = '400';
                for(String strTarifa : this.listTarifas){
                    serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                    servicesTrifDtlSub                      = new ObjDocEnLinea.servicesTrifDtlSub();
                    listserviceTrif                         = new List<ObjDocEnLinea.serviceTrif>();
                    servicesTrifDtlSub.slabNo               = obtieneTarifa(strTarifa);
                    serviceTrif.serviceId                   = 'SHP-E';
                    if(strTarifa == 'TARIFA SOBRE')
                        serviceTrif.refServiceId                = 'ENVELOPES';
                    else
                        serviceTrif.refServiceId                = 'PACKETS';
                    serviceTrif.trifAmount                  = this.mapQuotes.get(strTarifa).SBQQ__CustomerPrice__c;
                    serviceTrif.discount                    = this.mapQuotes.get(strTarifa).SBQQ__Discount__c;
                    serviceTrif.trifAmntBase                = 0;
                    listserviceTrif.add(serviceTrif);
                    if(this.mapQuotes.get(strTarifa).EAD__C != null){
                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                        serviceTrif.serviceId                   = 'EAD-1';
                        serviceTrif.refServiceId                = 'EAD';
                        serviceTrif.trifAmount                  = this.mapQuotes.get(strTarifa).EAD__c;
                        serviceTrif.trifAmntBase                = 0;
                        serviceTrif.discount                    = 0;
                        listserviceTrif.add(serviceTrif);
                    }
                    if(this.mapQuotes.get(strTarifa).RAD__C != null){
                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                        serviceTrif.serviceId                   = 'RAD-1';
                        serviceTrif.refServiceId                = 'RAD';
                        serviceTrif.trifAmount                  = this.mapQuotes.get(strTarifa).RAD__c;
                        serviceTrif.trifAmntBase                = 0;
                        serviceTrif.discount                    = 0;
                        listserviceTrif.add(serviceTrif);
                    }
                    servicesTrifDtlSub.serviceTrif          = listserviceTrif;
                    listServicesTrifDtlS.add(servicesTrifDtlSub);
                }                
                listkmServicesTrif                      = new List<ObjDocEnLinea.kmServicesTrifList>{kmServicesTrif};
                kmServicesTrif1.kmServicesTrif          = listkmServicesTrif;
                listkmServicesTrif1                     = new List<ObjDocEnLinea.kmServicesTrif>{kmServicesTrif1};
                data.kmConfig                           = listkmServicesTrif1;
                servicesTrifDtlList                     = new List<ObjDocEnLinea.servicesTrifDtl>{servicesTrifDtl};
                kmServicesTrif.servicesTrifDtl          = listServicesTrifDtlS;
                rq.data                                 = data;
                body.request                            = rq;
                odc.body                                = body;
                header.security                         = sec;
                odc.header                              = header;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Serializado: ' + JSON.serialize(odc)));
            }else  gr.publicarEvento(false, 'Imposible continuar con el grabado, no cuenta con los datos necesarios.');

        } catch (Exception ex){
            System.debug('ValidacionDocLinea: '+ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public static String obtieneTarifa(String tarifa){
        if(tarifa == 'TARIFA SOBRE')
            return 'S';
        else if(tarifa == 'TARIFA T0')
            return 'T0';
        else if(tarifa == 'TARIFA T1')
            return 'T1';
        else if(tarifa == 'TARIFA T2')
            return 'T2';
        else if(tarifa == 'TARIFA T3')
            return 'T3';
        else if(tarifa == 'TARIFA T4')
            return 'T4';
        else if(tarifa == 'TARIFA T5')
            return 'T5';
        else if(tarifa == 'TARIFA T6')
            return 'T6';
        else if(tarifa == 'TARIFA T7V')
            return 'T7V';
        else if(tarifa == 'TARIFA T7P')
            return 'T7P';
        else if(tarifa == 'TARIFA T7')
            return 'T7';
        else return '';
    }
    public void GrabarTarifaDocLinea(){
        try{
            iniciarGrabado(this.cas);
        } catch (Exception ex){
            System.debug('GrabarTarifaDocLinea ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
    }
    public static List<SBQQ__QuoteLine__c> queryquoteitem(String Id){
        return[SELECT Id, Rango_KM__c, Destiny__c, ACK__c, RAD__c, EAD__c, SBQQ__CustomerPrice__c, SBQQ__Discount__c,Tarifa__c FROM SBQQ__QuoteLine__c WHERE SBQQ__QUOTE__C = : Id AND Rango_KM__c = '0-400'];
    }
    public static String queryObtieneOrigen(String Id){
        SBQQ__Quote__c cot = [SELECT Plaza__c FROM SBQQ__QUOTE__C WHERE ID = : Id];
        if(cot.Plaza__c != null)
            return cot.Plaza__c;
        else return '';
    }
    public class Wrapper{
        public List<SBQQ__QuoteLine__c> listQuoteItem   {get; set;}
        public Wrapper(){
            this.listQuoteItem  = new List<SBQQ__QuoteLine__c>();
        }
    }
}
