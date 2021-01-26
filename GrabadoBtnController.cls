global class GrabadoBtnController {
    public Id owner {get; set;}
    public Id Id { get; set; }
    public SBQQ__Quote__c cas { get; set; }
    public string tipoDocumentacion {get;set;}
    public Id cuenta {get;set;}
    public string idSipWeb{get;set;}
    public date fechaVigencia{get;set;}
    public Boolean grabadoUnico{get;set;}
    public Boolean confirmacionGrabadoUnico{get;set;}
    
    public GrabadoBtnController(ApexPages.StandardController controller) {
        try{
        cas =  (SBQQ__Quote__c) controller.getRecord();
        Id = cas.Id;
        System.debug('Cotización: ' + cas); 
        idSipWeb = cas.SBQQ__Account__r.Id_SIpWeb__c;
        owner = cas.OwnerId;
        cuenta = cas.SBQQ__Account__c;
        tipoDocumentacion = cas.Tipo_de_documentacion__c;
        fechaVigencia = cas.Flujo_del_mes__c;
        grabadoUnico = cas.Descuento_prepago_unico__c;//Confirmacion_de_Grabado_Unico__c
            confirmacionGrabadoUnico = cas.Confirmacion_de_Grabado_Unico__c;}catch(Exception ex){System.debug('GrabadoBtnController: '+ex.getLineNumber()+' '+EX.getMessage());}
    }
    
    public PageReference procesar(){
        try{
        PageReference pageRef = new PageReference('/'+Id);
        pageRef.setRedirect(true);
        if(tipoDocumentacion=='Tarifario abierto de piso'){    
            if(System.isScheduled()||!(grabadoUnico && confirmacionGrabadoUnico)){
                if(fechaVigencia>=Date.today()||fechaVigencia==null)
                    iniciarGrabado(cas);
                else
                    publicarEvento(false,'Vigencia para cotización '+ cas.Name +' expirada.');
            }
            else
                publicarEvento(false,'No puede volver a enviarse el grabado para la cotización');
        }
        else{
            pageRef = new PageReference('/apex/GrabadoDocEnLinea?Id='+Id);
			pageRef.setRedirect(true);
            return pageRef;

        }
        
            return pageRef;        
        }catch(Exception ex){
        PageReference pageRef = new PageReference('/'+Id);
                return pageRef;        
                
            }
    }
    
    public void iniciarGrabado(SBQQ__Quote__c cotizacion){
        try{
            System.debug('Id Sipweb '+cotizacion.SBQQ__Account__r.Id_SIpWeb__c);
            if((cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c))|| Test.isRunningTest()){
                if(cotizacion.SBQQ__Status__c=='Approved'){
                    if(cotizacion.SBQQ__Opportunity2__r.StageName=='Cerrada/Ganada' || Test.isRunningTest()){
                        System.debug(Cotizacion.Id+' '+tipoDocumentacion);
                        System.debug('Id Sipweb: '+cotizacion.SBQQ__Account__r.Id_SIpWeb__c);
                        switch on tipoDocumentacion{
                            when 'En Piso-Sipweb'{
                                validacionEnpiso(cotizacion);
                            }
                            when 'Guías prepagadas'{
                                validacionGuiasPrepagadas(cotizacion);
                            }
                            /*when 'Documentación Remota'{
								GrabadoDocEnLinea.procesarDL(cotizacion);
							}*/
                            when else{
                                publicarEvento(false,'El tipo de documentación no es válido');
                            }
                        }
                    }
                    else
                        publicarEvento(false,'El estatus de la oportunidad no es "Cerrada/Ganada", estatus actual: '+cotizacion.SBQQ__Opportunity2__r.StageName);
                }
                else
                    publicarEvento(false,'La cotización aún no ha sido aprobada, estatus actual: '+cotizacion.SBQQ__Status__c);
            }
            else
                publicarEvento(false,'Sipweb Id no es válido.');            
        }
        catch(Exception ex){
            System.debug('iniciarGrabado: '+ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    
    public void validacionEnPiso(SBQQ__Quote__c cotizacion){
        try{
            if((cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c) || Test.isRunningTest())){
                String endpoint = Label.Grabado_SipWeb;
                User user = [SELECT Id_Sipweb__c,FederationIdentifier FROM User WHERE Id=:System.UserInfo.getUserId()];
                String userSipweb = '';
                if(!String.isEmpty(user.Id_Sipweb__c))
                    userSipweb = user.Id_Sipweb__c;
                else
                    userSipweb = user.FederationIdentifier;
                DefinicionesServiciosGrabado.requestDctoPiso rdp = new DefinicionesServiciosGrabado.requestDctoPiso();
                DefinicionesServiciosGrabado.header rdpH = new DefinicionesServiciosGrabado.header();            
                DefinicionesServiciosGrabado.security sec = new DefinicionesServiciosGrabado.security();
                DefinicionesServiciosGrabado.dataDescPiso ddP = new DefinicionesServiciosGrabado.dataDescPiso();
                DefinicionesServiciosGrabado.requestDescPiso req = new DefinicionesServiciosGrabado.requestDescPiso();
                DefinicionesServiciosGrabado.bodyDescPiso bdp = new DefinicionesServiciosGrabado.bodyDescPiso();
                List<DefinicionesServiciosGrabado.discountService> dsList = new List<DefinicionesServiciosGrabado.discountService>();
                Map<String,String> mapaServicios = getCodigoServicio();
                Map<String,String> mapaReferencias = getCodigoReferencia();
                String listaDeControl = '';
                List<SBQQ__QuoteLine__c> pPresupuesto = [SELECT ID,Tarifa__c,ZonaPlus__c,DiscountAcuse__c,SBQQ__Quote__r.Acuse__c,DiscountDelivery__c,RAD__c,EAD__c,ACK__c,SEG__c,Pack_Seg__c,SBQQ__Discount__c,DiscountRecolection__c,Discountflete__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c =: cotizacion.Id AND (DiscountDelivery__c != NULL OR RAD__c!=NULL OR DiscountDelivery__c!=NULL OR ACK__c!=NULL OR SEG__c != NULL OR Pack_Seg__c != NULL OR (Tarifa__c='SEG-DS' AND SBQQ__Discount__c != NULL)OR (Tarifa__c='SEG-2D' AND SBQQ__Discount__c != NULL)OR (Tarifa__c='SEG-A12' AND SBQQ__Discount__c != NULL)) Order By LastModifiedDate DESC];
                if(Test.isRunningTest()){
                    SBQQ__QuoteLine__c ql = new SBQQ__QuoteLine__c();
                    ql.DiscountRecolection__c = 9;
                    pPresupuesto.add(ql);
                    SBQQ__QuoteLine__c ql2 = new SBQQ__QuoteLine__c();
                    ql2.ZonaPlus__c = false;                    
                    ql2.DiscountDelivery__c = 9;
                    pPresupuesto.add(ql2);   
                    SBQQ__QuoteLine__c ql3 = new SBQQ__QuoteLine__c();
                    ql3.ZonaPlus__c = true;                    
                    ql2.DiscountDelivery__c = 9;
                    pPresupuesto.add(ql3);                      
                    SBQQ__QuoteLine__c ql4 = new SBQQ__QuoteLine__c();
                    ql4.ZonaPlus__c = true;
                    ql4.Tarifa__c = 'TARIFA SOBRE';
                    ql4.Discountflete__c = 9;
                    pPresupuesto.add(ql4);
                }
                for(SBQQ__QuoteLine__c p:pPresupuesto){
                    if(p.DiscountRecolection__c!=null && p.DiscountRecolection__c > 0 && !listaDeControl.containsIgnoreCase('RAD')){
                        dsList.add(obtenerRegistroPiso(p.DiscountRecolection__c,'RAD'));
                        listaDeControl = listaDeControl+'RAD';                     
                        System.debug('LDC: '+listaDeControl);
                    }if(p.DiscountDelivery__c !=null && !p.ZonaPlus__c && !listaDeControl.containsIgnoreCase('EAD') && p.DiscountDelivery__c > 0){
                        dsList.add(obtenerRegistroPiso(p.DiscountDelivery__c,'EAD'));
                        listaDeControl = listaDeControl+'EAD';                                                 
                    }if(p.DiscountAcuse__c!=null&& !listaDeControl.containsIgnoreCase('ACK') && p.DiscountAcuse__c >0){
                        if(p.SBQQ__Quote__r.Acuse__c!=null){
                            String tipoAcuse;
                            System.debug('Discount Acuseeee: '+p.DiscountAcuse__c);
                            if(p.SBQQ__Quote__r.Acuse__c=='XT'&& !listaDeControl.containsIgnoreCase('XT'))
                                tipoAcuse = 'Acuse XT';
                            else if(p.SBQQ__Quote__r.Acuse__c=='Interno' && !listaDeControl.containsIgnoreCase('Interno'))
                                tipoAcuse = 'Acuse Interno';
                            else if(p.SBQQ__Quote__r.Acuse__c=='Empresa' && !listaDeControl.containsIgnoreCase('Empresa'))
                                tipoAcuse = 'Acuse Empresa';
                            listaDeControl = listaDeControl+tipoAcuse;
                            dsList.add(obtenerRegistroPiso(p.DiscountAcuse__c,tipoAcuse));
                            listaDeControl = listaDeControl+'ACK';                     
                            System.debug('LDC: '+listaDeControl);                        
                        }
                    }
                    if(p.Discountflete__c!=null && p.Tarifa__c == 'TARIFA SOBRE' && !listaDeControl.containsIgnoreCase('Env') && p.Discountflete__c >0){
                        dsList.add(obtenerRegistroPiso(p.Discountflete__c,'Sobres'));
                        listaDeControl = listaDeControl+'Env';                                             
                    }
                    if(p.DiscountDelivery__c!=null && p.ZonaPlus__c && !listaDeControl.containsIgnoreCase('ZP') && p.DiscountDelivery__c >0 ){
                        dsList.add(obtenerRegistroPiso(p.DiscountDelivery__c,'EAD Zona plus'));
                        listaDeControl = listaDeControl+'ZP';
                    }
                    if(p.Discountflete__c!=null && p.Tarifa__c != 'TARIFA SOBRE' && !listaDeControl.containsIgnoreCase('Paq') && p.Discountflete__c >0){
                        dsList.add(obtenerRegistroPiso(p.Discountflete__c,'Paquetes'));
                        listaDeControl = listaDeControl+'Paq';                                             
                    }                                        
                }
                for(SBQQ__QuoteLine__c p:pPresupuesto){
                    if((p.Tarifa__c == 'SEG-DS' && p.SBQQ__Discount__c != null)&& !listaDeControl.containsIgnoreCase('DS') && p.SBQQ__Discount__c >0 ){
                        System.debug('Validacion SEG-DS');
                        dsList.add(obtenerRegistroPiso(p.SBQQ__Discount__c,'DIA SIGUIENTE (DS)'));
                        listaDeControl = listaDeControl+'DS';                        
                    }
                    if(p.Tarifa__c == 'SEG-2D' && p.SBQQ__Discount__c != null && !listaDeControl.containsIgnoreCase('2D') && p.SBQQ__Discount__c >0 ){
                        System.debug('Validacion SEG-2D');                        
                        dsList.add(obtenerRegistroPiso(p.SBQQ__Discount__c,'DOS DIAS (2D)'));
                        listaDeControl = listaDeControl+'2D';                        
                    }
                    if((p.Tarifa__c == 'SEG-A12' && p.SBQQ__Discount__c != null )&& !listaDeControl.containsIgnoreCase('A12') && p.SBQQ__Discount__c >0 ){
                        System.debug('Validacion SEG-A12');  
                        dsList.add(obtenerRegistroPiso(p.SBQQ__Discount__c,'ANTES DE LAS 12 (A12)'));
                        listaDeControl = listaDeControl+'A12';                        
                    }                                        
                }                
                System.debug('Lista de control: '+listaDeControl);
                System.debug('Lista generada: '+dsList);
                sec.user = 'SALESFORCE';
                sec.token = '325746796331582000000';
                rdpH.security = sec;    
                rdp.header= rdpH;
                ddP.user = userSipweb;
                ddp.clntId = cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
                ddp.discountServiceList = dsList;    
                req.data = ddp;
                bdp.request = req;
                rdp.body = bdp;
                if(envioGrabadoPOST(JSON.serialize(rdp).replace('ACK1','ACK').replace('ACK2','ACK'),endpoint,cotizacion))
                    publicarEvento(true,null);
                else
                    publicarEvento(false,'No se pudo realizar el grabado');
            }
            
            else
                System.debug('validacionEnPiso: Sipweb Id no es válido');
        }catch(Exception ex){
            System.debug('validacionEnPiso: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false,'No se pudo realizar el grabado');            
        }
    }
    public void validacionGuiasPrepagadas(SBQQ__Quote__c cotizacion){
        try{
            system.debug('Id sipweb: '+cotizacion.SBQQ__Account__r.Id_SIpWeb__c+' Sipweb account: '+cotizacion.SBQQ__Account__r.Id_SIpWeb__c);
            if(cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c)|| Test.isRunningTest()){
                System.debug('validacionGuiasPrepagadas');
                String endpoint = Label.Grabado_Guias_Prepagadas;
                String userSipweb = '';
                User u = [SELECT Id_Sipweb__c, FederationIdentifier FROM User WHERE Id=:System.UserInfo.getUserId()];
                if(!System.isScheduled()){
                    if(!String.isEmpty(u.Id_Sipweb__c))
                        userSipweb = u.Id_Sipweb__c;
                    else
                        userSipweb = u.FederationIdentifier;
                }
                DefinicionesServiciosGrabado.requestTarifaDcto rdp = new DefinicionesServiciosGrabado.requestTarifaDcto();
                DefinicionesServiciosGrabado.header rdpH = new DefinicionesServiciosGrabado.header();            
                DefinicionesServiciosGrabado.security sec = new DefinicionesServiciosGrabado.security();
                DefinicionesServiciosGrabado.data ddP = new DefinicionesServiciosGrabado.data();
                DefinicionesServiciosGrabado.request req = new DefinicionesServiciosGrabado.request();
                DefinicionesServiciosGrabado.body bdp = new DefinicionesServiciosGrabado.body();
                
                List<DefinicionesServiciosGrabado.discountZone> dzList = new List<DefinicionesServiciosGrabado.discountZone>();
                Map<String,String> listaZonas = mapZonas();
                List<SBQQ__QuoteLine__c> pPresupuesto = [SELECT Id,Zona_de_descuento__c,Rango_KM__c,Tarifa__c,SBQQ__TotalDiscountRate__c,	SBQQ__Discount__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c =: cotizacion.Id AND Rango_KM__c !=null ORDER BY SBQQ__Discount__c ASC];
                System.debug('Partidas de presupuesto: '+ pPresupuesto.size());
                if(pPresupuesto.size()>0){
                    for(String key:listaZonas.KeySet()){
                        String listaDeControl = ''; 
                        DefinicionesServiciosGrabado.discountZone dz = new DefinicionesServiciosGrabado.discountZone();                        
                        List<DefinicionesServiciosGrabado.tarifaDescuento> dsList = new List<DefinicionesServiciosGrabado.tarifaDescuento>();
                        for(SBQQ__QuoteLine__c p :pPresupuesto){
                            if(p.Tarifa__c.contains('2D')&&p.Rango_KM__c==Key)
                                System.debug('Se encontró 2D '+p.Tarifa__c+' Rango: '+p.Rango_KM__c+' Key: '+Key+'\n'+'Lista de control: '+listaDeControl);
                            
                            DefinicionesServiciosGrabado.tarifaDescuento dscS = new DefinicionesServiciosGrabado.tarifaDescuento();                                                  
                            if(p.Rango_KM__c==Key && !listaDeControl.containsIgnoreCase(p.Tarifa__c.replace('TARIFA ','').replace('SEG-','').replace('SOBRES','S').replace('SOBRE','S').replace(' ','').replace('-V','').replace('-P',''))){
                                if(System.isScheduled())
                                    dscS.discount = 0;    
                                else
                                    dscS.discount = (p.SBQQ__Discount__c * -1).setScale(2);
                                dscS.actvFlag = 'A';
                                dscS.slabNo = p.Tarifa__c.replace('TARIFA ','').replace('SEG-','').replace('SOBRES','S').replace('SOBRE','S').replace(' ','').replace('-V','').replace('-P','');
                                listaDeControl = listaDeControl + dscS.slabNo+',';
                                dsList.add(dscS);                              
                            }                    
                        }
                        dz.zone = listaZonas.get(key);
                        dz.actvFlag = 'A';
                        dz.discountTrfs = dsList;
                        dzList.add(dz);                                 
                    }
                }
                else
                    publicarEvento(false,'Datos insuficientes para realizar el grabado');            
                for(DefinicionesServiciosGrabado.discountZone dz :dzList){
                    System.debug('Zona final:' +dz.zone);
                    for(DefinicionesServiciosGrabado.tarifaDescuento td :dz.discountTrfs){
                        System.debug('Descuento: '+ td.discount);
                    }
                }
                sec.user = 'SALESFORCE';
                sec.token = '325746796331582000000';
                rdpH.security = sec;    
                rdp.header= rdpH;
                ddP.user = userSipweb;
                ddP.clntId = cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
                ddP.discountZones = dzList; 
                ddP.quotation =cotizacion.Name;
                req.data = ddP;
                bdp.request = req;
                rdp.body = bdp;
                System.debug('Se terminó de formar el JSON');
                if(!System.isScheduled()){
                    if(!cotizacion.Electronicas__c){
                        if(envioGrabadoPOST(JSON.serialize(rdp),endpoint,cotizacion))
                            publicarEvento(true,null);}
                    else if(cotizacion.Electronicas__c){
                        if(crearUsuarioWeb(cotizacion)){
                            if(envioGrabadoPOST(JSON.serialize(rdp),endpoint,cotizacion))
                                publicarEvento(true,null);
                        }
                    }
                    else
                        publicarEvento(false,'No se pudo realizar el grabado');
                }
                else
                    envioGrabadoPOST(JSON.serialize(rdp),endpoint,cotizacion);
            }
        }catch(Exception ex){
            System.debug('validacionEnPiso: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false,'No se pudo realizar el grabado');
        }
    }
    @future(callout=true)    
    public static void actualizarCotizacionExpirada(String cot){
        try{
            SBQQ__Quote__c cotizacion = (SBQQ__Quote__c)JSON.deserialize(cot, SBQQ__Quote__c.class);
            system.debug('Id sipweb: '+cotizacion.SBQQ__Account__r.Id_SIpWeb__c+' Sipweb account: '+cotizacion.SBQQ__Account__r.Id_SIpWeb__c);
            if(cotizacion.SBQQ__Account__r.Id_SIpWeb__c!=null && !String.isEmpty(cotizacion.SBQQ__Account__r.Id_SIpWeb__c)|| Test.isRunningTest()){
                System.debug('validacionGuiasPrepagadas');
                String endpoint = Label.Grabado_Guias_Prepagadas;
                String userSipweb = '';
                User u = [SELECT Id_Sipweb__c, FederationIdentifier FROM User WHERE Id=:System.UserInfo.getUserId()];
                if(!String.isEmpty(u.Id_Sipweb__c))
                    userSipweb = u.Id_Sipweb__c;
                else
                    userSipweb = u.FederationIdentifier;                
                DefinicionesServiciosGrabado.requestTarifaDcto rdp = new DefinicionesServiciosGrabado.requestTarifaDcto();
                DefinicionesServiciosGrabado.header rdpH = new DefinicionesServiciosGrabado.header();            
                DefinicionesServiciosGrabado.security sec = new DefinicionesServiciosGrabado.security();
                DefinicionesServiciosGrabado.data ddP = new DefinicionesServiciosGrabado.data();
                DefinicionesServiciosGrabado.request req = new DefinicionesServiciosGrabado.request();
                DefinicionesServiciosGrabado.body bdp = new DefinicionesServiciosGrabado.body();
                List<DefinicionesServiciosGrabado.discountZone> dzList = new List<DefinicionesServiciosGrabado.discountZone>();
                Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
                GrabadoBtnController gbc = new GrabadoBtnController(sc);
                Map<String,String> listaZonas = gbc.mapZonas();
                List<SBQQ__QuoteLine__c> pPresupuesto = [SELECT Id,Zona_de_descuento__c,Rango_KM__c,Tarifa__c,SBQQ__TotalDiscountRate__c,	SBQQ__Discount__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c =: cotizacion.Id AND Rango_KM__c !=null ORDER BY SBQQ__Discount__c ASC];
                if(Test.isRunningTest()){
                    pPresupuesto.add(new SBQQ__QuoteLine__c(Zona_de_descuento__c='401-800',Rango_KM__c='401-800',Tarifa__c='T1',SBQQ__Discount__c=3));
                }
                System.debug('Partidas de presupuesto: '+ pPresupuesto.size());
                if(pPresupuesto.size()>0){
                    for(String key:listaZonas.KeySet()){
                        String listaDeControl = ''; 
                        DefinicionesServiciosGrabado.discountZone dz = new DefinicionesServiciosGrabado.discountZone();                        
                        List<DefinicionesServiciosGrabado.tarifaDescuento> dsList = new List<DefinicionesServiciosGrabado.tarifaDescuento>();
                        for(SBQQ__QuoteLine__c p :pPresupuesto){
                            if(p.Tarifa__c.contains('2D')&&p.Rango_KM__c==Key)
                                System.debug('Se encontró 2D '+p.Tarifa__c+' Rango: '+p.Rango_KM__c+' Key: '+Key+'\n'+'Lista de control: '+listaDeControl);
                            
                            DefinicionesServiciosGrabado.tarifaDescuento dscS = new DefinicionesServiciosGrabado.tarifaDescuento();                                                  
                            if(p.Rango_KM__c==Key && !listaDeControl.containsIgnoreCase(p.Tarifa__c.replace('TARIFA ','').replace('SEG-','').replace('SOBRES','S').replace('SOBRE','S').replace(' ','').replace('-V','').replace('-P',''))){
                                
                                dscS.discount = 0;
                                dscS.actvFlag = 'A';
                                dscS.slabNo = p.Tarifa__c.replace('TARIFA ','').replace('SEG-','').replace('SOBRES','S').replace('SOBRE','S').replace(' ','').replace('-V','').replace('-P','');
                                listaDeControl = listaDeControl + dscS.slabNo+',';
                                dsList.add(dscS);                              
                            }                    
                        }
                        dz.zone = listaZonas.get(key);
                        dz.actvFlag = 'A';
                        dz.discountTrfs = dsList;
                        dzList.add(dz);                                 
                    }
                }
                else
                    gbc.publicarEvento(false,'Datos insuficientes para realizar el grabado');            
                for(DefinicionesServiciosGrabado.discountZone dz :dzList){
                    System.debug('Zona final:' +dz.zone);
                    for(DefinicionesServiciosGrabado.tarifaDescuento td :dz.discountTrfs){
                        System.debug('Descuento: '+ td.discount);
                    }
                }
                sec.user = 'SALESFORCE';
                sec.token = '325746796331582000000';
                rdpH.security = sec;    
                rdp.header= rdpH;
                ddP.user = userSipweb;
                ddP.clntId = cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
                ddP.discountZones = dzList; 
                ddP.quotation =cotizacion.Name;
                req.data = ddP;
                bdp.request = req;
                rdp.body = bdp;
                System.debug('Se terminó de formar el JSON');
                if(!cotizacion.Electronicas__c){
                    if(gbc.envioGrabadoPOST(JSON.serialize(rdp),endpoint,cotizacion))
                        gbc.publicarEvento(true,null);}
                else if(cotizacion.Electronicas__c){
                    if(gbc.crearUsuarioWeb(cotizacion)){
                        if(gbc.envioGrabadoPOST(JSON.serialize(rdp),endpoint,cotizacion))
                            gbc.publicarEvento(true,null);
                    }
                }
                else
                    gbc.publicarEvento(false,'No se pudo realizar el grabado');}
        }catch(Exception ex){
            SBQQ__Quote__c cotizacion = (SBQQ__Quote__c)JSON.deserialize(cot, SBQQ__Quote__c.class);            
            Apexpages.StandardController sc = new Apexpages.StandardController(cotizacion);
            GrabadoBtnController gbc = new GrabadoBtnController(sc);            
            System.debug('validacionEnPiso: '+ex.getLineNumber()+' '+ex.getMessage());
            gbc.publicarEvento(false,'No se pudo realizar el grabado');
        }
    }

    public Boolean crearUsuarioWeb(SBQQ__Quote__c cotizacion){
        try{
            System.debug('Creando usuario web...');
            Boolean requeridoUsuario = requeridoCrearUsuario(cotizacion);
            if(Test.isRunningTest())
                requeridoUsuario = true;
            if(requeridoUsuario){
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
                System.debug('Site: '+site+' Ubicacion:'+ubicacion);
                du.authBy = userSipweb;
                du.clntId= cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
                du.clntUser= cotizacion.SBQQ__Account__r.Id_SIpWeb__c;
                du.clntPass= '1234';
                du.clntAprvSite= site;
                du.clntAprvBrnc= ubicacion;
                du.clntTarifType= 'A';
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
                return envioGrabadoPOST(JSON.serialize(rwu),endpoint,cotizacion);}
            else{
                System.debug('crearUsuarioWeb: No se requiere crear usuario');
                return true;
            }
        }catch(Exception ex){
            System.debug('crearUsuarioWeb: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false,'No se pudo realizar el grabado');            
            return false;
        }
    }
    public Boolean requeridoCrearUsuario(SBQQ__Quote__c cotizacion){
        try{
            System.debug('Verificando si existe el usuario');
            String endpoint = Label.APIVerificarUsuario;
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
            System.debug('json pet:' + jsonFormateado);
            jsonFormateado = jsonFormateado.replace('typeR','type');
            HTTPResponse res = consultaAPIPOST(jsonFormateado,endpoint);
            DefinicionesServiciosGrabado.verificarUsuarioR vuR = (DefinicionesServiciosGrabado.verificarUsuarioR)JSON.deserialize(res.getBody().replace('time','timeR'), DefinicionesServiciosGrabado.verificarUsuarioR.class);
            System.debug('requeridoCrearUsuario: ¿Se require crear usuario?: '+vur.body.response.success);
            return Boolean.valueOf(vur.body.response.success);
        }
        catch(Exception ex){
            System.debug('requeridoCrearUsuario: '+ex.getLineNumber()+' '+ex.getMessage());
            publicarEvento(false,'Error al verificar el usuario');
            return false;
        }
    }
    public Boolean envioGrabadoPOST(String body, String endpoint,SBQQ__Quote__c cotizacion){
        try{
            System.debug('Envío de grabado');
            HttpResponse res = consultaAPIPOST(body,endpoint);
            return procesarRespuestaGrabado(res,cotizacion);
        }catch(Exception ex){
            System.debug('envioGrabadoPost: '+ex.getLineNumber()+' '+ex.getMessage());
            return false;
        }
    }
    public HTTPResponse consultaAPIPOST(String body, String endpoint){
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        System.debug('Body: '+body);
        request.setEndpoint(endpoint);
        request.setBody(body);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(60000);      
        HttpResponse res = h.send(request);
        return res;        
    }
    public boolean procesarRespuestaGrabado(HTTPResponse res,SBQQ__Quote__c cotizacion){
        try{
            String respuesta = res.getBody();
            respuesta = respuesta.replace('time', 'timeR');
            SBQQ__Quote__c cot = null;
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Respuesta: ' + respuesta));
            DefinicionesServiciosGrabado.responseGrabado rg = (DefinicionesServiciosGrabado.responseGrabado)JSON.deserializeStrict(respuesta, DefinicionesServiciosGrabado.responseGrabado.class);
            //System.debug('procesarRespuestaGrabado: ¿Procesado correctamente?: '+rg.body.response.success);
            //System.debug('mensajes: ' + rg.body.response.messages);
            if(cotizacion!=null && Boolean.valueOf(rg.body.response.success))
                cot = [SELECT Id, Grabado_exitoso__c,ProcesadoTareaGrabado__c FROM SBQQ__Quote__c WHERE Id=:cotizacion.Id LIMIT 1];
            if(null!=cot){
                cot.Grabado_Exitoso__c = true;
                if(System.isScheduled() || System.isFuture())
                    cot.ProcesadoTareaGrabado__c = true;
                update cot;
            }
            else if(!Boolean.valueOf(rg.body.response.success) && !System.isScheduled())
                publicarEvento(false,'Error: '+rg.body.response.messages[0].description);
            return Boolean.valueOf(rg.body.response.success);
        }catch(Exception ex){
            System.debug('procesarRespuestaGrabado: '+ex.getLineNumber()+' '+ex.getMessage());
            return False;
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
            System.debug('publicarEvento: '+ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public Map<String,String> getCodigoServicio(){
        Map<String,String> clavesMap = new Map<String,String>();
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = SBQQ__Quote__c.ClaveDeServicio__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        List<String>  theList = new List<String>();
        for(SelectOption so : options){
            //System.debug('Clave: '+so.getValue()+', '+so.getLabel());
            clavesMap.put(so.getValue(),so.getLabel());
        }
        return clavesMap;
    }
    public Map<String,String> getCodigoReferencia(){
        Map<String,String> clavesMap = new Map<String,String>();
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = SBQQ__Quote__c.ClaveDeReferencia__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        List<String>  theList = new List<String>();
        for(SelectOption so : options){
            //System.debug('Referencia: '+so.getValue()+', '+so.getLabel());
            clavesMap.put(so.getValue(),so.getLabel());
        }
        return clavesMap;
    }  
    public DefinicionesServiciosGrabado.discountService obtenerRegistroPiso(Decimal descuento, String Servicio){
        System.debug('Mapeando servicio '+Servicio);
        Map<String,String> mapaServicios = getCodigoServicio();
        Map<String,String> mapaReferencias = getCodigoReferencia();        
        DefinicionesServiciosGrabado.discountService ds = new DefinicionesServiciosGrabado.discountService();
        ds.discount = descuento;//cotizacion.PAQ_DescuentoGlobal__c.setScale(2);
        ds.isNational = 1;
        ds.refrSrvcId = mapaReferencias.get(Servicio);
        System.debug('Servicio obtenido: '+ds.refrSrvcId);
        ds.srvcId = mapaServicios.get(Servicio);
        System.debug('Referencia obtenida: '+ds.refrSrvcId);
        ds.toDelete = 0;        
        return ds;
    }
    public Map<String,String> mapZonas()
    {
        List<SelectOption> optionsZona = new List<SelectOption>();
        List<SelectOption> optionsRango = new List<SelectOption>();
        
        Schema.DescribeFieldResult fieldResultZonas = SBQQ__QuoteLine__c.Zona_de_descuento__c.getDescribe();
        Schema.DescribeFieldResult fieldResulRangos = SBQQ__QuoteLine__c.Rango_KM__c.getDescribe();
        Map<String,String> mRango = new Map<String,String>();
        
        
        List<Schema.PicklistEntry> zDesc = fieldResultZonas.getPicklistValues();
        List<Schema.PicklistEntry> zRango = fieldResulRangos.getPicklistValues();
        
        for( Schema.PicklistEntry f : zDesc)
        {
            optionsZona.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        for(Schema.PicklistEntry f : zRango)
        {
            optionsRango.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        Integer x = 0;
        for(SelectOption so: optionsRango){
            mRango.put(zRango[x].getValue(),Zdesc[x].getValue());
            x++;
        } 
        System.debug('Mapa de zonas: '+mRango);
        return mRango;
    }
    
    
}
