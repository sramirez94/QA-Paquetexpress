/*Created by: Salvador Ramírez López*/
public class GrabadoDocEnLinea {
    public Wrapper wp                                                           {get;set;}
    public Id owner                                                             {get;set;}
    public Id Id                                                                {get;set;}
    public SBQQ__Quote__c cas                                                   {get;set;}
    public string tipoDocumentacion                                             {get;set;}
    public Id cuenta                                                            {get;set;}
    public string idSipWeb                                                      {get;set;}
    public date fechaVigencia                                                   {get;set;}
    public Boolean grabadoUnico                                                 {get;set;}
    public Boolean confirmacionGrabadoUnico                                     {get;set;}
    public Boolean blnMostrarMensaje                                            {get;set;}
    public Boolean blnRAD                                                       {get;set;}
    public Boolean blnEAD                                                       {get;set;}
    public Boolean blnACK                                                       {get;set;}
    public Boolean blnSEG                                                       {get;set;}
    public Boolean blnZP                                                        {get;set;}
    public Boolean blnClienteNuevo                                              {get;set;}
    public Boolean ServiciosEspeciales                                          {get;set;}
    public Boolean blnTarifasExp                                                {get;set;}
    public Boolean blnTieneTarifasRegistradas                                   {get;set;}
    public Boolean blnT7ZP                                                      {get;set;}
    public Boolean blnCostosFijos                                               {get;set;}
    public Boolean blnCostoBaseGMP                                              {get;set;}
    public Boolean blnByDelivery                                                {get;set;}
    public Boolean blnByDimension                                               {get;set;}
    public Boolean blnPuedeGrabar												{get;set;}
    public String aprvUser                                                      {get;set;}
    public String orgnSite                                                      {get;set;}
    public String destSite                                                      {get;set;}
    public String factor                                                        {get;set;}
    public String serviceId                                                     {get;set;}
    public String refrServiceId                                                 {get;set;}
    public String trifType                                                      {get;set;}
    public String pieceMulti                                                    {get;set;}
    public String strMensajeError                                               {get;set;}
    public List<String> listTarifas                                             {get;set;}
    public List<String> listTarifasExp                                          {get;set;}
    public List<TempleateLine__c> listPlantillaLineItems                        {get;set;}
    public List<String> listRangeDestiny                                        {get;set;}
    public List<String> listRanges                                              {get;set;}
    public List<String> listSS                                                  {get;set;}
    public List<Decimal> listDecTarifas                                         {get;set;}
    public List<Decimal> listBloquesExp                                         {get;set;}
    public List<String> listTarifasCotizacion                                   {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes               {get;set;}
    public Map<Decimal, Map<String, SBQQ__QuoteLine__c>> mapdecQuotes           {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapQuotesT7ZP                        {get;set;}
    public Map<String, Map<String, TempleateLine__c>> mapTLines                 {get;set;}
    public Map<Decimal, Map<String, TempleateLine__c>> mapdecTLines             {get;set;}
    public Map<Decimal, Map<String, Map<String, TempleateLine__c>>> mapTLinesExp{get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesExp            {get;set;}
    public Map<String, Decimal> mapAcuse                                        {get;set;}
    public Map<String, Decimal> mapZonaPlus                                     {get;set;}
    public Map<String, String> mapTarifasRegistradas                            {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapPlantillas           {get;set;}
    public Map<Decimal, Map<String, SBQQ__QuoteLine__c>> mapTarifas             {get;set;}
    public Map<String, Map<String, PAQ_SpecialService__c>> mapRanges            {get;set;}
    public Map<String, String> mapRangeByDest                                   {get;set;}
    public Map<Decimal, Decimal> mapGuide                                       {get;set;}
    public Map<String,  Map<String, map<String, Decimal>>> mapBlocksServ        {get;set;}
    public Map<String, Block> mapBlocks                                         {get;set;}
    public Templeate__c objtempleate                                            {get;set;}
    public Map<Decimal, Map<String, Decimal>> mapRangesByBlock                  {get;set;}
    public Map<String, Block> mapService                                        {get;set;}
    public map<String, map<String, Decimal>> mapBlockAdic                       {get;set;}
    public Map<String, QuoteWP>  mapTotalByRange                                {get;set;}
    public GrabadoDocEnLinea (ApexPages.StandardController controller){
        this.aprvUser                       = '';
        this.destSite                       = '';
        this.orgnSite                       = '';
        this.factor                         = '';
        this.serviceId                      = '';
        this.refrServiceId                  = '';
        this.trifType                       = '';
        this.pieceMulti                     = '';
        this.strMensajeError                = '';
        this.blnMostrarMensaje              = false;
        this.blnRAD                         = false;
        this.blnEAD                         = false;
        this.blnACK                         = false;
        this.blnSEG                         = false;
        this.blnZP                          = false;
        this.ServiciosEspeciales            = false;
        this.blnTarifasExp                  = false;
        this.blnTieneTarifasRegistradas     = false;
        this.blnT7ZP                        = false;
        this.blnClienteNuevo                = false;
        this.blnCostosFijos                 = false;
        this.blnCostoBaseGMP                = false;
        this.blnByDelivery                  = false;
        this.blnByDimension                 = false;
        this.blnPuedeGrabar					= false;
        this.listTarifas                    = new List<String>{'TARIFA SOBRE', 'TARIFA T0', 'TARIFA T1', 'TARIFA T2', 'TARIFA T3', 'TARIFA T4', 'TARIFA T5', 'TARIFA T6', 'TARIFA T7-V', 'TARIFA T7-P'};
        this.listTarifasExp                 = new List<String>();
        this.listRangeDestiny               = new List<String>();
        this.listSS                         = new List<String>();
        this.listDecTarifas                 = new List<Decimal>();
        this.listPlantillaLineItems         = new List<TempleateLine__c>();
        this.listRanges                     = new List<String>{'0-400', '401-800', '801-1200', '1201-1600', '1601-2000', '2001-2400', 'Más de 2400'};
        this.listBloquesExp                 = new List<Decimal>();
        this.listTarifasCotizacion          = new List<String>();
        this.wp                             = new Wrapper();
        this.mapQuotes                      = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapdecQuotes                   = new Map<Decimal, Map<String, SBQQ__QuoteLine__c>>();
        this.mapPlantillas                  = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesT7ZP                  = new Map<String, SBQQ__QuoteLine__c>();
        this.mapQuotesExp                   = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapAcuse                       = new Map<String,Decimal>();
        this.mapTarifasRegistradas          = new Map<String, String>();
        this.mapRanges                      = new Map<String, Map<String, PAQ_SpecialService__c>>();
        this.mapTLines                      = new Map<String, Map<String, TempleateLine__c>>();
        this.mapdecTLines                   = new Map<Decimal, Map<String, TempleateLine__c>>();
        this.mapTLinesExp                   = new Map<Decimal, Map<String, Map<String, TempleateLine__c>>>();
        this.mapTarifas                     = new Map<Decimal, Map<String, SBQQ__QuoteLine__c>>();
        this.mapZonaPlus                    = new Map<String, Decimal>();
        this.mapRangeByDest                 = new Map<String, String>();
        this.mapGuide                       = new Map<Decimal, Decimal>();
        this.mapBlocksServ                  = new Map<String, Map<String, map<String, Decimal>>>();
        this.mapBlocks                      = new Map<String, Block>();
        this.mapRangesByBlock               = new Map<Decimal, Map<String, Decimal>>();
        this.mapService                     = new Map<String, Block>{
                                                    'ADD' => new Block('ADD',0,0,0)
                                                    , 'ACK' => new Block('ACK',0,0,0)
                                                    , 'ZP' => new Block('ZP',0,0,0)};
        this.mapBlockAdic                   = new map<String, map<String, Decimal>>();
        this.mapTotalByRange                = new Map<String, QuoteWP>();
        try{
            this.cas                        = (SBQQ__Quote__c) controller.getRecord();
            this.Id                         = cas.Id;
            idSipWeb                        = cas.SBQQ__Account__r.Id_SIpWeb__c;
            owner                           = cas.OwnerId;
            cuenta                          = cas.SBQQ__Account__c;
            tipoDocumentacion               = cas.Tipo_de_documentacion__c;
            fechaVigencia                   = cas.Flujo_del_mes__c;
            grabadoUnico                    = cas.Descuento_prepago_unico__c;
            confirmacionGrabadoUnico        = cas.Confirmacion_de_Grabado_Unico__c;
            if(cas.TipoCotizacion__c == 'byDelivery'){
                this.blnByDelivery          = true;
                this.blnByDimension         = false;
            } else {
                this.blnByDimension         = true;
                this.blnByDelivery          = false;
            }
            for(Tarifario_general_terrestre__c objTarifarioT: queryTarifarioTFull())
                if(!wp.mapTarifarioT.containsKey(objTarifarioT.Tarifa__c))
                    wp.mapTarifarioT.put(objTarifarioT.Tarifa__c, new Map<String, Tarifario_general_terrestre__c>{objTarifarioT.RangoKM__c => objTarifarioT});
                else if (!wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).containsKey(objTarifarioT.RangoKM__c))
                    wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).put(objTarifarioT.RangoKM__c, objTarifarioT);
            if(ObtieneInfoResponse(cas))
                System.debug('ejecutó correctamente');
            else System.debug('error al obtener response');
            //el bloque del if se comenta para que no ejecute nada en el constructor una vez que se pase a revisión
        }catch (Exception ex){
            System.debug('Error en el constructor ' +ex.getLineNumber()+' '+EX.getMessage());
            strMensajeError = 'Error al iniciar. Contacte a un consultor de salesforce';
        }
    }
    public Boolean ObtieneInfoResponse(SBQQ__Quote__c cotizacion){
        Boolean resultado   = false;
        strMensajeError     = '';
        blnMostrarMensaje   = false;
        Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
        GrabadoBtnController gr = new GrabadoBtnController(sc);
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
                ddP.clntId = cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
                req.data = ddP;
                bdp.request = req;
                rdp.body = bdp;
                if(ObtieneInfoSipweb(JSON.serialize(rdp), endpoint, cotizacion)){
                    System.debug('obtuvo info sipweb');
                }
                //iniciarGrabado(cotizacion);
                resultado = true;
            }
        }catch (Exception ex){
            System.debug('Error al obtener response '+ex.getLineNumber()+' '+EX.getMessage());
            gr.publicarEvento(false, 'Error al obtener response: ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
        return resultado;
    }
    public Boolean ObtieneInfoSipweb(String body, String endpoint,SBQQ__Quote__c cotizacion){
        Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
        GrabadoBtnController gr = new GrabadoBtnController(sc);
        try{
            HttpResponse res = gr.consultaAPIPOST(body,endpoint);
            String respuesta = res.getBody().replace('time','timeR');
            return ProcesaResponse(res,cotizacion);
        }catch (Exception ex){
            System.debug('ObtieneInfoSipweb: '+ex.getLineNumber()+' '+ex.getMessage());
            gr.publicarEvento(false, 'Error al obtener info sipweb');
            return false;
        }
    }
    public Boolean ProcesaResponse(HTTPResponse res,SBQQ__Quote__c cotizacion){
        Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
        GrabadoBtnController gr = new GrabadoBtnController(sc);
        try{
            String Respuesta    = res.getBody();
            String strRange     = '';
            String strTarifas   = '';
            String strDest      = '';
            User u = [SELECT Id_Sipweb__c, FederationIdentifier FROM User WHERE Id=:System.UserInfo.getUserId()];
            if(u != null){
                if(u.Id_Sipweb__c != null)
                    this.aprvUser = u.Id_Sipweb__c;
                else if(u.FederationIdentifier != null)
                    this.aprvUser = u.FederationIdentifier;
                this.blnPuedeGrabar = true;
            } else {
                gr.publicarEvento(false, 'Su usuario no cuenta con un id de sipweb o clave de federación. Consultar con el área de TI para configurar debidamente su usuario.');
                this.blnPuedeGrabar = false;
                return false;
            }
            respuesta = respuesta.replace('time', 'timeR');
            ObjDocEnLinea.documentacionRemota rg = (ObjDocEnLinea.documentacionRemota)JSON.deserialize(respuesta, ObjDocEnLinea.documentacionRemota.class);
            /*if(rg.body.response.data.kmConfig != null){
                for(Integer x = 0; x < rg.body.response.data.kmConfig[0].kmServicesTrif.size();x++){
                    strRange = '';
                    strTarifas = '';
                    strRange = rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + '-' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm;
                    for(Integer i = 0; i < rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl.size(); i ++){
                        if(!strTarifas.contains(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo)){
                            if(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo == 'S')
                                strTarifas += ';TARIFA SOBRE';
                            else strTarifas +=';TARIFA '+rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo;
                            if(!this.blnTieneTarifasRegistradas)
                                this.blnTieneTarifasRegistradas = true;
                        }
                    }
                    mapTarifasRegistradas.put(strRange, strTarifas);
                }
            }
            if(rg.body.response.data.ptpConfig != null){
                for(Integer x = 0; x < rg.body.response.data.ptpConfig[0].ptpServicesTrif.size(); x ++){
                    strDest     = '';
                    strTarifas  = '';
                    strDest     = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite;
                    for(Integer i = 0; i < rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl.size(); i ++){
                        if(!strTarifas.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo)){
                            if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo == 'S')
                                strTarifas += ';TARIFA SOBRE';
                            else strTarifas += ';TARIFA ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo;
                            if(!this.blnTieneTarifasRegistradas)
                                this.blnTieneTarifasRegistradas = true;
                        }
                    }
                    mapTarifasRegistradas.put(strDest, strTarifas);
                }
            }*/
            if(rg.body.response.data != null && rg.body.response.data.ptpConfig == null && rg.body.response.data.kmConfig == null)
                this.blnClienteNuevo = true;
            else this.listTarifas = new List<String>();
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tarifas: ' + mapTarifasRegistradas));
            /*if(rg.body.response.data != null){
                this.aprvUser   = rg.body.response.data.aprvUser;
            	this.trifType   = rg.body.response.data.trifType;
            	this.pieceMulti = rg.body.response.data.pieceMulti;
            }*/            
            return true;
        }catch (Exception ex){
            System.debug('ProcesaResponse ' + ex.getLineNumber() + ' ' + ex.getMessage());
            gr.publicarEvento(false, 'Error al procesar información obtenida de sipweb.');
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
        Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
        GrabadoBtnController gr = new GrabadoBtnController(sc);
        try{
            blnMostrarMensaje   = false;
            strMensajeError     = '';
            if((cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c))|| Test.isRunningTest()){
                if(cotizacion.SBQQ__Status__c=='Approved'){
                    if(cotizacion.SBQQ__Opportunity2__r.StageName=='Cerrada/Ganada' || Test.isRunningTest()){
                        ValidacionDocLinea(cotizacion);
                    } else {
                        gr.publicarEvento(false, 'Imposible continuar, la oportunidad debe tener un status "Cerrada/Ganada');
                    }
                }else{
                    gr.publicarEvento(false, 'Imposible continuar, la cotización no se encuentra aprobada');
                }
            } else {
                gr.publicarEvento(false, 'Imposible continuar, la cuenta no tiene un ID de sipweb');
            }
        }catch(Exception ex){
            System.debug('IniciarGrabado: '+ex.getLineNumber()+' '+ex.getMessage());
            gr.publicarEvento(false, 'Error al iniciar grabado de tarifas. ' +ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public void ValidacionDocLinea(SBQQ__Quote__c cotizacion){
        Apexpages.StandardController scr    = new Apexpages.StandardController(cotizacion);
        GrabadoBtnController gr             = new GrabadoBtnController(scr);
        String strOrigen                    = '';
        blnMostrarMensaje                   = false;
        Boolean blnRango                    = false;   
        Boolean blnDest                     = false;
        strMensajeError                     = '';
        String endpoint                     = Label.Grabar_DocLinea;
        String strRangos                    = '';
        Decimal decEADZP                    = 0;
        Map<String, String> mapSSOption     = new Map<String, String>();
        try{
            if(cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c)|| Test.isRunningTest()){
                this.wp.listQuoteItem                                           = queryquoteitem(cotizacion.id);
                this.objtempleate                                               = queryTempleate(cotizacion.id);
                wp.mapCS                                                        = queryCustomSetting([SELECT Id FROM Profile Where Name = 'System Administrator' OR Name = 'Administrador del sistema'].Id);
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
                ObjDocEnLinea.serviceTrifCbe serviceTrifCbe                     = new ObjDocEnLinea.serviceTrifCbe();
                ObjDocEnLinea.serviceTrif otherServiceTrif                      = new ObjDocEnLinea.serviceTrif();
                List<ObjDocEnLinea.serviceTrif> listserviceTrif                 = new List<ObjDocEnLinea.serviceTrif>();
                list<ObjDocEnLinea.kmServicesTrifList> listkmServicesTrif       = new List<ObjDocEnLinea.kmServicesTrifList>();
                List<ObjDocEnLinea.servicesTrifDtlSub> listServicesTrifDtlS     = new List<ObjDocEnLinea.servicesTrifDtlSub>();
                List<ObjDocEnLinea.kmServicesTrif> listkmServicesTrif1          = new List<ObjDocEnLinea.kmServicesTrif>();
                List<ObjDocEnLinea.servicesTrifDtl> servicesTrifDtlList         = new List<ObjDocEnLinea.servicesTrifDtl>();
                List<ObjDocEnLinea.ptpServicesTrifSub> listptpServicesTrifS     = new List<ObjDocEnLinea.ptpServicesTrifSub>();
                List<ObjDocEnLinea.ptpServicesTrif> listptpServicesTrif         = new List<ObjDocEnLinea.ptpServicesTrif>();
                List<ObjDocEnLinea.serviceTrif> listptpServTrif                 = new List<ObjDocEnLinea.serviceTrif>();
                List<ObjDocEnLinea.serviceTrifCbe> listserviceTrifCbe           = new List<ObjDocEnLinea.serviceTrifCbe>();
                List<ObjDocEnLinea.serviceTrif> listotherServiceTrif            = new List<ObjDocEnLinea.serviceTrif>();
                if(cotizacion.Plaza__c != null)
                    strOrigen   = cotizacion.Plaza__c;
                //30/12/2020 Salvador: Header y data
                sec.user    = 'USERSALESFORCE';
                sec.token   = '325746796331582000000';
                //30/12/2020 Salvador: Comienza creación del body
                data.quotation  = cotizacion.Name; //30/12/2020 Salvador: Nombre de la cotización, ej: Q-0245
                data.clntId     = cotizacion.SBQQ__Account__r.Id_SIpWeb__c; //30/12/2020 Salvador: Id de sipweb del cliente
                data.aprvUser   = this.aprvUser;
                if(cotizacion.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'){
                    data.trifType           = 'A';
                    this.blnCostosFijos     = true;
                    this.blnCostoBaseGMP    = false;
                } else {
                    data.trifType           = 'C';
                    this.blnCostoBaseGMP    = true;
                    this.blnCostosFijos     = false;
                }
                if(this.pieceMulti != '')
                    data.pieceMulti = this.pieceMulti;
                else {
                    if(cotizacion.Modelo_de_tarifas__c == 'Guía multipieza: Por Destinos / Por rangos de km')
                        data.pieceMulti     = 'K';
                }
                for(TempleateLine__c line : queryTempleateLine(objtempleate.Id)){
                    if(String.isNotBlank(line.Destiny__c))
                        line.Rango_KM__c = line.Destiny__c;
                    this.listPlantillaLineItems.add(line);          
                }
                if(this.blnCostosFijos){
                    for(TempleateLine__c line : this.listPlantillaLineItems){
                        String strRangeDest = '';
                        if(!line.Zona_Plus__c){
                            if(line.Tarifa__c != 'SEG-DS' && line.Tarifa__c != 'SEG-2D'){
                                if(!this.listTarifas.contains(line.Tarifa__c))
                                    this.listTarifas.add(line.Tarifa__c);
                                if(!this.mapTLines.containsKey(line.Tarifa__c)){
                                    this.mapTLines.put(line.Tarifa__c, new Map<String, TempleateLine__c>());
                                }
                                if(!this.listDecTarifas.contains(obtieneNumeroTarifa(line.Tarifa__c)))
                                    this.listDecTarifas.add(obtieneNumeroTarifa(line.Tarifa__c));
                                if(!this.mapdecTLines.containsKey(obtieneNumeroTarifa(line.Tarifa__c)))
                                    this.mapdecTLines.put(obtieneNumeroTarifa(line.Tarifa__c), new Map<String, TempleateLine__c>());
                                if(!this.listTarifasCotizacion.contains(line.Tarifa__c))
                                    this.listTarifasCotizacion.add(line.Tarifa__c);
                            } else {
                                if(!this.listTarifasExp.contains(line.Tarifa__c))
                                    this.listTarifasExp.add(line.Tarifa__c);
                                if(!this.mapTLinesExp.containsKey(line.Weight__c)){
                                    this.mapTLinesExp.put(line.Weight__c, new Map<String, Map<String, TempleateLine__c>>());
                                    this.listBloquesExp.add(line.Weight__c);
                                }
                                if(!this.mapTLinesExp.get(line.Weight__c).containsKey(line.Tarifa__c)){
                                    this.mapTLinesExp.get(line.Weight__c).put(line.Tarifa__c, new Map<String, TempleateLine__c>());
                                }
                                this.blnTarifasExp = true;
                            }
                            if(line.Destiny__c != null){
                                if(!this.mapRangeByDest.containsKey(line.Destiny__c))
                                    this.mapRangeByDest.put(line.Destiny__c, line.Rango_KM__c);
                                strRangeDest = line.Destiny__c;
                                if(!this.mapAcuse.containsKey(line.Destiny__c))
                                    this.mapAcuse.put(line.Destiny__c, line.ACK__c);
                                if(line.Tarifa__c == 'SEG-DS' || line.Tarifa__c == 'SEG-2D'){
                                    if(!this.mapTLinesExp.get(line.Weight__c).get(line.Tarifa__C).containsKey(line.Destiny__c))
                                        this.mapTLinesExp.get(line.Weight__c).get(line.Tarifa__c).put(line.Destiny__c, line);
                                } else {
                                    if(!this.mapTLines.get(line.Tarifa__c).containsKey(line.Destiny__c))
                                        this.mapTLines.get(line.Tarifa__c).put(line.Destiny__c, line);
                                }
                            } else {
                                strRangeDest = line.Rango_KM__c;
                                if(!this.mapAcuse.containsKey(line.Rango_KM__c))
                                    this.mapAcuse.put(line.Rango_KM__c, line.ACK__c);
                                if(line.Tarifa__c == 'SEG-DS' || line.Tarifa__c == 'SEG-2D'){
                                    if(!this.mapTLinesExp.get(line.Weight__c).get(line.Tarifa__C).containsKey(line.Rango_KM__c))
                                        this.mapTLinesExp.get(line.Weight__c).get(line.Tarifa__c).put(line.Rango_KM__c, line);
                                }else{
                                    if(!this.mapTLines.get(line.Tarifa__C).containsKey(line.Rango_KM__c))
                                        this.mapTLines.get(line.Tarifa__c).put(line.Rango_KM__c, line);
                                }
                            }
                            if(line.Tarifa__c != 'SEG-DS' && line.Tarifa__c != 'SEG-2D'){
                                if(!this.mapdecTLines.get(obtieneNumeroTarifa(line.Tarifa__c)).containsKey(strRangeDest))
                                    this.mapdecTLines.get(obtieneNumeroTarifa(line.Tarifa__c)).put(strRangeDest, line);
                            }
                            if(!this.wp.mapACKExp.containsKey(strRangeDest)){
                                this.wp.mapACKExp.put(strRangeDest, line.ACKES__c);
                            }
                        } else {
                            if(line.Destiny__c != null)
                                strRangeDest = line.Destiny__c;
                            else strRangeDest = line.Rango_KM__c;
                            if(!this.mapZonaPlus.containsKey(strRangeDest))
                                this.mapZonaPlus.put(strRangeDest, line.EAD__c);
                        }
                    }
                }
                for(SBQQ__QuoteLine__c cot:this.wp.listQuoteItem){
                    String strRangeDest = '';
                    if(cot.Tarifa__c == 'TARIFA T7' && cot.ZonaPlus__c && cot.SBQQ__Description__c == 'Propuesta'){
                        strRangeDest = '';
                        if(cot.Destiny__c != null)
                            strRangeDest = cot.Destiny__c;
                        else strRangeDest = cot.Rango_KM__c;
                        if(!this.mapQuotesT7ZP.containsKey(strRangeDest))
                            this.mapQuotesT7ZP.put(strRangeDest, cot);
                        this.blnT7ZP = true;
                    } else if(!cot.ZonaPlus__c) {
                        if(cot.Tarifa__c != 'SEG-DS' && cot.Tarifa__c != 'SEG-2D'){
                            if(this.blnCostosFijos){
                                if(!this.listTarifas.contains(cot.Tarifa__c))
                                    this.listTarifas.add(cot.Tarifa__c);
                                if(this.blnByDelivery && cot.Tarifa__c == 'TARIFA T7' && !this.listTarifas.contains('TARIFA T7'))
                                    this.listTarifas.add(cot.Tarifa__c);
                            }
                            if(!this.mapQuotes.containsKey(cot.Tarifa__c)){
                                this.mapQuotes.put(cot.Tarifa__c, new map<String, SBQQ__QuoteLine__c>());
                            }
                            strRangeDest = '';
                            if(cot.Destiny__c != null){
                                if(cot.Destiny__c.contains('('))
                                    strRangeDest = cot.Destiny__c.replace(cot.Rango_KM__c, '').replace(' (', '').replace(')', '');
                                else strRangeDest = cot.Destiny__c;
                            } else strRangeDest = cot.Rango_KM__c;
                            if(this.blnCostosFijos){
                                if(!this.mapQuotes.get(cot.Tarifa__c).containsKey(strRangeDest))
                                    this.mapQuotes.get(cot.Tarifa__c).put(strRangeDest, cot);
                                if(!this.mapTarifas.containsKey(obtieneNumeroTarifa(cot.Tarifa__c)))
                                    this.mapTarifas.put(obtieneNumeroTarifa(cot.Tarifa__c), new Map<String, SBQQ__QuoteLine__c>());
                                if(!this.mapTarifas.get(obtieneNumeroTarifa(cot.Tarifa__c)).containsKey(strRangeDest))
                                    this.mapTarifas.get(obtieneNumeroTarifa(cot.Tarifa__c)).put(strRangeDest, cot);
                                if(!this.listDecTarifas.contains(obtieneNumeroTarifa(cot.Tarifa__c)))
                                    this.listDecTarifas.add(obtieneNumeroTarifa(cot.Tarifa__c));
                            }
                            if(!mapRangesByBlock.containsKey(cot.PackWeightAVG__c))
                                mapRangesByBlock.put(cot.PackWeightAVG__c, new Map<String, Decimal>{strRangeDest => cot.FLETE__c});
                            else if(!mapRangesByBlock.get(cot.PackWeightAVG__c).containsKey(strRangeDest))
                                mapRangesByBlock.get(cot.PackWeightAVG__c).put(strRangeDest, cot.FLETE__c);
                            if(!this.mapService.get('ADD').mapRanges.containsKey(strRangeDest))
                                this.mapService.get('ADD').mapRanges.put(strRangeDest, cot.KG_ADICIONAL__c);
            
                            if(!this.mapService.get('ACK').mapRanges.containsKey(strRangeDest))
                                this.mapService.get('ACK').mapRanges.put(strRangeDest, cot.ACK__c);
            
                            if(cot.ZonaPlus__c)
                                this.mapService.get('ZP').mapRanges.put(strRangeDest, cot.EAD__c);

                        } else {
                            if(!this.listTarifasExp.contains(cot.Tarifa__c))
                                this.listTarifasExp.add(cot.Tarifa__c);
                            if(!this.mapQuotesExp.containsKey(cot.Tarifa__c)){
                                this.mapQuotesExp.put(cot.Tarifa__c, new Map<String, SBQQ__QuoteLine__c>());
                            }
                            this.blnTarifasExp = true;
                        }
                        if(cot.Destiny__c != null){
                            if(this.blnCostoBaseGMP){
                                if(!this.listRangeDestiny.contains(cot.Destiny__c.replace(cot.Rango_KM__c, '').replace(' (', '').replace(')', ''))){
                                    String Destino = '';
                                    if(cot.Destiny__c.contains('('))
                                        Destino = cot.Destiny__c.replace(cot.Rango_KM__c, '').replace(' (', '').replace(')', '');
                                    else Destino = cot.Destiny__c;
                                    this.listRangeDestiny.add(Destino);
                                }
                            } else {
                                if(!this.listRangeDestiny.contains(cot.Destiny__c)){
                                    this.listRangeDestiny.add(cot.Destiny__c);
                                }
                            }
                            if(!this.mapAcuse.containsKey(cot.Destiny__c))
                                this.mapAcuse.put(cot.Destiny__c, cot.ACK__c);
                            if(cot.Tarifa__c == 'SEG-DS' || cot.Tarifa__c == 'SEG-2D'){
                                if(!this.mapQuotesExp.get(cot.Tarifa__C).containsKey(cot.Destiny__c))
                                    this.mapQuotesExp.get(cot.Tarifa__c).put(cot.Destiny__c, cot);
                            }
                        } else {
                            if(!this.listRangeDestiny.contains(cot.Rango_KM__c))
                                this.listRangeDestiny.add(cot.Rango_KM__c);
                            if(!this.mapAcuse.containsKey(cot.Rango_KM__c))
                                this.mapAcuse.put(cot.Rango_KM__c, cot.ACK__c);
                            if(cot.Tarifa__c == 'SEG-DS' || cot.Tarifa__c == 'SEG-2D'){
                                if(!this.mapQuotesExp.get(cot.Tarifa__C).containsKey(cot.Rango_KM__c))
                                    this.mapQuotesExp.get(cot.Tarifa__c).put(cot.Rango_KM__c, cot);
                            }
                        }
                    } else if ((cot.Tarifa__c == 'TARIFA SOBRE' || cot.Tarifa__c == 'TARIFA T0' || cot.Tarifa__c == 'TARIFA T1' || cot.Tarifa__c == 'TARIFA T2' || cot.Tarifa__c == 'TARIFA T3' || cot.Tarifa__c == 'TARIFA T4' || cot.Tarifa__c == 'TARIFA T5'
                                || cot.Tarifa__c == 'TARIFA T6') && (cot.ZonaPlus__c)){
                        if(cot.Destiny__c != null){
                            if(this.blnCostoBaseGMP){
                                String Destino = '';
                                if(cot.Destiny__c.contains('('))
                                    Destino = cot.Destiny__c.replace(cot.Rango_KM__c, '').replace(' (', '').replace(')', '');
                                else Destino = cot.Destiny__c;
                                this.mapService.get('ZP').mapRanges.put(Destino, cot.EAD__c);
                            }
                        } else {
                            this.mapService.get('ZP').mapRanges.put(cot.Rango_KM__c, cot.EAD__c);
                        }
                    }
                    if(cot.SBQQ__Quantity__c != 0 && cot.ZonaPlus__c)
                        this.blnZP = true;
                    if(this.blnCostoBaseGMP){
                        if(!this.mapGuide.containsKey(cot.PackWeightAVG__c))
                            this.mapGuide.put(cot.PackWeightAVG__c, cot.PackVolAVG__c);
                    }
                }
                if(this.blnCostosFijos){
                    if(this.listTarifasCotizacion.size() == 0 && this.listTarifasExp.size() > 0){
                        this.listTarifas.clear();
                        this.wp.blnSoloTarifasExp = true;
                    }
                }
                if(this.blnCostoBaseGMP){
                    Integer blockCounter = 1;
                    Decimal decRespaldoFlete = 0;
                    Map<String, Map<String, Decimal>> mapRespaldo = new Map<String, Map<String, Decimal>>();
                    for(Decimal decW : this.mapGuide.keySet()){
                        this.mapBlocks.put('BLOQUE '+ blockCounter, new Block('BLOQUE '+ blockCounter, decW, this.mapGuide.get(decW), this.mapGuide.get(decW) * 200) );
                        this.mapBlocks.get('BLOQUE '+ blockCounter).mapRanges = mapRangesByBlock.get(decW);
                        mapRespaldo.put('BLOQUE ' + blockCounter, new Map<String, Decimal>());
                        for(String keyRange: this.listRangeDestiny){
                            Decimal decFlete = 0;
                            if(!this.mapBlocksServ.containsKey('BLOQUE ' + blockCounter)) {
                                this.mapBlocksServ.put('BLOQUE ' + blockCounter, new map<String, map<String, Decimal>>());
                                this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('FLT', new map<String, Decimal>());
                                this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('RAD', new map<String, Decimal>());
                                this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('EAD', new map<String, Decimal>());
                                this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('ADD', new Map<String, Decimal>());
                            }
                            decRespaldoFlete = mapRangesByBlock.get(decW).get(keyRange);
                            mapRespaldo.get('BLOQUE ' + blockCounter).put(keyRange, mapRangesByBlock.get(decW).get(keyRange));
                            if(blockCounter > 1){
                                if(this.blnRAD && this.blnEAD)
                                    decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange)) / 1.22;
                                else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD))
                                    decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange)) / 1.11;
                                else if(!this.blnRAD && !this.blnEAD)
                                    decFlete = (mapRangesByBlock.get(decW).get(keyRange) - mapRespaldo.get('BLOQUE ' + (blockCounter - 1)).get(keyRange));
                            } else {
                                if(this.blnRAD && this.blnEAD)
                                    decFlete = mapRangesByBlock.get(decW).get(keyRange) / 1.22;
                                else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD))
                                    decFlete = mapRangesByBlock.get(decW).get(keyRange) / 1.11;
                                else if(!this.blnRAD && !this.blnEAD)
                                    decFlete = mapRangesByBlock.get(decW).get(keyRange);
                            }
                                
                            
                            if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('FLT').containsKey(keyRange)){
                                this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('FLT').put(keyRange, (decFlete));
                            }
                            if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('RAD').containsKey(keyRange)){
                                this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('RAD').put(keyRange, (decFlete * 0.11));
                            }
                            if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('EAD').containsKey(keyRange)){
                                this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('EAD').put(keyRange, (decFlete * 0.11));
                            }
                            if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('ADD').containsKey(keyRange)){
                                Decimal decTotalAdic = 0;
                                if(this.blnRAD)
                                    decTotalAdic += this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('RAD').get(keyRange);
                                if(this.blnEAD)
                                    decTotalAdic += this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('EAD').get(keyRange);
                                decTotalAdic += decFlete;
                                this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('ADD').put(keyRange, decTotalAdic);
                            }
                        }
                        blockCounter++;
            
                    }
                    this.mapBlockAdic.put('ADD', new map<String, Decimal>());
                    this.mapBlockAdic.put('EAD', new map<String, Decimal>());
                    this.mapBlockAdic.put('RAD', new map<String, Decimal>());
                    this.mapBlockAdic.put('TOT', new map<String, Decimal>());
                    
                    for(String keyRange: this.listRangeDestiny){
                        this.mapTotalByRange.put(keyRange, new QuoteWP());
                        Decimal decFlete = 0;
                        if(!this.mapBlockAdic.get('ADD').containsKey(keyRange)){
                            if(this.blnRAD && this.blnEAD){
                                decFlete = (this.mapService.get('ADD').mapRanges.get(keyRange) / 1.22);
                            }else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD)){
                                decFlete = (this.mapService.get('ADD').mapRanges.get(keyRange) / 1.11);
                            } else if(!this.blnRAD && !this.blnEAD){
                                decFlete = (this.mapService.get('ADD').mapRanges.get(keyRange));
                            }
                            this.mapBlockAdic.get('ADD').put(keyRange, decFlete);
                            this.mapBlockAdic.get('EAD').put(keyRange, decFlete * 0.11);
                            this.mapBlockAdic.get('RAD').put(keyRange, decFlete * 0.11);
                            if(this.blnRAD && this.blnEAD){
                                this.mapBlockAdic.get('TOT').put(keyRange, (this.mapBlockAdic.get('ADD').get(keyRange) + this.mapBlockAdic.get('RAD').get(keyRange) + this.mapBlockAdic.get('EAD').get(keyRange)));
                            }else if((this.blnEAD && !this.blnRAD) || (!this.blnEAD && this.blnRAD)){
                                this.mapBlockAdic.get('TOT').put(keyRange, (this.mapBlockAdic.get('ADD').get(keyRange) + this.mapBlockAdic.get('RAD').get(keyRange)));
                            } else if(!this.blnRAD && !this.blnEAD){
                                this.mapBlockAdic.get('TOT').put(keyRange, (this.mapBlockAdic.get('ADD').get(keyRange)));
                            }
                        }
                    }
                }
                if(this.blnCostosFijos){
                    this.mapRanges = new map<String, Map<String, PAQ_SpecialService__c>>();
                    mapSSOption = getPicklistValues('PAQ_SpecialService__c', 'Option__c');
                    for(PAQ_SpecialService__c itemSS : querySS(Cotizacion.id)){
                        if(String.isNotBlank(itemSS.Destiny__c))
                            itemSS.RangoKM__c = itemSS.Destiny__c;
                        this.ServiciosEspeciales = true;
                        itemSS.Option__c = mapSSOption.get(itemSS.Option__c);
                        SS service = new SS(itemSS.MainDesinations__c, itemSS.Potencial__c);
                        service.mapRanges.put(itemSS.RangoKM__c, itemSS);
                        if(!this.wp.mapSS.containsKey(itemSS.Name))
                            this.wp.mapSS.put(itemSS.Name, service);
                        else
                            this.wp.mapSS.get(itemSS.Name).mapRanges.put(itemSS.RangoKM__c, itemSS);
                        if(!this.listSS.contains(itemSS.Name))
                            this.listSS.add(itemSS.Name);
                    }
            
                    for(String strName : this.listSS){
                        if(this.wp.mapSS.containsKey(strName)){
                            for(String keyRange : listRangeDestiny){
                                if( !this.wp.mapSS.get(strName).mapRanges.containsKey(keyRange)){
                                    this.wp.mapSS.get(strName).mapRanges.put(keyRange, new PAQ_SpecialService__c(Amount__c = 0, Option__c = '') );
                                }
                            }
                        }
                        else{
                            SS service = new SS ('', 0);
                            for(String keyRange : listRangeDestiny){
                                service.mapRanges.put(keyRange, new PAQ_SpecialService__c(Amount__c = 0, Option__c = '') );
                            }
                            this.wp.mapSS.put(strName, service);
                        }
                    }
                }
                if (String.isNotBlank(cotizacion.Acuse__c))
                    this.blnACK = true;
                if(String.isNotBlank(cotizacion.Servicios_adicionales__c)){          
                    for (String strKeyService : cotizacion.Servicios_adicionales__c.split(';')){
                        switch on strKeyService {
                            when 'RAD' {
                                this.blnRAD = true;
                            }
                            when 'EAD' {
                                this.blnEAD = true;
                            }
                            when 'Seguro' {
                                this.blnSEG = true;
                            }
                            when 'EAD Zona plus'{
                                this.blnZP = true;
                            }
                        }
                    }
                    
                }
                if(this.blnCostosFijos){
                    List<String> listRangosRespaldo = new List<String>();
                    if(this.blnByDelivery){
                        for(Integer i = 0; i < this.listTarifas.size(); i++){
                            if(this.listTarifas[i] == 'TARIFA T7-V')
                                this.listTarifas.remove(i);
                            if(this.listTarifas[i] == 'TARIFA T7-P')
                                this.listTarifas.remove(i);
                        }
                    }
                }
                if(this.blnCostosFijos){
                    for (AcusePorGuia__mdt objACK : queryACK())
                        wp.mapACK.put(objACK.Label, objACK.Amount__c);
                }
                if(this.blnClienteNuevo && this.blnCostosFijos){ //Salvaodr 29/01/2021: Planchado de información hacia abajo o hacia arriba (Solo aplicable para costos fijos por tarifa).
                    boolean blnTarifasCargadas = false;
                    for(String strTarifa : this.listTarifas){
                        //if(!this.mapTLines.containsKey(strTarifa)){
                            if(!this.mapTLines.containsKey(strTarifa))
                                this.mapTLines.put(strTarifa, new Map<String, TempleateLine__c>());
                            if(!this.mapQuotes.containsKey(strTarifa))
                                this.mapQuotes.put(strTarifa, new Map<String, SBQQ__QuoteLine__c>());
                            for(Decimal decTarifa: this.listDecTarifas){
                                blnTarifasCargadas = false;
                                if(obtieneNumeroTarifa(strTarifa) <= decTarifa && decTarifa < 7){
                                    for(String strRange : this.listRanges){
                                        if(this.mapdecTLines.containsKey(decTarifa) && !this.mapTLines.get(strTarifa).containsKey(strRange)){
                                            if(this.mapdecTLines.get(decTarifa).containsKey(strRange))
                                                this.mapdecTLines.get(decTarifa).get(strRange).Tarifa__c = strTarifa;
                                            else {
                                                TempleateLine__c TL     = new TempleateLine__c();
                                                String rango            = '';
                                                String Tarifa           = '';
                                                if(strTarifa == 'TARIFA SOBRE')
                                                    Tarifa = 'TARIFA TS';
                                                else Tarifa = strTarifa;
                                                if(strRange.contains('('))
                                                    rango = this.mapRangeByDest.get(strRange);
                                                else rango = strRange;
                                                if(strTarifa == 'TARIFA T7' || strTarifa == 'TARIFA T7-P'){
                                                    TL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
                                                    if(this.blnRAD)
                                                        TL.RAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c);
                                                    if(this.blnEAD)
                                                        TL.EAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c);
                                                } else if(strTarifa == 'TARIFA T7-V'){
                                                    TL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c;
                                                    if(this.blnRAD)
                                                        TL.RAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c);
                                                    if(this.blnEAD)
                                                        TL.EAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c);
                                                } else {
                                                    TL.Flete__c     = this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c;
                                                    if(this.blnRAD){
                                                        if(strTarifa != 'TARIFA SOBRE')
                                                            TL.RAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c);
                                                        else TL.RAD__c      = 0.01;
                                                    }
                                                    if(this.blnEAD){
                                                        if(strTarifa != 'TARIFA SOBRE')
                                                            TL.EAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c);
                                                        else TL.EAD__c      = 0.01;
                                                    }
                                                }
                                                this.mapdecTLines.get(decTarifa).put(strRange, TL);
                                            }
                                            this.mapTLines.get(strTarifa).put(strRange, this.mapdecTLines.get(decTarifa).get(strRange));
                                        }
                                        if(this.mapTarifas.containsKey(decTarifa) && !this.mapQuotes.get(strTarifa).containsKey(strRange)){
                                            if(this.mapTarifas.get(decTarifa).containsKey(strRange))
                                                this.mapTarifas.get(decTarifa).get(strRange).Tarifa__c = strTarifa;
                                            else{
                                                SBQQ__QuoteLine__c QL   = new SBQQ__QuoteLine__c();
                                                String rango            = '';
                                                String Tarifa           = '';
                                                if(strTarifa == 'TARIFA SOBRE')
                                                    Tarifa = 'TARIFA TS';
                                                else Tarifa = strTarifa;
                                                if(strRange.contains('('))
                                                    rango = this.mapRangeByDest.get(strRange);
                                                else rango = strRange;
                                                if(strTarifa == 'TARIFA T7' || strTarifa == 'TARIFA T7-P'){
                                                    QL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
                                                } else if(strTarifa == 'TARIFA T7-V'){
                                                    QL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c;
                                                } else {
                                                    QL.Flete__c     = this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c;
                                                }
                                                this.mapTarifas.get(decTarifa).put(strRange, QL);
                                            }
                                            this.mapQuotes.get(strTarifa).put(strRange, this.mapTarifas.get(decTarifa).get(strRange));
                                        }
                                    }
                                    blnTarifasCargadas = true;
                                }
                            }
                            if(!blnTarifasCargadas){
                                for(String strRange : this.listRanges){
                                    String rango = '';
                                    String Tarifa = '';
                                    if(strRange.contains('('))
                                        rango = this.mapRangeByDest.get(strRange);
                                    else rango = strRange;
                                    TempleateLine__c TLine = new TempleateLine__c();
                                    SBQQ__QuoteLine__c QL = new SBQQ__QuoteLine__c();
                                    if(strTarifa == 'TARIFA T7-P'){
                                        TLine.Flete__c  = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
                                        if(this.blnRAD)
                                            TLine.RAD__C= this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c * 0.11;//dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c);
                                        if(this.blnEAD)
                                            TLine.EAD__c= this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c * 0.11;//dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c);
                                        QL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
                                    } else if(strTarifa == 'TARIFA T7-V'){
                                        TLine.Flete__c  = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c;
                                        if(this.blnRAD)
                                            TLine.RAD__C = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c * 0.11; //dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c);
                                        if(this.blnEAD)
                                            TLine.EAD__c = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c * 0.11;//dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c);
                                        QL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c;
                                    } else {
                                        if(strTarifa == 'TARIFA SOBRE')
                                            Tarifa = 'TARIFA TS';
                                        else if(strTarifa == 'TARIFA T7') 
                                            Tarifa = 'TARIFA T7P';
                                        else Tarifa = strTarifa;
                                        if(this.blnRAD){
                                            if(strTarifa != 'TARIFA SOBRE')
                                                TLine.RAD__C = dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c);
                                            else TLine.RAD__c = 0.01;
                                        }
                                        if(this.blnEAD){
                                            if(strTarifa != 'TARIFA SOBRE')
                                                TLine.EAD__c = dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c);
                                            else TLine.EAD__c = 0.01;
                                        }
                                        TLine.Flete__c  = this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c;
                                        QL.Flete__c     = this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c;
                                    }
                                    TLine.Weight__c = 1;
                                    TLine.Vol__c    = 1;
                                    TLine.Tarifa__c = strTarifa;
                                    QL.Weight__c    = 1;
                                    QL.Tarifa__c    = strTarifa;
                                    if(!this.mapTLines.get(strTarifa).containsKey(strRange))
                                        this.mapTLines.get(strTarifa).put(strRange, TLine);
                                    if(!this.mapQuotes.get(strTarifa).containsKey(strRange))
                                        this.mapQuotes.get(strTarifa).put(strRange, QL);
                                }
                            }
                        //}
                    }
                    for(String strRange : this.listRanges){
                        if(!this.listRangeDestiny.contains(strRange))
                            this.listRangeDestiny.add(strRange);
                        if(!this.mapAcuse.containsKey(strRange))
                            this.mapAcuse.put(strRange, wp.mapACK.get(cotizacion.Acuse__c));
                        if(!this.mapZonaPlus.containsKey(strRange))
                            this.mapZonaPlus.put(strRange, wp.mapCS.get('AEZP'));
                    }
                }
                for(String strRange : this.listRangeDestiny){
                    blnRango                                = false;
                    blnDest                                 = false;
                    strRangos                               = '';
                    kmServicesTrif                          = new ObjDocEnLinea.kmServicesTrifList();
                    listServicesTrifDtlS                    = new List<ObjDocEnLinea.servicesTrifDtlSub>();
                    ptpServicesTrifSub                      = new ObjDocEnLinea.ptpServicesTrifSub();
                    listserviceTrifCbe                      = new List<ObjDocEnLinea.serviceTrifCbe>();
                    listotherServiceTrif                    = new List<ObjDocEnLinea.serviceTrif>();
                    otherServiceTrif                        = new ObjDocEnLinea.serviceTrif();
                    if(strRange == '0-400'){
                        kmServicesTrif.fromKm       = '0';
                        kmServicesTrif.toKm         = '400';
                        blnRango                    = true;
                        blnDest                     = false;
                    } else if(strRange == '401-800'){
                        kmServicesTrif.fromKm       = '401';
                        kmServicesTrif.toKm         = '800';
                        blnRango                    = true;
                        blnDest                     = false;
                    } else if(strRange == '801-1200'){
                        kmServicesTrif.fromKm       = '801';
                        kmServicesTrif.toKm         = '1200';
                        blnRango                    = true;
                        blnDest                     = false;
                    } else if(strRange == '1201-1600'){
                        kmServicesTrif.fromKm       = '1201';
                        kmServicesTrif.toKm         = '1600';
                        blnRango                    = true;
                        blnDest                     = false;
                    } else if(strRange == '1601-2000'){
                        kmServicesTrif.fromKm       = '1601';
                        kmServicesTrif.toKm         = '2000';
                        blnRango                    = true;
                        blnDest                     = false;
                    } else if(strRange == '2001-2400'){
                        kmServicesTrif.fromKm       = '2001';
                        kmServicesTrif.toKm         = '2400';
                        blnRango                    = true;
                        blnDest                     = false;
                    } else if(strRange == 'Más de 2400'){
                        kmServicesTrif.fromKm       = '2401';
                        kmServicesTrif.toKm         = '9999';
                        blnRango                    = true;
                        blnDest                     = false;
                    } else {
                        ptpServicesTrifSub.orgnSite = strOrigen;
                        ptpServicesTrifSub.destSite = strRange;
                        blnRango                    = false;
                        blnDest                     = true;
                    }
                    if(this.blnCostosFijos){
                        for(String strTarifa : this.listTarifas){
                            if(!strRangos.contains(strTarifa)){
                                if(strTarifa != 'SEG-DS' && strTarifa != 'SEG-2D'){
                                    if(strTarifa != 'TARIFA T7'){
                                        servicesTrifDtlSub                      = new ObjDocEnLinea.servicesTrifDtlSub();
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        listserviceTrif                         = new List<ObjDocEnLinea.serviceTrif>();
                                        servicesTrifDtlSub.slabNo               = obtieneTarifa(strTarifa);
                                        if(strTarifa == 'TARIFA SOBRE')
                                            serviceTrif.serviceId                   = 'SHP-E';
                                        else serviceTrif.serviceId                  = 'SHP-G';
                                        if(strTarifa == 'TARIFA SOBRE')
                                            serviceTrif.refServiceId                = 'ENVELOPES';
                                        else serviceTrif.refServiceId               = 'PACKETS';
                                        if(strTarifa == 'TARIFA T7-P'){
                                            if(this.blnByDelivery)
                                                serviceTrif.trifAmount              = (this.mapTLines.get(strTarifa).get(strRange).FLETE__c / this.mapTLines.get(strTarifa).get(strRange).Weight__c).setScale(2);
                                            else serviceTrif.trifAmount             = this.mapTLines.get(strTarifa).get(strRange).FLETE__c.setScale(2);
                                        } else if(strTarifa == 'TARIFA T7-V'){
                                            if(this.blnByDelivery)
                                                serviceTrif.trifAmount              = (this.mapTLines.get(strTarifa).get(strRange).FLETE__c / this.mapTLines.get(strTarifa).get(strRange).Vol__c).setScale(2);
                                            else serviceTrif.trifAmount             = this.mapTLines.get(strTarifa).get(strRange).FLETE__c.setScale(2);
                                        }
                                        else{
                                            serviceTrif.trifAmount                 = this.mapTLines.get(strTarifa).get(strRange).FLETE__c.setScale(2);
                                        } 
                                        serviceTrif.discount                    = this.mapQuotes.get(strTarifa).get(strRange).SBQQ__Discount__c;
                                        serviceTrif.trifAmntBase                = 0;
                                        if(strTarifa == 'TARIFA T7-V'){
                                            serviceTrif.factor                  = 'CUM';
                                            serviceTrif.factorValue             = this.mapTLines.get(strTarifa).get(strRange).Vol__c;
                                        } else if(strTarifa == 'TARIFA T7-P'){
                                            serviceTrif.factor                  = 'KG';
                                            serviceTrif.factorValue             = this.mapTLines.get(strTarifa).get(strRange).Weight__c;
                                        }
                                        listserviceTrif.add(serviceTrif);
                                        if(this.blnEAD){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'EAD-1';
                                            serviceTrif.refServiceId                = 'EAD';
                                            if(this.mapTLines.get(strTarifa).get(strRange).EAD__c != 0)
                                                serviceTrif.trifAmount              = this.mapTLines.get(strTarifa).get(strRange).EAD__c.setScale(2);
                                            else serviceTrif.trifAmount             = 0.01;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.discount                    = 0;
                                            if(strTarifa == 'TARIFA T7-V' || strTarifa == 'TARIFA T7-P')
                                                serviceTrif.factorValue             = 1;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        serviceTrif.serviceId                   = 'RAD-1';
                                        serviceTrif.refServiceId                = 'RAD';
                                        if(this.mapTLines.get(strTarifa).get(strRange).RAD__c != 0 && this.blnRAD)
                                            serviceTrif.trifAmount              = this.mapTLines.get(strTarifa).get(strRange).RAD__c.setScale(2);
                                        else serviceTrif.trifAmount             = 0.001;
                                        serviceTrif.trifAmntBase                = 0;
                                        serviceTrif.discount                    = 0;
                                        if(strTarifa == 'TARIFA T7-V' || strTarifa == 'TARIFA T7-P')
                                            serviceTrif.factorValue             = 1;
                                        listserviceTrif.add(serviceTrif);
                                        if((strTarifa == 'TARIFA T7-V' || strTarifa == 'TARIFA T7-P') && this.blnT7ZP){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'EXT-1';
                                            serviceTrif.refServiceId                = 'EXT';
                                            if(this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c != null && this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c != 0){
                                                if(strTarifa == 'TARIFA T7-V'){
                                                    serviceTrif.trifAmount          = (this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c * 200).setScale(2);
                                                    serviceTrif.factor              = 'CUM';
                                                    serviceTrif.factorValue         = this.mapQuotesT7ZP.get(strRange).Vol__c;
                                                } else {
                                                    serviceTrif.trifAmount         = this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c.setScale(2);
                                                    serviceTrif.factor              = 'KG';
                                                    serviceTrif.factorValue         = this.mapQuotesT7ZP.get(strRange).Weight__c;
                                                }
                                            } else
                                                serviceTrif.trifAmount              = 1;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.discount                    = this.mapQuotesT7ZP.get(strRange).SBQQ__Discount__c;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        servicesTrifDtlSub.serviceTrif          = listserviceTrif;
                                        listServicesTrifDtlS.add(servicesTrifDtlSub);
                                    } else if(strTarifa == 'TARIFA T7' && !listTarifas.contains('TARIFA T7-P')){
                                        //11/01/2021 Salvador: Este bloque se usa únicamente cuando el T7 se cotizó por tarimas
                                        servicesTrifDtlSub                      = new ObjDocEnLinea.servicesTrifDtlSub();
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        listserviceTrif                         = new List<ObjDocEnLinea.serviceTrif>();
                                        servicesTrifDtlSub.slabNo               = 'T7P';
                                        serviceTrif.serviceId                   = 'SHP-G';
                                        serviceTrif.refServiceId                = 'PACKETS';
                                        if(this.mapTLines.get(strTarifa).get(strRange).FLETE__c != 0)
                                            serviceTrif.trifAmount                  = (this.mapTLines.get(strTarifa).get(strRange).FLETE__c / this.mapTLines.get(strTarifa).get(strRange).Weight__c).setScale(2);
                                        else serviceTrif.trifAmount                 = 1;
                                        serviceTrif.discount                    = this.mapQuotes.get(strTarifa).get(strRange).SBQQ__Discount__c;
                                        serviceTrif.trifAmntBase                = 0;
                                        serviceTrif.factorValue                 = 1;
                                        serviceTrif.factor                      = 'KG';
                                        listserviceTrif.add(serviceTrif);
                                        if(this.blnT7ZP){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'EXT-1';
                                            serviceTrif.refServiceId                = 'EXT';
                                            if(this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c != 0)
                                                serviceTrif.trifAmount              = this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c.setScale(2);
                                            else serviceTrif.trifAmount             = 1;
                                            serviceTrif.discount                    = this.mapQuotesT7ZP.get(strRange).SBQQ__Discount__c;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        if(this.blnEAD){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'EAD-1';
                                            serviceTrif.refServiceId                = 'EAD';
                                            if(this.mapTLines.get(strTarifa).get(strRange).EAD__c != 0)
                                                serviceTrif.trifAmount              = (this.mapTLines.get(strTarifa).get(strRange).EAD__c / this.mapTLines.get(strTarifa).get(strRange).Weight__c).setScale(2);
                                            else serviceTrif.trifAmount             = 1;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.discount                    = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        if(this.blnRAD){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'RAD-1';
                                            serviceTrif.refServiceId                = 'RAD';
                                            if(this.mapTLines.get(strTarifa).get(strRange).RAD__c != 0)
                                                serviceTrif.trifAmount              = (this.mapTLines.get(strTarifa).get(strRange).RAD__c / this.mapTLines.get(strTarifa).get(strRange).Weight__c).setScale(2);
                                            else serviceTrif.trifAmount             = 1;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.discount                    = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        servicesTrifDtlSub.serviceTrif          = listserviceTrif;
                                        listServicesTrifDtlS.add(servicesTrifDtlSub);
                                        servicesTrifDtlSub                      = new ObjDocEnLinea.servicesTrifDtlSub();
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        listserviceTrif                         = new List<ObjDocEnLinea.serviceTrif>();
                                        servicesTrifDtlSub.slabNo               = 'T7V';
                                        serviceTrif.serviceId                   = 'SHP-G';
                                        serviceTrif.refServiceId                = 'PACKETS';
                                        serviceTrif.trifAmount                  = (this.mapTLines.get(strTarifa).get(strRange).FLETE__c / this.mapTLines.get(strTarifa).get(strRange).Vol__c).setScale(2);
                                        serviceTrif.discount                    = 0;
                                        serviceTrif.trifAmntBase                = 0;
                                        serviceTrif.factorValue                 = 1;
                                        serviceTrif.factor                      = 'CUM';
                                        listserviceTrif.add(serviceTrif);
                                        if(this.blnEAD){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'EAD-1';
                                            serviceTrif.refServiceId                = 'EAD';
                                            serviceTrif.trifAmount                  = (this.mapTLines.get(strTarifa).get(strRange).EAD__c / this.mapTLines.get(strTarifa).get(strRange).Vol__c).setScale(2);
                                            serviceTrif.discount                    = 0;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        if(this.blnRAD){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'RAD-1';
                                            serviceTrif.refServiceId                = 'RAD';
                                            serviceTrif.trifAmount                  = (this.mapTLines.get(strTarifa).get(strRange).RAD__c / this.mapTLines.get(strTarifa).get(strRange).Vol__c).setScale(2);
                                            serviceTrif.discount                    = 0;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        if(this.blnT7ZP){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'EXT-1';
                                            serviceTrif.refServiceId                = 'EXT';
                                            if(this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c != 0)
                                                serviceTrif.trifAmount              = (this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c * 200).setScale(2);
                                            else serviceTrif.trifAmount             = 1;
                                            serviceTrif.discount                    = this.mapQuotesT7ZP.get(strRange).SBQQ__Discount__c;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        servicesTrifDtlSub.serviceTrif          = listserviceTrif;
                                        listServicesTrifDtlS.add(servicesTrifDtlSub);
                                    }
                                }
                            }
                        }
                    } else {
                        listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                        serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                        serviceTrifCbe.factor               = 'KG';
                        serviceTrifCbe.serviceId            = 'SHP-G';
                        serviceTrifCbe.refServiceId         = 'PACKETS';
                        serviceTrifCbe.trifAmountExce       = this.mapService.get('ADD').mapRanges.get(strRange);
                        for(String strBlock : this.mapBlocks.keySet()){
                            serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                            serviceTrif.trifAmount          = this.mapBlocksServ.get(strBlock).get('FLT').get(strRange);
                            serviceTrif.trifAmntBase        = 0;
                            serviceTrif.discount            = 0;
                            serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decWeight;
                            listserviceTrif.add(serviceTrif);
                        }
                        serviceTrifCbe.serviceTrif = listserviceTrif;
                        listserviceTrifCbe.add(serviceTrifCbe);
                        if(this.blnEAD){
                            listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                            serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                            serviceTrifCbe.factor               = 'KG';
                            serviceTrifCbe.serviceId            = 'EAD-1';
                            serviceTrifCbe.refServiceId         = 'EAD';
                            serviceTrifCbe.trifAmountExce   	= this.mapService.get('ADD').mapRanges.get(strRange);
                            for(String strBlock : this.mapBlocks.keySet()){
                                serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                                serviceTrif.trifAmount          = this.mapBlocksServ.get(strBlock).get('EAD').get(strRange);
                                serviceTrif.trifAmntBase        = 0;
                                serviceTrif.discount            = 0;
                                serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decWeight;
                                listserviceTrif.add(serviceTrif);
                            }
                            serviceTrifCbe.serviceTrif = listserviceTrif;
                            listserviceTrifCbe.add(serviceTrifCbe);
                        }
                        if(this.blnRAD){
                            listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                            serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                            serviceTrifCbe.factor               = 'KG';
                            serviceTrifCbe.serviceId            = 'RAD-1';
                            serviceTrifCbe.refServiceId         = 'RAD';
                            serviceTrifCbe.trifAmountExce       = this.mapService.get('ADD').mapRanges.get(strRange);
                            for(String strBlock : this.mapBlocks.keySet()){
                                serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                                serviceTrif.trifAmount          = this.mapBlocksServ.get(strBlock).get('RAD').get(strRange);
                                serviceTrif.trifAmntBase        = 0;
                                serviceTrif.discount            = 0;
                                serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decWeight;
                                listserviceTrif.add(serviceTrif);
                            }
                            serviceTrifCbe.serviceTrif = listserviceTrif;
                            listserviceTrifCbe.add(serviceTrifCbe);
                        }
                        listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                        serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                        serviceTrifCbe.factor               = 'CUM';
                        serviceTrifCbe.serviceId            = 'SHP-G';
                        serviceTrifCbe.refServiceId         = 'PACKETS';
                        serviceTrifCbe.trifAmountExce       = this.mapService.get('ADD').mapRanges.get(strRange).setScale(2);
                        for(String strBlock : this.mapBlocks.keySet()){
                            serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                            serviceTrif.trifAmount          = this.mapBlocksServ.get(strBlock).get('FLT').get(strRange);
                            serviceTrif.trifAmntBase        = 0;
                            serviceTrif.discount            = 0;
                            serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decVol;
                            listserviceTrif.add(serviceTrif);
                        }
                        serviceTrifCbe.serviceTrif = listserviceTrif;
                        listserviceTrifCbe.add(serviceTrifCbe);
                        if(this.blnEAD){
                            listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                            serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                            serviceTrifCbe.factor               = 'CUM';
                            serviceTrifCbe.serviceId            = 'EAD-1';
                            serviceTrifCbe.refServiceId         = 'EAD';
                            serviceTrifCbe.trifAmountExce       = this.mapService.get('ADD').mapRanges.get(strRange).setScale(2);
                            for(String strBlock : this.mapBlocks.keySet()){
                                serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                                serviceTrif.trifAmount          = (this.mapBlocksServ.get(strBlock).get('EAD').get(strRange) * 200).setScale(2);
                                serviceTrif.trifAmntBase        = 0;
                                serviceTrif.discount            = 0;
                                serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decVol;
                                listserviceTrif.add(serviceTrif);
                            }
                            serviceTrifCbe.serviceTrif = listserviceTrif;
                            listserviceTrifCbe.add(serviceTrifCbe);
                        }
                        if(this.blnRAD){
                            listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                            serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                            serviceTrifCbe.factor               = 'CUM';
                            serviceTrifCbe.serviceId            = 'RAD-1';
                            serviceTrifCbe.refServiceId         = 'RAD';
                            serviceTrifCbe.trifAmountExce       = (this.mapService.get('ADD').mapRanges.get(strRange) * 200).setScale(2);
                            for(String strBlock : this.mapBlocks.keySet()){
                                serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                                serviceTrif.trifAmount          = (this.mapBlocksServ.get(strBlock).get('RAD').get(strRange) * 200).setScale(2);
                                serviceTrif.trifAmntBase        = 0;
                                serviceTrif.discount            = 0;
                                serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decVol;
                                listserviceTrif.add(serviceTrif);
                            }
                            serviceTrifCbe.serviceTrif = listserviceTrif;
                            listserviceTrifCbe.add(serviceTrifCbe);
                        }
                    }
                    if(this.blnACK || this.blnZP)
                        listserviceTrif                         = new List<ObjDocEnLinea.serviceTrif>();
                    if(this.blnACK){
                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                        serviceTrif.serviceId                   = obtieneAcuse(cotizacion.Acuse__c);
                        serviceTrif.refServiceId                = 'ACK';
                        if(this.blnCostosFijos){
                            if(this.wp.blnSoloTarifasExp)
                                serviceTrif.trifAmount          = this.wp.mapACKExp.get(strRange);
                            else serviceTrif.trifAmount         = this.mapAcuse.get(strRange);//this.wp.mapACK.get(cotizacion.Acuse__c);
                        }
                        else serviceTrif.trifAmount             = this.mapService.get('ACK').mapRanges.get(strRange);
                        serviceTrif.discount                    = 0;
                        serviceTrif.trifAmntBase                = 0;
                        if(cotizacion.AcuseCosto__c != null)
                            serviceTrif.servicesCant                = obtieneTipoAcuse(cotizacion.AcuseCosto__c);
                        else serviceTrif.servicesCant           = '';
                        serviceTrif.factor                      = 'NON';
                        listserviceTrif.add(serviceTrif);
                    }
                    if(this.blnZP){
                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                        serviceTrif.serviceId                   = 'EXT-1';
                        serviceTrif.refServiceId                = 'EXT';
                        if(this.blnCostosFijos){
                            if(this.mapZonaPlus.get(strRange) != 0)
                                serviceTrif.trifAmount              = this.mapZonaPlus.get(strRange).setscale(2);
                            else serviceTrif.trifAmount             = 1;
                        } else {
                            serviceTrif.trifAmount             = this.mapService.get('ZP').mapRanges.get(strRange);
                        }
                        serviceTrif.discount                    = 0;
                        serviceTrif.trifAmntBase                = 0;
                        serviceTrif.factor                      = 'NON';
                        listserviceTrif.add(serviceTrif);
                    }
                    if(this.blnACK || this.blnZP){
                        if(blnRango){
                            if(!listserviceTrif.isEmpty())
                                kmServicesTrif.serviceTrif = listserviceTrif;
                        }else{
                            if(!listserviceTrif.isEmpty())
                                ptpServicesTrifSub.serviceTrif = listserviceTrif;
                        }
                    }
                    if(this.blnTarifasExp && this.blnCostosFijos){
                        for(Decimal decBloque: this.listBloquesExp){
                            for(String strTarifa: this.listTarifasExp){
                                serviceTrifCbe                              = new ObjDocEnLinea.serviceTrifCbe();
                                serviceTrif                                 = new ObjDocEnLinea.serviceTrif();
                                listserviceTrif                             = new List<ObjDocEnLinea.serviceTrif>();
                                if(this.mapTLinesExp.get(decBloque).get(strTarifa).get(strRange).KG_Adicional__c != 0)
                                    serviceTrifCbe.trifAmountExce           = this.mapTLinesExp.get(decBloque).get(strTarifa).get(strRange).KG_Adicional__c;
                                else serviceTrifCbe.trifAmountExce          = 1;
                                serviceTrifCbe.factor                       = 'KG';
                                serviceTrifCbe.serviceId                    = strTarifa;
                                serviceTrifCbe.refServiceId                 = obtieneTarifaExpress(strTarifa);
                                if(this.mapTLinesExp.get(decBloque).get(strTarifa).get(strRange).FLETE__c != 0)
                                    serviceTrif.trifAmount                  = this.mapTLinesExp.get(decBloque).get(strTarifa).get(strRange).FleteE__c;
                                else serviceTrif.trifAmount                 = 1;
                                serviceTrif.trifAmntBase                    = 0;
                                serviceTrif.discount                        = 0;//this.mapQuotesExp.get(strTarifa).get(strRange).SBQQ__Discount__c;
                                serviceTrif.factor                          = 'KG';
                                serviceTrif.factorValue                     = decBloque;
                                listserviceTrif.add(serviceTrif);
                            }
                            serviceTrifCbe.serviceTrif                  = listserviceTrif;
                            listserviceTrifCbe.add(serviceTrifCbe);
                        }
                    }
                    if(this.ServiciosEspeciales && this.blnCostosFijos){
                        for(String strTarifa : this.listSS){
                            serviceTrif                                 = new ObjDocEnLinea.serviceTrif();
                            serviceTrif.serviceId                       = obtieneNombreServAdic(strTarifa);
                            serviceTrif.refServiceId                    = obtieneNombreServAdic(serviceTrif.serviceId);
                            if(this.wp.mapSS.get(strTarifa).mapRanges.get(strRange).Amount__c != 0)
                                serviceTrif.trifAmount                  = this.wp.mapSS.get(strTarifa).mapRanges.get(strRange).Amount__c.setScale(2);
                            else serviceTrif.trifAmount                 = 1;
                            serviceTrif.trifAmntBase                    = 0;
                            serviceTrif.discount                        = 0;
                            serviceTrif.factor                          = 'NON';
                            serviceTrif.servicesCant                    = obtieneservicesCant(this.wp.mapSS.get(strTarifa).mapRanges.get(strRange).Option__c);
                            listotherServiceTrif.add(serviceTrif);
                        }
                    }
                    if(listServicesTrifDtlS != null && listServicesTrifDtlS.size() != 0){
                        if(blnRango)
                            kmServicesTrif.servicesTrifDtl          = listServicesTrifDtlS;
                        else ptpServicesTrifSub.servicesTrifDtl     = listServicesTrifDtlS;
                    }
                    if(!listserviceTrifCbe.isEmpty()){
                        if(blnRango)
                            kmServicesTrif.servicesTrifCbe          = listserviceTrifCbe;
                        else ptpServicesTrifSub.servicesTrifCbe      = listserviceTrifCbe;
                    }
                    if(!listotherServiceTrif.isEmpty()){
                        if(blnRango)
                            kmServicesTrif.otherServiceTrif         = listotherServiceTrif;
                        else ptpServicesTrifSub.otherServiceTrif     = listotherServiceTrif;
                    }
                    if(blnDest)
                        listptpServicesTrifS.add(ptpServicesTrifSub);
                    if(blnRango){
                        if(kmServicesTrif != null)
                            listkmServicesTrif.add(kmServicesTrif);
                    }
                }
                servicesTrifDtlList                     = new List<ObjDocEnLinea.servicesTrifDtl>{servicesTrifDtl};
                if(listkmServicesTrif != null && listkmServicesTrif.size() != 0)
                    kmServicesTrif1.kmServicesTrif          = listkmServicesTrif;
                if(kmServicesTrif1 != null && kmServicesTrif1.kmServicesTrif != null)
                    listkmServicesTrif1.add(kmServicesTrif1);
                if(listkmServicesTrif1.size() != 0 && listkmServicesTrif1.size() != 0)
                    data.kmConfig                           = listkmServicesTrif1;
                if(!listptpServicesTrifS.isEmpty() && listptpServicesTrifS.size() != 0)
                    ptpServicesTrif.ptpServicesTrif         = listptpServicesTrifS;
                if(ptpServicesTrif != null)
                    listptpServicesTrif                     = new list<ObjDocEnLinea.ptpServicesTrif>{ptpServicesTrif};
                if(!listptpServicesTrif.isEmpty() && listptpServicesTrif.size() != 0)
                    data.ptpConfig                          = listptpServicesTrif;
                rq.data                                 = data;
                body.request                            = rq;
                odc.body                                = body;
                header.security                         = sec;
                odc.header                              = header;
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Request: ' + JSON.serialize(odc)));
                //if(!System.isScheduled()){
                    /*if(!cotizacion.Electronicas__c){
                        if(grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion))
                            grab.publicarEvento(true,null);
                    }else if(cotizacion.Electronicas__c){*/
                        grab.blnLlamadaDocLinea = true;
                        if(this.blnCostosFijos)
                            grab.strTipoCliente = 'A';
                        else grab.strTipoCliente = 'C';
                		grab.crearUsuarioWeb(cotizacion);
                		if(grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion)){
                                grab.publicarEvento(true,null);
                                /*SBQQ__Quote__c QT = null;
                                QT = [SELECT id, Tarifas_grabadas_sipweb__c from SBQQ__QUOTE__C WHERE ID = :cotizacion.id LIMIT 1];
                                if(QT != null){
                                    QT.Tarifas_grabadas_sipweb__c = true;
                                    update QT;
                                }*/
                            }
                        /*if(grab.crearUsuarioWeb(cotizacion)){
                            if(grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion)){
                                grab.publicarEvento(true,null);
                                SBQQ__Quote__c QT = null;
                                QT = [SELECT id, Tarifas_grabadas_sipweb__c from SBQQ__QUOTE__C WHERE ID = :cotizacion.id LIMIT 1];
                                if(QT != null){
                                    QT.Tarifas_grabadas_sipweb__c = true;
                                    update QT;
                                }
                            }
                        } else {
                            grab.publicarEvento(false,'No se pudo realizar el grabado');
                        }
                    /*}
                    else
                        grab.publicarEvento(false,'No se pudo realizar el grabado');*/
                /*}
                else
                    grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion);*/
            }else {
                gr.publicarEvento(false, 'Imposible continuar, datos insuficientes');
            }

        } catch (Exception ex){
            System.debug('ValidacionDocLinea: '+ex.getLineNumber()+' '+ex.getMessage());
            gr.publicarEvento(false, 'Error al realizar grabado de tarifas. ' +ex.getLineNumber()+' '+ex.getMessage());
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
            return 'T7P';
        else return '';
    }
    public static String obtieneAcuse(String TipoAcuse){
        if(TipoAcuse == 'Empresa')
            return 'ACK-C';
        else if(TipoAcuse == 'Interno')
            return 'ACK-P';
        else return 'ACK-X';
    }
    public static String obtieneTipoAcuse(String TipoAcuse){
        if(TipoAcuse == 'P')
            return 'E';
        else return 'G';
    }
    public static String obtieneTarifaExpress(String serviceId){
        if(serviceId == 'SEG-DS')
            return 'SEG-D';
        else if (serviceId == 'SEG-2D')
            return 'SEG-DD';
        else return '';
    }
    public static String obtieneNombreServAdic(String nombre){
        if(nombre == 'Maniobras')
            return 'MAN-1';
        else if (nombre == 'MAN-1')
            return 'MAN';
        else if (nombre == 'EAD con cita')
            return 'EAD-CITA-1';
        else if (nombre == 'EAD-CITA-1')
            return 'EAD-CITA';
       	else if (nombre == 'EAD a Detalle')
            return 'EAD-DET-1';
       	else if (nombre == 'EAD-DET-1')
            return 'EAD-DET';
        else if (nombre == 'Cruce fronterizo')
            return 'ITL-CRU-1';
        else if (nombre == 'ITL-CRU-1')
            return 'ITL-CRU';
        else if (nombre == 'Pick&Pack')
            return 'PICK-1';
        else if (nombre == 'PICK-1')
            return 'PICK';
        else if (nombre == 'Special Packing')
            return 'SPPAC-1';
        else if (nombre == 'SPPAC-1')
            return 'SPPAC';
        else return '';
    }
    public static String obtieneservicesCant(String servicesCant){
        if(servicesCant == 'Guía')
            return 'G';
        else if (servicesCant == 'Paquete')
            return 'E';
        else return 'K';
    }
    public static Decimal obtieneNumeroTarifa(String Tarifa){
        if(Tarifa == 'TARIFA SOBRE')
            return 0.0;
        else if(tarifa == 'TARIFA T0')
            return 0.1;
        else if(Tarifa == 'TARIFA T1')
            return 1.0;
        else if(Tarifa == 'TARIFA T2')
            return 2.0;
        else if(Tarifa == 'TARIFA T3')
            return 3.0;
        else if(Tarifa == 'TARIFA T4')
            return 4.0;
        else if(Tarifa == 'TARIFA T5')
            return 5.0;
        else if(Tarifa == 'TARIFA T6')
            return 6.0;
        else if(Tarifa == 'TARIFA T7-P')
            return 7.1;
        else if(Tarifa == 'TARIFA T7-V')
            return 7.2;
        else if(Tarifa == 'TARIFA T7')
            return 7.0;
        else return 0.0;
    }
    public void GrabarTarifaDocLinea(){
        try{
            iniciarGrabado(this.cas);
        } catch (Exception ex){
            System.debug('GrabarTarifaDocLinea ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
    }
    /*public PageReference procesar(){
        Apexpages.StandardController sc = new Apexpages.StandardController(this.cas);
        GrabadoBtnController gr = new GrabadoBtnController(sc);
        try{
            PageReference pageRef = new PageReference('/'+Id);
            pageRef.setRedirect(true);
            if(ObtieneInfoResponse(this.cas)){
                System.debug('OK');
            }else{
                gr.publicarEvento(false, 'Error general');
            }
            return pageRef;
        }catch(Exception ex){
            PageReference pageRef = new PageReference('/'+Id);
            gr.publicarEvento(false, 'procesar: ' + ex.getLineNumber() + ' ' + ex.getMessage());
            return pageRef;
        }
    }*/
    public static List<SBQQ__QuoteLine__c> queryquoteitem(String Id){
        return[SELECT Id, Rango_KM__c, Destiny__c, ACK__c, RAD__c, EAD__c, SBQQ__CustomerPrice__c, SBQQ__Discount__c,SBQQ__SpecialPrice__c, Tarifa__c, KG_ADICIONAL__c, ZonaPlus__c, SBQQ__Description__c, PackWeightAVG__c, SBQQ__Quantity__c, Vol__c, Weight__c, FLETE__c
                , PackVolAVG__c FROM SBQQ__QuoteLine__c WHERE SBQQ__QUOTE__C = : Id];
    }
    public static Decimal queryCostoZonaPlus(String Id){
        TempleateLine__c ct = new TempleateLine__c ();
        ct = [SELECT EAD__C FROM TempleateLine__c where Templeate__c = :Id AND ZONA_PLUS__C = TRUE LIMIT 1];
        return ct.EAD__C;
    }
    public Templeate__c queryTempleate(String strIdQuote){
        Templeate__c objPlantilla = new Templeate__c();
        try{
            objPlantilla = [SELECT Id
            , ServiciosAdicionales__c
            , Acuse__c
            , Electronicas__c
            , Impresas__c
            , TipoCotizacion__c
            , Fecha_sugar__c
            FROM Templeate__c where Quote__c =: strIdQuote ORDER BY CreatedDate DESC LIMIT 1];
        }
        catch (Exception ex){
            System.debug(ex.getMessage());
        }
        return objPlantilla;
    }
    public List<TempleateLine__c> queryTempleateLine(String templeateId){
        List<TempleateLine__c> listPlantillaLineItems = new List<TempleateLine__c>();
        try{
            listPlantillaLineItems = [SELECT Id, Quantity__c, EditMode__c, Tarifa__c, Weight__c, Vol__c, Rango_KM__c, Pack_Seg__c, Zona_Plus__c, ACK__c, EAD__c, RAD__c, SEG__c, PackWeightAVG__c, PackVolAVG__c, CustomerPrice__c, TarifaDominante__c, FLETE__c,Guia__c, fleteE__c, ACKES__c,KG_ADICIONAL__c, Destiny__c
                                    FROM TempleateLine__c where Templeate__c = :templeateId  ORDER BY CreatedDate];
        }catch(Exception ex){
            System.debug('queryTempleateLine: ' + ex.getMessage());
        }
        return listPlantillaLineItems;
    }
    public static List<PAQ_SpecialService__c> querySS (String strIdQuote){
		List<PAQ_SpecialService__c> listSS = new List<PAQ_SpecialService__c>();
		try{
			listSS = [SELECT Id, Name, Amount__c, Option__c, Potencial__c, MainDesinations__c, RangoKM__c, Destiny__c FROM PAQ_SpecialService__c WHERE Quote__c =: strIdQuote];
		} catch (Exception ex){
			System.debug(ex.getMessage());
		}
		return listSS;
    }
    public static Map<String, Decimal> queryCustomSetting(String pid){
        Map<String, Decimal> mapCS = new Map<String, Decimal>();
        Cotizador__c CSObj = Cotizador__c.getInstance(pid);
        mapCS.put('MinRAD', CSObj.MinRAD__c);
        mapCS.put('MinEAD', CSObj.MinEAD__c);
        mapCS.put('AEZP', CSObj.EntregaDomicilioZonaPlus__c);
        return mapCS;
    }
    public static Map<String, String> getPicklistValues( String strSObject, String strFieldSelected ){
		Schema.SObjectType objType                                  = Schema.getGlobalDescribe().get( strSObject );
		Schema.DescribeSObjectResult objDescribe                    = objType.getDescribe();
		Map<String, Schema.SObjectField> mapFieldsByName            = new Map<String, Schema.SObjectField>( objDescribe.fields.getMap() );

		Map<String, String> lstPicklist                              = new Map<String, String>();

		if( mapFieldsByName.containsKey( strFieldSelected ) ){
			List<Schema.PicklistEntry> lstPicklistValues            = mapFieldsByName.get( strFieldSelected ).getDescribe().getPickListValues();
			for( Schema.PicklistEntry rowValue : lstPicklistValues ){
				lstPicklist.put( rowValue.getValue(), rowValue.getLabel());
			}
		}

		return lstPicklist;
    }
    public static List<Tarifario_general_terrestre__c> queryTarifarioTFull(){
        return [SELECT  Id
        , Tarifa__c
        , Flete__c
        , Name
        , PesoMaximo__c
        , VolumenMaximo__c
        , RangoKM__c
        FROM Tarifario_general_terrestre__c WHERE Year__c = null];
    }
    public static List<AcusePorGuia__mdt> queryACK(){
        List<AcusePorGuia__mdt> listACK = new List<AcusePorGuia__mdt>();
        try {
            listACK = [SELECT Id, Label, Amount__c FROM AcusePorGuia__mdt];
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage() + ' caused by: ' + ex.getCause());
        }
        return listACK;
    }
    public static Decimal dominantFeeServiceDom(Decimal fltMinFee, decimal fltAmount){
        Decimal fltFee = fltAmount * 0.11;
        if(fltMinFee > fltFee)
            return fltMinFee;
        else
            return fltFee;
    }
    public class Wrapper{
        public List<SBQQ__QuoteLine__c> listQuoteItem                                   {get; set;}
        public Map<String,SS> mapSS          	                                        {get; set;}
        public Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT   {get; set;}
        public Map<String, Decimal> mapCS                                               {get; set;}
        public Map<String, Decimal> mapACK                                              {get; set;}
        public Map<String, Decimal> mapACKExp                                           {get; set;}
        public Boolean blnSoloTarifasExp                                                {get; set;}
        public Wrapper(){
            this.listQuoteItem      = new List<SBQQ__QuoteLine__c>();
            this.mapSS				= new Map<String, SS>();
            this.mapTarifarioT      = new Map<String, Map<String, Tarifario_general_terrestre__c>>();
            this.mapCS              = new Map<String, Decimal>();
            this.mapACK             = new Map<String, Decimal>();
            this.mapACKExp          = new Map<String, Decimal>();
            this.blnSoloTarifasExp  = false;
        }
    }
    public class SS{
		public String	                            MainDestinies 	{get; set;}
		public Decimal	                            Potential		{get; set;}
		public Map<String, PAQ_SpecialService__c>   mapRanges       {get; set;}
		public SS(String strMainDest, Decimal decPot){
			this.mapRanges      = new Map<String, PAQ_SpecialService__c>();
			this.Potential      = decPot;
			this.MainDestinies  = strMainDest;
		}
    }
    public class Block{
        public String       strName             {get; set;}
        public Decimal      decWeight           {get; set;}
        public Decimal      decVol              {get; set;}
        public Decimal      decVolWeight        {get; set;}
        public Map<String, Decimal> mapRanges   {get; set;}

        public Block(String paramName, Decimal paramWeight, Decimal paramVol, Decimal paramVolWeight){
            this.strName        = paramName;
            this.decWeight      = paramWeight;
            this.decVol         = paramVol;
            this.decVolWeight   = paramVolWeight;
            this.mapRanges      = new Map<String, Decimal>();
        }
    }
    public class QuoteWP{
        public Decimal totalPaquetes {get; set;}
        public Decimal frecPaquetes {get; set;}
        public Decimal totalAmount {get; set;}
        public Decimal totalNormal {get; set;}
        public Decimal totalSEG {get; set;}
        public Decimal totalDiscount {get; set;}

        public QuoteWP (){
            this.totalPaquetes = 0;
            this.frecPaquetes = 0;
            this.totalAmount = 0;
            this.totalNormal = 0;
            this.totalSEG = 0;
            this.totalDiscount = 0;
        }

        public QuoteWP(Decimal totalPaquetes, Decimal total, Decimal totalAmount){
            this.totalPaquetes = totalPaquetes;
            if(total > 0)
                this.frecPaquetes = (totalPaquetes / total) * 100;
            else
                this.frecPaquetes = 0;

            this.totalAmount = totalAmount;
        }
    }
}
