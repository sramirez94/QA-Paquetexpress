public class GrabadoDocEnLinea {
    public static void procesarDL(SBQQ__Quote__c cotizacion){
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

}
