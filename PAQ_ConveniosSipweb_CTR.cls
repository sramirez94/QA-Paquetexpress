/**
 * @description       : 
 * @author            : Salvador Ramírez López (sramirez@freewayconsulting.com)
 * @group             : 
 * @last modified on  : 05-04-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   05-02-2021   Salvador Ramírez López (sramirez@freewayconsulting.com)   Initial Version
**/
public class PAQ_ConveniosSipweb_CTR {
    public GrabadoBtnController GrabadoController                               {get;set;}
    Apexpages.StandardController StandarC                                       {get;set;}
    public Account objCuenta                                                    {get;set;}
    public ObjDocEnLinea.documentacionRemota rg                                 {get;set;}
    public ObjDocEnLinea.bodyDRemota  body                                      {get;set;}
    public ObjDocEnLinea.dataDRemota data                                       {get;set;}
    public ObjDocEnLinea.kmServicesTrifList kmServicesTrif                      {get;set;}
    public list<ObjDocEnLinea.kmServicesTrifList> listkmServicesTrif            {get;set;}
    public ObjDocEnLinea.servicesTrifDtlSub servicesTrifDtlSub                  {get;set;}
    public List<ObjDocEnLinea.servicesTrifDtlSub> listServicesTrifDtlS          {get;set;}
    public ObjDocEnLinea.ptpServicesTrif ptpServicesTrif                        {get;set;}
    public List<ObjDocEnLinea.ptpServicesTrif> listptpServicesTrif              {get;set;}
    public ObjDocEnLinea.servicesTrifDtl servicesTrifDtl                        {get;set;}
    public ObjDocEnLinea.serviceTrif serviceTrif                                {get;set;}
    public ObjDocEnLinea.kmServicesTrif kmServicesTrif1                         {get;set;}
    public ObjDocEnLinea.ptpServicesTrifSub ptpServicesTrifSub                  {get;set;}
    public ObjDocEnLinea.serviceTrif ptpServTrif                                {get;set;}
    public ObjDocEnLinea.serviceTrifCbe serviceTrifCbe                          {get;set;}
    public ObjDocEnLinea.serviceTrif otherServiceTrif                           {get;set;}
    public List<ObjDocEnLinea.serviceTrif> listserviceTrif                      {get;set;}
    public List<ObjDocEnLinea.kmServicesTrif> listkmServicesTrif1               {get;set;}
    public List<ObjDocEnLinea.servicesTrifDtl> servicesTrifDtlList              {get;set;}
    public List<ObjDocEnLinea.ptpServicesTrifSub> listptpServicesTrifS          {get;set;}
    public List<ObjDocEnLinea.serviceTrif> listptpServTrif                      {get;set;}
    public List<ObjDocEnLinea.serviceTrifCbe> listserviceTrifCbe                {get;set;}
    public List<ObjDocEnLinea.serviceTrif> listotherServiceTrif                 {get;set;}
    public Boolean blnPtpConfig                                                 {get;set;}
    public Boolean blnKmConfig                                                  {get;set;}
    public String clntId                                                        {get;set;}
    public String strTipoTarifa                                                 {get;set;}
    public Map<String, Map<String, Map<String, wpTarifa>>> mapTarifas           {get;set;}
    public List<String> listRangeDestiny                                        {get;set;}
    public List<String> listServicio                                            {get;set;}
    public List<String> listFactor                                              {get;set;}

