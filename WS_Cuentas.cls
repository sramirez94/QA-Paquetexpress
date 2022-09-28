/**
 * @description       : Integración Sipweb - Salesforce que recibe datos para crear cuenta
 * @author            : Néstor Ortiz (nortiz@freewayconsulting.com)
 * *********************** Modificaciones **************************
 * Modificada: 29/07/2022. Modificó: Salvador Ramírez (sramirez@freewayconsulting.com). Se agregan campos para facturación 4.0
**/
@RestResource(urlMapping='/Cuentas/*')
global with sharing class WS_Cuentas {
    global class wrapperCuenta{
        public String tipoDeCuenta;
        //DETALLE DE CUENTA
        public String nombreCuenta;
        public String idSipweb;
        public String numeroDeLaCuenta;        // AccountNumber
        public String cuentaPrincipal;         // parentId
        public String cuentaFacebook;          // Cuenta_de_Facebook__c
        public String clienteFavorito;         // Cliente_Favorito__c
        public String cuentaTwitter;           // Cuenta_de_Twitter__c
        public String sucursal;                // Sucursal__c
        public Boolean codigoRecompensa;       // Cuenta_con_c_digo_de_recompensa__c
        public Boolean agenteCorporativo;      // Cuenta_con_un_agente_corporativo__c
        public Boolean documentadorInHouse;    // documentador_in_house__c
        public Decimal Monto;                  // Monto__c
        //DATOS FISCALES
        public String rfc;                     // RFC_c
        public String tipoDeDireccion;         // Tip-o_direccion__c Replicar Tipo Domicilio - Envío, Estructurada (Otra), No estructurada 
        public String pisoFacturacion;         // Piso_Facturacion__c
        public String plazaFacturacion;        // Plaza_Facturacion__c Id Exerno sucursal
        public String emailDeFactura;          // Email_de_factura__c  
        public String calleDeFacturacion;      // BillingStreet
        public String cpFacturacion;           // BillingPostalCode
        public String ciudadFacturacion;       // BillingCity
        public String estadoFacturacion;       // BillingState
        public String paisFacturacion;         // BillingCountry
		public String coloniaFacturacion;	   // Colonia_Facturaci_n__c	
        public String regimFiscalId;
        public String usoCfdiId;
        public String nombreFiscal;
        /*29/07/2022 SRL: Añadido para datos fiscales facturación 4.0 */
        public String taxDataTaxId;
        public String taxDataClntType;
        public String taxDataBusinessName;
        public String taxDataCapitalRegm;
        public String taxDataFirstName;
        public String taxDataLastName1;
        public String taxDataLastName2;
        public String taxDataStreet;
        public String taxDataNoInt;
        public String taxDataNoExt;
        public String taxDataZipCode;
        public String taxDataRegmFisc;
        public String taxDataUsoCFDI;
        public String taxDataValidFlag;
        public String taxDataCountry;
        public String taxDataState;
        public String taxDataMunicipality;
        public String taxDataColony;
        public String taxDataCity;
        //DATOS GENERALES
        public Integer numeroEmpleados;        // NumberOfEmployees
        public String sitioWeb;                // webSite
        public String Comentarios;             // Comentarios__c
        //CONDICIONS COMERCIALES Y OPERATIVIDAD
        public Boolean serviciosNacionales;                //Servicios_nacionales__c   
        public String tiposDeServiciosNacionales;          //Tipo_de_servicios_nacionales__c   
        public Boolean serviciosInternacionales;           //Servicios_internacionales__c  
        public String tiposDeServiciosInternacionales;     //Tipo_de_servicios_internacionales__c  
        public Boolean operacionLogistica;                 //Operacion_logistica__c    
        public String tipoDeOperacionesLogisticas;         //Tipo_de_operaciones_log_sticas__c 
        public String programacion;                        //Programacion__c   (Diaria, Solicitud sobre servicio, Otros)
        public String horariosPropuestosDeRecoleccion;     //Horarios_propuestos_de_recoleccion__c 
        public String tipoDeAcuse;                         //Tipo_de_acuse__c  
        public String requerimientosDeAcuseClientes;       //Requerimientos_de_acuse_de_cliente_XT__c  (Nombre y firma de la persona que recibe, Sello de la compañía, Orden de entrada sellada, Firma de recibido, Factura original firmada y sellada, Factura original firmada, Copias de factura firmada y sellada, Orden de entrada firmada y sellada, Orden de entrada firmada, Copia de pedido sellado y firmado, Copia de pedido firmado, Copia de pedido sellado, Regresar pedimento, Regresar boleta de importación, Regreso de factura original, Factura original sellada, Orden de entrada, Folio de recibo, OTROS)
        public String presentacionDeFacturaCondicionada;   //Presentacion_de_Factura_condicionada_al__c
        public Decimal potencialMensualTotal;              //Potencial_mensual_Total__c    
        public String segmento;                            //Segmento__c   
        public Decimal potencialMensualDeEnvios;           //Potencial_mensual_de_envios__c    
        public String tipoDeCliente;                       //Tipo_de_cliente__c (Enviador, Receptor)   
        public String calleEnvio;                          //ShippingStreet
        public String cpEnvio;                             //ShippingpostalCode
        public String ciudadEnvio;                         //ShippingCity
        public String estadoEnvio;                         //ShippingState
        public String paisEnvio;                           // ShippingCountry
        public String plazaDeEnvio;                        //Plaza_Envio__c    
        public String pisoEnvio;                           //Piso_envio__c 
        public String zonaEnvio;                           //Zona_envio__c 
        public String coloniaEnvio;						   //Colonia__c
        //REPRESENTANTE LEGAL
        public String nombreRepresentanteLegal;            //Nombre_representante_legal__c 
        public String telefonoRepresentanteLegal;          //Tel_fono_representante_legal__c   
        public String puestoRepresentante;                 //Puesto_Representante__c   
        public String regPublioDeLaPropiedadYComercio;     //REGISTRO_P_BLICO_DE_LA_PROPIEDAD_Y_COMER__c   
        public String faxRepLegal;                         //FAX_representante_legal__c    
        public String numActaConstitutiva;                 //N_mero_de_acta_constitutiva__c    
        public String folioMercantilRep;                   //Folio_mercantin_Repres__c 
        public String numeroActaNotaria;                   //N_mero_notaria_Acta__c    
        public String numeroNotariaRepresentante;          //N_mero_notaria_Repres__c  
        public String folioMercantil;                      //Folio_mercantil__c    
        public String fechaActaRepresentanteLegal;         //Fecha_acta_representante_legal__c 
        public String numeroDeActa;                        //n_mero_de_ac__c
    }
    global class Response{
        public String recordId;
        public String status;
        public String message;
    }
    @HttpPost
    global static List<Response> generaCuenta(wrapperCuenta cuenta){
        System.debug(cuenta);
        List<Response> responseList         = new List<Response>();
        List<Account> AccountList           = new List<Account>();
        List<Schema.PicklistEntry> entries  = new List<Schema.PicklistEntry>(); //Para recorrer los valores de picklist para uso de CFDI y regimen fiscal.
        String strUsoCFDI                   = ''; //Se agrega para el uso de cfdi
		String strRegimenFiscal             = ''; //Se agrega para regimen fiscal
        try{
            Account acc = new Account ();
            acc.Name                                =   cuenta.nombreCuenta;
            acc.Id_SIpWeb__c                        =   cuenta.idSipweb;
            acc.AccountNumber                       =   cuenta.numeroDeLaCuenta;
            acc.ParentId                            =   validaCuenta(cuenta.cuentaPrincipal)    != '' ? validaCuenta(cuenta.cuentaPrincipal) : null;
            acc.Cuenta_de_Facebook__c               =   cuenta.cuentaFacebook;
            acc.Cliente_Favorito__c                 =   cuenta.clienteFavorito;
            acc.Cuenta_de_Twitter__c                =   cuenta.cuentaTwitter;
            List<Sucursal__c> sucursal              = [SELECT id, Id_SIpWeb__c FROM Sucursal__c WHERE Name =:cuenta.sucursal];
            acc.Sucursal__c                         =   sucursal.size()>0 ? sucursal[0].Id : null;
            acc.Cuenta_con_c_digo_de_recompensa__c  =   cuenta.codigoRecompensa == true ? cuenta.codigoRecompensa : false;
            acc.documentador_in_house__c            =   cuenta.documentadorInHouse == true ? cuenta.documentadorInHouse : false;
            acc.Cuenta_con_un_agente_corporativo__c =   cuenta.agenteCorporativo == true ? cuenta.agenteCorporativo : false;
            // DATOS FISCALES
            acc.RFC__c                              = cuenta.rfc;
            acc.Tipo_direccion__c                   = cuenta.tipoDeDireccion;
            acc.Piso_Facturacion__c                 = cuenta.pisoFacturacion;
            List<Sucursal__c> plazaFacturacion      = [SELECT id, Id_SIpWeb__c FROM Sucursal__c WHERE Name =:cuenta.plazaFacturacion];
            acc.Plaza_Facturacion__c                = plazaFacturacion.size()>0 ? plazaFacturacion[0].Id : null;
            acc.Email_de_factura__c                 = cuenta.emailDeFactura;
            acc.BillingStreet                       = cuenta.calleDeFacturacion;
            acc.BillingPostalCode                   = cuenta.cpFacturacion;
            acc.BillingCity                         = cuenta.ciudadFacturacion;
            acc.BillingState                        = cuenta.estadoFacturacion;
            acc.BillingCountry                      = cuenta.paisFacturacion;
            acc.Colonia_Facturaci_n__c				= cuenta.coloniaFacturacion;
            //Obtiene el uso de CFDI en base a la clave recibida en el request
			entries = Account.Uso_de_cfdi_CCP__c.getDescribe().getPickListValues();
            for(Schema.PicklistEntry p : entries){
                if(p.getLabel().contains(cuenta.usoCfdiId)){
                    acc.Uso_de_cfdi_CCP__c = p.getLabel();
                    System.debug('Uso cfdi: ' + p.getLabel());
                    break;
                }
            }
            //Obtiene el régimen fiscal en base a la clave recibida en el request
            entries  = Account.Regimen_fiscal_CCP__c.getDescribe().getPickListValues();
            for(Schema.PicklistEntry p : entries){
                if(p.getLabel().contains(cuenta.regimFiscalId)){
                    acc.Regimen_fiscal_CCP__c = p.getLabel();
                    System.debug('Regimen: ' + p.getLabel());
                    break;
                }
            }
            acc.NombreFiscal__c                     = cuenta.nombreFiscal;
            if(cuenta.taxDataTaxId != 'XAXX010101000'){
                //29/07/2022 SRL: Si es diferente de un RFC genérico (Sin obligaciones fiscales)
                if(cuenta.taxDataClntType == 'M'){
                    //29/07/2022 SRL: Si es una persona moral
                    acc.RazonSocial__c = cuenta.taxDataBusinessName;
                    acc.RegimenCapital__c = cuenta.taxDataCapitalRegm;
                } else {
                    //29/07/2022 SRL: Persona física
                    acc.Nombres__c = cuenta.taxDataFirstName;
                    acc.ApellidoPaterno__c = cuenta.taxDataLastName1;
                    acc.ApellidoMaterno__c = cuenta.taxDataLastName2;
                }
                //29/07/2022 SRL: Datos fiscales generales
                acc.BillingStreet = cuenta.taxDataStreet;
                acc.NumeroInterior__c = cuenta.taxDataNoInt;
                acc.Numero_de_facturacion__c = cuenta.taxDataNoExt == null?null:Decimal.valueOf(cuenta.taxDataNoExt);
                acc.BillingPostalCode = cuenta.taxDataZipCode;
                acc.DatosFiscalesObtenidosDeSipWeb__c =  cuenta.taxDataValidFlag == 'N'?false:true;
                acc.BillingCountry = cuenta.taxDataCountry;
                acc.BillingState = cuenta.taxDataState;
                acc.Municipio_Delegaci_n_Sector_facturacion__c = cuenta.taxDataMunicipality;
                acc.Colonia_Facturaci_n__c = cuenta.taxDataColony;
                acc.BillingCity = cuenta.taxDataCity;
            }
            // DATOS GENERALES
            acc.NumberOfEmployees                   = cuenta.numeroEmpleados;
            acc.webSite                             = cuenta.sitioweb;
            acc.comentarios__c                      = cuenta.comentarios;
            // CONDICIONES COMERCIALES Y OPERATIVIDAD
            acc.Servicios_nacionales__c                     = cuenta.serviciosNacionales == true ? cuenta.serviciosNacionales : false;
            acc.Tipo_de_servicios_nacionales__c             = cuenta.tiposDeServiciosNacionales != null ? cuenta.tiposDeServiciosNacionales : null;
            acc.Servicios_internacionales__c                = cuenta.serviciosInternacionales == true ? cuenta.serviciosInternacionales : false;
            acc.Tipo_de_servicios_internacionales__c        = cuenta.tiposDeServiciosInternacionales != null ? cuenta.tiposDeServiciosInternacionales : null;
            acc.Operacion_logistica__c                      = cuenta.operacionLogistica == true ? cuenta.operacionLogistica : false;
            acc.Tipo_de_operaciones_log_sticas__c           = cuenta.tipoDeOperacionesLogisticas != null ? cuenta.tipoDeOperacionesLogisticas : null;
            acc.Programacion__c                             = cuenta.programacion != null ? cuenta.programacion : null;
            if (cuenta.horariosPropuestosDeRecoleccion != null){
                String[] strTimeSplit = cuenta.horariosPropuestosDeRecoleccion.split(':');
                Time timeChange;
                if(strTimeSplit.size()>0){
                    timeChange = Time.newInstance( Integer.valueOf(strTimeSplit[0])  //hour
                                                  ,Integer.valueOf(strTimeSplit[1]) //min
                                                  ,Integer.valueOf(strTimeSplit[2]) //sec
                                                  ,Integer.valueOf(strTimeSplit[3]) //ms
                                                 );
                    acc.Horarios_propuestos_de_recoleccion__c = timeChange;
                }
            }
            acc.Tipo_de_acuse__c                            = cuenta.tipoDeAcuse;
            acc.Requerimientos_de_acuse_de_cliente_XT__c    = cuenta.requerimientosDeAcuseClientes;
            acc.Presentacion_de_Factura_condicionada_al__c  = cuenta.presentacionDeFacturaCondicionada;
            acc.Potencial_mensual_Total__c                  = cuenta.potencialMensualTotal;
            //acc.Segmento__c                                   = cuenta.segmento;
            acc.Potencial_mensual_de_envios__c              = cuenta.potencialMensualDeEnvios; 
            acc.Tipo_de_cliente__c                          =cuenta.tipoDeCliente;
            acc.ShippingStreet                              =cuenta.calleEnvio;
            acc.ShippingpostalCode                          =cuenta.cpEnvio;
            acc.ShippingCity                                =cuenta.ciudadEnvio;
            acc.ShippingState                               =cuenta.estadoEnvio;
            acc.ShippingCountry                             =cuenta.paisEnvio;
            acc.colonia__c									=cuenta.coloniaEnvio;
            List<Sucursal__c> plazaEnvio                    = [SELECT id, Id_SIpWeb__c FROM Sucursal__c WHERE Name =:cuenta.plazaDeEnvio];
            acc.Plaza_Envio__c                              = plazaEnvio.size()>0 ? plazaEnvio[0].Id : null;
            acc.Piso_envio__c                               =cuenta.pisoEnvio;
            acc.Zona_envio__c                               =cuenta.zonaEnvio;
            //REPRESENTANTE LEGAL
            acc.Nombre_representante_legal__c               = cuenta.nombreRepresentanteLegal;
            acc.Tel_fono_representante_legal__c             = cuenta.telefonoRepresentanteLegal;
            acc.Puesto_Representante__c                     = cuenta.puestoRepresentante;
            acc.REGISTRO_P_BLICO_DE_LA_PROPIEDAD_Y_COMER__c = cuenta.regPublioDeLaPropiedadYComercio;
            acc.FAX_representante_legal__c                  = cuenta.faxRepLegal;
            acc.N_mero_de_acta_constitutiva__c              = cuenta.numActaConstitutiva;
            acc.Folio_mercantin_Repres__c                   = cuenta.folioMercantilRep;  
            acc.N_mero_notaria_Acta__c                      = cuenta.numeroActaNotaria;
            acc.N_mero_notaria_Repres__c                    = cuenta.numeroNotariaRepresentante;
            acc.Folio_mercantil__c                          = cuenta.folioMercantil;
            acc.Fecha_acta_representante_legal__c           = cuenta.fechaActaRepresentanteLegal != null ? Date.valueOf(cuenta.fechaActaRepresentanteLegal): null;
            acc.n_mero_de_ac__c                             = cuenta.numeroDeActa;
            if(Cuenta.tipoDeCuenta != '' && Cuenta.tipoDeCuenta != null ){
                if(Cuenta.tipoDeCuenta == 'Personal'){
                    acc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Persona_fisica'].Id;
                }else if (Cuenta.tipoDeCuenta == 'Empresarial'){
                    acc.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Persona_moral'].Id;
                }
            }
            AccountList.add(acc);
            Database.UpsertResult [] ticketsResultUpsert =  database.upsert(AccountList, Account.Fields.Id_SIpWeb__c, false);
            for (Database.UpsertResult ur : ticketsResultUpsert){
                Response r = new Response();
                if(ur.isSuccess()){
                    r.recordId  =  ur.getId();
                    r.status    =  'Exitoso';
                    r.message   =  'OK';
                    responseList.add(r);
                }else{
                    for(DataBase.Error error: ur.getErrors()){
                        Response re = new Response();
                        re.recordId = 'NA';
                        re.status   =  ''+error.getStatusCode();
                        re.message  =  error.getMessage() ;
                        responseList.add(re);
                    }
                }
            }
        }catch (Exception e){
            Response re = new Response();
             re.recordId    = 'NA';
             re.status      =  'Error';
             re.message     =  e.getStackTraceString() + ' ' + e.getMessage() + ' ' +  e.getCause();
             responseList.add(re);
        }
        return responseList;
    }
    global static String validaCuenta (String idSipWeb){
        String idSF;
        if(idSipWeb != null && idSipWeb != 'NA'){
            for(account acc: [SELECT Id, Id_SIpWeb__c FROM Account WHERE Id_SIpWeb__c =: idSipWeb]){
                idSF = acc.Id;
            }
        }
        return idSF;
    }
    global static String validaSucursal (String idSucursal){
        String idSF;
        if(idSucursal != null){
            for(Sucursal__c suc: [SELECT Id, Name FROM Sucursal__c WHERE Name =: idSucursal]){
                idSF = suc.Id;
            }
        }
        return idSF;
    }
}
