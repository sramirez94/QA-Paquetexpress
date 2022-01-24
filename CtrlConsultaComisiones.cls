public class CtrlConsultaComisiones {
    
    public Decimal tVenta 						{get; set;}
    public Decimal tComisiones					{get; set;}
    public Decimal tCobranza					{get; set;}
    public String periodoSeleccionado 			{get; set;}
    public List<selectOption> periodoOptions 	{
        
         get{
            if(periodoOptions == null){
                periodoOptions = getPeriodoOptions();
            }
            return periodoOptions;
        }
        set;
        }
    
    public List<List<ObjResponseComision.Data>> listOfListData	{get; set;}
    public Boolean mostrarDetalleconsulta			{get;set;}
    public Boolean mostrarDetalleconsulta2			{get;set;}
    public Boolean mostrarDetalleconsulta3			{get;set;}
    public Boolean mostrarDetalleconsulta4			{get;set;}
    public Boolean mostrarDetalleconsulta5			{get;set;}

    public void validaConsulta (){
        System.debug('Ejecuta Metodo');
        System.debug('Periodo Seleccionado: ' + periodoSeleccionado);
        
        mostrarDetalleconsulta = false;
        mostrarDetalleconsulta2 = false;
        mostrarDetalleconsulta3 = false;
        mostrarDetalleconsulta4 = false;
        mostrarDetalleconsulta5 = false;
        
        IntervaloFecha intervalo = generaFechasConsulta(periodoSeleccionado);
        
        List<User> usuarioConsulta  = [SELECT Id, FederationIdentifier FROM User WHERE Id =:UserInfo.getUserId()];
        
        if(intervalo.fechaInicio != null && intervalo.fechaFin != null){
            mostrarDetalleconsulta = true;
            List<AggregateResult> SUMAEJECUTIVO = [SELECT SUM(totalAntesdeImpuestos__c) FROM Ventas__c WHERE OwnerId =: UserInfo.getUserId() AND fechaId__c >=: intervalo.fechaInicio AND fechaId__c <=: intervalo.fechaFin];
            system.debug('SUMAEJECUTIVO: ' + SUMAEJECUTIVO[0].get('expr0'));
            if(SUMAEJECUTIVO.size()>0){
                tVenta = (Decimal)SUMAEJECUTIVO[0].get('expr0');    
            }
            
            if(usuarioConsulta.size() == 1){
                System.debug('periodoInicio: ' + intervalo.periodoInicio);
                System.debug('periodoFin: ' + intervalo.periodoFin);
                
                listOfListData = callValidaEjecutivoComisiones (''+usuarioConsulta[0].FederationIdentifier, intervalo.periodoInicio, intervalo.periodoFin);
                System.debug('listData: ' + listOfListData);
                tComisiones = 0;
                tCobranza	= 0;
                if(listOfListData != null){
                    for(List<ObjResponseComision.Data>  listData: listOfListData){
                        for(ObjResponseComision.Data data: listData){
                            tComisiones += Decimal.valueOf(data.totalComision);
                            tCobranza += Decimal.valueOf(data.totalAntesDeImpuestos);
                        }    
                    }     
                }else{
                    tComisiones = null;
                    tCobranza = null;
                }
                
            }
            
        }else{
            mostrarDetalleconsulta = false;
            tVenta = null;
            tComisiones = null;
            tCobranza	= null;
        }
    }
    
	public List<selectOption> getPeriodoOptions() {
        List<selectOption> periodoOptions = new List<selectOption>();
        
        Integer anio = System.today().year();
        Integer anioAnterior = System.today().year()-1;
        
		periodoOptions.add(new selectOption('--Seleccione un periodo año en curso--','--Seleccione un periodo año en curso--'));
        periodoOptions.add(new selectOption('21 de Diciembre al 20 de Enero'	,'21 de Diciembre de '+ anioAnterior + ' al 20 de Enero de ' + anio)); 
        periodoOptions.add(new selectOption('21 de Enero al 20 de Febrero'		,'21 de Enero de '+ anio + ' al 20 de Febrero de ' + anio));
        periodoOptions.add(new selectOption('21 de Febero al 20 de Marzo'		,'21 de Febrero de '+ anio + '  al 20 de Marzo de ' + anio));
        periodoOptions.add(new selectOption('21 de Marzo al 20 de Abril'		,'21 de Marzo de '+ anio + '  al 20 de Abril de ' + anio));
        periodoOptions.add(new selectOption('21 de Abril al 20 de Mayo'			,'21 de Abril de '+ anio + '  al 20 de Mayo de ' + anio));
        periodoOptions.add(new selectOption('21 de Mayo al 20 de Junio'			,'21 de Mayo de '+ anio + '  al 20 de Junio de ' + anio));
        periodoOptions.add(new selectOption('21 de Junio al 20 de Julio'		,'21 de Junio de '+ anio + '  al 20 de Julio de ' + anio));
		periodoOptions.add(new selectOption('21 de Julio al 20 de Agosto'		,'21 de Julio de '+ anio + '  al 20 de Agosto de ' + anio));
        periodoOptions.add(new selectOption('21 de Agosto al 20 de Septiembre'	,'21 de Agosto de '+ anio + '  al 20 de Septiembre de ' + anio));
        periodoOptions.add(new selectOption('21 de Septiembre al 20 de Octubre'	,'21 de Septiembre de '+ anio + '  al 20 de Octubre de ' + anio));
        periodoOptions.add(new selectOption('21 de Octubre al 20 de Noviembre'	,'21 de Octubre de '+ anio + '  al 20 de Noviembre de ' + anio));
        periodoOptions.add(new selectOption('21 de Noviembre al 20 de Diciembre','21 de Noviembre de '+ anio + '  al 20 de Diciembre de ' + anio));
        
        
        return periodoOptions;
	}
    
    public IntervaloFecha generaFechasConsulta (String periodoSeleccionado){
        mostrarDetalleconsulta = false;
        IntervaloFecha intervalo = new IntervaloFecha();
        Integer anio = System.now().year();
        
        if(periodoSeleccionado == '21 de Diciembre al 20 de Enero'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 12, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 1, 20);
            intervalo.periodoInicio 	=  ''+anio+'01';
            intervalo.periodoFin 		=  ''+anio+'01';
        }else if(periodoSeleccionado == '--Seleccione un periodo año en curso--'){
            intervalo.fechaInicio 	=  null;
            intervalo.fechaFin 		=  null;
            intervalo.periodoInicio =  null;
            intervalo.periodoFin	=  null;
        }else if(periodoSeleccionado == '21 de Enero al 20 de Febrero'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 1, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 2, 20);
            intervalo.periodoInicio 	=  ''+anio+'02';
            intervalo.periodoFin 		=  ''+anio+'02';
        }else if(periodoSeleccionado == '21 de Febero al 20 de Marzo'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 2, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 3, 20);
            intervalo.periodoInicio 	=  ''+anio+'03';
            intervalo.periodoFin 		=  ''+anio+'03';
        }else if(periodoSeleccionado == '21 de Marzo al 20 de Abril'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 3, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 4, 20);
            intervalo.periodoInicio 	=  ''+anio+'04';
            intervalo.periodoFin 		=  ''+anio+'04';
        }else if(periodoSeleccionado == '21 de Abril al 20 de Mayo'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 4, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 5, 20);
            intervalo.periodoInicio 	=  ''+anio+'05';
            intervalo.periodoFin 		=  ''+anio+'05';
        }else if(periodoSeleccionado == '21 de Mayo al 20 de Junio'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 5, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 6, 20);
            intervalo.periodoInicio 	=  ''+anio+'06';
            intervalo.periodoFin 		=  ''+anio+'06';
        }else if(periodoSeleccionado == '21 de Junio al 20 de Julio'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 6, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 7, 20);
            intervalo.periodoInicio 	=  ''+anio+'07';
            intervalo.periodoFin 		=  ''+anio+'07';
        }else if(periodoSeleccionado == '21 de Julio al 20 de Agosto'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 7, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 8, 20);
            intervalo.periodoInicio 	=  ''+anio+'08';
            intervalo.periodoFin 		=  ''+anio+'08';
        }else if(periodoSeleccionado == '21 de Agosto al 20 de Septiembre'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 8, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 9, 20);
            intervalo.periodoInicio 	=  ''+anio+'09';
            intervalo.periodoFin 		=  ''+anio+'09';
        }else if(periodoSeleccionado == '21 de Septiembre al 20 de Octubre'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 9, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 10, 20);
            intervalo.periodoInicio 	=  ''+anio+'10';
            intervalo.periodoFin 		=  ''+anio+'10';
        }else if(periodoSeleccionado == '21 de Octubre al 20 de Noviembre'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 10, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 11, 20);
            intervalo.periodoInicio 	=  ''+anio+'11';
            intervalo.periodoFin 		=  ''+anio+'11';
        }else if(periodoSeleccionado == '21 de Noviembre al 20 de Diciembre'){
            intervalo.fechaInicio 	=  date.newInstance(anio, 11, 21);
            intervalo.fechaFin 		=  date.newInstance(anio, 12, 20);
            intervalo.periodoInicio 	=  ''+anio+'12';
            intervalo.periodoFin 		=  ''+anio+'12';
        }
        
            
        return intervalo;    
    }
    
    public class IntervaloFecha{
    	Date fechaInicio;
		Date fechaFin;
		String periodoInicio;
		String periodoFin;        
    }    
        
    public static List<List<ObjResponseComision.Data>> callValidaEjecutivoComisiones (String ejecutivo, String periodoInicio, String periodoFin){
        
        List<ObjResponseComision.Data> listData  = new List<ObjResponseComision.Data> ();
        List<ObjResponseComision.Data> listData2 = new List<ObjResponseComision.Data> ();
        List<ObjResponseComision.Data> listData3 = new List<ObjResponseComision.Data> ();
        List<ObjResponseComision.Data> listData4 = new List<ObjResponseComision.Data> ();
        List<ObjResponseComision.Data> listData5 = new List<ObjResponseComision.Data> ();
        
        List<List<ObjResponseComision.Data>> listOfListDatas = new List<List<ObjResponseComision.Data>>();
        
        HttpResponse response;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //QA
        //request.setEndpoint('https://apiqa.paquetexpress.com.mx/SalesForceRestFul/api/report/v1/ventas/executive');  
        //PRD
        request.setEndpoint('https://sf.paquetexpress.com.mx/SalesForceRestFul/api/report/v1/ventas/executive');  
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        request.setBody(generaJSONBodyConsultaComision(ejecutivo, periodoInicio, periodoFin));
        try{
        	response = http.send(request);
            
            if (response.getStatusCode() != 200) {
               System.debug('The status code returned was not expected: ' +response.getStatusCode() + ' ' + response.getStatus());
            } else {
               ObjResponseComision respComision = ObjResponseComision.parse(response.getBody());
               
                if(respComision.Body.Response.Data.size()>0){
                    for(Integer x=0; x<respComision.Body.Response.Data.size(); x++){
                        if(x <= 999){
                            listData.add(respComision.Body.Response.Data[x]);
                        }
                        if(x > 999 && x <= 1999){
                            listData2.add(respComision.Body.Response.Data[x]);
                        }
                        if(x > 1999 && x <= 2999){
                            listData3.add(respComision.Body.Response.Data[x]);
                        }
                        if(x > 2999 && x <= 3999){
                            listData4.add(respComision.Body.Response.Data[x]);
                        }
                        if(x > 3999 && x <= 4999){
                            listData5.add(respComision.Body.Response.Data[x]);
                        }
                    }
                    
                    if(listData.size()>0){listOfListDatas.add(listData);}
                    if(listData2.size()>0){listOfListDatas.add(listData2);}
                    if(listData3.size()>0){listOfListDatas.add(listData3);}
                    if(listData4.size()>0){listOfListDatas.add(listData4);}
                    if(listData5.size()>0){listOfListDatas.add(listData5);}
                }
                
               //listData = respComision.Body.Response.Data;
			}
            
            generaSolicitudEmail(generaJSONBodyConsultaComision(ejecutivo, periodoInicio, periodoFin));
            generaSolicitudEmail(response.getBody());
            
        }catch (CallOutException ex){
            generaSolicitudEmail('Hubo una excepcion: ' + ex.getMessage() +', '+ ex.getStackTraceString());
        }
        //generaSolicitudEmail(generaJSONBodyConsultaComision(ejecutivo, periodoInicio, periodoFin));
        
        return listOfListDatas;
    }
    
   	public static String generaJSONBodyConsultaComision (String ejecutivo, String periodoInicio, String periodoFin){

        JSONGenerator gen 	= JSON.createGenerator(true);
        
        SecurityObj SecObj	= new SecurityObj ('SALESFORCE', '325746796331582000000' /*CallWS_Token2.callGeneraToken('SALESFORCE', '1234')*/);
		DataObj   	DataObj	= new DataObj (ejecutivo, periodoInicio, periodoFin);
     
        gen.writeStartObject();	
        		
        	gen.writeFieldName('header');
				gen.writeStartObject();		

        			gen.writeFieldName('security');
                    gen.writeObject(SecObj);
					gen.writeStringField('output', 'JSON');
                gen.writeEndObject();
        
        	gen.writeFieldName('body');
        
        	gen.writeStartObject();	
        		gen.writeFieldName('request');
        			gen.writeStartObject();	
                        gen.writeFieldName('data');
                        gen.writeObject(DataObj); 
        				gen.writeNullField('objectDTO');
                    gen.writeEndObject();
        			gen.writeNullField('response');
        	gen.writeEndObject();
        	
        gen.writeEndObject();
        System.debug(gen.getAsString());
        
        return gen.getAsString();
    }
    
    public class SecurityObj{
        public String user;
        public String token;
        public String password;
        public Integer type;
        
        public SecurityObj (String user, String token){
            system.debug('TOKEN: ' + token);
            this.password	= '';
        	this.type		= 1;    
            this.user 		= user;
            this.token 		= token;
        }
    }
   
    public class DataObj {
		
        public String executiveId;
        public String initPeriod;
        public String endPeriod;
        
        public DataObj(String ejecutivo, String periodoInicio, String periodoFin){
            
            System.debug('Periodo Inicio: ' +  periodoInicio);
            System.debug('Periodo Inicio: ' +  periodoFin);
            
            executiveId = ejecutivo; 		//'GYANEZ';//ejecutivo;            
            initPeriod 	= periodoInicio; 	//'201904';//periodoInicio;
            endPeriod 	= periodoFin;	 	//'201904';//periodoFin;
        }
	}
    
    public static void generaSolicitudEmail (String json){
        try{

            Blob body = Blob.valueOf(json);
                
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/txt');
            attach.setFileName('JSON_RESPONSE_ASIGNA_EJECUTIVO.txt');
            attach.setInline(false);
            attach.Body = body;
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            mail.setToAddresses(new String[] { 'nortiz@freewayconsulting.com' });
            mail.setSubject('ASIGNA EJECUTIVOS WS');
            mail.setHtmlBody('ASIGNA EJECUTIVOS');
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
                
            // Send the email
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
       }catch (Exception e){
                system.debug(e);
                System.debug(e.getlinenumber());
                System.debug(e.getCause());
                System.debug(e.getStackTraceString());
            }

    }
    
    
    
}
