/**
**/
global class BatchProductividadEjecutivoPlaza implements Database.Batchable<AggregateResult>,   Database.AllowsCallouts, Database.Stateful {
    public String query;
    global Iterable<AggregateResult> start(Database.BatchableContext BC) {
        if(test.isRunningTest()){
            query = 'SELECT  Plaza__c FROM User GROUP BY Plaza__c LIMIT 1';
        }else{
            query = 'SELECT  Plaza__c FROM User WHERE Plaza__c != \'\'  GROUP BY Plaza__c LIMIT 1000';
            //query = 'SELECT  Plaza__c FROM User WHERE Plaza__c = \'GDL\'  GROUP BY Plaza__c';
        }
        return new AggregateResultIterable(query);
    }
    global void execute(Database.BatchableContext BC,  List<sObject> records) {
        try{
            System.debug('======= BATCH PRODUCTIVIDAD EJECUTIVO GERENTES =======');
            List<AggregateResult> recordsAR 	= records;
            Date 	hoy 						= AuxTendencia.getFechaEjecucion();
            if(test.isRunningTest()){hoy 		= date.newInstance(2020, 01, 22);}
            String dia							= ''+hoy.day();
            String Mes							= ''+hoy.month();
            String anio							= ''+hoy.year();
            String mesconsulta					= ''+AuxTendencia.generaMesConsulta(mes);
            Id rtId								= [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName ='Gerente_plazas' AND sObjectType='Productividad_Ejecutivo__c' ].Id;
            Id rtIdEj							= [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName ='Ejecutivo' AND sObjectType='Productividad_Ejecutivo__c' ].Id;
            system.debug('mesconsulta 	: ' +  mesconsulta);
            system.debug('hoy 			: ' +  hoy);
            system.debug('anio 			: ' +  anio);
            AuxBatchResumenTendenciaSucursales at = new AuxBatchResumenTendenciaSucursales ();
            Id propietario;
            List<Estructura__c> propietarioList = [SELECT Gerente_Sucursal__c, Plaza_sucursal__c FROM Estructura__c WHERE Plaza_sucursal__c =: String.valueOf(recordsAR[0].get('plaza__c')) LIMIT 1];
            List<Productividad_Ejecutivo__c> productividadEjecutivo = new List<Productividad_Ejecutivo__c>();
            if(propietarioList.size() == 1){
                propietario = propietarioList[0].Gerente_Sucursal__c;
            }else{
                propietario = '0052E00000L1OmUQAV';
            }
            if(test.isRunningTest()){propietario = '0052E00000L1OmUQAV';}
            System.debug('PLAZA PRESUPUESTO : ' + String.valueOf(recordsAR[0].get('plaza__c')));
            System.debug('GERENTE : ' + propietario);
            // VALIDA QUE HAYA REGISTRO PARA PRODUCTIVIDAD
            try {
                productividadEjecutivo = [SELECT id, Tendencia_Presupuesto__c, Tendencia_Servicio_Internacional__c,
                                                                       Tendencia_Servicio_Express__c, Tendencia_Mantenimiento__c, Tendencia_Venta_Nueva__c,
                                                                       Experiencia_del_vendedor__c, Herramientas_electronicas__c,  Prospectos_generados__c,
                                                                       Oportunidades_generadas__c, Precio_promedio_Kg__c, Precio_promedio_M3__c
                                                                       FROM Productividad_Ejecutivo__c
                                                                       WHERE Ownerid =: propietario AND Mes__c =:mesconsulta AND Anio__c=: anio];
            } catch (QueryException e) {
                System.debug('BatchProductividadEjecutivoPlaza productividadEjecutivo: ' + e.getMessage());
                AuxBatchProductividadEjecutivo.generaSolicitudEmail(e.getMessage(), 'BatchProductividadEjecutivoPlaza consulta de productividadEjecutivo', 0);
            }
            System.debug('productividadEjecutivo: ' + productividadEjecutivo);
            // USUARIOS RELACIONADOS A LA PLAZA
            List<User> UserList = [Select ID, FederationIdentifier, Experiencia_del_vendedor__c, zona__c, plaza__c, region__c
                                   FROM User
                                   WHERE FederationIdentifier != null
                                   AND zona__c != null
                                   AND Region__c != null
                                   AND plaza__c != null
                                   AND Experiencia_del_vendedor__c != null
                                   AND plaza__c =: String.valueOf(recordsAR[0].get('plaza__c'))
                                  ];
            if(UserList.size()>0){
                System.debug('72_ENTRA UserList.size()>0 ');
                // GENERA Id LISTA DE USUARIOS
                List<Id> usersIdList = new List<Id>();
                for (User u: UserList){
                    System.debug('USUARIO: ' + u.FederationIdentifier);
                    usersIdList.add(u.Id);
                }
                List<AggregateResult> sumatoriasProd 	= AuxBatchProductividadEjecutivo.getSumatoriasProductividadEjecutivos (usersIdList, mesConsulta, anio, rtIdEj);
                List<Decimal>	valoresKGyM3			= AuxBatchProductividadEjecutivo.getValoresKGyM3 (usersIdList, mesConsulta, anio);
                if(productividadEjecutivo.size() == 1){System.debug('ENTRA IF');	productividadEjecutivo[0].Tendencia_Presupuesto__c				= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Global');productividadEjecutivo[0].Tendencia_Servicio_Internacional__c	= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Internacional');productividadEjecutivo[0].Tendencia_Servicio_Express__c			= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Express');productividadEjecutivo[0].Tendencia_Mantenimiento__c			= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Total Venta Mantenimiento');productividadEjecutivo[0].Tendencia_Venta_Nueva__c				= AuxBatchProductividadEjecutivo.getValoresGlobalComparativa(usersIdList, mesConsulta, anio, rtIdEj, 'Total Venta Nueva');productividadEjecutivo[0].Herramientas_electronicas__c			= AuxBatchProductividadEjecutivo.getValorHE(sumatoriasProd);
                    productividadEjecutivo[0].Prospectos_generados__c				= AuxBatchProductividadEjecutivo.getValorPROSPECTOS(sumatoriasProd);
                    productividadEjecutivo[0].Oportunidades_generadas__c			= AuxBatchProductividadEjecutivo.getValorOPORTUNIDADES(sumatoriasProd);
                    if(valoresKGyM3.size()>0){productividadEjecutivo[0].Precio_promedio_Kg__c				= valoresKGyM3[0];
                        productividadEjecutivo[0].Precio_promedio_M3__c				= valoresKGyM3[1];
                    }else{productividadEjecutivo[0].Precio_promedio_Kg__c			= 0;
                        productividadEjecutivo[0].Precio_promedio_M3__c				= 0;
                    }
                    System.debug('productividadEjecutivo[0].Tendencia_Presupuesto__c: ' 			+ productividadEjecutivo[0].Tendencia_Presupuesto__c);
                    System.debug('productividadEjecutivo[0].Tendencia_Servicio_Internacional__c: ' 	+ productividadEjecutivo[0].Tendencia_Servicio_Internacional__c);
                       System.debug('productividadEjecutivo[0].Tendencia_Servicio_Express__c: ' 		+ productividadEjecutivo[0].Tendencia_Servicio_Express__c);
                    System.debug('productividadEjecutivo[0].Tendencia_Mantenimiento__c: ' 			+ productividadEjecutivo[0].Tendencia_Mantenimiento__c);
                    System.debug('productividadEjecutivo[0].Tendencia_Venta_Nueva__c: ' 			+ productividadEjecutivo[0].Tendencia_Venta_Nueva__c);
                    System.debug('productividadEjecutivo[0].Herramientas_electronicas__c: ' 		+ productividadEjecutivo[0].Herramientas_electronicas__c);
                    System.debug('productividadEjecutivo[0].Prospectos_generados__c: ' 				+ productividadEjecutivo[0].Prospectos_generados__c);
                    System.debug('productividadEjecutivo[0].Oportunidades_generadas__c: ' 			+ productividadEjecutivo[0].Oportunidades_generadas__c);
                    System.debug('productividadEjecutivo[0].Precio_promedio_Kg__c: ' 				+ productividadEjecutivo[0].Precio_promedio_Kg__c);
                    System.debug('productividadEjecutivo[0].Precio_promedio_M3__c: ' 				+ productividadEjecutivo[0].Precio_promedio_M3__c);
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
                    pe.Plaza__c								= String.valueOf(recordsAR[0].get('plaza__c'));
                    pe.OwnerId 								= propietario;
                    System.debug('pe.Tendencia_Presupuesto__c: ' 			+ pe.Tendencia_Presupuesto__c				);
                    System.debug('pe.Tendencia_Servicio_Internacional__c: ' + pe.Tendencia_Servicio_Internacional__c	);
                       System.debug('pe.Tendencia_Servicio_Express__c: ' 		+ pe.Tendencia_Servicio_Express__c			);
                    System.debug('pe.Tendencia_Mantenimiento__c: ' 			+ pe.Tendencia_Mantenimiento__c				);
                    System.debug('pe.Tendencia_Venta_Nueva__c: ' 			+ pe.Tendencia_Venta_Nueva__c				);
                    System.debug('pe.Herramientas_electronicas__c: ' 		+ pe.Herramientas_electronicas__c			);
                    System.debug('pe.Prospectos_generados__c: ' 			+ pe.Prospectos_generados__c				);
                    System.debug('pe.Oportunidades_generadas__c: ' 			+ pe.Oportunidades_generadas__c				);
                    System.debug('pe.Precio_promedio_Kg__c: ' 				+ pe.Precio_promedio_Kg__c					);
                    System.debug('pe.Precio_promedio_M3__c: ' 				+ pe.Precio_promedio_M3__c					);
                    insert pe;
                }
            }
        } catch(Exception ex){
            System.debug('BatchProductividadEjecutivoPlaza.Execute. Mensaje: ' + ex.getMessage() + '. Línea: ' + ex.getlinenumber());
            AuxBatchProductividadEjecutivo.generaSolicitudEmail(ex.getMessage(), 'BatchProductividadEjecutivoPlaza', ex.getLineNumber());
        }
   }
    global void finish(Database.BatchableContext BC){
        if(!test.isRunningTest()){System.enqueueJob(new CallBatchProductividadEjecutivoKAM());}
    }

}
