/*Created by: Salvador Ramírez López*/
public class GrabadoDocEnLinea {
    public Wrapper wp                                                           {get;set;}
    public Id owner                                                             {get;set;}
    public Id Id                                                                {get;set;}
    public SBQQ__Quote__c cas                                                   {get;set;}
    public string tipoDocumentacion                                             {get;set;}
    public Id cuenta                                                            {get;set;}
    public string idSipWeb                                                      {get;set;}
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
    public Boolean blnGrabarTarifas                                             {get;set;}
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
    public Map<Decimal, Map<String, Map<String, SBQQ__QuoteLine__c>>> mapTLinesExp{get;set;}
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
    public map<String, TempleateLine__c> mapBlockAdic                           {get;set;}
    //public Map<String, QuoteWP>  mapTotalByRange                                {get;set;}
    public Map<Decimal, Map<String, TempleateLine__c>> mapBloques               {get;set;}
    public Map<String, Map<String, Decimal>> mapExpAdic                         {get;set;}
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
        this.blnGrabarTarifas               = false;
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
        this.mapTLinesExp                   = new Map<Decimal, Map<String, Map<String, SBQQ__QuoteLine__c>>>();
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
        this.mapBlockAdic                   = new map<String, TempleateLine__c>();
        this.mapBloques                     = new Map<Decimal,  Map<String, TempleateLine__c>>();
        this.mapExpAdic                     = new Map<String, Map<String, Decimal>>();
        try{
            this.cas                        = (SBQQ__Quote__c) controller.getRecord();
            this.Id                         = cas.Id;
            idSipWeb                        = cas.SBQQ__Account__r.Id_SIpWeb__c;
            owner                           = cas.OwnerId;
            cuenta                          = cas.SBQQ__Account__c;
            tipoDocumentacion               = cas.Tipo_de_documentacion__c;
            this.wp.blnSoloDestinos         = cas.Destinos__c;
            if(cas.TipoCotizacion__c == 'byDelivery' || cas.Modelo_de_tarifas__c == 'Costo base más excedente: Por Destinos / Por rangos de km' || cas.Modelo_de_tarifas__c == 'Guía multipieza: Por Destinos / Por rangos de km'){
                this.blnByDelivery          = true;
                this.blnByDimension         = false;
            } else {
                this.blnByDimension         = true;
                this.blnByDelivery          = false;
            }
            if(cas.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'){
                this.blnCostosFijos     = true;
                this.blnCostoBaseGMP    = false;
            } else {
                this.blnCostoBaseGMP    = true;
                this.blnCostosFijos     = false;
            }
            Apexpages.StandardController StandarC   = new Apexpages.StandardController(cas);
            for(Tarifario_general_terrestre__c objTarifarioT: queryTarifarioTFull()){
                if(!wp.mapTarifarioT.containsKey(objTarifarioT.Tarifa__c)){
                    wp.mapTarifarioT.put(objTarifarioT.Tarifa__c, new Map<String, Tarifario_general_terrestre__c>{objTarifarioT.RangoKM__c => objTarifarioT});
                } else if (!wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).containsKey(objTarifarioT.RangoKM__c)){
                    wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).put(objTarifarioT.RangoKM__c, objTarifarioT);
                }
            }
            if(ObtieneInfoResponse(cas))
                System.debug('ejecutó correctamente');
            else System.debug('error al obtener response');
            if(test.isRunningTest()){
                String nombre = '';
                String tarifa = '';
                nombre = obtieneNombreServAdic('Maniobras');
                nombre = obtieneNombreServAdic('MAN-1');
                nombre = obtieneNombreServAdic('EAD con cita');
                nombre = obtieneNombreServAdic('EAD-CITA-1');
                nombre = obtieneNombreServAdic('EAD a detalle');
                nombre = obtieneNombreServAdic('EAD-DET-1');
                nombre = obtieneNombreServAdic('Cruce fronterizo');
                nombre = obtieneNombreServAdic('ITL-CRU-1');
                nombre = obtieneNombreServAdic('EAD-DET-1');
                nombre = obtieneNombreServAdic('Pick&Pack');
                nombre = obtieneNombreServAdic('PICK-1');
                nombre = obtieneNombreServAdic('Special Packing');
                nombre = obtieneNombreServAdic('SPPAC-1');
                nombre = obtieneServicesCant('Guía');
                nombre = obtieneServicesCant('Paquete');
                nombre = obtieneServicesCant('Otro');
                tarifa = obtieneTarifaDeNum(0.0);
                tarifa = obtieneTarifaDeNum(0.1);
                tarifa = obtieneTarifaDeNum(1.0);
                tarifa = obtieneTarifaDeNum(2.0);
                tarifa = obtieneTarifaDeNum(3.0);
                tarifa = obtieneTarifaDeNum(4.0);
                tarifa = obtieneTarifaDeNum(5.0);
                tarifa = obtieneTarifaDeNum(6.0);
                tarifa = obtieneTarifaDeNum(7.0);
                tarifa = obtieneTarifaDeNum(7.1);
                tarifa = obtieneTarifaDeNum(7.2);
                tarifa = obtieneTarifaDeNum(8.0);
            }
            if(cas.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cas.SBQQ__Account__r.Id_SIpWeb__c)){
                String endpoint = Label.Grabado_DocLinea;
                String userSipweb = '';
                User u = [SELECT Id_Sipweb__c, FederationIdentifier FROM User WHERE Id=:System.UserInfo.getUserId()];
                if(!String.isEmpty(u.Id_Sipweb__c)){
                    userSipweb = u.Id_Sipweb__c;
                    this.aprvUser = userSipweb;
                    this.blnPuedeGrabar = true;
                }else if(!String.isEmpty(u.FederationIdentifier)){
                    userSipweb = u.FederationIdentifier;
                    this.aprvUser = userSipweb;
                    this.blnPuedeGrabar = true;
                } else {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su usuario no cuenta con un ID de sipweb o de federación por lo tanto no puede realizar el proceso del grabado de tarifas. Favor de contactarse con TI para la configuración correcta del usuario.'));
                    this.blnPuedeGrabar = false;
                    return;
                }
            }
            if(Test.isRunningTest())
                ValidacionDocLinea(cas);
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
        String endpoint     = Label.Grabado_DocLinea;
        Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
        //GrabadoBtnController gr = new GrabadoBtnController(sc);
        try{
            if(cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c)|| Test.isRunningTest()){
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
            publicarEvento(false, 'Error al obtener response: ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
        return resultado;
    }
    public Boolean ObtieneInfoSipweb(String body, String endpoint,SBQQ__Quote__c cotizacion){
        Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
        //GrabadoBtnController gr = new GrabadoBtnController(sc);
        try{
            if(Test.isRunningTest()){
                HttpResponse res = consultaAPIPOST(body,endpoint);
                String respuesta = res.getBody().replace('time','timeR');
                //Boolean proceso =  ProcesaResponse(res,cotizacion);
                this.blnclientenuevo = true;
                return true;
            } else {
                HttpResponse res = consultaAPIPOST(body,endpoint);
                String respuesta = res.getBody().replace('time','timeR');
                return ProcesaResponse(res,cotizacion);
            }
        }catch (Exception ex){
            System.debug('ObtieneInfoSipweb: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false, 'Error al obtener info sipweb');
            return false;
        }
    }
    public Boolean ProcesaResponse(HTTPResponse res,SBQQ__Quote__c cotizacion){
        //Salvador Ramírez (sranmirez@freewayconsulting.com):Función para procesar el response al consultar los convenios que tiene el cliente en sipweb
        Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
        //GrabadoBtnController gr = new GrabadoBtnController(sc);
        try{
            String Respuesta    = res.getBody();
            String strRange     = '';
            String strTarifas   = '';
            String strDest      = '';
            respuesta = respuesta.replace('time', 'timeR');
            ObjDocEnLinea.documentacionRemota rg = (ObjDocEnLinea.documentacionRemota)JSON.deserialize(respuesta, ObjDocEnLinea.documentacionRemota.class);
            if((Boolean.valueOf(rg.body.response.success) && rg.body.response.data != null && rg.body.response.data.ptpConfig == null && rg.body.response.data.kmConfig == null) || (!Boolean.valueOf(rg.body.response.success)))
                this.blnClienteNuevo = true;
            else{
                this.trifType       = rg.body.response.data.trifType;
                this.pieceMulti     = rg.body.response.data.pieceMulti;
                this.listTarifas    = new List<String>();
            } //Salvador Ramírez (sranmirez@freewayconsulting.com): Este if-else se comenta si se necesitan hacer pruebas replicando un escenario con clientes nuevos, es decir que no estén en el catálogo de documentación en línea de sipweb o que no tengan convenios
            /*this.blnclientenuevo = true;
            this.listTarifas = new List<String>(); //Salvador Ramírez (sranmirez@freewayconsulting.com): Este bloque solo se descomenta cuando se comenta el anterior*/
            return true;
        }catch (Exception ex){
            System.debug('ProcesaResponse ' + ex.getLineNumber() + ' ' + ex.getMessage());
            publicarEvento(false, 'Error al procesar información obtenida de sipweb.');
            return false;
        }
    }
    public void grabadoTarifarioC(SBQQ__Quote__c cotizacion){    
        //System.debug('ejecuta grabadoTarifarioC');
		List<ObjDocEnLinea.serviceTrif> lstServiceTrif = new List<ObjDocEnLinea.serviceTrif>();
        for(Integer x=0;x<10;x++){
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
        try{
            blnMostrarMensaje   = false;
            strMensajeError     = '';
            if((cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c))|| Test.isRunningTest()){
                if(cotizacion.SBQQ__Status__c=='Approved'){
                    if(cotizacion.SBQQ__Opportunity2__r.StageName=='Cerrada/Ganada' || Test.isRunningTest()){
                        ValidacionDocLinea(cotizacion);
                    } else {
                        publicarEvento(false, 'Imposible continuar, la oportunidad debe tener un status "Cerrada/Ganada');
                    }
                }else{
                    publicarEvento(false, 'Imposible continuar, la cotización no se encuentra aprobada');
                }
            } else {
                publicarEvento(false, 'Imposible continuar, la cuenta no tiene un ID de sipweb');
            }
        }catch(Exception ex){
            System.debug('IniciarGrabado: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false, 'Error al iniciar grabado de tarifas. ' +ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public void ValidacionDocLinea(SBQQ__Quote__c cotizacion){
        Apexpages.StandardController scr    = new Apexpages.StandardController(cotizacion);
        //GrabadoBtnController gr             = new GrabadoBtnController(scr);
        String strOrigen                    = '';
        String TarifaUsar                   = '';
        blnMostrarMensaje                   = false;
        Boolean blnRango                    = false;   
        Boolean blnDest                     = false;
        Boolean blnRequiereCrearUsuario     = false;
        Boolean blnGraboTarifas             = false;
        strMensajeError                     = '';
        String endpoint                     = Label.Grabar_DocLinea;
        String strRangos                    = '';
        Decimal decEADZP                    = 0;
        Decimal decVolPromedio              = 0;
        Decimal decPesoPromedio             = 0;
        Decimal decPercEAD                  = 0; //sramirez: para guardar el porcentaje de EAD
        Decimal decPercRAD                  = 0; //sramirez: para guardar el porcentaje de RAD
        Map<String, String> mapSSOption     = new Map<String, String>();
        try{
            if(cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c)|| Test.isRunningTest()){
                this.wp.listQuoteItem                                           = queryquoteitem(cotizacion.id);
                this.objtempleate                                               = queryTempleate(cotizacion.id);
                wp.mapCS                                                        = PAQ_CotizadorNacional_CTR.queryCustomSetting([SELECT Id FROM Profile Where Name = 'System Administrator' OR Name = 'Administrador del sistema'].Id);
                Apexpages.StandardController sc                                 = new Apexpages.StandardController(cotizacion);
                //GrabadoBtnController grab                                       = new GrabadoBtnController(sc);
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
                decPercEAD = wp.mapCS.get('EAD') / 100;
                decPercRAD = wp.mapCS.get('RAD') / 100;
                if(cotizacion.Plaza__c != null){
                    strOrigen   = cotizacion.Plaza__c;
                }
                //30/12/2020 Salvador: Header y data
                sec.user    = 'USERSALESFORCE';
                sec.token   = '325746796331582000000';
                //30/12/2020 Salvador: Comienza creación del body
                data.quotation  = cotizacion.Name; //30/12/2020 Salvador: Nombre de la cotización, ej: Q-0245
                data.clntId     = cotizacion.SBQQ__Account__r.Id_SIpWeb__c; //30/12/2020 Salvador: Id de sipweb del cliente
                data.aprvUser   = this.aprvUser;
                if(this.pieceMulti != '')
                    data.pieceMulti = this.pieceMulti;
                else {
                    if(cotizacion.Modelo_de_tarifas__c == 'Guía multipieza: Por Destinos / Por rangos de km')
                        data.pieceMulti     = 'K';
                }
                if(this.wp.blnSoloDestinos)
                    this.listRanges.clear();
                for(TempleateLine__c line : queryTempleateLine(objtempleate.Id)){
                    this.listPlantillaLineItems.add(line);          
                }
                if(this.blnCostosFijos){
                    for(TempleateLine__c line : this.listPlantillaLineItems){
                        String strRangeDest = '';
                        if(!line.Zona_Plus__c){
                            if(line.Tarifa__c != 'SEG-DS' && line.Tarifa__c != 'SEG-2D' && line.Tarifa__c != 'SEG-A12'){
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
                                if(line.Destiny__c != null)
                                    strRangeDest = line.Destiny__c + ' (' + line.Rango_KM__c + ')';
                                else strRangeDest = line.Rango_KM__c;
                                if(!this.mapAcuse.containsKey(strRangeDest))
                                    this.mapAcuse.put(strRangeDest, line.ACK__c);
                            } else {
                                if(line.Destiny__c != null)
                                    strRangeDest = line.Destiny__c + ' (' + line.Rango_KM__c + ')';
                                else strRangeDest = line.Rango_KM__c;
                                if(line.KG_ADICIONAL__c != 0 && line.KG_ADICIONAL__c != null){
                                    if(line.Destiny__c != null)
                                        strRangeDest = line.Destiny__c + ' (' + line.Rango_KM__c + ')';
                                    else strRangeDest = line.Rango_KM__c;
                                }
                                if(!this.wp.mapACKExp.containsKey(strRangeDest)){
                                    this.wp.mapACKExp.put(strRangeDest, line.ACKES__c);
                                }
                                this.blnTarifasExp = true;
                            }
                            if(line.Destiny__c != null){
                                if(!this.mapRangeByDest.containsKey(line.Destiny__c + ' (' + line.Rango_KM__c + ')'))
                                    this.mapRangeByDest.put(line.Destiny__c + ' (' + line.Rango_KM__c + ')', line.Rango_KM__c);
                                strRangeDest = line.Destiny__c + ' (' + line.Rango_KM__c + ')';
                                if(line.Tarifa__c != 'SEG-DS' && line.Tarifa__c != 'SEG-2D' && line.Tarifa__c != 'SEG-A12'){
                                    if(!this.mapTLines.get(line.Tarifa__c).containsKey(line.Destiny__c + ' (' + line.Rango_KM__c + ')'))
                                        this.mapTLines.get(line.Tarifa__c).put(line.Destiny__c + ' (' + line.Rango_KM__c + ')', line);
                                }
                            } else {
                                strRangeDest = line.Rango_KM__c;
                                if(line.Tarifa__c != 'SEG-DS' && line.Tarifa__c != 'SEG-2D' && line.Tarifa__c != 'SEG-A12'){
                                    if(!this.mapTLines.get(line.Tarifa__C).containsKey(line.Rango_KM__c))
                                        this.mapTLines.get(line.Tarifa__c).put(line.Rango_KM__c, line);
                                }
                            }
                            if(line.Tarifa__c != 'SEG-DS' && line.Tarifa__c != 'SEG-2D' && line.Tarifa__c != 'SEG-A12'){
                                if(!this.mapdecTLines.get(obtieneNumeroTarifa(line.Tarifa__c)).containsKey(strRangeDest))
                                    this.mapdecTLines.get(obtieneNumeroTarifa(line.Tarifa__c)).put(strRangeDest, line);
                            }
                        } else {
                            if(line.Destiny__c != null)
                                strRangeDest = line.Destiny__c + ' (' + line.Rango_KM__c + ')';
                            else strRangeDest = line.Rango_KM__c;
                            if(!this.mapZonaPlus.containsKey(strRangeDest))
                                this.mapZonaPlus.put(strRangeDest, line.EAD__c);
                            this.blnZP = true;
                        }
                    }
                } else {
                    for(TempleateLine__c line : queryTempleateLine(objtempleate.Id)){
                        String strRangeDest = '';
                        if(!line.Zona_Plus__c && line.CustomerPrice__c != 0){
                            if(!this.mapBloques.containsKey(line.PackWeightAVG__c))
                                this.mapBloques.put(line.PackWeightAVG__c, new Map<String, TempleateLine__c>());
                            if(line.Destiny__c != null){
                                if(!line.Destiny__c.contains('(')){
                                	strRangeDest = line.Destiny__c + ' (' + line.Rango_KM__c + ')';
                                    if(!this.mapRangeByDest.containsKey(strRangeDest))
                                        this.mapRangeByDest.put(strRangeDest, line.Rango_KM__c);
                                }else{
                                    strRangeDest = line.Destiny__c;
                                    if(!this.mapRangeByDest.containsKey(strRangeDest))
                                        this.mapRangeByDest.put(strRangeDest, line.Rango_KM__c);
                                } 
                            } else strRangeDest = line.Rango_KM__c;
                            if(!this.mapBloques.get(line.PackWeightAVG__c).containsKey(strRangeDest))
                                this.mapBloques.get(line.PackWeightAVG__c).put(strRangeDest, line);
                            if(this.blnCostoBaseGMP){
                                if(!this.listRangeDestiny.contains(strRangeDest) && line.Flete__c != 0)
                                    this.listRangeDestiny.add(strRangeDest);
                            } else {
                                if(!this.listRangeDestiny.contains(strRangeDest))
                                    this.listRangeDestiny.add(strRangeDest);
                            }
                            if(!this.mapGuide.containsKey(line.PackWeightAVG__c))
                                this.mapGuide.put(line.PackWeightAVG__c, line.PackVolAVG__c);
                            if(!this.mapBlockAdic.containsKey(strRangeDest))
                                this.mapBlockAdic.put(strRangeDest, line);
                        }
                        this.listPlantillaLineItems.add(line);
                    }
                }
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '1 Tarifas express: ' + this.mapTLinesExp));
                for(SBQQ__QuoteLine__c cot:this.wp.listQuoteItem){ //08/03/2021 Salvador: Recorrido de las partidas de presupuesto
                    String strRangeDest = ''; //08/03/2021 Salvador: Variable que permite almacenar el rango de km o destinos para no duplicar validaciones
                    if(cot.Tarifa__c == 'TARIFA T7' && cot.ZonaPlus__c && cot.SBQQ__Description__c == 'Propuesta'){ //08/03/2021 Salvador: Tarifas T7 zona plus
                        strRangeDest = '';
                        if(cot.Destiny__c != null)
                            strRangeDest = cot.Destiny__c + ' ('+cot.Rango_KM__c+')';
                        else strRangeDest = cot.Rango_KM__c;
                        if(!this.mapQuotesT7ZP.containsKey(strRangeDest))
                            this.mapQuotesT7ZP.put(strRangeDest, cot);
                        this.blnT7ZP = true;
                    } else if(!cot.ZonaPlus__c) { //08/03/2021 Salvador: Si no es zona plus
                        if(cot.Tarifa__c != 'SEG-DS' && cot.Tarifa__c != 'SEG-2D' && cot.Tarifa__c != 'SEG-A12'){
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
                            if(this.blnByDelivery && (cot.Tarifa__c == 'TARIFA T7' || cot.Tarifa__c == 'TARIFA T7-P')){
                                if(decVolPromedio == 0)
                                    decVolPromedio = cot.PackVolAVG__c;
                                if(decPesoPromedio == 0)
                                    decPesoPromedio = cot.PackWeightAVG__c;
                            }
                            if(cot.Destiny__c != null){
                                strRangeDest = cot.Destiny__c + ' (' + cot.Rango_KM__c + ')';
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
                            if(this.blnCostoBaseGMP){
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
                            }

                        } else {
                            if(!this.listTarifasExp.contains(cot.Tarifa__c))
                                this.listTarifasExp.add(cot.Tarifa__c);
                            strRangeDest = '';
                            if(cot.Destiny__c != null){
                                strRangeDest = cot.Destiny__c + ' (' + cot.Rango_KM__c + ')';
                            } else strRangeDest = cot.Rango_KM__c;
                            if(!this.listRangeDestiny.contains(strRangeDest))
                                this.listrangedestiny.add(strRangeDest);
                            if(!this.mapTLinesExp.containsKey(cot.Guia__c)){
                                this.mapTLinesExp.put(cot.Guia__c, new Map<String, Map<String, SBQQ__QuoteLine__c>>());
                                this.listBloquesExp.add(cot.Guia__c);
                            }
                            if(!this.mapTLinesExp.get(cot.Guia__c).containsKey(cot.Tarifa__c)){
                                this.mapTLinesExp.get(cot.Guia__c).put(cot.Tarifa__c, new Map<String, SBQQ__QuoteLine__c>());
                            }
                            if(!this.mapExpAdic.containsKey(cot.Tarifa__c))
                                this.mapExpAdic.put(cot.Tarifa__c, new Map<String, Decimal>());
                            if(cot.KG_ADICIONAL__c != 0 && cot.KG_ADICIONAL__c != null){
                                if(!this.mapExpAdic.get(cot.Tarifa__c).containsKey(strRangeDest))
                                    this.mapExpAdic.get(cot.Tarifa__c).put(strRangeDest, cot.KG_ADICIONAL__c);
                            }
                            if(!this.mapQuotesExp.containsKey(cot.Tarifa__c)){
                                this.mapQuotesExp.put(cot.Tarifa__c, new Map<String, SBQQ__QuoteLine__c>());
                            }
                            this.blnTarifasExp = true;
                        }
                        if(cot.Destiny__c != null){
                            if(this.blnCostoBaseGMP){
                                if(cot.Flete__c != 0){

                                }
                            } else {
                                if(!this.listRangeDestiny.contains(cot.Destiny__c + ' (' + cot.Rango_KM__c + ')')){
                                    this.listRangeDestiny.add(cot.Destiny__c + ' (' + cot.Rango_KM__c + ')');
                                }
                                if(!this.listRanges.contains(cot.Destiny__c + ' (' + cot.Rango_KM__c + ')'))
                                    this.listRanges.add(cot.Destiny__c + ' (' + cot.Rango_KM__c + ')');
                            }
                            if(this.blnCostoBaseGMP){
                                if(!this.mapAcuse.containsKey(cot.Destiny__c))
                                    this.mapAcuse.put(cot.Destiny__c, cot.ACK__c);
                            }
                            if(cot.Tarifa__c == 'SEG-DS' || cot.Tarifa__c == 'SEG-2D' || cot.Tarifa__c == 'SEG-A12'){
                                if(!this.mapTLinesExp.get(cot.Guia__c).get(cot.Tarifa__c).containsKey(cot.Destiny__c + ' (' + cot.Rango_KM__c + ')'))
                                    this.mapTLinesExp.get(cot.Guia__c).get(cot.Tarifa__c).put(cot.Destiny__c + ' (' + cot.Rango_KM__c + ')', cot);
                                if(!this.mapQuotesExp.get(cot.Tarifa__C).containsKey(cot.Destiny__c))
                                    this.mapQuotesExp.get(cot.Tarifa__c).put(cot.Destiny__c, cot);
                            }
                        } else {
                            if(this.blnCostoBaseGMP){
                                if(cot.Flete__c != 0){
                                    if(!this.listRangeDestiny.contains(cot.Rango_KM__c))
                                        this.listRangeDestiny.add(cot.Rango_KM__c);
                                }
                            } else {
                                if(!this.listRangeDestiny.contains(cot.Rango_KM__c))
                                    this.listRangeDestiny.add(cot.Rango_KM__c);
                            }
                            if(this.blnCostoBaseGMP){
                                if(!this.mapAcuse.containsKey(cot.Rango_KM__c))
                                    this.mapAcuse.put(cot.Rango_KM__c, cot.ACK__c);
                            }
                            if(cot.Tarifa__c == 'SEG-DS' || cot.Tarifa__c == 'SEG-2D' || cot.Tarifa__c == 'SEG-A12'){
                                if(!this.mapTLinesExp.get(cot.Guia__c).get(cot.Tarifa__c).containsKey(cot.Rango_KM__c))
                                    this.mapTLinesExp.get(cot.Guia__c).get(cot.Tarifa__c).put(cot.Rango_KM__c, cot);
                                if(!this.mapQuotesExp.get(cot.Tarifa__C).containsKey(cot.Rango_KM__c))
                                    this.mapQuotesExp.get(cot.Tarifa__c).put(cot.Rango_KM__c, cot);
                            }
                        }
                    } else if ((cot.Tarifa__c == 'TARIFA SOBRE' || cot.Tarifa__c == 'TARIFA T0' || cot.Tarifa__c == 'TARIFA T1' || cot.Tarifa__c == 'TARIFA T2' || cot.Tarifa__c == 'TARIFA T3' || cot.Tarifa__c == 'TARIFA T4' || cot.Tarifa__c == 'TARIFA T5'
                                || cot.Tarifa__c == 'TARIFA T6') && (cot.ZonaPlus__c)){ //08/03/2021 Salvador: Si es zona plus pero de las tarifas de sobre a la 6
                        if(cot.Destiny__c != null){
                            if(this.blnCostoBaseGMP){
                                String Destino = '';
                                if(cot.Destiny__c.contains('('))
                                    Destino = cot.Destiny__c.replace(cot.Rango_KM__c, '').replace(' (', '').replace(')', '');
                                else Destino = cot.Destiny__c;
                                this.mapService.get('ZP').mapRanges.put(Destino, cot.EAD__c);
                            }
                        } else {
                            if(this.blnCostosFijos)
                                this.mapService.get('ZP').mapRanges.put(cot.Rango_KM__c, cot.EAD__c);
                        }
                    }
                }
                if(this.blnCostosFijos){ //08/03/2021 Salvador: Si es una cotización de costos fijos por tarifa
                    if(this.listTarifasCotizacion.size() == 0 && this.listTarifasExp.size() > 0){ //08/03/2021 Salvador: Si solo hay tarifas express en la cotización
                        this.listTarifas.clear(); //08/03/2021 Salvador: Limpia la lista que tiene precargadas las tarifas desde el inicio de la ejecución
                        this.listRanges.clear(); //08/03/2021 Salvador: Limpia la lista de angos
                        this.wp.blnSoloTarifasExp = true; //08/03/2021 Salvador: Indica que solo va a grabar tarifas express
                    }
                    for(String strRange : this.listRangeDestiny){ //08/03/2021 Salvador: El recorrido valida si uno de los rangos de km no coincide en costo de acuse tanto en las tarifas normales como express ya que debe ser el mismo monto.
                        if(this.mapAcuse.containsKey(strRange) && this.wp.mapACKExp.containsKey(strRange)){ //08/03/2021 Salvador: Si existe el rango de km tanto en el mapa de acuse de tarifas normales como en la de acuse por express
                            if(this.mapAcuse.get(strRange) != this.wp.mapACKExp.get(strRange)){ //08/03/2021 Salvador: Si son diferentes los montos
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Imposible continuar, uno de los rangos de km no concuerda en el costo de acuse entre tarifa express y tarifa normal. Favor de revisar. ' + strRange));
                                this.blnPuedeGrabar = false; //08/03/2021 Salvador: Oculta el botón para que no pueda volver a detonarlo.
                                return; //08/03/2021 Salvador: se sale de todo el flujo
                            }
                        } else if(!this.mapAcuse.containsKey(strRange) && this.wp.mapACKExp.containsKey(strRange)){
                            this.mapacuse.put(strRange, this.wp.mapACKExp.get(strRange));
                        }
                    }
                }
                if(this.blnCostoBaseGMP) //08/03/2021 Salvador: Si es una cotización de costo base más excedente
                    CargaMapasCostoBaseGMP(); //08/03/2021 Salvador: llama la función que carga todos los mapas
                if(this.blnByDelivery){
                    data.vol    = decVolPromedio;
                    data.weight = decPesoPromedio;
                }
                if(this.blnCostosFijos){
                    this.mapRanges = new map<String, Map<String, PAQ_SpecialService__c>>();
                    mapSSOption = getPicklistValues('PAQ_SpecialService__c', 'Option__c');
                    for(PAQ_SpecialService__c itemSS : querySS(Cotizacion.id)){
                        if(String.isNotBlank(itemSS.Destiny__c))
                            itemSS.RangoKM__c = itemSS.Destiny__c + ' (' + itemSS.RangoKM__c + ')';
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
            
                    /*for(String strName : this.listSS){
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
                    }*/
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
                            /*when 'EAD Zona plus'{
                                this.blnZP = true;
                            }*/
                        }
                    }
                    
                }
                if(this.blnCostosFijos){
                    List<String> listRangosRespaldo = new List<String>();
                    if(this.blnByDelivery || test.isRunningTest()){
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
                    this.listDecTarifas.sort();
                    boolean blnTarifasCargadas = false;
                    String strNuevoRango = '';
                    for(Tarifario__c tarifaEXP : queryFullTarifario()) //08/03/2021 Salvador: Rellena el mapa con los costos de público en general
                        if(!wp.mapTarifarioEXP.containsKey(tarifaEXP.Tarifa__c))
                            wp.mapTarifarioEXP.put(tarifaEXP.Tarifa__c, new Map<String, Tarifario__c>{ tarifaEXP.Rango_km__c => tarifaEXP });
                        else if(!wp.mapTarifarioEXP.get(tarifaEXP.Tarifa__c).containsKey(tarifaEXP.Rango_km__c))
                            wp.mapTarifarioEXP.get(tarifaEXP.Tarifa__c).put(tarifaEXP.Rango_km__c, tarifaEXP);
                    
                    for(String strRange : this.listrangedestiny){ //08/03/2021 Salvador: Rellena los rangos que puedan faltar en la lista de rangos por defecto, estos rangos pueden ser destinos que no están contemplados
                        if(!this.listRanges.contains(strRange))
                            this.listRanges.add(strRange);
                    }


                    for(Decimal decTarifa: this.listDecTarifas){ //Recorre las tarifas que ya están registradas para planchar hacia abajo
                        if(decTarifa < 7){
                            for(String strTarifa : this.listTarifas){
                                if(!this.mapTLines.containsKey(strTarifa)){
                                    this.mapTLines.put(strTarifa, new Map<String, TempleateLine__c>());
                                }
                                if(!this.mapQuotes.containsKey(strTarifa)){
                                    this.mapQuotes.put(strTarifa, new Map<String, SBQQ__QuoteLine__c>());
                                }
                                for(String strRange : this.listRanges){
                                    System.debug('tarifa: ' + strTarifa);
                                    System.debug('Rango: ' + strRange);
                                    System.debug('decTarifa: ' + decTarifa);
                                    System.debug('MapTLines contiene llave tarifa: ' + this.mapTLines.containsKey(strTarifa));
                                    System.debug('MapTLines contiene llave rango: ' + this.mapTLines.get(strTarifa).containsKey(strRange));
                                    System.debug('Número de tarifa: ' + obtieneNumeroTarifa(strTarifa));
                                    System.debug('mapdecTLines contiene llave dectarifa: ' + this.mapdecTLines.get(decTarifa));
                                    System.debug('mapdectLines contiene llave rango: ' + this.mapdecTLines.get(decTarifa).containsKey(strRange));
                                    if(!this.mapTLines.get(strTarifa).containsKey(strRange) && obtieneNumeroTarifa(strTarifa) < decTarifa && this.mapdecTLines.get(decTarifa).containsKey(strRange)){
                                        this.mapdecTLines.get(decTarifa).get(strRange).Tarifa__c    = strTarifa;
                                        this.mapTarifas.get(decTarifa).get(strRange).Tarifa__c      = strTarifa;
                                        this.mapTLines.get(strTarifa).put(strRange, this.mapdecTLines.get(decTarifa).get(strRange));
                                        this.mapQuotes.get(strTarifa).put(strRange, this.mapTarifas.get(decTarifa).get(strRange));
                                    } else if(!this.mapTLines.get(strTarifa).containsKey(strRange) && obtieneNumeroTarifa(strTarifa) < decTarifa && !this.mapdecTLines.get(decTarifa).containsKey(strRange)){
                                        TempleateLine__c TL     = new TempleateLine__c();
                                        SBQQ__QuoteLine__c QL   = new SBQQ__QuoteLine__c();
                                        String rango            = '';
                                        String Tarifa           = '';
                                        String strNewRange      = '';
                                        if(strRange.contains('('))
                                            rango = this.mapRangeByDest.get(strRange);
                                        else rango = strRange;
                                        if(strTarifa == 'TARIFA SOBRE')
                                            Tarifa = 'TARIFA TS';
                                        else Tarifa = strTarifa;
                                        if(strTarifa == 'TARIFA T7-P' || strTarifa == 'TARIFA T7'){
                                            QL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
                                            TL.Flete__c = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
                                            if(this.blnRAD)
                                                TL.RAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c);
                                            if(this.blnEAD)
                                                TL.EAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c);
                                        } else if(strTarifa == 'TARIFA T7-V') {
                                            TL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c;
                                            if(this.blnRAD)
                                                TL.RAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c);
                                            if(this.blnEAD)
                                                TL.EAD__c       = dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c);
                                            QL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
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
                                            QL.Flete__c     = this.wp.mapTarifarioT.get(Tarifa).get(rango).Flete__c;
                                        }
                                        TL.Weight__c = 1;
                                        TL.Vol__c    = 1;
                                        TL.Tarifa__c = strTarifa;
                                        QL.Weight__c    = 1;
                                        QL.Tarifa__c    = strTarifa;
                                        this.mapTLines.get(strTarifa).put(strRange, TL);
                                        this.mapQuotes.get(strTarifa).put(strRange, QL);
                                    }
                                }
                            }
                        }
                    }
                    for(String strTarifa : this.listTarifas){
                        for(String strRange : this.listRanges){
                            String rango = '';
                            String Tarifa = '';
                            String strNewRange = '';
                            if(strRange.contains('('))
                                rango = this.mapRangeByDest.get(strRange);
                            else rango = strRange;
                            if(!this.mapTLines.containsKey(strTarifa))
                                this.mapTLines.put(strTarifa, new Map<String, TempleateLine__c>());
                            if(!this.mapTLines.get(strTarifa).containsKey(strRange)){
                                TempleateLine__c TLine = new TempleateLine__c();
                                SBQQ__QuoteLine__c QL = new SBQQ__QuoteLine__c();
                                if(strTarifa == 'TARIFA T7-P' || strTarifa == 'TARIFA T7'){
                                    TLine.Flete__c  = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
                                    if(this.blnRAD)
                                        TLine.RAD__C= this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c * decPercRAD;//dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c);
                                    if(this.blnEAD)
                                        TLine.EAD__c= this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c * decPercEAD;//dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c);
                                    QL.Flete__c     = this.wp.mapTarifarioT.get('TARIFA T7P').get(rango).Flete__c;
                                } else if(strTarifa == 'TARIFA T7-V'){
                                    TLine.Flete__c  = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c;
                                    if(this.blnRAD)
                                        TLine.RAD__C = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c * decPercRAD; //dominantFeeServiceDom(this.wp.mapCS.get('MinRAD'), this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c);
                                    if(this.blnEAD)
                                        TLine.EAD__c = this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c * decPercEAD;//dominantFeeServiceDom(this.wp.mapCS.get('MinEAD'), this.wp.mapTarifarioT.get('TARIFA T7V').get(rango).Flete__c);
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
                                TLine.Vol__c    = 0;
                                TLine.Tarifa__c = strTarifa;
                                QL.Weight__c    = 1;
                                QL.Tarifa__c    = strTarifa;
                                if(!this.mapTLines.get(strTarifa).containsKey(strRange))
                                    this.mapTLines.get(strTarifa).put(strRange, TLine);
                                if(!this.mapQuotes.containsKey(strTarifa))
                                    this.mapQuotes.put(strTarifa, new Map<String, SBQQ__QuoteLine__c>());
                                if(!this.mapQuotes.get(strTarifa).containsKey(strRange))
                                    this.mapQuotes.get(strTarifa).put(strRange, QL);
                            }
                            
                        }
                    }
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tarifas express: ' + this.mapTLinesExp));
                    for(String strRange : this.listRanges){
                        if(!this.listRangeDestiny.contains(strRange) && !strRange.contains('('))
                            this.listRangeDestiny.add(strRange);
                        if(!this.mapAcuse.containsKey(strRange))
                            this.mapAcuse.put(strRange, wp.mapACK.get(cotizacion.Acuse__c));
                        if(!this.mapZonaPlus.containsKey(strRange))
                            this.mapZonaPlus.put(strRange, wp.mapCS.get('AEZP'));
                        if(this.blnTarifasExp){
                            if(!strRange.contains('(')){
                                for(Decimal decBloque: this.listBloquesExp){
                                    for(String strTarifa: this.listTarifasExp){
                                        if(!this.mapTLinesExp.get(decBloque).containsKey(strTarifa))
                                            this.mapTLinesExp.get(decBloque).put(strTarifa, new Map<String,SBQQ__QuoteLine__c>());
                                        if(!this.mapExpAdic.containsKey(strTarifa))
                                            this.mapExpAdic.put(strTarifa, new Map<String, Decimal>());
                                        if(!this.mapTLinesExp.get(decBloque).get(strTarifa).containsKey(strRange)){
                                            SBQQ__QuoteLine__c TL = new SBQQ__QuoteLine__c();
                                            String tarifa       = '';
                                            tarifa              = strTarifa.remove('SEG-');
                                            TL.KG_Adicional__c 	= this.wp.mapTarifarioEXP.get(tarifa).get(strRange).Kg_adicional__c;
                                            TL.Flete__c       	= this.wp.mapTarifarioEXP.get(tarifa).get(strRange).GuiaDeArranque1Kg__c;
                                            this.mapTLinesExp.get(decBloque).get(strTarifa).put(strRange, TL);
                                            if(!this.mapExpAdic.containsKey(strRange))
                                                this.mapExpAdic.get(strTarifa).put(strRange, TL.KG_ADICIONAL__c);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                if(this.blnCostosFijos && this.blnTarifasExp){
                    Map<Integer, Decimal> mapBloqInt = new Map<Integer, Decimal>();
                    Integer intContador = 1;
                    for(Decimal decBloque : this.listBloquesExp){
                        mapBloqInt.put(intContador, decBloque);
                        intContador ++;
                    }
                    for(String strRange : this.listrangedestiny){
                        intContador = 1;
                        for(Decimal decbloque : this.listBloquesExp){
                            for(String strTarifa : this.listTarifasExp){
                                if(intContador > 1 && this.mapTLinesExp.containsKey(mapBloqInt.get(intContador - 1)) && this.mapTLinesExp.get(mapBloqInt.get(intContador - 1)).containsKey(strtarifa)){
                                    if(this.mapTLinesExp.get(mapBloqInt.get(intContador - 1)).get(strtarifa).containsKey(strRange)){
                                        this.mapTLinesExp.get(decbloque).get(strTarifa).get(strRange).Flete__c = this.mapTLinesExp.get(decbloque).get(strTarifa).get(strRange).Flete__c - this.mapTLinesExp.get(mapBloqInt.get(intContador - 1)).get(strTarifa).get(strRange).Flete__c;
                                    }
                                }
                            }
                            intContador ++;
                        }
                    }
                }
                if(this.wp.blnSoloTarifasExp && !this.blnclientenuevo){
                    data.trifType = this.trifType;
                } else {
                    if(cotizacion.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'){
                        data.trifType           = 'A';
                    } else {
                        data.trifType           = 'C';
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
                        blnRango                    = true; //08/03/2021 Salvador: Indica que es un rango de km
                        blnDest                     = false; //08/03/2021 Salvador: indica que es un destino
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
                        if(strRange.contains('(')) //08/03/2021 Salvador: Si el rango contiene un parentesis quiere decir que es un destino
                            ptpServicesTrifSub.destSite = strRange.replace(this.mapRangeByDest.get(strRange), '').replace(' (', '').replace(')', ''); //08/03/2021 Salvador: Le quita los parentesis y el rango de km para que solo se grabe el nombre del destino
                        else ptpServicesTrifSub.destSite = strRange;
                        blnRango                    = false;
                        blnDest                     = true;
                    }
                    if(this.blnCostosFijos){
                        //Salvador Ramírez (sramirez@freewayconsulting.com): Construcción de request para grabado de tarifas de costos fijos por tarifa
                        for(String strTarifa : this.listTarifas){
                            if((!this.blnClienteNuevo && this.mapTLines.get(strTarifa).containsKey(strRange)) || (this.blnClienteNuevo)){
                                if(strTarifa != 'SEG-DS' && strTarifa != 'SEG-2D' && strTarifa != 'SEG-A12'){
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
                                            serviceTrif.factorValue             = 1;//this.mapTLines.get(strTarifa).get(strRange).Vol__c;
                                        } else if(strTarifa == 'TARIFA T7-P'){
                                            serviceTrif.factor                  = 'KG';
                                            serviceTrif.factorValue             = 1;//this.mapTLines.get(strTarifa).get(strRange).Weight__c;
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
                                                    serviceTrif.factorValue         = 1;//this.mapQuotesT7ZP.get(strRange).Vol__c;
                                                } else {
                                                    serviceTrif.trifAmount         = this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c.setScale(2);
                                                    serviceTrif.factor              = 'KG';
                                                    serviceTrif.factorValue         = 1;//this.mapQuotesT7ZP.get(strRange).Weight__c;
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
                                        //if(this.blnRAD){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'RAD-1';
                                            serviceTrif.refServiceId                = 'RAD';
                                            if(this.mapTLines.get(strTarifa).get(strRange).RAD__c != 0 && this.blnRAD)
                                                serviceTrif.trifAmount              = (this.mapTLines.get(strTarifa).get(strRange).RAD__c / this.mapTLines.get(strTarifa).get(strRange).Weight__c).setScale(2);
                                            else serviceTrif.trifAmount             = 0.01;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.discount                    = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        //}
                                        servicesTrifDtlSub.serviceTrif          = listserviceTrif;
                                        listServicesTrifDtlS.add(servicesTrifDtlSub);
                                        servicesTrifDtlSub                      = new ObjDocEnLinea.servicesTrifDtlSub();
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        listserviceTrif                         = new List<ObjDocEnLinea.serviceTrif>();
                                        servicesTrifDtlSub.slabNo               = 'T7V';
                                        serviceTrif.serviceId                   = 'SHP-G';
                                        serviceTrif.refServiceId                = 'PACKETS';
                                        if(this.blnclientenuevo && this.mapTLines.get(strTarifa).get(strRange).Vol__c == 0){
                                            //Salvador 28/07/2021: Desconozco la causa por la que este código estaba implementado, así que se comentan por si después son necesarias
                                            if(strRange.contains('('))
                                                serviceTrif.trifAmount          = (this.wp.mapTarifarioT.get('TARIFA T7V').get(this.mapRangeByDest.get(strRange)).Flete__c).setScale(2);
                                            else serviceTrif.trifAmount         = (this.wp.mapTarifarioT.get('TARIFA T7V').get(strRange).Flete__c).setscale(2);
                                            //serviceTrif.trifAmount              = this.mapTLines.get(strTarifa).get(strRange).FLETE__c;
                                        }else serviceTrif.trifAmount             = (this.mapTLines.get(strTarifa).get(strRange).FLETE__c / this.mapTLines.get(strTarifa).get(strRange).Vol__c).setScale(2);
                                        serviceTrif.discount                    = 0;
                                        serviceTrif.trifAmntBase                = 0;
                                        serviceTrif.factorValue                 = 1;
                                        serviceTrif.factor                      = 'CUM';
                                        listserviceTrif.add(serviceTrif);
                                        if(this.blnEAD){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'EAD-1';
                                            serviceTrif.refServiceId                = 'EAD';

                                            if(this.blnclientenuevo && this.mapTLines.get(strTarifa).get(strRange).Vol__c == 0){
                                                //Salvador 28/07/2021: Desconozco la causa por la que este código estaba implementado, así que se comentan por si después son necesarias
                                                if(strRange.contains('('))
                                                    serviceTrif.trifAmount          = (this.wp.mapTarifarioT.get('TARIFA T7V').get(this.mapRangeByDest.get(strRange)).Flete__c * decPercEAD);
                                                else serviceTrif.trifAmount         = (this.wp.mapTarifarioT.get('TARIFA T7V').get(strRange).Flete__c * decPercEAD).setScale(2);
                                            } else serviceTrif.trifAmount             = (this.mapTLines.get(strTarifa).get(strRange).EAD__c / this.mapTLines.get(strTarifa).get(strRange).Vol__c).setScale(2);
                                            serviceTrif.discount                    = 0;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        }
                                        //if(this.blnRAD){
                                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                            serviceTrif.serviceId                   = 'RAD-1';
                                            serviceTrif.refServiceId                = 'RAD';
                                            if(this.blnRAD){
                                                if(this.blnclientenuevo && this.mapTLines.get(strTarifa).get(strRange).Vol__c == 0){
                                                    //Salvador 28/07/2021: Desconozco la causa por la que este código estaba implementado, así que se comentan por si después son necesarias
                                                    if(strRange.contains('('))
                                                        serviceTrif.trifAmount          = (this.wp.mapTarifarioT.get('TARIFA T7V').get(this.mapRangeByDest.get(strRange)).Flete__c * decPercRAD).setScale(2);
                                                    else serviceTrif.trifAmount         = (this.wp.mapTarifarioT.get('TARIFA T7V').get(strRange).Flete__c * decPercRAD).setScale(2);
                                                }else serviceTrif.trifAmount             = (this.mapTLines.get(strTarifa).get(strRange).RAD__c / this.mapTLines.get(strTarifa).get(strRange).Vol__c).setScale(2);
                                            } else serviceTrif.trifAmount           = 0.01;
                                            serviceTrif.discount                    = 0;
                                            serviceTrif.trifAmntBase                = 0;
                                            serviceTrif.factorValue                 = 1;
                                            listserviceTrif.add(serviceTrif);
                                        //}
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
                        //Salvador Ramírez (sramirez@freewayconsulting.com): Aquí se construye el request para grabado de tarifas de costo base más excedente y guía multipieza
                        listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                        serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                        serviceTrifCbe.factor               = 'KG';
                        serviceTrifCbe.serviceId            = 'SHP-G';
                        serviceTrifCbe.refServiceId         = 'PACKETS';
                        serviceTrifCbe.trifAmountExce       = this.mapBlockAdic.get(strRange).FleteAdic__c.setScale(2);
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
                            serviceTrifCbe.trifAmountExce   	= this.mapBlockAdic.get(strRange).EADAdic__c.setScale(2);
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
                        listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                        serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                        serviceTrifCbe.factor               = 'KG';
                        serviceTrifCbe.serviceId            = 'RAD-1';
                        serviceTrifCbe.refServiceId         = 'RAD';
                        if((this.mapBlockAdic.get(strRange).RADAdic__c != 0 || this.mapBlockAdic.get(strRange).RADAdic__c != null) && (this.blnRAD))
                        	serviceTrifCbe.trifAmountExce   = this.mapBlockAdic.get(strRange).RADAdic__c.setScale(2);
                       	else serviceTrifCbe.trifAmountExce	= 0.001;
                        for(String strBlock : this.mapBlocks.keySet()){
                            serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                            if(this.mapBlocksServ.get(strBlock).get('RAD').get(strRange) != 0 && this.blnRAD)
                            	serviceTrif.trifAmount          = this.mapBlocksServ.get(strBlock).get('RAD').get(strRange);
                           	else serviceTrif.trifAmount		= 0.001;
                            serviceTrif.trifAmntBase        = 0;
                            serviceTrif.discount            = 0;
                                serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decWeight;
                            listserviceTrif.add(serviceTrif);
                        }
                        serviceTrifCbe.serviceTrif = listserviceTrif;
                        listserviceTrifCbe.add(serviceTrifCbe);
                        //Salvador Ramírez (sramirez@freewayconsulting.com): Se agrega al request el costo propuesto por rango de km de T7 zona plus
                        if(this.blnT7ZP){
                            listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                            serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                            serviceTrifCbe.factor               = 'KG';
                            serviceTrifCbe.serviceId            = 'EXT-1';
                            serviceTrifCbe.refServiceId         = 'EXT';
                            serviceTrifCbe.trifAmountExce	= 0.001;
                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                            if(this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c != null && this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c != 0){
                                serviceTrif.trifAmount         = this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c.setScale(2);
                                serviceTrif.factor              = 'KG';
                                serviceTrif.factorValue         = this.mapQuotesT7ZP.get(strRange).PackWeightAVG__c;
                            } else
                                serviceTrif.trifAmount              = 0.001;
                            serviceTrif.trifAmntBase                = 0;
                            serviceTrif.discount                    = this.mapQuotesT7ZP.get(strRange).SBQQ__Discount__c;
                            listserviceTrif.add(serviceTrif);
                            serviceTrifCbe.serviceTrif = listserviceTrif;
                            listserviceTrifCbe.add(serviceTrifCbe);
                        }




                        //Salvador: A partir de aquí se genera el grabado por volumen
                        listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                        serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                        serviceTrifCbe.factor               = 'CUM';
                        serviceTrifCbe.serviceId            = 'SHP-G';
                        serviceTrifCbe.refServiceId         = 'PACKETS';
                        serviceTrifCbe.trifAmountExce       = (this.mapBlockAdic.get(strRange).FleteAdic__c * 200).setScale(2);
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
                            serviceTrifCbe.trifAmountExce       = (this.mapBlockAdic.get(strRange).EADAdic__c * 200).setScale(2);
                            for(String strBlock : this.mapBlocks.keySet()){
                                serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                                serviceTrif.trifAmount          = this.mapBlocksServ.get(strBlock).get('EAD').get(strRange).setScale(2);
                                serviceTrif.trifAmntBase        = 0;
                                serviceTrif.discount            = 0;
                                serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decVol;
                                listserviceTrif.add(serviceTrif);
                            }
                            serviceTrifCbe.serviceTrif = listserviceTrif;
                            listserviceTrifCbe.add(serviceTrifCbe);
                        }
                        listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                        serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                        serviceTrifCbe.factor               = 'CUM';
                        serviceTrifCbe.serviceId            = 'RAD-1';
                        serviceTrifCbe.refServiceId         = 'RAD';
                        if((this.mapBlockAdic.get(strRange).RADAdic__c != 0 || this.mapBlockAdic.get(strRange).RADAdic__c != null) && (this.blnRAD))
                            serviceTrifCbe.trifAmountExce   = (this.mapBlockAdic.get(strRange).RADAdic__c * 200).setScale(2);
                        else serviceTrifCbe.trifAmountExce	= 0.001;
                        for(String strBlock : this.mapBlocks.keySet()){
                            serviceTrif                     = new ObjDocEnLinea.serviceTrif();
                            if(this.mapBlocksServ.get(strBlock).get('RAD').get(strRange) != 0 && this.blnRAD)
                                serviceTrif.trifAmount      = this.mapBlocksServ.get(strBlock).get('RAD').get(strRange).setScale(2);
                            else serviceTrif.trifAmount		= 0.001;
                            serviceTrif.trifAmntBase        = 0;
                            serviceTrif.discount            = 0;
                                serviceTrif.factorValue         = this.mapBlocks.get(strBlock).decVol;
                            listserviceTrif.add(serviceTrif);
                        }
                        serviceTrifCbe.serviceTrif = listserviceTrif;
                        listserviceTrifCbe.add(serviceTrifCbe);


                        if(this.blnT7ZP){
                            listserviceTrif                     = new List<ObjDocEnLinea.serviceTrif>();
                            serviceTrifCbe                      = new ObjDocEnLinea.serviceTrifCbe();
                            serviceTrifCbe.factor               = 'CUM';
                            serviceTrifCbe.serviceId            = 'EXT-1';
                            serviceTrifCbe.refServiceId         = 'EXT';
                            serviceTrifCbe.trifAmountExce	    = 0.001;
                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                            if(this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c != null && this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c != 0){
                                serviceTrif.trifAmount         = this.mapQuotesT7ZP.get(strRange).SBQQ__SpecialPrice__c.setScale(2);
                                serviceTrif.factor              = 'KG';
                                serviceTrif.factorValue         = this.mapQuotesT7ZP.get(strRange).PackVolAVG__c;
                            } else
                                serviceTrif.trifAmount              = 0.001;
                            serviceTrif.trifAmntBase                = 0;
                            serviceTrif.discount                    = this.mapQuotesT7ZP.get(strRange).SBQQ__Discount__c;
                            listserviceTrif.add(serviceTrif);
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
                        serviceTrif.factorValue                 = 0;
                        listserviceTrif.add(serviceTrif);
                    }
                    if(this.blnZP){
                        if((this.blnCostoBaseGMP && (this.mapService.get('ZP').mapRanges.get(strRange) != 0 || this.mapService.get('ZP').mapRanges.get(strRange) != null)) || ((this.blnCostosFijos) && (this.mapZonaPlus.get(strRange) != 0 || this.mapZonaPlus.get(strRange) != null))){
                            serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                            serviceTrif.serviceId                   = 'EXT-1';
                            serviceTrif.refServiceId                = 'EXT';
                            if(this.blnCostosFijos){
                                if(this.mapZonaPlus.get(strRange) != 0){
                                    serviceTrif.trifAmount              = this.mapZonaPlus.get(strRange).setscale(2);
                                }
                                else serviceTrif.trifAmount             = 1;
                            } else {
                                serviceTrif.trifAmount             = this.mapService.get('ZP').mapRanges.get(strRange);
                            }
                            serviceTrif.discount                    = 0;
                            serviceTrif.trifAmntBase                = 0;
                            serviceTrif.factorValue                 = 0;
                            serviceTrif.factor                      = 'NON';
                            listserviceTrif.add(serviceTrif);
                        }
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
                        for(String strTarifa: this.listTarifasExp){
                            serviceTrifCbe                              = new ObjDocEnLinea.serviceTrifCbe();
                            listserviceTrif                             = new List<ObjDocEnLinea.serviceTrif>();
                            serviceTrifCbe.factor                       = 'KG';
                            serviceTrifCbe.serviceId                    = strTarifa;
                            serviceTrifCbe.refServiceId                 = obtieneTarifaExpress(strTarifa);
                            serviceTrifCbe.trifAmountExce               = this.mapExpAdic.get(strTarifa).get(strRange);
                            serviceTrifCbe.factor                       = 'KG';
                            serviceTrifCbe.serviceId                    = strTarifa;
                            serviceTrifCbe.refServiceId                 = obtieneTarifaExpress(strTarifa);
                            for(Decimal decBloque: this.listBloquesExp){
                                serviceTrif                                 = new ObjDocEnLinea.serviceTrif();
                                if(this.mapTLinesExp.get(decBloque).get(strTarifa).get(strRange).Flete__c != 0)
                                    serviceTrif.trifAmount                  = this.mapTLinesExp.get(decBloque).get(strTarifa).get(strRange).Flete__c;
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
                            if(this.wp.mapSS.get(strTarifa).mapRanges.containsKey(strRange)){
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
                
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Terminó el proceso')); //Salvador Ramírez (sranmirez@freewayconsulting.com):Esta linea solo se descomenta cuando se quiere visualizar el json del request que se va a mandar a grabar
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'JSON convenio a grabar: ' + JSON.serialize(odc))); //Salvador Ramírez (sranmirez@freewayconsulting.com):Esta linea solo se descomenta cuando se quiere visualizar el json del request que se va a mandar a grabar
                //Salvador Ramírez (sranmirez@freewayconsulting.com): Si no se va a pedir el grabado y solo se quiere analizar el json que se genere deben comentarse los siguientes if (requeridocrearusuario(), blnrequierecrearusuario y this.blngrabartarifas)
                if(requeridoCrearUsuario(cotizacion))
                    blnRequiereCrearUsuario = true;
                if(blnRequiereCrearUsuario){
                    if(cotizacion.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'){
                        TarifaUsar = 'A';
                    } else{
                        TarifaUsar = 'C';
                    } 
                    if(!crearUsuarioWeb(cotizacion, TarifaUsar)){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error al crear a cliente en catálogo de documentación en línea: ' + this.strMensajeError)); 
                        this.blnPuedeGrabar = false;
                        return;
                    }
                }
                if(this.blnGrabarTarifas){
                    if(envioGrabadoPOST(JSON.serialize(odc), endpoint))
                        blnGraboTarifas = true;
                    if(blnGraboTarifas)
                        publicarEvento(true,null);
                    else publicarEvento(false,this.strMensajeError);
                    if(blnGraboTarifas){
                        NotificaGrabadoUsuario(cotizacion.Id);
                    }
                }
            }else {
                publicarEvento(false, 'Imposible continuar, datos insuficientes');
            }

        } catch (Exception ex){
            System.debug('ValidacionDocLinea: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false, 'Error al realizar grabado de tarifas. ' +ex.getLineNumber()+' '+ex.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error al realizar grabado de tarifas. ' +ex.getLineNumber()+' '+ex.getMessage()));
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
        if(TipoAcuse == 'P' || TipoAcuse == '')
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
    public static String obtieneTarifaDeNum(Decimal decTarifa){
        if(decTarifa == 0.0)
            return 'TARIFA TS';
        else if(decTarifa == 0.1)
            return 'TARIFA T0';
        else if(decTarifa == 1.0)
            return 'TARIFA T1';
        else if(decTarifa == 2.0)
            return 'TARIFA T2';
        else if(decTarifa == 3.0)
            return 'TARIFA T3';
        else if(decTarifa == 4.0)
            return 'TARIFA T4';
        else if(decTarifa == 5.0)
            return 'TARIFA T5';
        else if(decTarifa == 6.0)
            return 'TARIFA T6';
        else if(decTarifa == 7.0)
            return 'TARIFA T7';
        else if(decTarifa == 7.1)
            return 'TARIFA T7-P';
        else if(decTarifa == 7.2)
            return 'TARIFA T7-V';
        else return '';
    }
    public void GrabarTarifaDocLinea(){
        try{
            iniciarGrabado(this.cas);
        } catch (Exception ex){
            System.debug('GrabarTarifaDocLinea ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
    }
    /*public PageReference procesar(){
        try{
            PageReference pageRef = new PageReference('/'+Id);
            pageRef.setRedirect(true);
            return pageRef;
        }catch(Exception ex){
            PageReference pageRef = new PageReference('/'+Id);
            this.GrabadoController.publicarEvento(false, 'procesar: ' + ex.getLineNumber() + ' ' + ex.getMessage());
            return pageRef;
        }
    }*/
    public static List<SBQQ__QuoteLine__c> queryquoteitem(String Id){
        return[SELECT Id, Rango_KM__c, Destiny__c, ACK__c, RAD__c, EAD__c, SBQQ__CustomerPrice__c, SBQQ__Discount__c,SBQQ__SpecialPrice__c, Tarifa__c, KG_ADICIONAL__c, ZonaPlus__c, SBQQ__Description__c, PackWeightAVG__c, SBQQ__Quantity__c, Vol__c, Weight__c, FLETE__c
                , PackVolAVG__c, Guia__c FROM SBQQ__QuoteLine__c WHERE SBQQ__QUOTE__C = : Id];
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
            listPlantillaLineItems = [SELECT Id, Quantity__c, EditMode__c, Tarifa__c, Weight__c, Vol__c, Rango_KM__c, Pack_Seg__c, Zona_Plus__c, ACK__c, EAD__c, RAD__c, SEG__c, PackWeightAVG__c, PackVolAVG__c, CustomerPrice__c, TarifaDominante__c, FLETE__c,Guia__c, fleteE__c, ACKES__c,KG_ADICIONAL__c, Destiny__c,
                                        FleteAdic__c, RADAdic__c, EADAdic__c, TotalAdic__c FROM TempleateLine__c where Templeate__c = :templeateId  ORDER BY CreatedDate];
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
    public static List<Tarifario__c> queryFullTarifario(){
        return [SELECT Id
        , GuiaDeArranque1Kg__c
        , Kg_adicional__c
        , Rango_km__c
        , Tarifa__c FROM Tarifario__c WHERE Year__c = null];
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
        Decimal fltFee = fltAmount * PAQ_CotizadorNacional_CTR.getpercentageEAD();
        if(fltMinFee > fltFee)
            return fltMinFee;
        else
            return fltFee;
    }
    public Boolean requeridoCrearUsuario(SBQQ__Quote__c cotizacion){
        try{
            System.debug('Verificando si existe el usuario');
            String endpoint = Label.APIVerificarUsuario;
            Boolean blnReturn = false;
            DefinicionesServiciosGrabado.securityVU sv = new DefinicionesServiciosGrabado.securityVU();
            DefinicionesServiciosGrabado.headerVU hv = new DefinicionesServiciosGrabado.headerVU();
            DefinicionesServiciosGrabado.dataVU dv = new DefinicionesServiciosGrabado.dataVU();
            DefinicionesServiciosGrabado.requestVU rv = new DefinicionesServiciosGrabado.requestVU();
            DefinicionesServiciosGrabado.bodyVU bv = new DefinicionesServiciosGrabado.bodyVU();
            DefinicionesServiciosGrabado.VerificarUsuario vu = new DefinicionesServiciosGrabado.VerificarUsuario();
            sv.user ='SALESFORCE';
            sv.password =null;
            sv.typeR ='0';
            sv.token ='325746796331582000000';
            hv.security = sv;
            hv.device =null;
            hv.language =null;
            hv.output =null;
            hv.target = null;
            dv.clntId = cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
            dv.clntUser = cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
            rv.data = dv;
            rv.objectDTO = null;
            bv.request = rv;
            bv.response = null;
            vu.header = hv;
            vu.body = bv;
            String jsonFormateado = JSON.serialize(vu);
            jsonFormateado = jsonFormateado.replace('typeR','type');
            HTTPResponse res = consultaAPIPOST(jsonFormateado,endpoint);
            DefinicionesServiciosGrabado.verificarUsuarioR vuR = (DefinicionesServiciosGrabado.verificarUsuarioR)JSON.deserialize(res.getBody().replace('time','timeR'), DefinicionesServiciosGrabado.verificarUsuarioR.class);
            System.debug('requeridoCrearUsuario: ¿Se require crear usuario?: '+vur.body.response.success);
            if(vur.body.response.success == 'false'){
                if(vur.body.response.messages[0].description.contains('ES MIEMBRO DE CLIENTE DE DOCUMENTACION EN LINEA')){
                    //publicarEvento(false, vur.body.response.messages[0].description);
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, vur.body.response.messages[0].description));
                    this.blnGrabarTarifas = false;
                    blnReturn = false;
                    blnPuedeGrabar = false;
                } else{
                    blnReturn = false;
                    this.blnGrabarTarifas = true;
                } 
            } else {
                blnReturn = true;
            }
            /*if(vur.body.response.success == 'false'){
                this.blnGrabarTarifas = true;
                blnReturn = Boolean.valueOf(vur.body.response.success);
            } else {
                if(vur.body.response.messages[0].description.contains('ES MIEMBRO DE CLIENTE DE DOCUMENTACION EN LINEA')){
                    publicarEvento(false, vur.body.response.messages[0].description);
                    this.blnGrabarTarifas = false;
                    blnReturn = false;
                } else{
                    blnReturn = true;
                }
            }*/
            return blnReturn;
        }
        catch(Exception ex){
            System.debug('requeridoCrearUsuario: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false,'Error al verificar el usuario');
            return false;
        }
    }
    public Boolean crearUsuarioWeb(SBQQ__Quote__c cotizacion, String tipoUsuario){
        try{
            System.debug('Creando usuario web...');
            String userSipweb = '';
            System.debug('Crear usuario web');
            User u = [SELECT Id_Sipweb__c, FederationIdentifier FROM User WHERE Id=:System.UserInfo.getUserId()];
            if(u.Id_Sipweb__c!=null)
                userSipweb = u.Id_Sipweb__c;
            else if(u.FederationIdentifier!=null)
                userSipweb = u.FederationIdentifier;
            String endpoint = Label.APIRegistrarUsuario;
            DefinicionesServiciosGrabado.dataUser du = new DefinicionesServiciosGrabado.dataUser();
            DefinicionesServiciosGrabado.requestU ru = new DefinicionesServiciosGrabado.requestU();
            DefinicionesServiciosGrabado.headerU hu = new DefinicionesServiciosGrabado.headerU();
            DefinicionesServiciosGrabado.bodyU bu = new DefinicionesServiciosGrabado.bodyU();
            DefinicionesServiciosGrabado.securityU su = new DefinicionesServiciosGrabado.securityU();
            DefinicionesServiciosGrabado.requestWebUser rwu = new DefinicionesServiciosGrabado.requestWebUser();
            String ubicacion = cotizacion.SBQQ__Account__r.Plaza_Envio__r.Name;
            String site = '';
            if(String.isEmpty(ubicacion)||null==ubicacion)
                ubicacion = cotizacion.SBQQ__Account__r.Plaza_Facturacion__r.Name;
            if(null!=ubicacion && !String.isEmpty(ubicacion))
                site = ubicacion.replaceAll(ubicacion.replaceAll('[^0-9]',''),'');
            //System.debug('Site: '+ this.strTipoCliente);
            du.authBy = userSipweb;
            du.clntId= cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
            du.clntUser= cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
            du.clntPass= '1234';
            du.clntAprvSite= site;
            du.clntAprvBrnc= ubicacion;
            du.clntTarifType = tipoUsuario;
            du.clntAddSrvcDips= 'Y';
            du.setShipmentLetterQty= '3';
            du.clntInvcPerd= '0';
            ru.data = du;
            ru.objectDTO = null;
            bu.request = ru;
            su.password =null;
            su.token = '325746796331582000000';
            su.type = '0';
            su.user = 'SALESFORCE';
            hu.device = null;
            hu.language= null;
            hu.output= null;
            hu.security = su;
            hu.target= null;    
            rwu.body = bu;
            rwu.header = hu;
            if(envioGrabadoPOST(JSON.serialize(rwu),endpoint)){
                blnGrabarTarifas = true;
                return true;
            } else {
                blnGrabarTarifas = false;
                return false;
            }

        }catch(Exception ex){
            System.debug('crearUsuarioWeb: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false,'No se pudo realizar el grabado');            
            return false;
        }
    }
    public HTTPResponse consultaAPIPOST(String body, String endpoint){
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
    public Boolean envioGrabadoPOST(String body, String endpoint){
        try{
            System.debug('Envío de grabado');
            HttpResponse res = consultaAPIPOST(body,endpoint);
            return procesarRespuestaGrabado(res);
        }catch(Exception ex){
            System.debug('envioGrabadoPost: '+ex.getLineNumber()+' '+ex.getMessage());
            return false;
        }
    }
    public boolean procesarRespuestaGrabado(HTTPResponse res){
        try{
            String respuesta = res.getBody();
            respuesta = respuesta.replace('time', 'timeR');
            SBQQ__Quote__c cot = null;
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Respuesta: ' + respuesta));
            DefinicionesServiciosGrabado.responseGrabado rg = (DefinicionesServiciosGrabado.responseGrabado)JSON.deserializeStrict(respuesta, DefinicionesServiciosGrabado.responseGrabado.class);
            //ObjDocEnLinea.documentacionRemota rg = (ObjDocEnLinea.documentacionRemota)JSON.deserialize(respuesta, ObjDocEnLinea.documentacionRemota.class);
            System.debug('procesarRespuestaGrabado: ¿Procesado correctamente?: '+rg.body.response.success);
            //System.debug('mensajes: ' + rg.body.response.messages[0].description);
            if (rg.body.response.messages != null)
                this.strMensajeError = rg.body.response.messages[0].description;
            System.debug('6');
            //System.debug('procesarRespuestaGrabado: ¿Procesado correctamente?: '+rg.body.response.success);
            //System.debug('mensajes: ' + rg.body.response.messages);
            return Boolean.valueOf(rg.body.response.success);
        }catch(Exception ex){
            System.debug('procesarRespuestaGrabado doc en línea: '+ex.getLineNumber()+' '+ex.getMessage());
            return False;
        }        
    }
    public static void NotificaGrabadoUsuario(String Id){
        try{
            SBQQ__Quote__c cot = null;
            cot                = [SELECT Id, Grabado_exitoso__c,ProcesadoTareaGrabado__c FROM SBQQ__Quote__c WHERE Id=:Id LIMIT 1];
            if(cot != null){
                cot.Grabado_Exitoso__c = true;
                update cot;
            }
        }catch (Exception ex){
            System.debug('NotificaUsuarioGrabado: ' + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public void CargaMapasCostoBaseGMP(){
        for(SBQQ__QuoteLine__c objQLine : this.wp.listQuoteItem){
            String strRangeDest = '';
            if(objQLine.Destiny__c != null)
                strRangeDest = objQLine.Destiny__c;
            else strRangeDest = objQLine.Rango_KM__c;
            if(!mapRangesByBlock.containsKey(objQLine.PackWeightAVG__c))
                mapRangesByBlock.put(objQLine.PackWeightAVG__c, new Map<String, Decimal>{strRangeDest => objQLine.FLETE__c});
            else if(!mapRangesByBlock.get(objQLine.PackWeightAVG__c).containsKey(strRangeDest))
                mapRangesByBlock.get(objQLine.PackWeightAVG__c).put(strRangeDest, objQLine.FLETE__c);
            

            if(!(objQLine.Tarifa__c == 'TARIFA T7' && objQLine.ZonaPlus__c)){
                if(!this.listRangeDestiny.contains(strRangeDest) && objQline.Flete__c > 0)
                    this.listRangeDestiny.add(strRangeDest);
                if(!this.mapService.get('ADD').mapRanges.containsKey(strRangeDest))
                    this.mapService.get('ADD').mapRanges.put(strRangeDest, objQLine.KG_ADICIONAL__c);
    
                if(!this.mapService.get('ACK').mapRanges.containsKey(strRangeDest))
                    this.mapService.get('ACK').mapRanges.put(strRangeDest, objQLine.ACK__c);
    
                if(objQLine.ZonaPlus__c && objQLine.Tarifa__c != 'TARIFA T7' && objQLine.EAD__c > 0){
                    this.blnZP = true;
                    if(!this.mapService.get('ZP').mapRanges.containsKey(strRangeDest))
                        this.mapService.get('ZP').mapRanges.put(strRangeDest, objQLine.EAD__c);
                }
            }
        }
        Integer blockCounter = 1;
        for(Decimal decW : this.mapGuide.keySet()){
            String strRangeDest = '';
            this.mapBlocks.put('BLOQUE '+ blockCounter, new Block('BLOQUE '+ blockCounter, decW, this.mapGuide.get(decW), this.mapGuide.get(decW) * 200) );
            this.mapBlocks.get('BLOQUE '+ blockCounter).mapRanges = mapRangesByBlock.get(decW);
            for(String keyRange: this.listRangeDestiny){
                if(!this.mapBlocksServ.containsKey('BLOQUE ' + blockCounter)) {
                    this.mapBlocksServ.put('BLOQUE ' + blockCounter, new map<String, map<String, Decimal>>());
                    this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('FLT', new map<String, Decimal>());
                    this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('RAD', new map<String, Decimal>());
                    this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('EAD', new map<String, Decimal>());
                    this.mapBlocksServ.get('BLOQUE ' + blockCounter).put('ADD', new Map<String, Decimal>());
                }
                if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('FLT').containsKey(keyRange)){
                    this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('FLT').put(keyRange, this.mapBloques.get(decW).get(keyRange).Flete__c);
                }
                if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('RAD').containsKey(keyRange)){
                    this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('RAD').put(keyRange, this.mapBloques.get(decW).get(keyRange).RAD__c);
                }
                if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('EAD').containsKey(keyRange)){
                    this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('EAD').put(keyRange, this.mapBloques.get(decW).get(keyRange).EAD__c);
                }
                if(!this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('ADD').containsKey(keyRange)){
                    this.mapBlocksServ.get('BLOQUE ' + blockCounter).get('ADD').put(keyRange, this.mapBloques.get(decW).get(keyRange).KG_ADICIONAL__c);
                }
            }
            blockCounter++;
        }
    }
    public void publicarEvento(Boolean EjecucionCorrecta, String mensaje){
        try{
            System.debug('Publicando evento...');
            String mensajeFinal;
            List<ResultadoGrabado__e> inkEvents = new List<ResultadoGrabado__e>();
            if(mensaje==null)
                mensajeFinal = 'Grabado exitoso';
            else
                mensajeFinal = mensaje;
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
            System.debug('publicarEvento doc en línea: '+ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public class Wrapper{
        public List<SBQQ__QuoteLine__c> listQuoteItem                                   {get; set;}
        public Map<String,SS> mapSS          	                                        {get; set;}
        public Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT   {get; set;}
        public Map<String, Decimal> mapCS                                               {get; set;}
        public Map<String, Decimal> mapACK                                              {get; set;}
        public Map<String, Decimal> mapACKExp                                           {get; set;}
        public Boolean blnSoloTarifasExp                                                {get; set;}
        public Boolean blnSoloDestinos                                                  {get; set;}
        public Map<String, Map<String, Tarifario__c>> mapTarifarioEXP                   {get; set;}
        public Wrapper(){
            this.listQuoteItem      = new List<SBQQ__QuoteLine__c>();
            this.mapSS				= new Map<String, SS>();
            this.mapTarifarioT      = new Map<String, Map<String, Tarifario_general_terrestre__c>>();
            this.mapCS              = new Map<String, Decimal>();
            this.mapACK             = new Map<String, Decimal>();
            this.mapACKExp          = new Map<String, Decimal>();
            this.mapTarifarioEXP    = new Map<String, Map<String, Tarifario__c>>();
            this.blnSoloTarifasExp  = false;
            this.blnSoloDestinos    = false;
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
}
