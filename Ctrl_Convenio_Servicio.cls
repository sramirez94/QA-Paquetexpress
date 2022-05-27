/**
 * @description       : 
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com
 * @group             : 
 * @last modified on  : 27-05-2022
 * @last modified by  : Salvador Ramírez (sramirez@freewayconsulting.com
**/
public class Ctrl_Convenio_Servicio {
	Public Account 	Cuenta;
    
    public List<SBQQ__Quote__c> cotizacion;
    
    public string 	NombreCuenta		{get;set;}
    public string 	SApellido			{get;set;}
    public string 	PApellido			{get;set;}
    public String 	FullDate 			{get;set;}
    public String 	propietario 		{get;set;}
    public String 	Calle 				{get;set;}
    public String 	Ciudad 				{get;set;}
    public String 	Estado 				{get;set;}
    public String 	CP 					{get;set;}
    public String 	Pais 				{get;set;}
    public String 	IdContrato 			{get;set;}
    public String 	Email 				{get;set;}
    public String 	RFC 				{get;set;}
    public String 	Month  				{get;set;}
    public String 	day  				{get;set;}
    public String 	year  				{get;set;}
    public String 	Industria  			{get;set;}
    public decimal 	PotenciaMensualTotal{get;set;}
    public decimal 	PotenciaMensualEnvio{get;set;}
    public String  	Segmento  			{get;set;}   
    public String  	Tipo_de_cliente 	{get;set;}  
    public boolean 	ServiciosN  		{get;set;}  
    public boolean 	ServiciosI  		{get;set;} 
    public boolean 	Logistica  			{get;set;} 
    public String 	TipoSI  			{get;set;}
    public String 	TipoSN  			{get;set;}
    public String 	TipoOL  			{get;set;}
    public boolean 	Operacion_logistica {get;set;}
    public Decimal 	Monto  				{get;set;}
    public String 	Plazo  				{get;set;}
    public String 	FacturaCondicionada {get;set;}
    public String 	TipoAcuse  			{get;set;}
    public String 	RequerimientosAcuse {get;set;}
    public String 	Tipo  				{get;set;}
    public String 	Descripcion  		{get;set;}
    public String 	Programacion  		{get;set;}
    public Time 	Horarios  			{get;set;}  
    public String 	Propietario2 		{get;set;} 
    public String 	giro				{get;set;}
    public String   TipoDeCotizacion	{get;set;}
    public String  	ServiciosQueUtilizara {get;set;}
    public String   paquetesMensuales	{get;set;}
    public String  	ingresoMensual		 {get;set;}
    
    String idCuenta;
  
