/**
 * @description       : 
 * @author            : Salvador Ramírez López (sramirez@freewayconsulting.com)
 * @group             : 
 * @last modified on  : 01-05-2022
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
    public Boolean blnCostosFijos                                               {get;set;}
    public Boolean blnCostoBaseGMP                                              {get;set;}
    public Boolean blnTarifasExp                                                {get;set;}
    public Boolean blnServicios                                                 {get;set;}
    public Boolean blnTarifas                                                   {get;set;}
    public String clntId                                                        {get;set;}
    public String strTipoTarifa                                                 {get;set;}
    public Map<String, Map<String, Map<String, wpTarifa>>> mapTarifas           {get;set;}
    public Map<String, wpTarifa> mapTarifas2                                    {get;set;}
    public List<String> listRangeDestiny                                        {get;set;}
    public List<String> listServicio                                            {get;set;}
    public List<String> listFactor                                              {get;set;}

    public Map<String, Map<String, Map<Decimal, wpTarifa>>> mapTarifasExp       {get;set;}
    public Map<String, wpTarifa> mapTarifasC                                    {get;set;}
    
    public List<String> listRangeDestinyExp                                     {get;set;}
    public List<String> listServicioExp                                         {get;set;}
    public List<Decimal> listBloquesExp                                         {get;set;}
    public Map<String, wpServicios> mapServicios                                {get;set;}
    public List<String> listServicios                                           {get;set;}
    public List<String> listRangeServ                                           {get;set;}
    public List<String> listTarifas                                             {get;set;}
    public List<String> listTarifasC                                            {get;set;}
    public PAQ_ConveniosSipweb_CTR(ApexPages.StandardController controller) {
        this.objCuenta                              = (Account) controller.getRecord();
        this.StandarC                               = new Apexpages.StandardController(this.objCuenta);
        this.rg                                     = null;
        this.blnPtpConfig                           = false;
        this.blnCostoBaseGMP                        = false;
        this.blnCostosFijos                         = false;
        this.blnTarifasExp                          = false;
        this.blnServicios                           = false;
        this.blnTarifas                             = false;
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
        this.mapTarifasC                            = new Map<String, wpTarifa>();
        this.mapTarifas                             = new Map<String, Map<String, Map<String, wpTarifa>>>();
        this.listRangeDestiny                       = new List<String>();
        this.listServicio                           = new List<String>();
        this.listFactor                             = new List<String>();

        this.mapTarifasExp                          = new Map<String, Map<String, Map<Decimal, wpTarifa>>>();
        this.listRangeDestinyExp                    = new List<String>();
        this.listServicioExp                        = new List<String>();
        this.listBloquesExp                         = new List<Decimal>();

        this.mapServicios                           = new Map<String, wpServicios>();
        this.listServicios                          = new List<String>();
        this.listRangeServ                          = new List<String>();
        this.listTarifas                            = new List<String>();
        this.listTarifasC                           = new list<String>();
        this.mapTarifas2                            = new Map<String, wpTarifa>();
        if(!test.isRunningTest())
            CargaInfoSipweb();
    }
    public void CargaInfoSipweb(){
        String strRangeDest                                         = '';
        String strKeyServ                                           = '';
        String RangoKm                                              = '';
        String serviceId                                            = '';
        String factor                                               = '';
        String strMultipieza                                        = '';
        String refServiceId                                         = '';
        Decimal factorValue                                         = 0;
        Decimal trifAmountExce                                      = 0;
        wpTarifa wpT                                                = new wpTarifa();
        wpServicios wpS                                             = new wpServicios();
        ObjDocEnLinea.ptpServicesTrif ptpConfig                     = new ObjDocEnLinea.ptpServicesTrif();
        ObjDocEnLinea.kmServicesTrif kmConfig                       = new ObjDocEnLinea.kmServicesTrif();
        ObjDocEnLinea.serviceTrifCbe servicesTrifCbe                = new ObjDocEnLinea.serviceTrifCbe();
        ObjDocEnLinea.serviceTrif serviceTrif                       = new ObjDocEnLinea.serviceTrif();
        ObjDocEnLinea.kmServicesTrifList kmServicesTrif             = new ObjDocEnLinea.kmServicesTrifList();
        List<ObjDocEnLinea.serviceTrifCbe> lstservicesTrifCbe       = new List<ObjDocEnLinea.serviceTrifCbe>();
        List<ObjDocEnLinea.ptpServicesTrifSub> lstptpServicesTrif   = new List<ObjDocEnLinea.ptpServicesTrifSub>();
        List<ObjDocEnLinea.kmServicesTrifList> lstkmServicesTrif    = new List<ObjDocEnLinea.kmServicesTrifList>();
        List<ObjDocEnLinea.serviceTrif> lstServiceTrif              = new List<ObjDocEnLinea.serviceTrif>();
        try{
            if(ObtieneInfoResponse(objCuenta)){
                ptpConfig   = this.rg.body.response.data.ptpConfig[0];
                kmConfig    = this.rg.body.response.data.kmConfig[0];
                if(rg.body.response.messages != null && rg.body.response.messages[0] != null){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, rg.body.response.messages[0].description));
                    return;
                }
                if(rg.body.response.data != null || test.isrunningtest() ){
                    if(kmConfig == null && ptpConfig == null){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'El cliente consultado no cuenta con tarifas grabadas en documentación en línea.'));
                        return;
                    }
                    this.clntId = rg.body.response.data.clntId;
                    this.strTipoTarifa  = this.rg.body.response.data.trifType;
                    if(rg.body.response.data.pieceMulti != '')
                        strMultipieza = 'SI';
                    else strMultipieza = 'NO';
                    if(this.strTipoTarifa == 'C'){
                        this.blnCostoBaseGMP = true;
                        if(ptpConfig != null){
                            this.blnPtpConfig   = true;
                            lstptpServicesTrif  = ptpConfig.ptpServicesTrif;
                            for(Integer x = 0;x < lstptpServicesTrif.size();x++){
                                ObjDocEnLinea.ptpServicesTrifSub ptpservidesTrif    = lstptpServicesTrif[x];
                                RangoKm                                             = ptpservidesTrif.orgnSite + ' - ' + ptpservidesTrif.destSite;
                                if(ptpservidesTrif.serviceTrif != null && ptpservidesTrif.serviceTrif.size() > 0){
                                    for(ObjDocEnLinea.serviceTrif s : ptpservidesTrif.serviceTrif){
                                        refServiceId                            = s.refServiceId;
                                        if(refServiceId == 'ACK' || refServiceId == 'EXT' || refServiceId == 'EAD' || refServiceId == 'RAD' || refServiceId == 'PACKETS'){
                                            this.blnServicios = true;
                                            strKeyServ = RangoKm + ' - ' + refServiceId + ' - ' + s.factor;
                                            if(!this.listRangeServ.contains(strKeyServ)){
                                                this.listRangeServ.add(strKeyServ);
                                            }
                                            wpS                 = new wpServicios();
                                            wpS.Servicio        = s.serviceId;
                                            wpS.Monto           = s.trifAmount;
                                            wpS.servicesCant    = s.servicesCant;
                                            wpS.cotizacion      = s.quotation;
                                            wpS.rango           = RangoKm;
                                            if(!this.mapServicios.containsKey(strKeyServ)){
                                                this.mapServicios.put(strKeyServ, wpS);
                                            }
                                        }
                                    }
                                }
                                lstservicesTrifCbe = ptpservidesTrif.servicesTrifCbe;
                                if(lstservicesTrifCbe != null && lstservicesTrifCbe.size() > 0){
                                    for(ObjDocEnLinea.serviceTrifCbe sCbe : lstservicesTrifCbe){
                                        serviceId       = sCbe.serviceId;
                                        factor          = sCbe.factor;
                                        trifAmountExce  = sCbe.trifAmountExce;
                                        for(ObjDocEnLinea.serviceTrif s : sCbe.serviceTrif){
                                            factorValue     = s.factorValue;
                                            strRangeDest    = RangoKm + ' - ' + serviceId + ' - ' + factor + ' - ' + factorValue;
                                            if(serviceId != 'SEG-DS' && serviceId != 'SEG-2D' && serviceId != 'SEG-A12'){
                                                if(!this.listTarifasC.contains(strRangeDest))
                                                    this.listTarifasC.add(strRangeDest);
                                                if(!this.mapTarifasC.containsKey(strRangeDest)){
                                                    wpT                  = new wpTarifa();
                                                    wpT.Peso_Vol_Inicial = factorValue;
                                                    wpT.Monto            = s.trifAmount;
                                                    wpT.Monto_Excedente  = trifAmountExce;
                                                    wpT.Multipieza       = strMultipieza;
                                                    wpT.cotizacion       = s.quotation;
                                                    wpT.RangoKm          = RangoKm;
                                                    wpT.Tarifa           = this.strTipoTarifa;
                                                    wpT.Servicio         = serviceId;
                                                    wpT.factor           = s.factor;
                                                    this.mapTarifasC.put(strRangeDest, wpT);
                                                }
                                            } else {
                                                this.blnTarifasExp = true;
                                                if(!this.listRangeDestinyExp.contains(RangoKm))
                                                    this.listRangeDestinyExp.add(RangoKm);
                                                if(!this.listServicioExp.contains(serviceId))
                                                    this.listServicioExp.add(serviceId);
                                                if(!this.listBloquesExp.contains(factorValue))
                                                    this.listBloquesExp.add(factorValue);
                                                if(!this.mapTarifasExp.containsKey(RangoKm))
                                                    this.mapTarifasExp.put(RangoKm, new Map<String, Map<Decimal, wpTarifa>>());
                                                if(!this.mapTarifasExp.get(RangoKm).containsKey(serviceId))
                                                    this.mapTarifasExp.get(RangoKm).put(serviceId, new Map<Decimal, wpTarifa>());
                                                wpT                     = new wpTarifa();
                                                wpT.Peso_Vol_Inicial    = factorValue;
                                                wpT.Monto               = s.trifAmount;
                                                wpT.Monto_Excedente     = trifAmountExce;
                                                wpT.Multipieza          = strMultipieza;
                                                wpT.cotizacion          = s.quotation;
                                                this.mapTarifasExp.get(RangoKm).get(serviceId).put(factorValue, wpT);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if(kmConfig != null){
                            this.blnKmConfig    = true;
                            lstkmServicesTrif   = null;
                            lstkmServicesTrif   = kmConfig.kmServicesTrif;
                            for(ObjDocEnLinea.kmServicesTrifList kmST : lstkmServicesTrif){
                                RangoKm         = kmST.fromKm + ' - ' + kmST.toKm;
                                lstServiceTrif  = kmST.serviceTrif;
                                if(lstServiceTrif != null && lstServiceTrif.size() > 0){
                                    for(ObjDocEnLinea.serviceTrif s : lstServiceTrif){
                                        refServiceId    = s.refServiceId;
                                        serviceId       = s.serviceId;
                                        if(refServiceId == 'ACK' || refServiceId == 'EXT' || refServiceId == 'EAD' || refServiceId == 'RAD' || refServiceId == 'PACKETS'){
                                            this.blnServicios   = true;
                                            strKeyServ          = RangoKm + ' - ' + refServiceId;
                                            if(!this.listRangeServ.contains(strKeyServ)){
                                                this.listRangeServ.add(strKeyServ);
                                            }
                                            wpS                 = new wpServicios();
                                            wpS.Servicio        = serviceId;
                                            wpS.Monto           = s.trifAmount;
                                            wpS.servicesCant    = s.servicesCant;
                                            wpS.cotizacion      = s.quotation;
                                            wpS.rango           = RangoKm;
                                            if(!this.mapServicios.containsKey(strKeyServ)){
                                                this.mapServicios.put(strKeyServ, wpS);
                                            }
                                        }
                                    }
                                }
                                lstservicesTrifCbe  = kmST.servicesTrifCbe;
                                for(ObjDocEnLinea.serviceTrifCbe sCbe : lstservicesTrifCbe){
                                    serviceId       = sCbe.serviceId;
                                    factor          = sCbe.factor;
                                    trifAmountExce  = sCbe.trifAmountExce;
                                    lstServiceTrif  = sCbe.serviceTrif;
                                    for(ObjDocEnLinea.serviceTrif s : lstServiceTrif){
                                        //serviceTrif = sCbe.serviceTrif[y];
                                        factorValue = s.factorValue;
                                        if(serviceId != 'SEG-DS' && serviceId != 'SEG-2D' && serviceId != 'SEG-A12'){
                                            strRangeDest = RangoKm + ' - ' + serviceId + ' - ' + factor + ' - ' + factorValue;
                                            if(!this.listTarifasC.contains(strRangeDest)){
                                                this.listTarifasC.add(strRangeDest);
                                            }
                                            wpT = new wpTarifa();
                                            wpT.Peso_Vol_Inicial = factorValue;
                                            wpT.Monto            = s.trifAmount;
                                            wpT.Monto_Excedente  = trifAmountExce;
                                            wpT.Multipieza       = strMultipieza;
                                            wpT.cotizacion       = s.quotation;
                                            wpT.RangoKm          = RangoKm;
                                            wpT.Tarifa           = this.strTipoTarifa;
                                            wpT.Servicio         = serviceId;
                                            wpT.factor           = factor;
                                            if(!this.mapTarifasC.containsKey(strRangeDest)){
                                                this.mapTarifasC.put(strRangeDest, wpT);
                                            }
                                        } else {
                                            this.blnTarifasExp = true;
                                            if(!this.listRangeDestinyExp.contains(RangoKm)){
                                                this.listRangeDestinyExp.add(RangoKm);
                                            }
                                            if(!this.listServicioExp.contains(serviceId)){
                                                this.listServicioExp.add(serviceId);
                                            }
                                            if(!this.listBloquesExp.contains(factorValue)){
                                                this.listBloquesExp.add(factorValue);
                                            }
                                            if(!this.mapTarifasExp.containsKey(RangoKm)){
                                                this.mapTarifasExp.put(RangoKm, new Map<String, Map<Decimal, wpTarifa>>());
                                            }
                                            if(!this.mapTarifasExp.get(RangoKm).containsKey(serviceId)){
                                                this.mapTarifasExp.get(RangoKm).put(serviceId, new Map<Decimal, wpTarifa>());
                                            }
                                            wpT                     = new wpTarifa();
                                            wpT.Peso_Vol_Inicial    = factorValue;
                                            wpT.Monto               = s.trifAmount;
                                            wpT.Monto_Excedente     = trifAmountExce;
                                            wpT.Multipieza          = strMultipieza;
                                            wpT.cotizacion          = s.quotation;
                                            this.mapTarifasExp.get(RangoKm).get(serviceId).put(factorValue, wpT);
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        this.blnCostosFijos = true;
                        String strserv = '';
                        if(kmConfig != null){
                            for(Integer x = 0;x < kmConfig.kmServicesTrif.size();x++){
                                kmServicesTrif  = kmConfig.kmServicesTrif[x];
                                RangoKm         = kmServicesTrif.fromKm + ' - ' + kmServicesTrif.toKm;
                                if(kmServicesTrif.serviceTrif != null && kmServicesTrif.serviceTrif.size() > 0){
                                    for(Integer z = 0; z < kmServicesTrif.serviceTrif.size();z ++){
                                        serviceTrif     = kmServicesTrif.serviceTrif[z];
                                        refServiceId    = serviceTrif.refServiceId;
                                        factor          = serviceTrif.factor;
                                        if(refServiceId == 'ACK' || refServiceId == 'EXT' || refServiceId == 'EAD' || refServiceId == 'RAD' || refServiceId == 'PACKETS'){
                                            this.blnServicios = true;
                                            strKeyServ = RangoKm + ' - ' + refServiceId + ' - ' + factor;
                                            if(!this.listRangeServ.contains(strKeyServ)){
                                                this.listRangeServ.add(strKeyServ);
                                            }
                                            wpS = new wpServicios();
                                            wpS.Servicio      = serviceTrif.serviceId;
                                            wpS.Monto         = serviceTrif.trifAmount;
                                            wpS.servicesCant  = serviceTrif.servicesCant;
                                            wpS.cotizacion    = serviceTrif.quotation;
                                            wpS.rango         = RangoKm;
                                            if(!this.mapServicios.containsKey(strKeyServ)){
                                                this.mapServicios.put(strKeyServ, wpS);
                                            }
                                        }
                                    }
                                }
                                if(kmServicesTrif.otherServiceTrif != null && kmServicesTrif.otherServiceTrif.size() > 0){
                                    for(Integer z = 0; z < kmServicesTrif.otherServiceTrif.size();z++){
                                        serviceTrif = kmServicesTrif.otherServiceTrif[z];
                                        refServiceId = serviceTrif.refServiceId;
                                        serviceId = serviceTrif.serviceId;
                                        this.blnServicios = true;
                                        if(!this.listRangeServ.contains(RangoKm + ' - ' + refServiceId)){
                                            this.listRangeServ.add(RangoKm + ' - ' + refServiceId);
                                        }
                                        wpS                 = new wpServicios();
                                        wpS.Servicio        = serviceId;
                                        wpS.Monto           = serviceTrif.trifAmount;
                                        wpS.servicesCant    = serviceTrif.servicesCant;
                                        wpS.cotizacion      = serviceTrif.quotation;
                                        wpS.rango           = RangoKm;
                                        if(!this.mapServicios.containsKey(RangoKm + ' - ' + refServiceId)){
                                            this.mapServicios.put(RangoKm + ' - ' + refServiceId, wpS);
                                        }
                                    }
                                }
                                if(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl != null && rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl.size() > 0 ){
                                    this.blnTarifas = true;
                                    for(Integer i = 0; i < rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl.size(); i ++){
                                        for(Integer y = 0; y < rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif.size(); y ++){
                                            if(!this.listRangeDestiny.contains(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo))
                                                this.listRangeDestiny.add(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm+ ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo);
                                            if(!this.mapTarifas2.containsKey(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm+ ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo)){
                                                this.mapTarifas2.put(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm+ ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo, new wpTarifa());
                                                this.mapTarifas2.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm+ ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo).Servicio = rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId;
                                                this.mapTarifas2.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm+ ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo).Tarifa = rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo;
                                                this.mapTarifas2.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm+ ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo).Monto = rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].trifAmount;
                                                this.mapTarifas2.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm+ ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo).cotizacion = rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].quotation; 
                                                this.mapTarifas2.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm+ ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifDtl[i].slabNo).RangoKm = rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm; 
                                            }
                                        }
                                    }
                                }
                                if(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe != null && rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe.size() != 0){
                                    for(Integer i = 0; i < rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe.size(); i ++){
                                        if(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId == 'SEG-DS' || rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId == 'SEG-2D' || rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId == 'SEG-A12'){
                                            this.blnTarifasExp = true;
                                            for(Integer y = 0; y < rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif.size(); y ++){
                                                if(!this.listRangeDestinyExp.contains(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm))
                                                    this.listRangeDestinyExp.add(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm);
                                                if(!this.listServicioExp.contains(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId))
                                                    this.listServicioExp.add(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId);
                                                
                                                if(!this.listBloquesExp.contains(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue))
                                                    this.listBloquesExp.add(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue);
        
                                                if(!this.mapTarifasExp.containsKey(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm))
                                                    this.mapTarifasExp.put(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm, new Map<String, Map<Decimal, wpTarifa>>());
                                                if(!this.mapTarifasExp.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm).containsKey(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId))
                                                    this.mapTarifasExp.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm).put(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId, new Map<Decimal, wpTarifa>());
                                                    this.mapTarifasExp.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId).put(
                                                        rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue, new wpTarifa());
                                                this.mapTarifasExp.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).Peso_Vol_Inicial = rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue;
                                                this.mapTarifasExp.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).Monto = rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].trifAmount;
                                                this.mapTarifasExp.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).Monto_Excedente = rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].trifAmountExce;
                                                this.mapTarifasExp.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).Multipieza = 'NO';
                                                this.mapTarifasExp.get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].fromKm + ' - ' + rg.body.response.data.kmConfig[0].kmServicesTrif[x].toKm).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).cotizacion = rg.body.response.data.kmConfig[0].kmServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].quotation;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if(this.rg.body.response.data.ptpConfig != null){
                            if(this.rg.body.response.data.ptpConfig[0].ptpServicesTrif != null && this.rg.body.response.data.ptpConfig[0].ptpServicesTrif.size() > 0){
                                for(Integer x = 0;x < this.rg.body.response.data.ptpConfig[0].ptpServicesTrif.size();x++){
                                    if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe != null && rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe.size() > 0){
                                        for(Integer z = 0; z < this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif.size();z ++){                                    
                                            if(this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].refServiceId == 'ACK' || this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].refServiceId == 'EXT' || this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].refServiceId == 'EAD' || this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].refServiceId == 'RAD' || this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].refServiceId == 'PACKETS'){
                                                this.blnServicios = true;
                                                strKeyServ = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].refServiceId + ' - ' + this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].factor;
                                                if(!this.listRangeServ.contains(strKeyServ))
                                                    this.listRangeServ.add(strKeyServ);
                
                                                if(!this.mapServicios.containsKey(strKeyServ)){
                                                    this.mapServicios.put(strKeyServ, new wpServicios());
                                                }
                                                if(this.mapServicios.containsKey(strKeyServ)){
                                                    this.mapServicios.get(strKeyServ).Servicio      = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].serviceId;
                                                    this.mapServicios.get(strKeyServ).Monto         = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].trifAmount;
                                                    this.mapServicios.get(strKeyServ).servicesCant  = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].servicesCant;
                                                    this.mapServicios.get(strKeyServ).cotizacion    = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].serviceTrif[z].quotation;
                                                    this.mapServicios.get(strKeyServ).rango         = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite;
                                                }
                                            }
                                        }
                                    }
                                    if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif != null && rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif.size() > 0){
                                        for(Integer z = 0; z < this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif.size();z++){
                                            this.blnServicios = true;
                                            if(!this.listRangeServ.contains(this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId))
                                                this.listRangeServ.add(this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId);
                                            if(!this.mapServicios.containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId)){
                                                this.mapServicios.put(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId, new wpServicios());
                                            }
                                            if(this.mapServicios.containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId)){
                                                this.mapServicios.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId).Servicio = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].serviceId;
                                                this.mapServicios.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId).Monto = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].trifAmount;
                                                this.mapServicios.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId).servicesCant = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].servicesCant;
                                                this.mapServicios.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId).cotizacion = this.rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].quotation;
                                                this.mapServicios.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].otherServiceTrif[z].refServiceId).rango = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite;
                                            }
                                        }
                                    }
                                    if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl != null && rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl.size() > 0){
                                        for(Integer i = 0; i < rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl.size(); i ++){
                                            for(Integer y = 0; y < rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif.size(); y ++){
                                                if(!this.listRangeDestiny.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo))
                                                    this.listRangeDestiny.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite+ ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo);
                                                if(!this.mapTarifas2.containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite+ ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo)){
                                                    this.mapTarifas2.put(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite+ ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo, new wpTarifa());
                                                    this.mapTarifas2.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite+ ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo).Servicio = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId;
                                                    this.mapTarifas2.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite+ ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo).Tarifa = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo;
                                                    this.mapTarifas2.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite+ ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo).Monto = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].trifAmount;
                                                    this.mapTarifas2.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite+ ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo).cotizacion = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].quotation; 
                                                    this.mapTarifas2.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite+ ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].serviceTrif[y].serviceId + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifDtl[i].slabNo).RangoKm = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite; 
                                                }
                                            }
                                        }
                                    }
                                    if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe != null && rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe.size() > 0){
                                        for(Integer i = 0; i < rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe.size(); i ++){
                                            if(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId == 'SEG-DS' || rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId == 'SEG-2D' || rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId == 'SEG-A12'){
                                                this.blnTarifasExp = true;
                                                for(Integer y = 0; y < rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif.size(); y ++){
                                                    if(!this.listRangeDestinyExp.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite))
                                                        this.listRangeDestinyExp.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite);
                                                    if(!this.listServicioExp.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId))
                                                        this.listServicioExp.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId);
                                                    
                                                    if(!this.listBloquesExp.contains(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue))
                                                        this.listBloquesExp.add(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue);
            
                                                    if(!this.mapTarifasExp.containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite))
                                                        this.mapTarifasExp.put(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite, new Map<String, Map<Decimal, wpTarifa>>());
                                                    if(!this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).containsKey(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId))
                                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).put(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId, new Map<Decimal, wpTarifa>());
                                                        this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).put(
                                                            rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue, new wpTarifa());
                                                    this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).Peso_Vol_Inicial = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue;
                                                    this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).Monto = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].trifAmount;
                                                    this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).Monto_Excedente = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].trifAmountExce;
                                                    this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).Multipieza = 'NO';
                                                    this.mapTarifasExp.get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].orgnSite + ' - ' + rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].destSite).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceId).get(rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].factorValue).cotizacion = rg.body.response.data.ptpConfig[0].ptpServicesTrif[x].servicesTrifCbe[i].serviceTrif[y].quotation;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            System.debug('costo base: ' + blnCostoBaseGMP + '. costos fijos: ' + blnCostosFijos);
        }catch(Exception ex){
            System.debug('Error en el constructor ' +ex.getLineNumber()+' '+EX.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error al iniciar. Contacte a un consultor de salesforce.'));
        }
    }
    public Boolean ObtieneInfoResponse(Account cuenta){
        Boolean resultado   = false;
        String endpoint     = Label.Grabado_DocLinea; //QA
        //String endpoint     = 'https://sf.paquetexpress.com.mx/SalesForceRestFul/api/agreements/getDetail';
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
    public void AsignaResponseTest(ObjDocEnLinea.documentacionRemota DR){
        try{
            System.debug('asigna response enviado desde pruebas');
            System.debug('1 valor rg: ' + rg);
            rg = DR;
            System.debug('2 valor rg: ' + rg);
            CargaInfoSipweb();
        }catch (exception ex){
            System.debug('AsignaResponseTest ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }
    }
    public class wpTarifa{
        public Decimal Peso_Vol_Inicial {get;set;}
        public Decimal Monto            {get;set;}
        public Decimal Monto_Excedente  {get;set;}
        public String Multipieza        {get;set;}
        public String Cotizacion        {get;set;}
        public String Tarifa            {get;set;}
        public String Servicio          {get;set;}
        public String RangoKm           {get;set;}
        public String factor            {get;set;}
        public wpTarifa(){
            this.Peso_Vol_Inicial   = 0;
            this.Monto              = 0;
            this.Monto_Excedente    = 0;
            this.Multipieza         = '';
            this.cotizacion         = '';
            this.Tarifa             = '';
            this.Servicio           = '';
            this.RangoKm            = '';
            this.factor             = '';
        }
    }
    public class wpServicios{
        public Decimal Monto            {get;set;}
        public String servicesCant      {get;set;}
        public String Cotizacion        {get;set;}
        public String Servicio          {get;set;}
        public String Rango          {get;set;}
        public wpServicios(){
            this.Monto              = 0;
            this.servicesCant       = '';
            this.cotizacion         = '';
            this.Servicio           = '';
            this.Rango           = '';
        }
    }
}
