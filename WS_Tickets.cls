@RestResource(urlMapping='/TICKETS/*')
global with sharing class WS_Tickets {
       
    global class Ticket{
       	
        // RAD
        //public String numero_del_Ticket;									//CaseNumber								Numero (Auto)
		//public String tipo_de_solicitud;									//Tipo_de_solicitud_form__c	Texto 			(Formula)
		public String tipo_de_recoleccion;									//Tipo_de_recoleccion__c					Picklist (Documentación GLP con RPP, Guía WW RPP de documentación en Línea, Documentación GLP sin RPP (normal))
		public String estatus;												//Status									Picklist (Nuevo, Asignado, Pendiente de información, Cerrado, En revisión)
		public String cliente_desea_recoleccion_normal;					//Cliente_desea_recoleccion_normal__c		Picklist (Si, No)
		public String nombre_del_contacto;									//ContactId									Busqueda(Contacto)
		//public String email_del_contacto;								//ContactEmail								Email
		//public String telefono_del_contacto;								//ContactPhone								Teléfono
		public String nombre_de_la_cuenta;									//AccountId									Busqueda(Cuenta)
		public String sucursal_RAD;										//Sucursal_RAD__c							Busqueda(Sucursal)
		public String sucursal_destino;									//Sucursal_destino__c						Busqueda(Sucursal)
		public String medio_de_contacto;									//Origin									Picklist (Chat en Línea, Cliente en piso, E-mail, Evaluación caritas PDA, Facebook, Notificación EAD/RAD, Otros, Riesgos, Teléfono, Twitter, Webmaster, Whatsapp, Sección Amarilla)
		public String glp;													//GLP__c 									Picklist (Pendiente, Cancelado, Programado, Convertida, Documentación en Línea,PP en Línea, No se concreto por falta de dato, RAD diaria)
		public String contacto_RAD;										//Contacto_RAD__c							Texto
		public String telefono_RAD;										//Telefono_RAD__c							Teléfono
		public String horario;												//Horario__c								Texto
		public String descripcion;											//Description								Area de Texto
		public String cantidad;											//Cantidad__c								Texto
		public String peso;												//Peso__c									Texto
		public String resolucion;											//Resolucion__c								Area de Texto
		public String tipo_de_Embalaje;									//Tipo_de_Embalaje__c						Picklist (Valores notepad)
		public String volumen;												//Volumen__c								Texto
		public String calle;												//Calle__c									Texto
		public String colonia;												//Colonia__c								Texto
		public String delegacion_Municipio;									//Delegacion_Municipio__c					Texto
		public String numero_Exterior_Interior;								//Numero_Exterior_Interior__c				Texto
		public String codigo_Postal;										//Codigo_Postal__c							Texto
		public String referencia_domiciliaria;								//Referencia_domiciliaria__c				Texto
		public String folio_GLP;											//Folio_GLP__c								Texto
        public String tipo_de_Ticket;										// Nombre API que se proporciono ayer a Abraham	
        public String rastreo;
        public double costo;
        public String propietario;
        public Articulo[] Articulos;
        
        
        
        
        /*  
        
        String atributo1;
        String atributo2;
        String atributo3;
        String atributoN;
       */
    }
    
    global class Articulo{
        public String cantidad;
        public String tipoEmbalaje;
        public String peso;
        public String volumen;
        public String dimensiones;
        public String contenido;
        
    }
    
    global class Response{
        public String recordId;
        public String status;
        public String message;
        
    }
    
    @HttpPost
    global static List<Response> upsert_RAD(Ticket t){
        
        System.debug(t);
        
        List<Response> responseList 		= new List<Response>();
        List<Case> upsertTicketsList 		= new List<Case>();
        
        System.debug('IdJSON: ' + t.nombre_de_la_cuenta );
        
        
        List<Contact> idContacto 			= [SELECT id, Id_SIpWeb__c FROM Contact WHERE Id_SIpWeb__c =:t.nombre_del_contacto];
        List<Account> idCuenta				= [SELECT id, Id_SIpWeb__c FROM Account WHERE Id_SIpWeb__c =:t.nombre_de_la_cuenta];
        List<Sucursal__c> idSucursalRAD		= [SELECT id, Id_SIpWeb__c FROM Sucursal__c WHERE Name =:t.sucursal_RAD];
        List<Sucursal__c> idSucursalDestino	= [SELECT id, Id_SIpWeb__c FROM Sucursal__c WHERE Name =:t.sucursal_destino];
        
        System.debug('IdJSON: ' + idCuenta);
        
        
        /*system.debug('idContacto: ' + idContacto[0].id);
        system.debug('idCuenta: ' + idCuenta[0].Id);
        system.debug('idSucursalRAD: ' + idSucursalRAD[0].Id);
        system.debug('idSucursalDestino: ' + idSucursalDestino[0].Id);*/
        
                
        Map<String, Id> mapa_Name_Id_RT 		= new Map<String, Id>();
        Map<String, Id> mapa_Name_Id_Sucursal 	= new Map<String, Id>();
        
        String  rtRAD = [SELECT Id, DeveloperName FROM RecordType WHERE SObjecttype ='Case' AND DeveloperName = 'Recoleccion_a_Domicilio'].Id;
        
        String owner = '';
        
        List<User> userList = [SELECT Id, FederationIdentifier From User WHERE FederationIdentifier =: t.propietario LIMIT 1];
        
        if(userList.size() ==1){
            if(userList[0].FederationIdentifier != null && userList[0].FederationIdentifier != ''){
                owner = userList[0].Id;
            }
        }
        
        
        try{
           
                Case ticket 									= new Case ();               
                ticket.Tipo_de_recoleccion__c 					= t.tipo_de_recoleccion;
                ticket.status									= t.estatus;	
				ticket.Cliente_desea_recoleccion_normal__c		= t.cliente_desea_recoleccion_normal;
				ticket.ContactId								= idContacto.size()        ==1 ? idContacto[0].Id	  	: null;
				ticket.AccountId								= idCuenta.size()          ==1 ? idCuenta[0].Id   		: null;
				ticket.Sucursal_RAD__c							= idSucursalRAD.size()     ==1 ? idSucursalRAD[0].Id    : null;
				ticket.Sucursal_destino__c						= idSucursalDestino.size() ==1 ? idSucursalDestino[0].Id: null;
				ticket.origin									= t.medio_de_contacto;
				ticket.GLP__c									= t.GLP;
				ticket.Contacto_RAD__c							= t.Contacto_RAD;
				ticket.Telefono_RAD__c							= t.Telefono_RAD;
				ticket.Horario__c								= t.horario;
				ticket.Description								= t.descripcion + '\n ' +'TICKET DE PRUEBA GENERADO POR WS TICKETS '+ Date.today();
				ticket.Cantidad__c								= t.cantidad;
				ticket.Peso__c									= t.peso;
				ticket.Resolucion__c							= t.resolucion;
				ticket.Tipo_de_Embalaje__c						= t.Tipo_de_Embalaje;
				ticket.Volumen__c								= t.volumen;
				ticket.Calle__c									= t.calle;
                ticket.Colonia__c								= t.colonia;
                ticket.Delegacion_Municipio__c					= t.Delegacion_Municipio;
                ticket.Numero_Exterior_Interior__c				= t.Numero_Exterior_Interior;
                ticket.Codigo_Postal__c							= t.Codigo_Postal;
                ticket.referencia_domiciliaria__c				= t.referencia_domiciliaria;
            	ticket.Folio_GLP__c								= t.folio_GLP;
            	//ticket.ContactEmail								= t.email_del_contacto == '' ? 'correo@ejemplo.com' : t.email_del_contacto;
            	ticket.RecordTypeId								= rtRAD;//'0122f0000008lCMAAY';//Schema.SObjectType.Case.getRecordTypeInfosByName().get('Recoleccion_a_Domicilio').getRecordTypeId();//[SELECT Id, Name FROM RecordType WHERE Name ='Recoleccion_a_Domicilio'].Id;
            if(owner != ''){
                ticket.OwnerId									= 	owner;	
            }
            	
            
            	String detalleArticulo = '';
            
            if(t.Articulos.size()>0){
                
                System.debug('Articulos.size()  ==' +  t.Articulos.size());
                System.debug('Articulos[]' +  t.Articulos);
                
                ticket.Tipo_de_Embalaje__c	= t.Articulos[0].tipoEmbalaje;
				ticket.Cantidad__c			= t.Articulos[0].cantidad;
				ticket.Peso__c				= t.Articulos[0].peso;
				ticket.Volumen__c			= t.Articulos[0].volumen;
				ticket.Resolucion__c 		= t.rastreo + '; ' + t.costo;
                ticket.Dimensiones__c		= t.Articulos[0].dimensiones;
                ticket.Contenido__c			= t.Articulos[0].contenido;
                
                
                Integer numArticulo = 1;
                for(Integer i=1; i< t.Articulos.size(); i++){
                    
                    detalleArticulo += '===== Artículo '+ numArticulo + ' ===== \n';
                    detalleArticulo += 'Cantidad: ' + t.Articulos[i].cantidad + '\n';
                    detalleArticulo += 'Tipo de embalaje: ' + t.Articulos[i].tipoEmbalaje + '\n';
                    detalleArticulo += 'Peso: ' + t.Articulos[i].peso + ' kg \n';
                    detalleArticulo += 'Volumen: ' + t.Articulos[i].volumen + ' m3 \n';
					detalleArticulo += 'Dimensiones: ' + t.Articulos[i].dimensiones + ' m3 \n';
                    detalleArticulo += 'Contenido: ' + t.Articulos[i].contenido + ' m3 \n';
                    detalleArticulo += '\n\n';
                    numArticulo++;
                }
                if(detalleArticulo!= ''){
                    ticket.Detalle_de_articulos__c = detalleArticulo;
                }
            }
            
            
            	upsertTicketsList.add(ticket);    
                
            Database.UpsertResult [] ticketsResultUpsert =  database.upsert(upsertTicketsList, Case.Fields.Folio_GLP__c, false);
            
            Integer contador = 0;
            
            for (Database.UpsertResult ur : ticketsResultUpsert){
                
                Response r = new Response();
                
                if(ur.isSuccess()){
                	r.recordId 	=  ur.getId();	    
                    r.status 	=  'Exitoso';		
                    r.message 	=  'OK';	    
                    responseList.add(r);
                }else{
                    for(DataBase.Error error: ur.getErrors()){
                        Response re = new Response();
                    	
                        re.recordId = 'NA';
                        re.status 	=  ''+error.getStatusCode();
                    	re.message 	=  error.getMessage() + ' ' ;
                        responseList.add(re);
                    }
                    	    
                }
                
                
                
            } 
            
            
        }catch (Exception e){
            Response re = new Response();
            re.recordId = 'NA';
            re.status 	=  ''+e.getTypeName();
            re.message 	=  ''+e.getStackTraceString();
            responseList.add(re);
        }
        
        return responseList;
    }
	
}
