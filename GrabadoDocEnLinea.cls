public class GrabadoDocEnLinea {
    public Wrapper wp                                                   {get;set;}
    public Id owner                                                     {get;set;}
    public Id Id                                                        {get;set;}
    public SBQQ__Quote__c cas                                           {get;set;}
    public string tipoDocumentacion                                     {get;set;}
    public Id cuenta                                                    {get;set;}
    public string idSipWeb                                              {get;set;}
    public date fechaVigencia                                           {get;set;}
    public Boolean grabadoUnico                                         {get;set;}
    public Boolean confirmacionGrabadoUnico                             {get;set;}
    public Boolean blnMostrarMensaje                                    {get;set;}
    public Boolean blnRAD                                               {get;set;}
    public Boolean blnEAD                                               {get;set;}
    public Boolean blnACK                                               {get;set;}
    public Boolean blnSEG                                               {get;set;}
    public Boolean blnZP                                                {get;set;}
    public Boolean blnClienteNuevo                                      {get;set;}
    public Boolean ServiciosEspeciales                                  {get;set;}
    public Boolean blnTarifasExp                                        {get;set;}
    public Boolean blnTieneTarifasRegistradas                           {get;set;}
    public Boolean blnT7ZP                                              {get;set;}
    public String aprvUser                                              {get;set;}
    public String orgnSite                                              {get;set;}
    public String destSite                                              {get;set;}
    public String factor                                                {get;set;}
    public String serviceId                                             {get;set;}
    public String refrServiceId                                         {get;set;}
    public String trifType                                              {get;set;}
    public String pieceMulti                                            {get;set;}
    public String strMensajeError                                       {get;set;}
    public List<String> listTarifas                                     {get;set;}
    public List<String> listTarifasExp                                  {get;set;}
    public List<TempleateLine__c> listPlantillaLineItems                {get;set;}
    public List<String> listRangeDestiny                                {get;set;}
    public List<String> listSS                                          {get;set;}
    public List<Decimal> listDecTarifas                                 {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes       {get;set;}
    public Map<String, SBQQ__QuoteLine__c> mapQuotesT7ZP                {get;set;}
    public Map<String, Map<String, TempleateLine__c>> mapTLines         {get;set;}
    public Map<String, Map<String, TempleateLine__c>> mapTLinesExp      {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesExp    {get;set;}
    public Map<String, Decimal> mapAcuse                                {get;set;}
    public Map<String, String> mapTarifasRegistradas                    {get;set;}
    public Map<String, Map<String, SBQQ__QuoteLine__c>> mapPlantillas   {get;set;}
    public Map<Decimal, Map<String, SBQQ__QuoteLine__c>> mapTarifas     {get;set;}
    public Map<String, Map<String, PAQ_SpecialService__c>> mapRanges    {get;set;}
    public Templeate__c objtempleate                                    {get;set;}
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
        this.listTarifas                    = new List<String>{'TARIFA SOBRE', 'TARIFA T0', 'TARIFA T1', 'TARIFA T2', 'TARIFA T3', 'TARIFA T4', 'TARIFA T5', 'TARIFA T6', 'TARIFA T7-V', 'TARIFA T7-P'};
        this.listTarifasExp                 = new List<String>();
        this.listRangeDestiny               = new List<String>();
        this.listSS                         = new List<String>();
        this.listDecTarifas                 = new List<Decimal>();
        this.listPlantillaLineItems         = new List<TempleateLine__c>();
        this.wp                             = new Wrapper();
        this.mapQuotes                      = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapQuotesT7ZP                  = new Map<String, SBQQ__QuoteLine__c>();
        this.mapQuotesExp                   = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        this.mapAcuse                       = new Map<String,Decimal>();
        this.mapTarifasRegistradas          = new Map<String, String>();
        this.mapRanges                      = new Map<String, Map<String, PAQ_SpecialService__c>>();
        this.mapTLines                      = new Map<String, Map<String, TempleateLine__c>>();
        this.mapTLinesExp                   = new Map<String, Map<String, TempleateLine__c>>();
        this.mapTarifas                     = new Map<Decimal, Map<String, SBQQ__QuoteLine__c>>();
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
            respuesta = respuesta.replace('time', 'timeR');
            ObjDocEnLinea.documentacionRemota rg = (ObjDocEnLinea.documentacionRemota)JSON.deserialize(respuesta, ObjDocEnLinea.documentacionRemota.class);
            if(rg.body.response.data.kmConfig != null){
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
            }
            if(rg.body.response.data.ptpConfig == null && rg.body.response.data.kmConfig == null)
                this.blnClienteNuevo = true;
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tarifas: ' + mapTarifasRegistradas));
            this.aprvUser   = rg.body.response.data.aprvUser;
            this.trifType   = rg.body.response.data.trifType;
            this.pieceMulti = rg.body.response.data.pieceMulti;
            return true;
        }catch (Exception ex){
            gr.publicarEvento(false, 'Error al procesar información obtenida de sipweb.');
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
                if(cotizacion.Modelo_de_tarifas__c == 'Costos fijos por Tarifas: Por Destinos / Por rangos de km')
                    data.trifType = 'A';
                else data.trifType   = 'C';
                data.pieceMulti = this.pieceMulti;
                for(TempleateLine__c line : queryTempleateLine(objtempleate.Id)){
                    if(line.Zona_Plus__c )
                        this.blnZP = true;
                    if(String.isNotBlank(line.Destiny__c))
                        line.Rango_KM__c = line.Destiny__c;
                    this.listPlantillaLineItems.add(line);          
                }
                for(TempleateLine__c line : this.listPlantillaLineItems){
                    if(!line.Zona_Plus__c){
                        if(line.Tarifa__c != 'SEG-DS' && line.Tarifa__c != 'SEG-2D'){
                            if(!this.listTarifas.contains(line.Tarifa__c))
                                this.listTarifas.add(line.Tarifa__c);
                            if(!this.mapTLines.containsKey(line.Tarifa__c)){
                                this.mapTLines.put(line.Tarifa__c, new Map<String, TempleateLine__c>());
                            }
                        } else {
                            if(!this.listTarifasExp.contains(line.Tarifa__c))
                                this.listTarifasExp.add(line.Tarifa__c);
                            if(!this.mapTLinesExp.containsKey(line.Tarifa__c)){
                                this.mapTLinesExp.put(line.Tarifa__c, new Map<String, TempleateLine__c>());
                            }
                            this.blnTarifasExp = true;
                        }
                        if(line.Destiny__c != null){
                            if(!this.listRangeDestiny.contains(line.Destiny__c))
                                this.listRangeDestiny.add(line.Destiny__c);
                            if(!this.mapAcuse.containsKey(line.Destiny__c))
                                this.mapAcuse.put(line.Destiny__c, line.ACK__c);
                            if(line.Tarifa__c == 'SEG-DS' || line.Tarifa__c == 'SEG-2D'){
                                if(!this.mapTLinesExp.get(line.Tarifa__C).containsKey(line.Destiny__c))
                                    this.mapTLinesExp.get(line.Tarifa__c).put(line.Destiny__c, line);
                            } else {
                                if(!this.mapTLines.get(line.Tarifa__c).containsKey(line.Destiny__c))
                                    this.mapTLines.get(line.Tarifa__c).put(line.Destiny__c, line);
                            }
                        } else {
                            if(!this.listRangeDestiny.contains(line.Rango_KM__c))
                                this.listRangeDestiny.add(line.Rango_KM__c);
                            if(!this.mapAcuse.containsKey(line.Rango_KM__c))
                                this.mapAcuse.put(line.Rango_KM__c, line.ACK__c);
                            if(line.Tarifa__c == 'SEG-DS' || line.Tarifa__c == 'SEG-2D'){
                                if(!this.mapTLinesExp.get(line.Tarifa__C).containsKey(line.Rango_KM__c))
                                    this.mapTLinesExp.get(line.Tarifa__c).put(line.Rango_KM__c, line);
                            }else{
                                if(!this.mapTLines.get(line.Tarifa__C).containsKey(line.Rango_KM__c))
                                    this.mapTLines.get(line.Tarifa__c).put(line.Rango_KM__c, line);
                            }
                        }
                    }
                }
                String strRangeDest = '';
                for(SBQQ__QuoteLine__c cot:this.wp.listQuoteItem){
                    if(cot.Tarifa__c == 'TARIFA T7' && cot.ZonaPlus__c && cot.SBQQ__Description__c == 'Propuesta'){
                        strRangeDest = '';
                        if(cot.Destiny__c != null)
                            strRangeDest = cot.Destiny__c;
                        else strRangeDest = cot.Rango_KM__c;
                        if(!this.mapQuotesT7ZP.containsKey(strRangeDest))
                            this.mapQuotesT7ZP.put(strRangeDest, cot);
                        this.blnT7ZP = true;
                    } else if(!(cot.Tarifa__c == 'TARIFA T7' && cot.ZonaPlus__c)){
                        if(cot.Tarifa__c != 'SEG-DS' && cot.Tarifa__c != 'SEG-2D'){
                            if(!this.listTarifas.contains(cot.Tarifa__c))
                                this.listTarifas.add(cot.Tarifa__c);
                            if(!this.mapQuotes.containsKey(cot.Tarifa__c)){
                                this.mapQuotes.put(cot.Tarifa__c, new map<String, SBQQ__QuoteLine__c>());
                            }
                            strRangeDest = '';
                            if(cot.Destiny__c != null)
                                strRangeDest = cot.Destiny__c;
                            else strRangeDest = cot.Rango_KM__c;
                            if(!this.mapQuotes.get(cot.Tarifa__c).containsKey(strRangeDest))
                                this.mapQuotes.get(cot.Tarifa__c).put(strRangeDest, cot);
                            if(!this.mapTarifas.containsKey(obtieneNumeroTarifa(cot.Tarifa__c)))
                                this.mapTarifas.put(obtieneNumeroTarifa(cot.Tarifa__c), new Map<String, SBQQ__QuoteLine__c>());
                            if(!this.mapTarifas.get(obtieneNumeroTarifa(cot.Tarifa__c)).containsKey(strRangeDest))
                                this.mapTarifas.get(obtieneNumeroTarifa(cot.Tarifa__c)).put(strRangeDest, cot);
                        } else {
                            if(!this.listTarifasExp.contains(cot.Tarifa__c))
                                this.listTarifasExp.add(cot.Tarifa__c);
                            if(!this.mapQuotesExp.containsKey(cot.Tarifa__c)){
                                this.mapQuotesExp.put(cot.Tarifa__c, new Map<String, SBQQ__QuoteLine__c>());
                            }
                            this.blnTarifasExp = true;
                        }
                        if(cot.Destiny__c != null){
                            if(!this.listRangeDestiny.contains(cot.Destiny__c))
                                this.listRangeDestiny.add(cot.Destiny__c);
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
                    }
                }
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
                if(!this.blnClienteNuevo){
                    for(String strTarifa : this.listTarifas){
                        if(!this.mapPlantillas.containsKey(strTarifa)){
                            this.mapPlantillas.put(strTarifa, new Map<String, TempleateLine__c>());
                        }
                    }
                }
                decEADZP = queryCostoZonaPlus(objtempleate.Id);
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
                    for(String strTarifa : this.listTarifas){
                        if(strRange != 'Más de 2400'){
                            if(this.mapTarifasRegistradas.containsKey(strRange) && this.mapTarifasRegistradas.get(strRange) != null)
                                strRangos = this.mapTarifasRegistradas.get(strRange);
                            else strRangos = ';';
                        } else{
                            if(this.mapTarifasRegistradas.containsKey('2401-9999') && this.mapTarifasRegistradas.get('2401-9999') != null)
                                strRangos = this.mapTarifasRegistradas.get('2401-9999');
                            else strRangos = ';';
                        }
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
                                    else serviceTrif.refServiceId                = 'PACKETS';
                                    serviceTrif.trifAmount                  = this.mapTLines.get(strTarifa).get(strRange).FLETE__c.setScale(2);
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
                                        if(strTarifa != 'TARIFA SOBRE'){
                                            if(this.mapTLines.get(strTarifa).get(strRange).EAD__c != 0)
                                                serviceTrif.trifAmount              = this.mapTLines.get(strTarifa).get(strRange).EAD__c.setScale(2);
                                            else serviceTrif.trifAmount             = 1;
                                        } else serviceTrif.trifAmount             = 1;
                                        serviceTrif.trifAmntBase                = 0;
                                        serviceTrif.discount                    = 0;
                                        if(strTarifa == 'TARIFA T7-V' || strTarifa == 'TARIFA T7-P')
                                            serviceTrif.factorValue             = 1;
                                        listserviceTrif.add(serviceTrif);
                                    }
                                    if(this.blnRAD){
                                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                                        serviceTrif.serviceId                   = 'RAD-1';
                                        serviceTrif.refServiceId                = 'RAD';
                                        if(strTarifa != 'TARIFA SOBRE'){
                                            if(this.mapTLines.get(strTarifa).get(strRange).RAD__c != 0)
                                                serviceTrif.trifAmount              = this.mapTLines.get(strTarifa).get(strRange).RAD__c.setScale(2);
                                            else serviceTrif.trifAmount             = 1;
                                        } else serviceTrif.trifAmount             = 1;
                                        serviceTrif.trifAmntBase                = 0;
                                        serviceTrif.discount                    = 0;
                                        if(strTarifa == 'TARIFA T7-V' || strTarifa == 'TARIFA T7-P')
                                            serviceTrif.factorValue             = 1;
                                        listserviceTrif.add(serviceTrif);
                                    }
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
                    if(this.blnACK || this.blnZP)
                        listserviceTrif                         = new List<ObjDocEnLinea.serviceTrif>();
                    if(this.blnACK){
                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                        serviceTrif.serviceId                   = obtieneAcuse(cotizacion.Acuse__c);
                        serviceTrif.refServiceId                = 'ACK';
                        serviceTrif.trifAmount                  = this.mapAcuse.get(strRange).setScale(2);
                        serviceTrif.discount                    = 0;
                        serviceTrif.trifAmntBase                = 0;
                        serviceTrif.servicesCant                = obtieneTipoAcuse(cotizacion.AcuseCosto__c);
                        serviceTrif.factor                      = 'NON';
                        listserviceTrif.add(serviceTrif);
                    }
                    if(this.blnZP){
                        serviceTrif                             = new ObjDocEnLinea.serviceTrif();
                        serviceTrif.serviceId                   = 'EXT-1';
                        serviceTrif.refServiceId                = 'EXT';
                        if(decEADZP != 0)
                            serviceTrif.trifAmount              = decEADZP.setscale(2);
                        else serviceTrif.trifAmount             = 1;
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
                    if(this.blnTarifasExp){
                        for(String strTarifa: this.listTarifasExp){
                            serviceTrifCbe                              = new ObjDocEnLinea.serviceTrifCbe();
                            serviceTrif                                 = new ObjDocEnLinea.serviceTrif();
                            listserviceTrif                             = new List<ObjDocEnLinea.serviceTrif>();
                            if(this.mapTLinesExp.get(strTarifa).get(strRange).KG_Adicional__c != 0)
                                serviceTrifCbe.trifAmountExce           = this.mapTLinesExp.get(strTarifa).get(strRange).KG_Adicional__c;
                            else serviceTrifCbe.trifAmountExce          = 1;
                            serviceTrifCbe.factor                       = 'KG';
                            serviceTrifCbe.serviceId                    = strTarifa;
                            serviceTrifCbe.refServiceId                 = obtieneTarifaExpress(strTarifa);
                            if(this.mapTLinesExp.get(strTarifa).get(strRange).FLETE__c != 0)
                                serviceTrif.trifAmount                  = this.mapTLinesExp.get(strTarifa).get(strRange).FLETE__c;
                            else serviceTrif.trifAmount                 = 1;
                            serviceTrif.trifAmntBase                    = 0;
                            serviceTrif.discount                        = 0;//this.mapQuotesExp.get(strTarifa).get(strRange).SBQQ__Discount__c;
                            serviceTrif.factor                          = 'KG';
                            serviceTrif.factorValue                     = 1;
                            listserviceTrif.add(serviceTrif);
                            serviceTrifCbe.serviceTrif                  = listserviceTrif;
                            listserviceTrifCbe.add(serviceTrifCbe);
                        }
                    }
                    if(this.ServiciosEspeciales){
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
                    if(blnRango)
                        kmServicesTrif.servicesTrifDtl          = listServicesTrifDtlS;
                    else ptpServicesTrifSub.servicesTrifDtl     = listServicesTrifDtlS;
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
                if(listkmServicesTrif1.size() != 0 && listkmServicesTrif1 != null)
                    data.kmConfig                           = listkmServicesTrif1;
                if(!listptpServicesTrifS.isEmpty() && listptpServicesTrifS != null)
                    ptpServicesTrif.ptpServicesTrif         = listptpServicesTrifS;
                listptpServicesTrif                     = new list<ObjDocEnLinea.ptpServicesTrif>{ptpServicesTrif};
                if(!listptpServicesTrif.isEmpty())
                    data.ptpConfig                          = listptpServicesTrif;
                rq.data                                 = data;
                body.request                            = rq;
                odc.body                                = body;
                header.security                         = sec;
                odc.header                              = header;
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Request: ' + JSON.serialize(odc)));
                if(!System.isScheduled()){
                    if(!cotizacion.Electronicas__c){
                        if(grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion))
                            grab.publicarEvento(true,null);
                    }else if(cotizacion.Electronicas__c){
                        if(grab.crearUsuarioWeb(cotizacion)){
                            if(grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion))
                                grab.publicarEvento(true,null);
                        }
                    }
                    else
                        grab.publicarEvento(false,'No se pudo realizar el grabado');
                }
                else
                    grab.envioGrabadoPOST(JSON.serialize(odc),endpoint,cotizacion);
            }else {
                gr.publicarEvento(false, 'Imposible continuar, datos insuficientes');
            }

        } catch (Exception ex){
            System.debug('ValidacionDocLinea: '+ex.getLineNumber()+' '+ex.getMessage());
            gr.publicarEvento(false, 'Error al generar conexión con sipweb. ' +ex.getLineNumber()+' '+ex.getMessage());
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
        else return '';
    }
    public static String obtieneservicesCant(String servicesCant){
        if(servicesCant == 'Guía')
            return 'G';
        else return '';
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
        return[SELECT Id, Rango_KM__c, Destiny__c, ACK__c, RAD__c, EAD__c, SBQQ__CustomerPrice__c, SBQQ__Discount__c,SBQQ__SpecialPrice__c, Tarifa__c, KG_ADICIONAL__c, ZonaPlus__c, SBQQ__Description__c FROM SBQQ__QuoteLine__c WHERE SBQQ__QUOTE__C = : Id];
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
    public class Wrapper{
        public List<SBQQ__QuoteLine__c> listQuoteItem   {get; set;}
        public Map<String,SS> mapSS          	        {get; set;}
        public Wrapper(){
            this.listQuoteItem      = new List<SBQQ__QuoteLine__c>();
            this.mapSS				= new Map<String, SS>();
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
}