    public   Ctrl_Convenio_Servicio(){
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        if(idCuenta != '' && idCuenta != null){
            try{
                
                Cuenta = [SELECT Id,Programacion__c,CreatedById,Horarios_propuestos_de_recoleccion__c/*,Credito__r.Monto__c*/,Type,giro__c,
                          Requerimientos_de_acuse_de_cliente_XT__c,Tipo_de_acuse__c/*,Credito__r.Plazo__c*/,Presentacion_de_Factura_condicionada_al__c,Name,
                          Operacion_logistica__c, LastName,Tipo_de_operaciones_log_sticas__c,Tipo_de_servicios_nacionales__c,Tipo_de_servicios_internacionales__c,
                          Servicios_nacionales__c,Servicios_internacionales__c ,Tipo_de_cliente__c, FirstName,Segmento__c, Salutation, BillingStreet, BillingCity,
                          BillingState, BillingPostalCode,  BillingCountry,  BillingAddress, Industry, PersonEmail, OwnerId, RFC__c,Potencial_mensual_Total__c,
                          Potencial_mensual_de_envios__c FROM Account WHERE Id =: idCuenta];
                
                List<Opportunity> oppList = [SELECT Id  FROM Opportunity WHERE AccountId =: idCuenta];

                if(oppList.size() > 0)
                    cotizacion = [SELECT id, Name, SBQQ__Type__c, Modelo_de_tarifas__c, PAQ_TipoServicio__c, Paquetes_Mensuales__c, Ingreso_Mensual__c  FROM SBQQ__Quote__c WHERE SBQQ__Opportunity2__c=: oppList[0].Id];
                else
                    cotizacion = new List<SBQQ__Quote__c>();
                if(cotizacion.size()>0){
                    if(cotizacion[0].SBQQ__Type__c != null){
                        TipoDeCotizacion = cotizacion[0].Modelo_de_tarifas__c;
                    }else{
                        TipoDeCotizacion = '---';
                    }
                }else{
                    TipoDeCotizacion = '---';
                }
                
                if(cotizacion.size()>0){
                    if(cotizacion[0].PAQ_TipoServicio__c != null){
                        ServiciosQueUtilizara = cotizacion[0].PAQ_TipoServicio__c;
                    }else{
                        ServiciosQueUtilizara = '---';
                    }
                }else{
                    ServiciosQueUtilizara = '---';
                }
                
                if(cotizacion.size()>0){
                    if(cotizacion[0].Paquetes_Mensuales__c != null){
                        paquetesMensuales = ''+cotizacion[0].Paquetes_Mensuales__c;
                    }else{
                        paquetesMensuales = '---';
                    }
                }else{
                    paquetesMensuales = '---';
                }
                ingresoMensual = '';
                if(cotizacion.size()>0){
                    if(cotizacion[0].Ingreso_Mensual__c != null){
                        ingresoMensual = ''+cotizacion[0].Ingreso_Mensual__c;
                    }else{
                        ingresoMensual = '---';
                    }
                }else{
                    ingresoMensual = '---';
                }
                
                
                if(Cuenta.Name != null){
                    NombreCuenta =Cuenta.Name;
                }else{
                    NombreCuenta = '---';
                } 
                
                
                if(Cuenta.RFC__c != null){
                    RFC =Cuenta.RFC__c;
                }else{
                    RFC = '---';
                }
                
                if(Cuenta.giro__c != null){
                    giro =Cuenta.Giro__c;
                }else{
                    giro = '---';
                } 
                
                
                
                if(Cuenta.LastName != null){
                    SApellido =Cuenta.LastName;
                }else{
                    SApellido = '';
                }
                
                
                if(Cuenta.FirstName != null){
                    PApellido =Cuenta.FirstName;
                }else{
                    PApellido = '';
                }
                
                
                if(Cuenta.OwnerId != null){
                    propietario =Cuenta.OwnerId;
                }else{
                    propietario = '';
                }
                
                
                if(Cuenta.BillingStreet != null){
                    Calle =Cuenta.BillingStreet;
                }else{
                    Calle = '---';
                }
                
                
                if(Cuenta.BillingCity != null){
                    Ciudad =Cuenta.BillingCity;
                }else{
                    Ciudad = '---';
                }
                
                
                if(Cuenta.BillingState != null){
                    Estado =Cuenta.BillingState;
                }else{
                    Estado = '---';
                }
                
                
                if(Cuenta.BillingPostalCode != null){
                    CP =Cuenta.BillingPostalCode;
                }else{
                    CP = '---';
                }
                
                
                if(Cuenta.BillingCountry != null){
                    Pais =Cuenta.BillingCountry;
                }else{
                    Pais = '---';
                }
                
                
                if(Cuenta.PersonEmail != null){
                    Email =Cuenta.PersonEmail;
                }else{
                    Email = '---';
                }
                
                
                if(Cuenta.Id != null){
                    IdContrato =Cuenta.Id;
                }else{
                    IdContrato = '---';
                }
                
                
                
                
                
                if(Cuenta.Industry != null){
                    Industria =Cuenta.Industry;
                }else{
                    Industria = '---';
                }
                
                
                if(Cuenta.Industry != null){
                    Industria =Cuenta.Industry;
                }else{
                    Industria = '---';
                }
                
                
                if(Cuenta.Potencial_mensual_Total__c != null){
                    PotenciaMensualTotal =Cuenta.Potencial_mensual_Total__c;
                }else{
                    
                }
                
                
                if(Cuenta.Potencial_mensual_de_envios__c != null){
                    PotenciaMensualEnvio =Cuenta.Potencial_mensual_de_envios__c;
                }else{
                    
                }
                
                
                if(Cuenta.Segmento__c != null){
                    Segmento =Cuenta.Segmento__c;
                }else{
                    Segmento = '--';
                }
                
                
                if(Cuenta.Tipo_de_cliente__c != null){
                    Tipo_de_cliente =Cuenta.Tipo_de_cliente__c;
                }else{
                    Tipo_de_cliente = '---';
                }
                
                
                if(Cuenta.Servicios_nacionales__c != null){
                    ServiciosN =Cuenta.Servicios_nacionales__c;
                }else{
                    
                }
                
               
                if(Cuenta.Servicios_internacionales__c != null){
                    ServiciosI =Cuenta.Servicios_internacionales__c;
                }else{
                    
                }
                
                
                if(Cuenta.Tipo_de_servicios_internacionales__c != null){
                    TipoSI =Cuenta.Tipo_de_servicios_internacionales__c;
                }else{
                    TipoSI='No aplicas'; 
                }
                
                
                if(Cuenta.Tipo_de_servicios_nacionales__c != null){
                    TipoSN =Cuenta.Tipo_de_servicios_nacionales__c;
                }else{
                    TipoSN='No aplica';
                }
                
                
                if(Cuenta.Tipo_de_operaciones_log_sticas__c != null){
                    TipoOL =Cuenta.Tipo_de_operaciones_log_sticas__c;
                }else{
                    TipoOL='No aplica'; 
                }
                
                
                
                if(Cuenta.Operacion_logistica__c != null){
                    Logistica =Cuenta.Operacion_logistica__c;
                }else{
                    
                }
                
                
               /* if(Cuenta.Credito__r.Monto__c != null){
                    Monto =Cuenta.Credito__r.Monto__c;
                }else{
                    
                }
                
                
                if(Cuenta.Credito__r.Plazo__c != null){
                    Plazo =Cuenta.Credito__r.Plazo__c;
                }else{
                    
                }*/
                
                
                if(Cuenta.Presentacion_de_Factura_condicionada_al__c != null){
                    FacturaCondicionada =Cuenta.Presentacion_de_Factura_condicionada_al__c;
                }else{
                    FacturaCondicionada='--';
                }
                
                
                if(Cuenta.Tipo_de_acuse__c != null){
                    TipoAcuse =Cuenta.Tipo_de_acuse__c;
                }else{
                    TipoAcuse='--'; 
                }
                
                
                if(Cuenta.Requerimientos_de_acuse_de_cliente_XT__c != null){
                    RequerimientosAcuse =Cuenta.Requerimientos_de_acuse_de_cliente_XT__c;
                }else{
                    RequerimientosAcuse ='--'; 
                }
                
                
                if(Cuenta.Type != null){
                    Tipo =Cuenta.Type;
                }else{
                    Tipo ='--'; 
                }
                
                
              
                if(Cuenta.Programacion__c != null){
                    Programacion =Cuenta.Programacion__c;
                }else{
                    Descripcion ='no aplica'; 
                }
                
                
                if(Cuenta.Horarios_propuestos_de_recoleccion__c != null){
                    Horarios =Cuenta.Horarios_propuestos_de_recoleccion__c;
                }else{
                    
                }
                
                
                if(Cuenta.CreatedById != null){
                    Propietario2 =Cuenta.CreatedById;
                }else{
                    
                }
                
                
                
                FullDate = Datetime.now().format('dd-MMM-yyyy');
                
                system.debug('FullDate: ' + FullDate);
                
                Month = Datetime.now().format('MMM');
                day = Datetime.now().format('dd');
                year = Datetime.now().format('yyyy');
                
                system.debug('Month: ' + Month);
                system.debug('day: ' + day);
                system.debug('year: ' + year);
                system.debug('Datetime.now(): ' + Datetime.now());
                
                
            } catch(Exception e){
                system.debug(e.getMessage());
            }
        
        } 
    }
}
