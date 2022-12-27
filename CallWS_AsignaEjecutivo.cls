public class CallWS_AsignaEjecutivo {
    //Realiza nueva asignación:
    @future(callout=true)
    public static void callGeneraEjecutivo (Id accId){
        
        String dateOutput = System.now().format('yyyy-MM-dd');
        
        Account acc = [SELECT id, Id_SIpWeb__c, AsignacionNacionalRegular__c, AsignacionRegular_Nuevo__c, AnalisisDeValidacion__c,
                       AsignacionRegular_Recuperado__c, AsignacionRegular_Mantenimiento__c, Comisi_n_por_Mantenimiento_100__c,
                       Comision_diferenciada__c, Comision_directa__c, Usuario_a_asignar__c, AsignacionNacionalPrepago__c, Sincronizar_con_SW__c,
                       Asignacion_Internacional__c, MigracionPrepagoADocumentacionEnLinea__c, Porcentaje_de_comision_diferenciada__c,
                       Porcentaje_de_comision_directa__c, Potencial_mensual_de_envios__c, Usuario_a_asignar__r.FederationIdentifier 
                       FROM Account WHERE Id=: accId];
        
        String respuesta;
        HttpResponse response;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //QA
        request.setEndpoint('https://apiqa.paquetexpress.com.mx/SalesForceRestFul/api/executive/assing');  
        //PRD
        //request.setEndpoint('https://sf.paquetexpress.com.mx/SalesForceRestFul/api/executive/assing');  
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        request.setBody(generaJSONBody(acc));
        try{
        	response = http.send(request);
            
            if (response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' +
                             response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
                ObjResponseAsignaEjecutivo ObjRAE = ObjResponseAsignaEjecutivo.parse(response.getBody());
                if(ObjRAE.Body.Response.success){
                    acc.AnalisisDeValidacion__c += '<br/><p style="color: green;">'+dateOutput+'<br/> El ejecutivo fué sincronizado correctamente en Sipweb</p> ';
                }else{
                    acc.AnalisisDeValidacion__c += '<br/><p style="color: red;">'+dateOutput+'<br/> Hubo un error al sincronizar con Sipweb </p> ';
                    System.debug('ERROR:' + ObjRAE );
                }
                acc.Sincronizar_con_SW__c = false;
                update acc;
                
            }
            
            //generaSolicitudEmail(generaJSONBody(acc));
            //generaSolicitudEmail(response.getBody());
            
        }catch (CallOutException ex){
            //generaSolicitudEmail('Hubo una excepcion: ' + ex.getMessage() +', '+ ex.getStackTraceString());
            System.debug('Hubo una excepcion: ' + ex.getMessage() +', '+ ex.getStackTraceString());
        }
        
                
        //String log = 'REQUEST: \n\n\n' + request.getBody() + '\n\n\n  RESPONSE: \n\n\n' + response.getBody();        
        //return log;
        //return response.getBody();
        //return generaJSONBody(acc);
        
    }
    //Consulta las asignaciones actuales:
    @future(callout=true)
    public static void callValidaEjecutivo (Id accId){
        List<Estructura__c> estructuraUserAnt = new List<Estructura__c>();
        List<User> PlazaUserAnt = new List<User>();
        List<String> PlazasAnt = new List<String>();
        String OldUser = '';
        String dateOutput = System.now().format('yyyy-MM-dd');
        
        Account acc = [SELECT id, Id_SIpWeb__c, AnalisisDeValidacion__c, Usuario_anterior__c, Usuario_a_asignar__r.FederationIdentifier, 
                       Asignacion_Internacional__c, Agregar_Desarrollo_de_Negocios__c, Gerente_Sucursal_UserAn__c,
                       KAM_Regional_UserAn__c, GDN_UserAn__c FROM Account WHERE Id=: accId];
        
        String respuesta;
        HttpResponse response;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //QA
        //request.setEndpoint('https://apiqa.paquetexpress.com.mx/SalesForceRestFul/api/executive/retrieveAssingedExecutive');  
        // PRD
        request.setEndpoint('https://sf.paquetexpress.com.mx/SalesForceRestFul/api/executive/retrieveAssingedExecutive');  
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        request.setBody(generaJSONBodyConsultaCuenta(acc));
        try{
        	response = http.send(request);
            
            if (response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' +
                             response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
                ObjResponseValidaCuenta objRVC = ObjResponseValidaCuenta.parse(response.getBody());
                
                if(objRVC.Body.Response.success){
                    if (objRVC.Body.Response.Data.slmnFlr != acc.Usuario_a_asignar__r.FederationIdentifier 
                     || objRVC.Body.Response.Data.slmnItl != acc.Usuario_a_asignar__r.FederationIdentifier
                     || objRVC.Body.Response.Data.slmnPpg != acc.Usuario_a_asignar__r.FederationIdentifier  ){
                    	acc.Agregar_Desarrollo_de_Negocios__c = true;        
                    }
                    acc.AnalisisDeValidacion__c += '<p style = "color: blue;"><br/>'+dateOutput+'<br/> El cliente cuenta con las siguientes asignaciones: <br/> NACIONAL: ' + objRVC.Body.Response.Data.slmnFlr +'<br/>  INTERNACIONAL: ' + objRVC.Body.Response.Data.slmnItl +'<br/>  PREPAGO: ' + objRVC.Body.Response.Data.slmnPpg + ' </p>';
                    if(acc.Asignacion_Internacional__c == true){
                    	acc.Usuario_anterior__c =  objRVC.Body.Response.Data.slmnItl;
                        OldUser = objRVC.Body.Response.Data.slmnItl;
                        if(OldUser != null && OldUser != 'NA'){
							PlazaUserAnt = [SELECT Id, FederationIdentifier, Plaza__c FROM User WHERE FederationIdentifier=: OldUser];
            				if(PlazaUserAnt.size() > 0){
                            	PlazasAnt.add(PlazaUserAnt[0].Plaza__c);
            					System.debug('Plaza del usuario: ' + PlazaUserAnt[0].Plaza__c);
                            }
            			}
                    } else {
                    	acc.Usuario_anterior__c = objRVC.Body.Response.Data.slmnFlr;
                        OldUser = objRVC.Body.Response.Data.slmnFlr;
                        if(OldUser != null && OldUser != 'NA'){
							PlazaUserAnt = [SELECT Id, FederationIdentifier, Plaza__c FROM User WHERE FederationIdentifier=: OldUser];
                            if(PlazaUserAnt.size() > 0){
                            	PlazasAnt.add(PlazaUserAnt[0].Plaza__c);
            					System.debug('Plaza del usuario: ' + PlazaUserAnt[0].Plaza__c);
                            }
            			}
                    }
                    
                    //Asigna gerente, kam y gdn para el usuario que ya estaba asigando
        			if(PlazasAnt.size()>0){
            			estructuraUserAnt = [SELECT Id, Gerente_Sucursal__c, KAM_regional__c, Gerente_desarrollo_de_negocios__c, Plaza_sucursal__c FROM Estructura__c WHERE Plaza_sucursal__c IN: PlazasAnt];
            			System.debug('Plazas de estructuras encontradas: ' + estructuraUserAnt.size());
            			if(estructuraUserAnt.size()>0){
                    		System.debug('Plaza del usuario anterior: ' + PlazaUserAnt[0].Plaza__c);
                    		for(estructura__c est: estructuraUserAnt){
                        		System.debug('Plaza de la estructura: ' + est.Plaza_sucursal__c);
                        		if(OldUser == PlazaUserAnt[0].FederationIdentifier && PlazaUserAnt[0].Plaza__c == est.Plaza_sucursal__c){
                            		System.debug('Realiza asiganción para usuario anterior:');
                    				acc.Gerente_Sucursal_UserAn__c = est.Gerente_Sucursal__c;
                    				acc.KAM_Regional_UserAn__c = est.KAM_regional__c;
                    				acc.GDN_UserAn__c = est.Gerente_desarrollo_de_negocios__c;
                        		}
                    		}
                		}
                    } else {
                        acc.Gerente_Sucursal_UserAn__c = null;
                    	acc.KAM_Regional_UserAn__c = null;
                    	acc.GDN_UserAn__c = null; 
                    }
        
                }else{
                    acc.AnalisisDeValidacion__c += '<p style = "color: blue;"><br/>'+dateOutput+'<br/> Hubo un error al validar la cuenta con Sipweb';
                }
                update acc;
			}
            
            generaSolicitudEmail(generaJSONBodyConsultaCuenta(acc));
            generaSolicitudEmail(response.getBody());
            
        }catch (CallOutException ex){
            generaSolicitudEmail('Hubo una excepcion: ' + ex.getMessage() +', '+ ex.getStackTraceString());
        }
        
    }
    
    
    
    
    public static String generaJSONBodyConsultaCuenta (Account cuenta){

        JSONGenerator gen 	= JSON.createGenerator(true);
        
        SecurityObj SecObj	= new SecurityObj ('SALESFORCE', '325746796331582000000' /*CallWS_Token2.callGeneraToken('SALESFORCE', '1234')*/);
		DataObjConsultaCuenta   	DataObj	= new DataObjConsultaCuenta (cuenta);
     
        gen.writeStartObject();	
        		
        	gen.writeFieldName('header');
				gen.writeStartObject();		

        			gen.writeFieldName('security');
                    gen.writeObject(SecObj);

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
    
    public static String generaJSONBody (Account cuenta){

        JSONGenerator gen 	= JSON.createGenerator(true);
        
        SecurityObj SecObj	= new SecurityObj ('SALESFORCE', '325746796331582000000' /*CallWS_Token2.callGeneraToken('SALESFORCE', '1234')*/);
		DataObj   	DataObj	= new DataObj (cuenta);
     
        gen.writeStartObject();	
        		
        	gen.writeFieldName('header');
				gen.writeStartObject();		

        			gen.writeFieldName('security');
                    gen.writeObject(SecObj);

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
        
        public SecurityObj (String user, String token){
            system.debug('TOKEN: ' + token);
            this.user 		= user;
            this.token 		= token;
        }
    }
   
    public class DataObj {
		
        public String user;
        public String clntId;
        public String clntStus;
        public clntComm clntComm;
		public clntPotn clntPotn;
		public clntSlsm clntSlsm;        
        
        public DataObj(Account cuenta){
			
            if(cuenta.Usuario_a_asignar__r.FederationIdentifier != null){
            	this.user = ''+ cuenta.Usuario_a_asignar__r.FederationIdentifier; //RLGASTELUM';    
            }else{
                this.user = null;
            }
            
            if(cuenta.Id_SIpWeb__c != null) {
            	this.clntId 	= ''+ cuenta.Id_SIpWeb__c;//'2066763';
            } else {
                this.clntId = null;
            }
            
            if(cuenta.AsignacionNacionalRegular__c && cuenta.AsignacionRegular_Nuevo__c){
            	this.clntStus 	= 'N';    
            }else if (cuenta.AsignacionNacionalRegular__c && cuenta.AsignacionRegular_Recuperado__c){
                this.clntStus 	= 'R';
            }else if (cuenta.AsignacionNacionalRegular__c && cuenta.AsignacionRegular_Mantenimiento__c){
                this.clntStus 	= 'M';
                String tipo;
                Decimal porcentaje;
                if(cuenta.Comisi_n_por_Mantenimiento_100__c == true){
                    tipo = 'COM';
                    porcentaje = 100;
                }else if(cuenta.Comision_directa__c == true){
                    tipo = 'DIR';
                    porcentaje = (Decimal)cuenta.Porcentaje_de_comision_directa__c;
                    System.debug('Porcentaje campo: ' + cuenta.Porcentaje_de_comision_directa__c);
                    System.debug('Porcentaje código: ' + porcentaje);
                }else if(cuenta.Comision_diferenciada__c == true){
                    tipo = 'DIF';
                    porcentaje = (Decimal)cuenta.Porcentaje_de_comision_diferenciada__c;
                    System.debug('Porcentaje campo: ' + cuenta.Comision_diferenciada__c);
                    System.debug('Porcentaje código: ' + porcentaje);
                }
                this.clntComm	= new clntComm (tipo, porcentaje);
            }
            
            if(cuenta.Potencial_mensual_de_envios__c == null){
            	this.clntPotn = null;
            }else{
                this.clntPotn	= new clntPotn ((Integer) cuenta.Potencial_mensual_de_envios__c);    
            }
            
            
            String UsuarioNacional = '';
            String UsuarioInternacional = '';
            String UsuarioPrepago = '';
            
            if(cuenta.AsignacionNacionalRegular__c){
                UsuarioNacional = cuenta.Usuario_a_asignar__r.FederationIdentifier;
            }
            if(cuenta.Asignacion_Internacional__c){
                UsuarioInternacional = cuenta.Usuario_a_asignar__r.FederationIdentifier;
            }
            if(cuenta.AsignacionNacionalPrepago__c){
                UsuarioPrepago = cuenta.Usuario_a_asignar__r.FederationIdentifier;
            }
            
            this.clntSlsm	= new clntSlsm (UsuarioNacional,UsuarioInternacional,UsuarioPrepago);
            
        }
	}
    
    public class clntComm{
        
        public String commFactor;
        public String commValue;
        
        public clntComm (String tipo, decimal porcentaje){
            this.commFactor = tipo;
            if(porcentaje != null) {
            	this.commValue = ''+porcentaje;
            }else {
                this.commValue = null;
            }
        }
        
    }
    
    public class clntPotn{
        
        public String potnSend;
        public String potnRecv;
        public String potnPpg;
        
        public clntPotn (Integer potencial){
            if(potencial != null){
            	this.potnSend = ''+potencial;
            }else{
                this.potnSend = null;
            }
            this.potnRecv = null;
            this.potnPpg = null;
        }
        
    }
    
    public class clntSlsm{
    
    	public String slmnFlr;
        public String slmnItl;
        public String slmnPpg;
        
        public clntSlsm (String UsuarioNacional, String UsuarioInternacional, String UsuarioPrepago){
            if(UsuarioNacional != ''){this.slmnFlr = UsuarioNacional;}
            if(UsuarioInternacional != ''){this.slmnItl = UsuarioInternacional;}
            if(UsuarioPrepago != ''){this.slmnPpg = UsuarioPrepago;}
        }
        
    }
    
    
    public class DataObjConsultaCuenta {
		public String clntId;
        
        public DataObjConsultaCuenta (Account cuenta){
            this.clntId = cuenta.Id_SIpWeb__c;
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
            //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
       }catch (Exception e){
                system.debug(e);
                System.debug(e.getlinenumber());
                System.debug(e.getCause());
                System.debug(e.getStackTraceString());
            }

    }
    
    


}
