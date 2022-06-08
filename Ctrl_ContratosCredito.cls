/**
 * Modificado: 07/06/2022. Modificó: Salvador Ramírez (sramirez@freewayconsulting.com). Al mostrar el domicilio de facturación se indica que solo muestre el campo Direcci_n_facturaci_n__c ya que el Direcci_n_facturaci_n_M__c no se usa y solo causa discrepancias.
**/
public class Ctrl_ContratosCredito {
    public Credito__c Credito;
    String idCredito;
    public List<Cuenta_Hija__c> Hijas = new List<Cuenta_Hija__c>();
    
    public boolean SinPagare{get;set;}
    public string MontoLetra{get;set;}
    public decimal Monto {get; set;}
    public string NombreCuenta{get;set;}
    public string NumerodeCuenta{get;set;}
    public string Apellido{get;set;}
    public string Folio{get;set;}
    public string CalleFactura{get;set;}
    public string CiudadFactura{get;set;}
    public string EstadoFactura{get;set;}
    public string Colonia{get;set;}
    public string ColoniaFisico{get;set;}
    public string Delegacion{get;set;}
    public string DelegacionF{get;set;}
    public string MunicipioF{get;set;}
    public string CPFactura{get;set;}
    public string PaisFactura{get;set;}
    public string NumeroFactura{get;set;}
    public string Telefono{get;set;}
    public string RFC{get;set;}
    public string NombreR{get;set;}
    public string FAXR{get;set;}
    public string PuestoR{get;set;}
    public string EmailFactura{get;set;}
    public string TelefonoR{get;set;}
    public String FullDate {get;set;}
    public String Plazo {get;set;}
    public String FechaActa {get;set;}
    public String NumeroNotaria {get;set;}
    public String NombreNotario  {get;set;}
    public String NombreNotarioRep {get;set;}
    public String CP  {get;set;}
    public String CURP  {get;set;}
    public String Numero  {get;set;}
    public String FolioMercantil  {get;set;}
    public String RegistroPublico  {get;set;} 
    public String Month  {get;set;}
    public String day  {get;set;}
    public String year  {get;set;}
    public String Sucursal  {get;set;}
    public String DireccionSucursal  {get;set;}
    public String Cobro  {get;set;}
    public String NoActa  {get;set;}
    public String FechaActaC  {get;set;}
    public String NotariaA  {get;set;}
    public String DomFiscal {get;set;}
    public String NOMBRECUENTASPORPAGAR {get;set;}
    public String NOMBRECOMPRAS {get;set;}
    public String NOMBREFINANZAS {get;set;}
    public String CORREO1 {get;set;}
    public String CORREO2 {get;set;}
    public String CORREO3 {get;set;}
    public String TELEFONO1 {get;set;}
    public String TELEFONO2 {get;set;}
    public String TELEFONO3 {get;set;}
    public String NOMBREFACTURAS {get;set;}
    public String DOCSREQUERIDOS {get;set;}
    public String CORREO4 {get;set;}
    public String TELEFONO4 {get;set;}
    public String INDICACIONESFACTURACION {get;set;}
    public String METODOPAGO {get;set;}
    public String FORMAPAGO {get;set;}
    public String USOCFDI {get;set;}
    public String FINANCIERA1 {get;set;}
    public String FINANCIERA2 {get;set;}
    public String FINANCIERA3 {get;set;}
    public String NOMBRE1 {get;set;}
    public String NOMBRE2 {get;set;}
    public String NOMBRE3 {get;set;}
    public String PUESTO1 {get;set;}
    public String PUESTO2 {get;set;}
    public String PUESTO3 {get;set;}
    public String CORREO5 {get;set;}
    public String CORREO6 {get;set;}
    public String CORREO7 {get;set;}
    public String TELEFONO5 {get;set;}
    public String TELEFONO6 {get;set;}
    public String TELEFONO7 {get;set;}
    public String EMPRESA1 {get;set;}
    public String EMPRESA2 {get;set;}
    public String EMPRESA3 {get;set;}
    public String NOMBRE4 {get;set;}
    public String NOMBRE5 {get;set;}
    public String NOMBRE6 {get;set;}
    public String PUESTO4 {get;set;}
    public String PUESTO5 {get;set;}
    public String PUESTO6 {get;set;}
    public String CORREO8 {get;set;}
    public String CORREO9 {get;set;}
    public String CORREO10 {get;set;}
    public String TELEFONO8 {get;set;}
    public String TELEFONO9 {get;set;}
    public String TELEFONO10 {get;set;}
    public String APELLIDOP {get;set;}
    public String APELLIDOM {get;set;}
    public String LasHijas {get;set;}
    public String NoInterior {get;set;}
    public String NoFisico {get;set;}
   
