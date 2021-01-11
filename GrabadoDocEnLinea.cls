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
    public Boolean blnMostrarMensaje                    {get;set;}
    public String aprvUser                              {get;set;}
    public String orgnSite                              {get;set;}
    public String destSite                              {get;set;}
    public String factor                                {get;set;}
    public String serviceId                             {get;set;}
    public String refrServiceId                         {get;set;}
    public String trifType                              {get;set;}
    public String pieceMulti                            {get;set;}
    public String strMensajeError                       {get;set;}
    public List<String> listTarifas                     {get;set;}
    public List<String> listRangeDestiny                {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapQuotes    {get;set;}
    public GrabadoDocEnLinea (ApexPages.StandardController controller){
        this.aprvUser           = '';
        this.destSite           = '';
        this.orgnSite           = '';
        this.factor             = '';
        this.serviceId          = '';
        this.refrServiceId      = '';
        this.trifType           = '';
        this.pieceMulti         = '';
        this.strMensajeError    = '';
        this.blnMostrarMensaje  = false;
        this.listTarifas        = new List<String>();
        this.listRangeDestiny   = new List<String>();
        this.wp                 = new Wrapper();
        this.mapQuotes          = new Map<String,SBQQ__QuoteLine__c>();
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
            strMensajeError = 'Error al iniciar. Contacte a un consultor de salesforce';
        }
    }
    public Boolean ObtieneInfoResponse(SBQQ__Quote__c cotizacion){
        Boolean resultado   = false;
        strMensajeError     = '';
        blnMostrarMensaje   = false;
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
            strMensajeError = 'Error al obtener información de sipweb';
            blnMostrarMensaje = true;
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
            blnMostrarMensaje   = false;
            strMensajeError     = '';
            Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
            GrabadoBtnController gr = new GrabadoBtnController(sc);
            if((cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c))|| Test.isRunningTest()){
                System.debug('entra validación');
                if(cotizacion.SBQQ__Status__c=='Approved'){
                    if(cotizacion.SBQQ__Opportunity2__r.StageName=='Cerrada/Ganada' || Test.isRunningTest()){
                        ValidacionDocLinea(cotizacion);
                    } else {
                        strMensajeError = 'Imposible continuar, la oportunidad debe tener un status "Cerrada/Ganada".';
                        blnMostrarMensaje = true;
                    }
                }else{
                    strMensajeError = 'Imposible continuar, la cotización no se encuentra aprobada.';
                    blnMostrarMensaje = true;
                }
            } else {
                strMensajeError = 'Imposible continuar, es necesario un ID se sipweb';
                blnMostrarMensaje = true;
            }
        }catch(Exception ex){
            System.debug('IniciarGrabado: '+ex.getLineNumber()+' '+ex.getMessage());
            strMensajeError = 'Error al iniciar el grabado de tarifas';
            blnMostrarMensaje = true;
        }
    }
    public void ValidacionDocLinea(SBQQ__Quote__c cotizacion){
        GrabadoBtnController gr;
        String strOrigen    = '';
        blnMostrarMensaje   = false;
        strMensajeError     = '';
        String endpoint     = Label.Grabar_DocLinea;
        try{
            if(cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c)|| Test.isRunningTest()){
                this.wp.listQuoteItem                                           = queryquoteitem(cotizacion.id);
                Apexpages.StandardController sc                                 = new Apexpages.StandardController(cotizacion);
                GrabadoBtnController grab                                       = new GrabadoBtnController(sc);
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
                ObjDocEnLinea.ptpServicesTrifSub ptpServicesTrifSub             = new ObjDocEnLinea.ptpServicesTrifSub();
                ObjDocEnLinea.servicesTrifDtlSub servicesTrifDtlSub             = new ObjDocEnLinea.servicesTrifDtlSub();
                ObjDocEnLinea.ptpServicesTrif ptpServicesTrif                   = new ObjDocEnLinea.ptpServicesTrif();
                ObjDocEnLinea.serviceTrif ptpServTrif                           = new ObjDocEnLinea.serviceTrif();
                List<ObjDocEnLinea.serviceTrif> listserviceTrif                 = new List<ObjDocEnLinea.serviceTrif>();
                list<ObjDocEnLinea.kmServicesTrifList> listkmServicesTrif       = new List<ObjDocEnLinea.kmServicesTrifList>();
                List<ObjDocEnLinea.servicesTrifDtlSub> listServicesTrifDtlS     = new List<ObjDocEnLinea.servicesTrifDtlSub>();
                List<ObjDocEnLinea.kmServicesTrif> listkmServicesTrif1          = new List<ObjDocEnLinea.kmServicesTrif>();
                List<ObjDocEnLinea.servicesTrifDtl> servicesTrifDtlList         = new List<ObjDocEnLinea.servicesTrifDtl>();
                List<ObjDocEnLinea.ptpServicesTrifSub> listptpServicesTrifS     = new List<ObjDocEnLinea.ptpServicesTrifSub>();
                List<ObjDocEnLinea.ptpServicesTrif> listptpServicesTrif         = new List<ObjDocEnLinea.ptpServicesTrif>();
                List<ObjDocEnLinea.serviceTrif> listptpServTrif                 = new List<ObjDocEnLinea.serviceTrif>();
                if(cotizacion.Plaza__c != null)
                    strOrigen   = cotizacion.Plaza__c;
                //30/12/2020 Salvador: Header y data
                sec.user    = 'USERSALESFORCE';
                sec.token   = '325746796331582000000';
                //30/12/2020 Salvador: Comienza creación del body
                //data.quotation  = cotizacion.Name; //30/12/2020 Salvador: Nombre de la cotización, ej: Q-0245
                data.clntId     = cotizacion.SBQQ__Account__r.Id_SIpWeb__c; //30/12/2020 Salvador: Id de sipweb del cliente
                data.aprvUser   = this.aprvUser;
                if(cotizacion.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km')
                    data.trifType = 'A';
                else data.trifType   = 'C';
                data.pieceMulti = this.pieceMulti;
                for(SBQQ__QuoteLine__c cot:this.wp.listQuoteItem){
                    if(!this.listTarifas.contains(cot.Tarifa__c))
                        this.listTarifas.add(cot.Tarifa__c);
                    if(!this.mapQuotes.containsKey(cot.Tarifa__c)){
                        this.mapQuotes.put(cot.Tarifa__c, cot);
                    }
                    if(cot.Destiny__c != null){
                        if(!this.listRangeDestiny.contains(cot.Destiny__c))
                            this.listRangeDestiny.add(cot.Destiny__c);
                    } else {
                        if(!this.listRangeDestiny.contains(cot.Rango_KM__c))
                            this.listRangeDestiny.add(cot.Rango_KM__c);
                    }
                }
                if(strOrigen != '')
                    ptpServicesTrifSub.orgnSite = strOrigen;
                for(String strRange : this.listRangeDestiny){
                    kmServicesTrif = new ObjDocEnLinea.kmServicesTrifList();
                    serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                    listserviceTrif                         = new List<ObjDocEnLinea.serviceTrif>();
                    listServicesTrifDtlS                    = new List<ObjDocEnLinea.servicesTrifDtlSub>();
                    if(strRange == '0-400'){
                        kmServicesTrif.fromKm       = '0';
                        kmServicesTrif.toKm         = '400';
                    } else if(strRange == '401-800'){
                        kmServicesTrif.fromKm       = '401';
                        kmServicesTrif.toKm         = '800';
                    } else if(strRange == '801-1200'){
                        kmServicesTrif.fromKm       = '801';
                        kmServicesTrif.toKm         = '1200';
                    } else if(strRange == '1201-1600'){
                        kmServicesTrif.fromKm       = '1201';
                        kmServicesTrif.toKm         = '1600';
                    } else if(strRange == '1601-2000'){
                        kmServicesTrif.fromKm       = '1601';
                        kmServicesTrif.toKm         = '2000';
                    } else if(strRange == '2001-2400'){
                        kmServicesTrif.fromKm       = '2001';
                        kmServicesTrif.toKm         = '2400';
                    } else if(strRange == 'Más de 2400'){
                        kmServicesTrif.fromKm       = '2400';
                        kmServicesTrif.toKm         = '9999';
                    } else {
                        ptpServicesTrifSub.destSite = strRange;
                    }
                    for(String strTarifa : this.listTarifas){
                        if(strTarifa != 'TARIFA T7'){
                            servicesTrifDtlSub                      = new ObjDocEnLinea.servicesTrifDtlSub();
                            servicesTrifDtlSub.slabNo               = obtieneTarifa(strTarifa);
                            /*serviceTrif.serviceId                   = 'SHP-E';
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
                                if(this.mapQuotes.get(strTarifa).EAD__c != 0)
                                    serviceTrif.trifAmount              = this.mapQuotes.get(strTarifa).EAD__c;
                                else serviceTrif.trifAmount             = 1;
                                serviceTrif.trifAmntBase                = 0;
                                serviceTrif.discount                    = 0;
                                listserviceTrif.add(serviceTrif);
                            }
                            if(this.mapQuotes.get(strTarifa).RAD__C != null){
                                serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                serviceTrif.serviceId                   = 'RAD-1';
                                serviceTrif.refServiceId                = 'RAD';
                                if(this.mapQuotes.get(strTarifa).RAD__c != 0)
                                    serviceTrif.trifAmount              = this.mapQuotes.get(strTarifa).RAD__c;
                                else serviceTrif.trifAmount             = 1;
                                serviceTrif.trifAmntBase                = 0;
                                serviceTrif.discount                    = 0;
                                listserviceTrif.add(serviceTrif);
                            }
                            /*if(listptpServTrif.isEmpty()){
                                if(this.mapQuotes.get(strTarifa).ACK__c != null){
                                    ptpServTrif                         = new ObjDocEnLinea.serviceTrif();
                                    ptpServTrif.serviceId               = 'ACK-C';
                                    ptpServTrif.refServiceId            = 'ACK';
                                    ptpServTrif.trifAmount              = this.mapQuotes.get(strTarifa).ACK__c;
                                    ptpServTrif.trifAmntBase            = 0;
                                    ptpServTrif.factor                  = 'NON';
                                    ptpServTrif.factorValue             = 0;
                                    ptpServTrif.servicesCant            = 'G';
                                    listptpServTrif.add(ptpServTrif);
                                }
                            }*/
                            if(mapQuotes.get(strTarifa).Destiny__c != null)
                                ptpServicesTrifSub.destSite    = 'CUL';
                            servicesTrifDtlSub.serviceTrif          = listserviceTrif;
                            listServicesTrifDtlS.add(servicesTrifDtlSub);
                        }
                    }
                    kmServicesTrif.servicesTrifDtl          = listServicesTrifDtlS;
                    listkmServicesTrif.add(kmServicesTrif);
//                    kmServicesTrif1.kmServicesTrif          = listkmServicesTrif;
//                    listkmServicesTrif1.add(kmServicesTrif1);
                }
                servicesTrifDtlList                     = new List<ObjDocEnLinea.servicesTrifDtl>{servicesTrifDtl};
                if(strOrigen == ''){
                    //kmServicesTrif.servicesTrifDtl          = listServicesTrifDtlS;
                    /*listkmServicesTrif                      = new List<ObjDocEnLinea.kmServicesTrifList>{kmServicesTrif};*/
                    kmServicesTrif1.kmServicesTrif          = listkmServicesTrif;
                    listkmServicesTrif1                     = new List<ObjDocEnLinea.kmServicesTrif>{kmServicesTrif1};
                    data.kmConfig                           = listkmServicesTrif1;
                } else {
                    ptpServicesTrifSub.servicesTrifDtl      = listServicesTrifDtlS;
                    ptpServicesTrifSub.serviceTrif          = listptpServTrif;
                    listptpServicesTrifS                    = new list<ObjDocEnLinea.ptpServicesTrifSub>{ptpServicesTrifSub};
                    ptpServicesTrif.ptpServicesTrif         = listptpServicesTrifS;
                    listptpServicesTrif                     = new list<ObjDocEnLinea.ptpServicesTrif>{ptpServicesTrif};
                    data.ptpConfig                          = listptpServicesTrif;
                }
                rq.data                                 = data;
                body.request                            = rq;
                odc.body                                = body;
                header.security                         = sec;
                odc.header                              = header;
                //grab.envioGrabadoPOST(JSON.serialize(odc), endpoint, cotizacion);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Request: ' + JSON.serialize(odc)));
                //if(!System.isScheduled()){
                    /*if(!cotizacion.Electronicas__c){
                        if(grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion))
                            grab.publicarEvento(true,null);
                    }else if(cotizacion.Electronicas__c){
                        if(grab.crearUsuarioWeb(cotizacion)){
                            if(grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion))
                                grab.publicarEvento(true,null);
                        }
                    }
                    /*else
                        grab.publicarEvento(false,'No se pudo realizar el grabado');
                }
                else
                    grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion);*/
            }else {
                strMensajeError     = 'Imposible continuar, datos insuficientes.';
                blnMostrarMensaje   = true;
            }

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
        else if(tarifa == 'TARIFA T7-V')
            return 'T7V';
        else if(tarifa == 'TARIFA T7-P')
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
        return[SELECT Id, Rango_KM__c, Destiny__c, ACK__c, RAD__c, EAD__c, SBQQ__CustomerPrice__c, SBQQ__Discount__c,Tarifa__c FROM SBQQ__QuoteLine__c WHERE SBQQ__QUOTE__C = : Id];
    }
    public class Wrapper{
        public List<SBQQ__QuoteLine__c> listQuoteItem   {get; set;}
        public Wrapper(){
            this.listQuoteItem  = new List<SBQQ__QuoteLine__c>();
        }
    }
}
