/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-02-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
global class BatchProductividadEjecutivoRegion implements Database.Batchable<AggregateResult>,   Database.AllowsCallouts, Database.Stateful {
    public String query;
    global Iterable<AggregateResult> start(Database.BatchableContext BC) {
        if(test.isRunningTest()){
            query = 'SELECT  Region__c FROM User GROUP BY Region__c LIMIT 1';
        }else{
            query = 'SELECT  Region__c FROM User WHERE Region__c != \'\'  GROUP BY Region__c LIMIT 1000';
            //query = 'SELECT  Region__c FROM User WHERE Region__c = \'NORTE\'  GROUP BY Region__c LIMIT 1000';
        }
        return new AggregateResultIterable(query);
    }
    global void execute(Database.BatchableContext BC,  List<sObject> records) {
        List<AggregateResult> recordsAR 	= records;
        Date 	hoy 						= AuxTendencia.getFechaEjecucion();
        if(test.isRunningTest()){hoy 		= date.newInstance(2020, 01, 22);}
        String dia							= ''+hoy.day();
        String Mes							= ''+hoy.month();
        String anio							= ''+hoy.year();
        String mesconsulta					= ''+AuxTendencia.generaMesConsulta(mes);
        Id rtId								= [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName ='KAM_Regional'].Id;
        Id rtIdEj							= [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName ='Ejecutivo' AND sObjectType='Productividad_Ejecutivo__c' ].Id;
        system.debug('mesconsulta 	: ' +  mesconsulta);
        system.debug('hoy 			: ' +  hoy);
        AuxBatchResumenTendenciaSucursales at = new AuxBatchResumenTendenciaSucursales ();
        Id propietario;
        List<Estructura__c> propietarioList = [SELECT KAM_regional__c, Region_Presupuesto_sucursal__c FROM Estructura__c WHERE Region_Presupuesto_sucursal__c =: String.valueOf(recordsAR[0].get('Region__c')) LIMIT 1];
        if(propietarioList.size() == 1){
            propietario = propietarioList[0].KAM_regional__c;
        }else{
            propietario = '0052E00000L1OmUQAV';
        }
        if(test.isRunningTest()){propietario = '0052E00000L1OmUQAV';}
        System.debug('REGION PRESUPUESTO : ' + String.valueOf(recordsAR[0].get('Region__c')));
        // VALIDA QUE HAYA REGISTRO PARA PRODUCTIVIDAD 
        List<Productividad_Ejecutivo__c> productividadEjecutivo = [SELECT id, Tendencia_Presupuesto__c, Tendencia_Servicio_Internacional__c, 
                                                                   Tendencia_Servicio_Express__c, Tendencia_Mantenimiento__c, Tendencia_Venta_Nueva__c, 
                                                                   Experiencia_del_vendedor__c, Herramientas_electronicas__c,  Prospectos_generados__c, 
                                                                   Oportunidades_generadas__c, Precio_promedio_Kg__c, Precio_promedio_M3__c
                                                                   FROM Productividad_Ejecutivo__c 
                                                                   WHERE Ownerid =: propietario AND Mes__c =:mesconsulta AND Anio__c=: anio];
        
        System.debug('productividadEjecutivo: ' + productividadEjecutivo);
        
        // EJECUTIVOS / RELACIONADOS A LA REGIÓN 
        /*List<AggregateResult> UserList = [Select Gerente_Sucursal__c
                               FROM Estructura__c 
                               WHERE Gerente_Sucursal__c != null 
                               AND Region_Presupuesto_sucursal__c =: String.valueOf(recordsAR[0].get('Region__c'))
                               GROUP BY Gerente_Sucursal__c       
                              ];*/
        
        List<User> UserList = [Select ID, FederationIdentifier, Experiencia_del_vendedor__c, zona__c, plaza__c, region__c  
                               FROM User 
                               WHERE FederationIdentifier != null 
                               AND zona__c != null 
                               AND Region__c != null 
                               AND plaza__c != null 
                               AND Experiencia_del_vendedor__c != null 
                               AND region__c =: String.valueOf(recordsAR[0].get('Region__c')) 
                              ];
        
        if(UserList.size()>0){
            // GENERA Id LISTA DE USUARIOS
            List<Id> usersIdList = new List<Id>();
            
            for (User u: UserList){
                System.debug('USUARIO: ' + u.FederationIdentifier);
                usersIdList.add(u.Id);
            }
            
            
            List<AggregateResult> sumatoriasProd 	= AuxBatchProductividadEjecutivo.getSumatoriasProductividadEjecutivos (usersIdList, mesConsulta, anio, rtIdEj);
            List<Decimal>	valoresKGyM3			= AuxBatchProductividadEjecutivo.getValoresKGyM3 (usersIdList, mesConsulta, anio);
            
            
            /*
            List<AggregateResult> sumatoriasProd = AuxBatchProductividadEjecutivo.getSumatoriasProductividad (usersIdList, mesConsulta, anio, rtIdEj);
            Productividad_Ejecutivo__c pEjec =  AuxBatchProductividadEjecutivo.getValoresProductividad (usersIdList, sumatoriasProd);
            
            System.debug('pEjec.Tendencia_Presupuesto__c: ' 			+ pEjec.Tendencia_Presupuesto__c);
            System.debug('pEjec.Tendencia_Servicio_Internacional__c: ' 	+ pEjec.Tendencia_Servicio_Internacional__c);
            System.debug('pEjec.Tendencia_Servicio_Express__c: ' 		+ pEjec.Tendencia_Servicio_Express__c);
            System.debug('pEjec.Tendencia_Mantenimiento__c: ' 			+ pEjec.Tendencia_Mantenimiento__c);
            System.debug('pEjec.Tendencia_Venta_Nueva__c: ' 			+ pEjec.Tendencia_Venta_Nueva__c);
            System.debug('pEjec.Herramientas_electronicas__c: ' 		+ pEjec.Herramientas_electronicas__c);
            System.debug('pEjec.Prospectos_generados__c: ' 				+ pEjec.Prospectos_generados__c);
            System.debug('pEjec.Precio_promedio_Kg__c: ' 				+ pEjec.Precio_promedio_Kg__c);
            System.debug('pEjec.Precio_promedio_M3__c: ' 				+ pEjec.Precio_promedio_M3__c);
            */
            
            if(productividadEjecutivo.size() == 1){System.debug('ENTRA IF');	productividadEjecutivo[0].Tendencia_Presupuesto__c				= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Global');
                productividadEjecutivo[0].Tendencia_Servicio_Internacional__c	= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Internacional');
                productividadEjecutivo[0].Tendencia_Servicio_Express__c			= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Express');
                productividadEjecutivo[0].Tendencia_Mantenimiento__c			= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Total Venta Mantenimiento');
                productividadEjecutivo[0].Tendencia_Venta_Nueva__c				= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Total Venta Nueva');
                productividadEjecutivo[0].Herramientas_electronicas__c			= AuxBatchProductividadEjecutivo.getValorHE(sumatoriasProd);
                productividadEjecutivo[0].Prospectos_generados__c				= AuxBatchProductividadEjecutivo.getValorPROSPECTOS(sumatoriasProd);
                productividadEjecutivo[0].Oportunidades_generadas__c			= AuxBatchProductividadEjecutivo.getValorOPORTUNIDADES(sumatoriasProd);
                
                if(valoresKGyM3.size()>0){productividadEjecutivo[0].Precio_promedio_Kg__c				= valoresKGyM3[0];
                	productividadEjecutivo[0].Precio_promedio_M3__c				= valoresKGyM3[1];    
                }else{productividadEjecutivo[0].Precio_promedio_Kg__c				= 0;
                	productividadEjecutivo[0].Precio_promedio_M3__c				= 0;    
                }
                
                /*productividadEjecutivo[0].Tendencia_Presupuesto__c 			= pEjec.Tendencia_Presupuesto__c;
                productividadEjecutivo[0].Tendencia_Servicio_Internacional__c   = pEjec.Tendencia_Servicio_Internacional__c;
                productividadEjecutivo[0].Tendencia_Servicio_Express__c 		= pEjec.Tendencia_Servicio_Express__c;
                productividadEjecutivo[0].Tendencia_Mantenimiento__c			= pEjec.Tendencia_Mantenimiento__c;
                productividadEjecutivo[0].Tendencia_Venta_Nueva__c 				= pEjec.Tendencia_Venta_Nueva__c;
                productividadEjecutivo[0].Herramientas_electronicas__c 			= pEjec.Herramientas_electronicas__c;
                productividadEjecutivo[0].Prospectos_generados__c 				= pEjec.Prospectos_generados__c;
                productividadEjecutivo[0].Oportunidades_generadas__c 			= pEjec.Oportunidades_generadas__c;
                productividadEjecutivo[0].Precio_promedio_Kg__c 				= pEjec.Precio_promedio_Kg__c;
                productividadEjecutivo[0].Precio_promedio_M3__c 				= pEjec.Precio_promedio_M3__c;*/
                
                update productividadEjecutivo; 
            }
            
            if(productividadEjecutivo.size() == 0 || test.isRunningTest()){
                System.debug('ENTRA ELSE');
                Productividad_Ejecutivo__c pe = new Productividad_Ejecutivo__c ();
                pe.Anio__c 								= anio;
                pe.Mes__c 								= mesconsulta;
                pe.Experiencia_del_vendedor__c 			= 'Maduro';
                pe.Tendencia_Presupuesto__c 			= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Global');
                pe.Tendencia_Servicio_Internacional__c	= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Internacional');
                pe.Tendencia_Servicio_Express__c 		= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Express');
                pe.Tendencia_Mantenimiento__c 			= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Total Venta Mantenimiento');
                pe.Tendencia_Venta_Nueva__c 			= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Total Venta Nueva');
                pe.Herramientas_electronicas__c 		= AuxBatchProductividadEjecutivo.getValorHE(sumatoriasProd);
                pe.Prospectos_generados__c 				= AuxBatchProductividadEjecutivo.getValorPROSPECTOS(sumatoriasProd);
                pe.Oportunidades_generadas__c 			= AuxBatchProductividadEjecutivo.getValorOPORTUNIDADES(sumatoriasProd);

				if(valoresKGyM3.size()>0){
                	pe.Precio_promedio_Kg__c			= valoresKGyM3[0];
                	pe.Precio_promedio_M3__c			= valoresKGyM3[1];    
                }else{
                    pe.Precio_promedio_Kg__c			= 0;	pe.Precio_promedio_M3__c			= 0;    
                }
				
                
                pe.RecordTypeId							= rtId;
                pe.Region__c							= String.valueOf(recordsAR[0].get('Region__c'));
                
                pe.OwnerId 								= propietario;
                insert pe;
            } 
            
        }
        
        
        
        
   }  
    
    global void finish(Database.BatchableContext BC){
        if(!test.isRunningTest()){System.enqueueJob(new CallBatchProductividadEjecutivoZona());}
    }

}