    public Map<String, Map<String, Map<String, wpTarifa>>> mapTarifasExp        {get;set;}
    public List<String> listRangeDestinyExp                                     {get;set;}
    public List<String> listServicioExp                                         {get;set;}
    public List<String> listFactorExp                                           {get;set;}
    public PAQ_ConveniosSipweb_CTR(ApexPages.StandardController controller) {
        this.objCuenta                              = (Account) controller.getRecord();
        this.StandarC                               = new Apexpages.StandardController(this.objCuenta);
        //this.GrabadoController                      = new GrabadoBtnController(StandarC);
        this.rg                                     = null;
        this.blnPtpConfig                           = false;
        this.strTipoTarifa                          = '';
        body                                        = new ObjDocEnLinea.bodyDRemota();
        data                                        = new ObjDocEnLinea.dataDRemota();
        kmServicesTrif                              = new ObjDocEnLinea.kmServicesTrifList();
        servicesTrifDtl                             = new ObjDocEnLinea.servicesTrifDtl();
        serviceTrif                                 = new ObjDocEnLinea.serviceTrif();
        kmServicesTrif1                             = new ObjDocEnLinea.kmServicesTrif();
        ptpServicesTrifSub                          = new ObjDocEnLinea.ptpServicesTrifSub();
        servicesTrifDtlSub                          = new ObjDocEnLinea.servicesTrifDtlSub();
        ptpServicesTrif                             = new ObjDocEnLinea.ptpServicesTrif();
        ptpServTrif                                 = new ObjDocEnLinea.serviceTrif();
        serviceTrifCbe                              = new ObjDocEnLinea.serviceTrifCbe();
        otherServiceTrif                            = new ObjDocEnLinea.serviceTrif();
        listserviceTrif                             = new List<ObjDocEnLinea.serviceTrif>();
        listkmServicesTrif                          = new List<ObjDocEnLinea.kmServicesTrifList>();
        listServicesTrifDtlS                        = new List<ObjDocEnLinea.servicesTrifDtlSub>();
        listkmServicesTrif1                         = new List<ObjDocEnLinea.kmServicesTrif>();
        servicesTrifDtlList                         = new List<ObjDocEnLinea.servicesTrifDtl>();
        listptpServicesTrifS                        = new List<ObjDocEnLinea.ptpServicesTrifSub>();
        listptpServicesTrif                         = new List<ObjDocEnLinea.ptpServicesTrif>();
        listptpServTrif                             = new List<ObjDocEnLinea.serviceTrif>();
        listserviceTrifCbe                          = new List<ObjDocEnLinea.serviceTrifCbe>();
        listotherServiceTrif                        = new List<ObjDocEnLinea.serviceTrif>();
        this.mapTarifas                             = new Map<String, Map<String, Map<String, wpTarifa>>>();
        this.listRangeDestiny                       = new List<String>();
        this.listServicio                           = new List<String>();
        this.listFactor                             = new List<String>();

        this.mapTarifasExp                          = new Map<String, Map<String, Map<String, wpTarifa>>>();
        this.listRangeDestinyExp                    = new List<String>();
        this.listServicioExp                        = new List<String>();
        this.listFactorExp                          = new List<String>();
        try{
            if(ObtieneInfoResponse(objCuenta)){
                System.debug('obtuvo información de sipweb');
                if(rg.body.response.data != null && this.rg.body.response.data.ptpConfig != null){
                    String strMultipieza = '';
                    this.blnPtpConfig = true;
                    this.data = this.rg.body.response.data;
                    this.strTipoTarifa = this.rg.body.response.data.trifType;
                    this.data.ptpConfig = this.rg.body.response.data.ptpConfig;
                    this.clntId = this.data.clntId;
                    for(Integer x = 0;x < this.rg.body.response.data.ptpConfig[0].ptpServicesTrif.size();x++){
                        for(Integer i = 0; i < rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe.size(); i ++){
                            for(Integer y = 0; y < rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif.size(); y ++){
                                if(rg.body.response.data.pieceMulti != '')
                                    strMultipieza = 'SI';
                                else strMultipieza = 'NO';
                                if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId != 'SEG-DS' && rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId != 'SEG-2D'){
                                    if(!this.listRangeDestiny.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite))
                                        this.listRangeDestiny.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite);
                                    if(!this.listServicio.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId))
                                        this.listServicio.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId);
                                    if(!this.listFactor.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor))
                                        this.listFactor.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor);
                                    if(!this.mapTarifas.containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite))
                                        this.maptarifas.put(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite, new Map<String, Map<String, wpTarifa>>());
                                    if(!this.mapTarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId))
                                        this.maptarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).put(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId, new Map<String, wpTarifa>());
                                    if(!this.maptarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor)){
                                        if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor == 'CUM' || rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor == 'KG'){
                                            this.maptarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).put(
                                                    rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor, new wpTarifa());
                                            this.maptarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).Peso_Vol_Inicial = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue;
                                            this.maptarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).Monto = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].trifAmount;
                                            this.maptarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).Monto_Excedente = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].trifAmountExce;
                                            this.maptarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).Multipieza = strMultipieza;
                                            this.maptarifas.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).cotizacion = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].quotation;
                                        }
                                    }
                                } else {
                                    if(!this.listRangeDestinyExp.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite))
                                        this.listRangeDestinyExp.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite);
                                    if(!this.listServicioExp.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId))
                                        this.listServicioExp.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId);
                                    if(!this.listFactorExp.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor))
                                        this.listFactorExp.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor);
                                    if(!this.mapTarifasExp.containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite))
                                        this.mapTarifasExp.put(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite, new Map<String, Map<String, wpTarifa>>());
                                    if(!this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId))
                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).put(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId, new Map<String, wpTarifa>());
                                    if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor == 'CUM' || rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor == 'KG'){
                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).put(
                                                rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor, new wpTarifa());
                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).Peso_Vol_Inicial = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue;
                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).Monto = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].trifAmount;
                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).Monto_Excedente = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].trifAmountExce;
                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).Multipieza = strMultipieza;
                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].factor).cotizacion = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].quotation;
                                    }
                                }
                            }
                        }
                    }
                } else {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No se encontraron convenios grabados para el id de sipweb: ' + this.objCuenta.Id_SIpWeb__c));
                    return;
                }
                if(rg.body.response.data != null && this.rg.body.response.data.kmConfig != null){
                    this.blnKmConfig = true;
                }
                System.debug('mapa: ' + this.mapTarifas.get('LMM - LMM'));
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Información recabada: .' + this.rg.body.response));
            }
        }catch(Exception ex){
            System.debug('Error en el constructor ' +ex.getLineNumber()+' '+EX.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error al iniciar. Contacte a un consultor de salesforce.'));
        }
    }
    public Boolean ObtieneInfoResponse(Account cuenta){
        Boolean resultado   = false;
        String endpoint     = Label.Grabado_DocLinea;
        GrabadoBtnController gr = new GrabadoBtnController(StandarC);
        try{
            if(cuenta.Id_SIpWeb__c!=null && !String.isEmpty(cuenta.Id_SIpWeb__c)|| Test.isRunningTest()){
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
                ddP.clntId = cuenta.Id_SIpWeb__c;
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
            gr.publicarEvento(false, 'Error al obtener response: ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
        return resultado;
    }
    public Boolean ObtieneInfoSipweb(String body, String endpoint){
        GrabadoBtnController gr = new GrabadoBtnController(StandarC);
        try{
            if(Test.isRunningTest()){
                HttpResponse res = gr.consultaAPIPOST(body,endpoint);
                String respuesta = res.getBody().replace('time','timeR');
                return true;
            } else {
                HttpResponse res = gr.consultaAPIPOST(body,endpoint);
                String respuesta = res.getBody().replace('time','timeR');
                return ProcesaResponse(res);
            }
        }catch (Exception ex){
            System.debug('ObtieneInfoSipweb: '+ex.getLineNumber()+' '+ex.getMessage());
            gr.publicarEvento(false, 'Error al obtener info sipweb');
            return false;
        }
    }
    public Boolean ProcesaResponse(HTTPResponse res){
        //Salvador Ramírez (sranmirez@freewayconsulting.com):Función para procesar el response al consultar los convenios que tiene el cliente en sipweb
        GrabadoBtnController gr = new GrabadoBtnController(StandarC);
        try{
            String Respuesta    = res.getBody();
            respuesta = respuesta.replace('time', 'timeR');
            rg = (ObjDocEnLinea.documentacionRemota)JSON.deserialize(respuesta, ObjDocEnLinea.documentacionRemota.class);
            return true;
        }catch (Exception ex){
            System.debug('ProcesaResponse ' + ex.getLineNumber() + ' ' + ex.getMessage());
            gr.publicarEvento(false, 'Error al procesar información obtenida de sipweb.');
            return false;
        }
    }
    public class wpTarifa{
        public Decimal Peso_Vol_Inicial {get;set;}
        public Decimal Monto            {get;set;}
        public Decimal Monto_Excedente  {get;set;}
        public String Multipieza        {get;set;}
        public String Cotizacion        {get;set;}
        public wpTarifa(){
            this.Peso_Vol_Inicial   = 0;
            this.Monto              = 0;
            this.Monto_Excedente    = 0;
            this.Multipieza         = '';
            this.cotizacion         = '';
        }
    }
}