    //Aqui empieza la clase del controlador del contrato
    
    public Ctrl_ContratosCredito(){
        
        
        //Credito = new Credito__c();
        idCredito = ApexPages.currentPage().getParameters().get('Id');
        
        if(idCredito != '' && idCredito != null){
            try{
                Credito = [SELECT Id,
                           Autorizar_contrato_sin_pagar__c,
                           Direcci_n_facturaci_n__c,
                           Sucursal__r.Direccion__c,
                           Sucursal_de_cobro__r.Name,
                           Cuenta__r.REGISTRO_P_BLICO_DE_LA_PROPIEDAD_Y_COMER__c,
                           N_mero_de_Cuenta__c,
                           Cuenta__r.Folio_mercantil__c,
                           Cuenta__r.Name, 
                           Cuenta__r.ShippingPostalCode,
                           Cuenta__r.FirstName, 
                           Folio__c,
                           Monto__c,
                           Monto2__c,
                           Direcci_n_facturaci_n_M__c,
                           Ingresa_monto_de_credito__c,
                           Cuenta__r.BillingStreet, 
                           Cuenta__r.BillingCity, 
                           Cuenta__r.BillingState, 
                           Cuenta__r.BillingPostalCode, 
                           Cuenta__r.BillingCountry,
                           Cuenta__r.Numero_de_facturacion__c,
                           Cuenta__r.Piso_facturacion__c,
                           Cuenta__r.n_mero_de_ac__c,
                           Cuenta__r.Phone,
                           Cuenta__r.RFC__c, 
                           Cuenta__r.CURP__c,
                           Cuenta__r.FAX_representante_legal__c,
                           Cuenta__r.Nombre_representante_legal__c,
                           Cuenta__r.Puesto_Representante__c, 
                           Cuenta__r.Email_de_factura__c,
                           Cuenta__r.Tel_fono_representante_legal__c,
                           Cuenta__r.Fecha_acta_representante_legal__c,
                           Cuenta__r.N_mero_notaria_Repres__c,
                           Cuenta__r.Nombre_notario__c,
                           Cuenta__r.Nombre_Notario_Rep__c,
                           Cuenta__r.Numero__c,
                           Plazo__c,
                           Plazo2__c,
                           RecordTypeId,
                           Dias_de_Ampliacion__c,
                           Dias_de_ampliacion_solicitados__c,
                           Cuenta__r.Colonia_Facturaci_n__c,
                           Cuenta__r.Colonia__c,
                           Cuenta__r.Municipio_Delegaci_n_Sector_facturacion__c,
                           Cuenta__r.Municipio_Delegaci_n_Sector__c,
                           Cuenta__r.N_mero_de_acta_constitutiva__c,
                           Cuenta__r.Fecha_de_acta_constitutiva__c,
                           Cuenta__r.N_mero_notaria_Acta__c,
                           Cuenta__r.NOMBRE_RESPONSABLE_CUENTAS_POR_PAGAR__c,
                           Cuenta__r.NOMBRE_RESPONSABLE_COMPRAS_Y_O_LOG_STICA__c,
                           Cuenta__r.NOMBRE_RESPONSABLE_DEL_REA_FINANZAS__c,
                           Cuenta__r.CORREO_ELECTR_NICO1__c,
                           Cuenta__r.CORREO_ELECTR_NICO2__c,
                           Cuenta__r.CORREO_ELECTR_NICO3__c,
                           Cuenta__r.TEL_FONO1__c,
                           Cuenta__r.TEL_FONO2__c,
                           Cuenta__r.TEL_FONO3__c,
                           Cuenta__r.NOMBRE_RESPONSABLE_RECEPCI_N_DE_FACTURAS__c,
                           Cuenta__r.CORREO_ELECTR_NICO4__c,
                           Cuenta__r.TEL_FONO4__c,
                           Cuenta__r.DOCUMENTACI_N_REQUERIDA__c,
                           Cuenta__r.INDICACIONES_ESPECIALES_PARA_FACTURACI_N__c,
                           Cuenta__r.M_TODO_DE_PAGO__c,
                           Cuenta__r.FORMA_DE_PAGO__c,
                           Cuenta__r.Uso_de_cfdi_CCP__c,
                           Cuenta__r.INSTITUCI_N_FINANCIERA1__c,
                           Cuenta__r.INSTITUCI_N_FINANCIERA2__c,
                           Cuenta__r.INSTITUCI_N_FINANCIERA3__c,
                           Cuenta__r.NOMBREIF1__c,
                           Cuenta__r.NOMBREIF2__c,
                           Cuenta__r.NOMBREIF3__c,
                           Cuenta__r.PUESTO1__c,
                           Cuenta__r.PUESTO2__c,
                           Cuenta__r.PUESTO3__c,
                           Cuenta__r.CORREO_ELECTR_NICO5__c,
                           Cuenta__r.CORREO_ELECTR_NICO6__c,
                           Cuenta__r.CORREO_ELECTR_NICO7__c,
                           Cuenta__r.TEL_FONO5__c,
                           Cuenta__r.TEL_FONO6__c,
                           Cuenta__r.TEL_FONO7__c,
                           Cuenta__r.EMPRESA1__c,
                           Cuenta__r.EMPRESA2__c,
                           Cuenta__r.EMPRESA3__c,
                           Cuenta__r.NOMBRERC1__c,
                           Cuenta__r.NOMBRERC2__c,
                           Cuenta__r.NOMBRERC3__c,
                           Cuenta__r.PUESTO4__c,
                           Cuenta__r.PUESTO5__c,
                           Cuenta__r.PUESTO6__c,
                           Cuenta__r.CORREO_ELECTR_NICO8__c,
                           Cuenta__r.CORREO_ELECTR_NICO9__c,
                           Cuenta__r.CORREO_ELECTR_NICO10__c,
                           Cuenta__r.TEL_FONO8__c,
                           Cuenta__r.TEL_FONO9__c,
                           Cuenta__r.TEL_FONO10__c,
                           Cuenta__r.Apellido_Paterno__c,
                           Cuenta__r.Apellido_Materno__c,
                           Cuenta__r.Sucursal__c from Credito__c WHERE Id =: idCredito];
                
                Hijas = [SELECT Sucursal__c, Credito__c FROM Cuenta_Hija__c WHERE Credito__c =: idCredito];
                
                if(Hijas.size() > 0) {
                    LasHijas = 'Sucursal: ';
                    for(Cuenta_Hija__c hija : Hijas) {
                        LasHijas = LasHijas + ' ' + hija.Sucursal__c;
                    }
                } else {
                    LasHijas='No se encontraron cuentas hijas asociadas con este registro.';
                }
                
                if(Credito.Autorizar_contrato_sin_pagar__c == FALSE) {
                    SinPagare = FALSE;
                } else {
                    SinPagare = TRUE;
                }
                
                if(Credito.Cuenta__r.Apellido_Paterno__c != null) {
                    APELLIDOP = Credito.Cuenta__r.Apellido_Paterno__c;    
                } else {
                    APELLIDOP = '---';
                }
                
                if(Credito.Cuenta__r.Apellido_Materno__c != null) {
                    APELLIDOM = Credito.Cuenta__r.Apellido_Materno__c;    
                } else {
                    APELLIDOM = '---';
                }
                
                if(Credito.Cuenta__r.NOMBRE_RESPONSABLE_CUENTAS_POR_PAGAR__c != null) {
                    NOMBRECUENTASPORPAGAR = Credito.Cuenta__r.NOMBRE_RESPONSABLE_CUENTAS_POR_PAGAR__c;    
                } else {
                    NOMBRECUENTASPORPAGAR = '---';
                }
                
                if(Credito.Cuenta__r.Piso_facturacion__c != null) {
                    NoInterior = Credito.Cuenta__r.Piso_facturacion__c;
                } else {
                    NoInterior = '---';
                }
                
                if(Credito.Cuenta__r.NOMBRE_RESPONSABLE_COMPRAS_Y_O_LOG_STICA__c != null) {
                    NOMBRECOMPRAS = Credito.Cuenta__r.NOMBRE_RESPONSABLE_COMPRAS_Y_O_LOG_STICA__c;    
                } else {
                    NOMBRECOMPRAS = '---';
                }
                
                if(Credito.Cuenta__r.NOMBRE_RESPONSABLE_DEL_REA_FINANZAS__c != null) {
                    NOMBREFINANZAS = Credito.Cuenta__r.NOMBRE_RESPONSABLE_DEL_REA_FINANZAS__c;    
                } else {
                    NOMBREFINANZAS = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO1__c != null) {
                    CORREO1 = Credito.Cuenta__r.CORREO_ELECTR_NICO1__c;    
                } else {
                    CORREO1 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO1__c != null) {
                    TELEFONO1 = Credito.Cuenta__r.TEL_FONO1__c;    
                } else {
                    TELEFONO1 = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO2__c != null) {
                    CORREO2 = Credito.Cuenta__r.CORREO_ELECTR_NICO2__c;    
                } else {
                    CORREO2 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO2__c != null) {
                    TELEFONO2 = Credito.Cuenta__r.TEL_FONO2__c;    
                } else {
                    TELEFONO2 = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO3__c != null) {
                    CORREO3 = Credito.Cuenta__r.CORREO_ELECTR_NICO3__c;    
                } else {
                    CORREO3 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO3__c != null) {
                    TELEFONO3 = Credito.Cuenta__r.TEL_FONO3__c;    
                } else {
                    TELEFONO3 = '---';
                }
                
                if(Credito.Cuenta__r.NOMBRE_RESPONSABLE_RECEPCI_N_DE_FACTURAS__c != null) {
                    NOMBREFACTURAS = Credito.Cuenta__r.NOMBRE_RESPONSABLE_RECEPCI_N_DE_FACTURAS__c;    
                } else {
                    NOMBREFACTURAS = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO4__c != null) {
                    CORREO4 = Credito.Cuenta__r.CORREO_ELECTR_NICO4__c;    
                } else {
                    CORREO4 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO4__c != null) {
                    TELEFONO4 = Credito.Cuenta__r.TEL_FONO4__c;    
                } else {
                    TELEFONO4 = '---';
                }
                
                if(Credito.Cuenta__r.DOCUMENTACI_N_REQUERIDA__c != null) {
                    DOCSREQUERIDOS = Credito.Cuenta__r.DOCUMENTACI_N_REQUERIDA__c;    
                } else {
                    DOCSREQUERIDOS = '---';
                }
                
                if(Credito.Cuenta__r.INDICACIONES_ESPECIALES_PARA_FACTURACI_N__c != null) {
                    INDICACIONESFACTURACION = Credito.Cuenta__r.INDICACIONES_ESPECIALES_PARA_FACTURACI_N__c;    
                } else {
                    INDICACIONESFACTURACION = '---';
                }
                
                if(Credito.Cuenta__r.M_TODO_DE_PAGO__c != null) {
                    METODOPAGO = Credito.Cuenta__r.M_TODO_DE_PAGO__c;    
                } else {
                    METODOPAGO = '---';
                }
                
                if(Credito.Cuenta__r.FORMA_DE_PAGO__c != null) {
                    FORMAPAGO = Credito.Cuenta__r.FORMA_DE_PAGO__c;    
                } else {
                    FORMAPAGO = '---';
                }
                
                if(Credito.Cuenta__r.Uso_de_cfdi_CCP__c != null) {
                    USOCFDI = Credito.Cuenta__r.Uso_de_cfdi_CCP__c;    
                } else {
                    USOCFDI = '---';
                }
                
                if(Credito.Cuenta__r.INSTITUCI_N_FINANCIERA1__c != null) {
                    FINANCIERA1 = Credito.Cuenta__r.INSTITUCI_N_FINANCIERA1__c;    
                } else {
                    FINANCIERA1 = '---';
                }
                
                if(Credito.Cuenta__r.INSTITUCI_N_FINANCIERA2__c != null) {
                    FINANCIERA2 = Credito.Cuenta__r.INSTITUCI_N_FINANCIERA2__c;    
                } else {
                    FINANCIERA2 = '---';
                }
                
                if(Credito.Cuenta__r.INSTITUCI_N_FINANCIERA3__c != null) {
                    FINANCIERA3 = Credito.Cuenta__r.INSTITUCI_N_FINANCIERA3__c;    
                } else {
                    FINANCIERA3 = '---';
                }
                
                if(Credito.Cuenta__r.NOMBREIF1__c != null) {
                    NOMBRE1 = Credito.Cuenta__r.NOMBREIF1__c;    
                } else {
                    NOMBRE1 = '---';
                }
                
                if(Credito.Cuenta__r.NOMBREIF2__c != null) {
                    NOMBRE2 = Credito.Cuenta__r.NOMBREIF2__c;    
                } else {
                    NOMBRE2 = '---';
                }
                
                if(Credito.Cuenta__r.NOMBREIF3__c != null) {
                    NOMBRE3 = Credito.Cuenta__r.NOMBREIF3__c;    
                } else {
                    NOMBRE3 = '---';
                }
                
                if(Credito.Cuenta__r.PUESTO1__c != null) {
                    PUESTO1 = Credito.Cuenta__r.PUESTO1__c;    
                } else {
                    PUESTO1 = '---';
                }
                
                if(Credito.Cuenta__r.PUESTO2__c != null) {
                    PUESTO2 = Credito.Cuenta__r.PUESTO2__c;    
                } else {
                    PUESTO2 = '---';
                }
                
                if(Credito.Cuenta__r.PUESTO3__c != null) {
                    PUESTO3 = Credito.Cuenta__r.PUESTO3__c;    
                } else {
                    PUESTO3 = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO5__c != null) {
                    CORREO5 = Credito.Cuenta__r.CORREO_ELECTR_NICO5__c;    
                } else {
                    CORREO5 = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO6__c != null) {
                    CORREO6 = Credito.Cuenta__r.CORREO_ELECTR_NICO6__c;    
                } else {
                    CORREO6 = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO7__c != null) {
                    CORREO7 = Credito.Cuenta__r.CORREO_ELECTR_NICO7__c;    
                } else {
                    CORREO7 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO5__c != null) {
                    TELEFONO5 = Credito.Cuenta__r.TEL_FONO5__c;    
                } else {
                    TELEFONO5 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO6__c != null) {
                    TELEFONO6 = Credito.Cuenta__r.TEL_FONO6__c;    
                } else {
                    TELEFONO6 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO7__c != null) {
                    TELEFONO7 = Credito.Cuenta__r.TEL_FONO7__c;    
                } else {
                    TELEFONO7 = '---';
                }
                
                if(Credito.Cuenta__r.EMPRESA1__c != null) {
                    EMPRESA1 = Credito.Cuenta__r.EMPRESA1__c;    
                } else {
                    EMPRESA1 = '---';
                }
                
                if(Credito.Cuenta__r.EMPRESA2__c != null) {
                    EMPRESA2 = Credito.Cuenta__r.EMPRESA2__c;    
                } else {
                    EMPRESA2 = '---';
                }
                
                if(Credito.Cuenta__r.EMPRESA3__c != null) {
                    EMPRESA3 = Credito.Cuenta__r.EMPRESA3__c;    
                } else {
                    EMPRESA3 = '---';
                }
                
                if(Credito.Cuenta__r.NOMBRERC1__c != null) {
                    NOMBRE4 = Credito.Cuenta__r.NOMBRERC1__c;    
                } else {
                    NOMBRE4 = '---';
                }
                
                if(Credito.Cuenta__r.NOMBRERC2__c != null) {
                    NOMBRE5 = Credito.Cuenta__r.NOMBRERC2__c;    
                } else {
                    NOMBRE5 = '---';
                }
                
                if(Credito.Cuenta__r.NOMBRERC3__c != null) {
                    NOMBRE6 = Credito.Cuenta__r.NOMBRERC3__c;    
                } else {
                    NOMBRE6 = '---';
                }
                
                if(Credito.Cuenta__r.PUESTO4__c != null) {
                    PUESTO4 = Credito.Cuenta__r.PUESTO4__c;    
                } else {
                    PUESTO4 = '---';
                }
                
                if(Credito.Cuenta__r.PUESTO5__c != null) {
                    PUESTO5 = Credito.Cuenta__r.PUESTO5__c;    
                } else {
                    PUESTO5 = '---';
                }
                
                if(Credito.Cuenta__r.PUESTO6__c != null) {
                    PUESTO6 = Credito.Cuenta__r.PUESTO6__c;    
                } else {
                    PUESTO6 = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO8__c != null) {
                    CORREO8 = Credito.Cuenta__r.CORREO_ELECTR_NICO8__c;    
                } else {
                    CORREO8 = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO9__c != null) {
                    CORREO9 = Credito.Cuenta__r.CORREO_ELECTR_NICO9__c;    
                } else {
                    CORREO9 = '---';
                }
                
                if(Credito.Cuenta__r.CORREO_ELECTR_NICO10__c != null) {
                    CORREO10 = Credito.Cuenta__r.CORREO_ELECTR_NICO10__c;    
                } else {
                    CORREO10 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO8__c != null) {
                    TELEFONO8 = Credito.Cuenta__r.TEL_FONO8__c;    
                } else {
                    TELEFONO8 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO9__c != null) {
                    TELEFONO9 = Credito.Cuenta__r.TEL_FONO9__c;    
                } else {
                    TELEFONO9 = '---';
                }
                
                if(Credito.Cuenta__r.TEL_FONO10__c != null) {
                    TELEFONO10 = Credito.Cuenta__r.TEL_FONO10__c;    
                } else {
                    TELEFONO10 = '---';
                }
                //0122E0000012hr7QAA
                if(Credito.Direcci_n_facturaci_n__c != null /*&& credito.RecordTypeId == '0122E000000tqUuQAI'*/) {
                    DomFiscal = Credito.Direcci_n_facturaci_n__c;
                }/*else{
                    DomFiscal = Credito.Direcci_n_facturaci_n_M__c;
                }*/
                if(Credito.Cuenta__r.N_mero_notaria_Acta__c != null){
                    NotariaA = Credito.Cuenta__r.N_mero_notaria_Acta__c;
                }
                if(Credito.Cuenta__r.Fecha_de_acta_constitutiva__c != null){
                    FechaActaC = Credito.Cuenta__r.Fecha_de_acta_constitutiva__c.format();
                }
                if(Credito.Cuenta__r.N_mero_de_acta_constitutiva__c != null){
                    NoActa = Credito.Cuenta__r.N_mero_de_acta_constitutiva__c;
                    
                }else{
                    
                }
                
                if(Credito.Cuenta__r.Municipio_Delegaci_n_Sector_facturacion__c != null){
                    Delegacion = Credito.Cuenta__r.Municipio_Delegaci_n_Sector_facturacion__c;
                    MunicipioF = Credito.Cuenta__r.Municipio_Delegaci_n_Sector_facturacion__c;
                }else{
                    Delegacion = '---';
                    MunicipioF = '---';
                }
                
                if(Credito.Cuenta__r.Municipio_Delegaci_n_Sector__c != null){
                    DelegacionF = Credito.Cuenta__r.Municipio_Delegaci_n_Sector__c;
                }else{
                    DelegacionF = '---';
                }
                
                if(Credito.Cuenta__r.Colonia_Facturaci_n__c != null){
                    Colonia = Credito.Cuenta__r.Colonia_Facturaci_n__c;    
                }else{
                    Colonia = '---';    
                }
                
                if(Credito.Cuenta__r.Colonia__c != null){
                    ColoniaFisico = Credito.Cuenta__r.Colonia__c;    
                }else{
                    ColoniaFisico = '---';    
                }
                
                if(Credito.Monto2__c != null && Credito.Monto2__c != 0){
                    Monto = Credito.Monto2__c;
                    MontoLetra = Ctrl_NumeroALetra.Convertir(''+ Monto,true);
                    
                }else if(Credito.Ingresa_monto_de_credito__c != null){
                    Monto = Credito.Ingresa_monto_de_credito__c;
                    MontoLetra = Ctrl_NumeroALetra.Convertir(''+ Monto,true);
                }else {
                    Monto = 0;
                    MontoLetra = '---';
                }
                
                if(Credito.Cuenta__r.Name != null){
                    NombreCuenta = Credito.Cuenta__r.Name;
                }else{
                    NombreCuenta = '---';
                }
                if(Credito.Cuenta__r.FirstName != null){
                    Apellido = Credito.Cuenta__r.FirstName;
                }else{
                    Apellido = '---';
                }
                if(Credito.Folio__c != null){
                    Folio = Credito.Folio__c ;
                }else{
                    Folio = '---';
                }
                if(Credito.N_mero_de_Cuenta__c != null){
                    NumerodeCuenta = Credito.N_mero_de_Cuenta__c ;
                }else{
                    NumerodeCuenta = '---';
                }
                if(Credito.Cuenta__r.BillingStreet != null){
                    CalleFactura = Credito.Cuenta__r.BillingStreet ;
                }else{
                    CalleFactura = '---';
                }
                if(Credito.Cuenta__r.BillingCity != null){
                    CiudadFactura = Credito.Cuenta__r.BillingCity ;
                }else{
                    CiudadFactura = '---';
                }
                if(Credito.Cuenta__r.BillingState != null){
                    EstadoFactura = Credito.Cuenta__r.BillingState ;
                }else{
                    EstadoFactura = '---';
                }
                if(Credito.Cuenta__r.BillingPostalCode != null){
                    CPFactura = Credito.Cuenta__r.BillingPostalCode ;
                }else{
                    CPFactura = '---';
                }
                if(Credito.Cuenta__r.BillingCountry != null){
                    PaisFactura = Credito.Cuenta__r.BillingCountry ;
                }else{
                    PaisFactura = '---';
                }
                if(Credito.Cuenta__r.Numero_de_facturacion__c != null){
                    NumeroFactura = String.valueOf(Credito.Cuenta__r.Numero_de_facturacion__c) ;
                }else{
                    NumeroFactura = '---';    
                }
                if(Credito.Cuenta__r.Numero__c != null){
                    NoFisico = String.valueOf(Credito.Cuenta__r.Numero__c);
                }else {
                    NoFisico = '---';
                }
                if(Credito.Cuenta__r.Phone != null){
                    Telefono = Credito.Cuenta__r.Phone ;
                }else{
                    Telefono = '---';
                }
                if(Credito.Cuenta__r.RFC__c != null){
                    RFC = Credito.Cuenta__r.RFC__c ;
                }else{
                    RFC = '---';
                }
                if(Credito.Cuenta__r.FAX_representante_legal__c != null){
                    FAXR = Credito.Cuenta__r.FAX_representante_legal__c ;
                }else{
                    FAXR = '---';
                }
                if(Credito.Cuenta__r.Nombre_representante_legal__c != null){
                    NombreR = Credito.Cuenta__r.Nombre_representante_legal__c ;
                }else{
                    NombreR = '---';
                }if(Credito.Cuenta__r.Puesto_Representante__c != null){
                    PuestoR = Credito.Cuenta__r.Puesto_Representante__c ;
                }else{
                    PuestoR = '---';
                }if(Credito.Cuenta__r.Email_de_factura__c != null){
                    EmailFactura = Credito.Cuenta__r.Email_de_factura__c ;
                }else{
                    EmailFactura = '---';
                    
                    if(Credito.Cuenta__r.ShippingPostalCode != null){
                        CP = Credito.Cuenta__r.ShippingPostalCode ;
                    }else{
                        CP = '---';
                    }
                    
                }if(Credito.Cuenta__r.Tel_fono_representante_legal__c!= null){
                    TelefonoR = Credito.Cuenta__r.Tel_fono_representante_legal__c;
                }else{
                    TelefonoR = '---';
                }
                
                if(Credito.Plazo2__c!= null && Credito.Plazo2__c!= 0){
                    Plazo = String.valueOf(Credito.Plazo2__c);
                }else if(Credito.Dias_de_Ampliacion__c != null){
                    Plazo = String.valueOf(Credito.Dias_de_Ampliacion__c);
                }else {
                    Plazo = '---';
                }
                
                if(Credito.Cuenta__r.Fecha_acta_representante_legal__c!= null){
                    FechaActa = Credito.Cuenta__r.Fecha_acta_representante_legal__c.format();
                }else{
                    
                }
                if(Credito.Cuenta__r.N_mero_notaria_Repres__c!= null){
                    NumeroNotaria = Credito.Cuenta__r.N_mero_notaria_Repres__c;
                }else{
                    NumeroNotaria = '---';
                }
                if(Credito.Cuenta__r.Nombre_notario__c!= null){
                    NombreNotario = Credito.Cuenta__r.Nombre_notario__c;
                }else{
                    NombreNotario = '---';
                }
                if(Credito.Cuenta__r.Nombre_notario_Rep__c!= null){
                    NombreNotarioRep = Credito.Cuenta__r.Nombre_notario_Rep__c;
                }else{
                    NombreNotarioRep = '---';
                }
                if(Credito.Cuenta__r.Curp__c!= null){
                    CURP = Credito.Cuenta__r.CURP__C;
                }else{
                    CURP = '---';
                }
                if(Credito.Cuenta__r.n_mero_de_ac__c!= null){
                    Numero = Credito.Cuenta__r.n_mero_de_ac__c;
                }else{
                    Numero = '---';
                }
                if(Credito.Cuenta__r.Folio_mercantil__c!= null){
                    FolioMercantil = Credito.Cuenta__r.Folio_mercantil__c;
                }else{
                    FolioMercantil = '---';
                }
                if(Credito.Cuenta__r.REGISTRO_P_BLICO_DE_LA_PROPIEDAD_Y_COMER__c!= null){
                    RegistroPublico = Credito.Cuenta__r.REGISTRO_P_BLICO_DE_LA_PROPIEDAD_Y_COMER__c;
                }else{
                    RegistroPublico = '---';
                }
                 if(Credito.Cuenta__r.Sucursal__c!= null){
                    Sucursal = Credito.Cuenta__r.Sucursal__c;
                }else{
                    Sucursal = '---';
                }
                
                    if(Credito.Sucursal__r.Direccion__c!= null){
                    DireccionSucursal = Credito.Sucursal__r.Direccion__c;
                }else{
                    DireccionSucursal = '---';
                }
                
                 if(Credito.Sucursal_de_cobro__c!= null){
                    
                     Cobro= Credito.Sucursal_de_cobro__r.Name;
                }else{
                    Cobro = '---';
                }
                Month = Datetime.now().format('MMM');
                day = Datetime.now().format('dd');
                year = Datetime.now().format('yyyy');
                FullDate = Datetime.now().format('dd-MMM-yyyy');
            }catch(Exception e){
                system.debug(e);
                
            }
        }
    }
    
}
