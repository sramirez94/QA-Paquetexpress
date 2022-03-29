/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-03-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class AuxBatchProductividadEjecutivo {
    
    public static void productividadEjecutivo (Id ejecutivoId,  String mesconsulta, Date hoy, String anio, String experienciaVendedor){
        
        system.debug('Ejecutivo: ' 				+ ejecutivoId );
        system.debug('mesconsulta: ' 			+ mesconsulta );
        system.debug('hoy: ' 					+ hoy );
        system.debug('anio: ' 					+ anio );
        system.debug('experienciaVendedor: ' 	+ experienciaVendedor );
        
        List<User> usrList 						= [SELECT Id, plaza__c, zona__c, region__c FROM User WHERE id =: ejecutivoId];
        
        Id rtId									= [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName ='Ejecutivo' AND sObjectType='Productividad_Ejecutivo__c' ].Id;
        
        List<AggregateResult> sumatoriasAR 		= getSumatoriasVentasTotal (ejecutivoId, hoy);
        List<AggregateResult> sumatoriasPesoVol = getSumatoriasPesoVolumen (ejecutivoId, mesconsulta, anio);
        List<Decimal> valoresHE					= getParticipacionHerramientasElectronicas(ejecutivoId, hoy, sumatoriasAR);	
        List<Decimal> valoresLEADS				= getLeads(ejecutivoId, hoy, experienciaVendedor);
        List<Decimal> valoresOPPS				= getOpps(ejecutivoId, hoy, experienciaVendedor);
        
        
        List<Productividad_Ejecutivo__c> productividadEjecutivo = [SELECT id, Tendencia_Presupuesto__c, Tendencia_Servicio_Internacional__c, 
                                                                   Tendencia_Servicio_Express__c, Tendencia_Mantenimiento__c, Tendencia_Venta_Nueva__c, 
                                                                   Experiencia_del_vendedor__c, Herramientas_electronicas__c,  Prospectos_generados__c, 
                                                                   Oportunidades_generadas__c, Precio_promedio_Kg__c, Precio_promedio_M3__c
                                                                   FROM Productividad_Ejecutivo__c 
                                                                   WHERE Ownerid =: ejecutivoId AND Mes__c =:mesconsulta AND Anio__c=: anio];
        
        System.debug('productividadEjecutivo: ' + productividadEjecutivo);
        
        if(productividadEjecutivo.size() == 1){
            System.debug('ENTRA IF');
            productividadEjecutivo[0].Tendencia_Presupuesto__c 				= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Global');
            productividadEjecutivo[0].Tendencia_Servicio_Internacional__c   = getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Internacional');
            productividadEjecutivo[0].Tendencia_Servicio_Express__c 		= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Express');
            productividadEjecutivo[0].Tendencia_Mantenimiento__c			= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Total Venta Mantenimiento');
            productividadEjecutivo[0].Tendencia_Venta_Nueva__c 				= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Total Venta Nueva');
            productividadEjecutivo[0].Venta_global_mes__c		 			= valoresHE[0];
            productividadEjecutivo[0].Venta_global_mes_HE__c	 			= valoresHE[1];
            productividadEjecutivo[0].Herramientas_electronicas__c 			= valoresHE[2];
            productividadEjecutivo[0].Objetivo_prospectos__c 				= valoresLEADS[0];
            productividadEjecutivo[0].Total_prospectos_generados__c 		= valoresLEADS[1];
            productividadEjecutivo[0].Prospectos_generados__c 				= valoresLEADS[2];
            productividadEjecutivo[0].Objetivo_Oportunidades__c				= valoresOPPS[0];
            productividadEjecutivo[0].Total_oportunidades_generadas__c		= valoresOPPS[1];
            productividadEjecutivo[0].Oportunidades_generadas__c 			= valoresOPPS[2];
            productividadEjecutivo[0].Precio_promedio_Kg__c 				= getPesoPromedio(ejecutivoId, hoy, sumatoriasPesoVol);
            productividadEjecutivo[0].Precio_promedio_M3__c 				= getVolumenPromedio(ejecutivoId, hoy, sumatoriasPesoVol);
            
            if(usrList.size()==1){
            	productividadEjecutivo[0].Plaza_del_ejecutivo__c			= usrList[0].plaza__c;
                productividadEjecutivo[0].Region_del_ejecutivo__c			= usrList[0].region__c;
                productividadEjecutivo[0].Zona_del_ejecutivo__c				= usrList[0].zona__c;
            }
            
            System.debug('UPDATE');
            system.debug('productividadEjecutivo[0].Tendencia_Presupuesto__c: ' 			+ productividadEjecutivo[0].Tendencia_Presupuesto__c);
            system.debug('productividadEjecutivo[0].Tendencia_Servicio_Internacional__c: ' 	+ productividadEjecutivo[0].Tendencia_Servicio_Internacional__c);
            system.debug('productividadEjecutivo[0].Tendencia_Servicio_Express__c: ' 		+ productividadEjecutivo[0].Tendencia_Servicio_Express__c);
            system.debug('productividadEjecutivo[0].Tendencia_Mantenimiento__c: ' 			+ productividadEjecutivo[0].Tendencia_Mantenimiento__c);
            system.debug('productividadEjecutivo[0].Tendencia_Venta_Nueva__c: ' 			+ productividadEjecutivo[0].Tendencia_Venta_Nueva__c);
            system.debug('productividadEjecutivo[0].Venta_global_mes__c: ' 					+ productividadEjecutivo[0].Venta_global_mes__c);
            system.debug('productividadEjecutivo[0].Venta_global_mes_HE__c: ' 				+ productividadEjecutivo[0].Venta_global_mes_HE__c);
            system.debug('productividadEjecutivo[0].Herramientas_electronicas__c: ' 		+ productividadEjecutivo[0].Herramientas_electronicas__c);
            system.debug('productividadEjecutivo[0].Objetivo_prospectos__c: ' 				+ productividadEjecutivo[0].Objetivo_prospectos__c);
            system.debug('productividadEjecutivo[0].Total_prospectos_generados__c: ' 		+ productividadEjecutivo[0].Total_prospectos_generados__c);
            system.debug('productividadEjecutivo[0].Prospectos_generados__c: ' 				+ productividadEjecutivo[0].Prospectos_generados__c);
            system.debug('productividadEjecutivo[0].Objetivo_Oportunidades__c: ' 			+ productividadEjecutivo[0].Objetivo_Oportunidades__c);
            system.debug('productividadEjecutivo[0].Total_oportunidades_generadas__c: ' 	+ productividadEjecutivo[0].Total_oportunidades_generadas__c);
            system.debug('productividadEjecutivo[0].Oportunidades_generadas__c: ' 			+ productividadEjecutivo[0].Oportunidades_generadas__c);
            system.debug('productividadEjecutivo[0].Precio_promedio_Kg__c: ' 				+ productividadEjecutivo[0].Precio_promedio_Kg__c);
            system.debug('productividadEjecutivo[0].Precio_promedio_M3__c: ' 				+ productividadEjecutivo[0].Precio_promedio_M3__c);
            
            update productividadEjecutivo; 
        }else{
            System.debug('ENTRA ELSE');
            Productividad_Ejecutivo__c pe = new Productividad_Ejecutivo__c ();
            pe.Anio__c 								= anio;
            pe.Mes__c 								= mesconsulta;
            pe.Experiencia_del_vendedor__c 			= experienciaVendedor;
            pe.Tendencia_Presupuesto__c 			= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Global');
            pe.Tendencia_Servicio_Internacional__c	= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Internacional');
            pe.Tendencia_Servicio_Express__c 		= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Express');
            pe.Tendencia_Mantenimiento__c 			= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Total Venta Mantenimiento	');
            pe.Tendencia_Venta_Nueva__c 			= getTendenciaGlobal(ejecutivoId, mesconsulta, anio, 'Total Venta Nueva	');
            pe.Venta_global_mes__c		 			= valoresHE[0];
            pe.Venta_global_mes_HE__c	 			= valoresHE[1];
            pe.Herramientas_electronicas__c 		= valoresHE[2];
            pe.Objetivo_prospectos__c 				= valoresLEADS[0];
            pe.Total_prospectos_generados__c 		= valoresLEADS[1];
            pe.Prospectos_generados__c 				= valoresLEADS[2];
            pe.Objetivo_Oportunidades__c			= valoresOPPS[0];
            pe.Total_oportunidades_generadas__c		= valoresOPPS[1];
            pe.Oportunidades_generadas__c 			= valoresOPPS[2];
            pe.Precio_promedio_Kg__c 				= getPesoPromedio(ejecutivoId, hoy, sumatoriasPesoVol);
            pe.Precio_promedio_M3__c 				= getVolumenPromedio(ejecutivoId, hoy, sumatoriasPesoVol);
            pe.RecordTypeId							= rtId;
            pe.OwnerId 								= ejecutivoId;
            
            System.debug('INSERT');
            system.debug('pe.Tendencia_Presupuesto__c: ' 			+ pe.Tendencia_Presupuesto__c);
            system.debug('pe.Tendencia_Servicio_Internacional__c: ' + pe.Tendencia_Servicio_Internacional__c);
            system.debug('pe.Tendencia_Servicio_Express__c: ' 		+ pe.Tendencia_Servicio_Express__c);
            system.debug('pe.Tendencia_Mantenimiento__c: ' 			+ pe.Tendencia_Mantenimiento__c);
            system.debug('pe.Tendencia_Venta_Nueva__c: ' 			+ pe.Tendencia_Venta_Nueva__c);
            system.debug('pe.Venta_global_mes__c: ' 				+ pe.Venta_global_mes__c);
            system.debug('pe.Venta_global_mes_HE__c: ' 				+ pe.Venta_global_mes_HE__c);
            system.debug('pe.Herramientas_electronicas__c: ' 		+ pe.Herramientas_electronicas__c);
            system.debug('pe.Objetivo_prospectos__c: ' 				+ pe.Objetivo_prospectos__c);
            system.debug('pe.Total_prospectos_generados__c: ' 		+ pe.Total_prospectos_generados__c);
            system.debug('pe.Prospectos_generados__c: ' 			+ pe.Prospectos_generados__c);
            system.debug('pe.Objetivo_Oportunidades__c: ' 			+ pe.Objetivo_Oportunidades__c);
            system.debug('pe.Total_oportunidades_generadas__c: ' 	+ pe.Total_oportunidades_generadas__c);
            system.debug('pe.Oportunidades_generadas__c: ' 			+ pe.Oportunidades_generadas__c);
            system.debug('pe.Precio_promedio_Kg__c: ' 				+ pe.Precio_promedio_Kg__c);
            system.debug('pe.Precio_promedio_M3__c: ' 				+ pe.Precio_promedio_M3__c);
            
            insert pe;
        }
        
        
   }
    
    public static Decimal getTendenciaGlobal (Id ejecutivoId,String mesconsulta,String anio, string comparativa){
        
        Decimal 	porcentajeGlobal 	= 0; 
        Id 			rtId 				= [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName  ='Ejecutivo_Ventas'].Id;
        
        System.debug('======getTendenciaGlobal=====');
        System.debug('ejecutivoId:' + ejecutivoId);
        System.debug('mesconsulta:' + mesconsulta);
        System.debug('anio:' + anio);
        System.debug('comparativa:' + comparativa);
        System.debug('rtId:' + rtId);
        
        List<Resumen_Tendencia__c>  rtList = [SELECT Id, OwnerId, Venta_vs_Presupuesto__c, Tendencia_vs_Presupuesto__c, comparativa__c FROM Resumen_Tendencia__c WHERE OwnerId =:ejecutivoId AND Mes__c=:mesconsulta AND Anio__c =:anio AND recordTypeId =:rtId AND comparativa__c =: comparativa];
        system.debug('TAMAÑO rtList: ' + rtList.size());
        if(rtList.size()== 1){
            System.debug('ENTRA IF rtList.size()== 1');
            porcentajeGlobal = rtList[0].Tendencia_vs_Presupuesto__c;
        }
        
        System.debug('porcentajeGlobal: ' + porcentajeGlobal);
        System.debug('======FIN getTendenciaGlobal=====');
        return porcentajeGlobal;             
    }
    
    public static List<Decimal> getParticipacionHerramientasElectronicas (Id ejecutivoId, Date fecha, List<AggregateResult> sumatorias){
        
        List<Decimal> valoresHE = new List<Decimal>();
        
        System.debug('======getParticipacionHerramientasElectronicas=====');
        System.debug('ejecutivoId:' + ejecutivoId);
        System.debug('fecha:' + fecha);
        System.debug('sumatorias:' + sumatorias);
        
        Integer 	numberOfDays 	= Date.daysInMonth(fecha.year(), fecha.month());
		Date 		fechaFin 		= Date.newInstance(fecha.year(), fecha.month(), numberOfDays);
        Date 		fechaInicio 	= Date.newInstance(fecha.year(), fecha.month(), 1);
        
        Decimal totalVentasElect  	= 0;
        Decimal totalVentasEject	= 0;
        
        Decimal participacionHE  	= 0;
                
        List<AggregateResult> ventasEjecListHE = [SELECT  SUM(totalAntesdeImpuestos__c) FROM Ventas__c WHERE (origenDoc__c ='DOCUMLINEA' OR origenDoc__c='ECOMMERCE' OR origenDoc__c='ELECTRONICAWEB' OR origenDoc__c = 'PAGINAWEB' OR origenDoc__c='SERVICIOWEB') AND fechaId__c >=: fechaInicio AND fechaId__c <: fechaFin AND ownerId =: ejecutivoId];
        //List<AggregateResult> ventasEjecListTotal = [SELECT  SUM(totalAntesdeImpuestos__c) FROM Ventas__c WHERE fechaId__c >=: fechaInicio AND fechaId__c <: fechaFin AND ownerId =: ejecutivoId];
        
        if(ventasEjecListHE != null){
            totalVentasElect = (Decimal)ventasEjecListHE[0].get('expr0');
        }
        
        if(sumatorias != null){
            //totalVentasEject = (Decimal)ventasEjecListTotal[0].get('expr0');
            totalVentasEject   = (Decimal)sumatorias[0].get('expr0');
        }
        
        if(totalVentasElect != 0 && totalVentasElect != null && totalVentasEject != 0 && totalVentasEject != null){
            System.debug('totalVentasElect: ' + totalVentasElect);
            System.debug('totalVentasEject: ' + totalVentasEject);
            participacionHE = (totalVentasElect / totalVentasEject)*100;
        }
        
        System.debug('participacionHE: ' + participacionHE);
        System.debug('======FIN getParticipacionHerramientasElectronicas=====');
        
        valoresHE.add(totalVentasEject);
        valoresHE.add(totalVentasElect);
        valoresHE.add(participacionHE);
        
        return valoresHE;
    }
    
    public static List<Decimal> getLeads (Id ejecutivoId, Date fecha, String experienciaVendedor){
        
        List<Decimal> valoresLEADS = new List<Decimal>();
        
        Datetime 	fechaInicio = Datetime.newInstance(fecha.year(), fecha.month(), 1);
        Datetime 	fechaFin	= Datetime.newInstance(fecha.year(), fecha.month()+1, 1);
        Decimal 	porcentajeProspectos = 0;
        
        System.debug('======getLeads=====');
        System.debug('ejecutivoId:' + ejecutivoId);
        System.debug('fecha:' + fecha);
        System.debug('experienciaVendedor:' + experienciaVendedor);
        
        System.debug('Fecha Inicio: ' + fechaInicio);
        System.debug('Fecha Fin: ' + fechaFin );
        
        Decimal countProspectos	= 0;
                
        List<AggregateResult> ventasEjecListHE = [SELECT  Count(Id) FROM Lead WHERE CreatedDate >=:fechaInicio AND CreatedDate <: fechaFin AND CreatedById =:ejecutivoId];
        countProspectos = (Integer)ventasEjecListHE[0].get('expr0');
        
        porcentajeProspectos = (countProspectos / getObjetivoProspecto (experienciaVendedor));
		system.debug('porcentajeProspectos: ' + porcentajeProspectos);
        porcentajeProspectos = porcentajeProspectos*100;
        
        system.debug('Objetivo Prospecto: ' + getObjetivoProspecto (experienciaVendedor));
        system.debug('countProspectos: ' + countProspectos);
        system.debug('porcentajeProspectos: ' + porcentajeProspectos);
        System.debug('======FIN getLeads=====');
        
		valoresLEADS.add(getObjetivoProspecto (experienciaVendedor));
		valoresLEADS.add(countProspectos);
        valoresLEADS.add(porcentajeProspectos);
        return valoresLEADS;
    }
    
    public static List<Decimal> getOpps (Id ejecutivoId, Date fecha, String experienciaVendedor){
        
        List<Decimal> valoresOPP = new List<Decimal>();
        
        System.debug('======getOpps=====');
        System.debug('ejecutivoId:' + ejecutivoId);
        System.debug('fecha:' + fecha);
        System.debug('experienciaVendedor:' + experienciaVendedor);
        
        Datetime 	fechaInicio = Datetime.newInstance(fecha.year(), fecha.month(), 1);
        Datetime 	fechaFin	= Datetime.newInstance(fecha.year(), fecha.month()+1, 1);
        Decimal 	porcentajeOportunidades;
        
        System.debug('Fecha Inicio: ' + fechaInicio);
        System.debug('Fecha Fin: ' + fechaFin );
        
        Decimal countOpps	= 0;
                
        List<AggregateResult> ventasEjecListHE = [SELECT  Count(Id) FROM Opportunity WHERE CreatedDate >=:fechaInicio AND CreatedDate <: fechaFin AND CreatedById =:ejecutivoId];
        countOpps = (Integer)ventasEjecListHE[0].get('expr0');
        
        porcentajeOportunidades = (countOpps / getObjetivoOportunidad (experienciaVendedor));
        System.debug('porcentajeOportunidades: ' +porcentajeOportunidades);
        porcentajeOportunidades = porcentajeOportunidades*100;
        system.debug('Objetivo oportunidades: ' + getObjetivoOportunidad (experienciaVendedor));
        System.debug('porcentajeOportunidades: ' + porcentajeOportunidades);
        System.debug('countOpps: ' + countOpps);
        System.debug('======FIN getOpps=====');
        
        valoresOPP.add(getObjetivoOportunidad (experienciaVendedor));
        valoresOPP.add(countOpps);
        valoresOPP.add(porcentajeOportunidades);
            
        return valoresOPP;
    }
    
    public static Decimal getVolumenPromedio (Id ejecutivoId, Date fecha, List<AggregateResult> sumatorias){
        
        System.debug('======getVolumenPromedio=====');
        System.debug('ejecutivoId:' + ejecutivoId);
        System.debug('fecha:' + fecha);
        System.debug('sumatorias:' + sumatorias);
        
        List<Decimal> ObjetivosVolumenPesoList = getObjetivosVolumenPeso(''+fecha.year());
        Decimal 	volmenObjetivo	= ObjetivosVolumenPesoList[1];
        
        Decimal volumenPromedio			= 0;
        Decimal porcentajeAlcanzadoVol  = 0;
        
        if(sumatorias[0].get('expr1') != null){
            volumenPromedio = (Decimal)sumatorias[0].get('expr1');
        }
        
        System.debug('-->volumenPromedio: ' + volumenPromedio);
        System.debug('-->volmenObjetivo: ' + volmenObjetivo);
        
        porcentajeAlcanzadoVol = (volumenPromedio/volmenObjetivo)*100;
        
        System.debug('==>porcentajeAlcanzadoVol: ' + porcentajeAlcanzadoVol);
        System.debug('======FIN getVolumenPromedio=====');
        return porcentajeAlcanzadoVol;
    }
    
    public static Decimal getPesoPromedio (Id ejecutivoId, Date fecha, List<AggregateResult> sumatorias){
        
        System.debug('======getPesoPromedio=====');
        System.debug('ejecutivoId:' + ejecutivoId);
        System.debug('fecha:' + fecha);
        System.debug('sumatorias:' + sumatorias);
        
        List<Decimal> 	ObjetivosVolumenPesoList 	= getObjetivosVolumenPeso(''+fecha.year());
        Decimal 		pesoObjetivo				= ObjetivosVolumenPesoList[0];
        
        Integer 	numberOfDays 	= Date.daysInMonth(fecha.year(), fecha.month());
		Date 		fechaFin 		= Date.newInstance(fecha.year(), fecha.month(), numberOfDays);
        Date 		fechaInicio 	= Date.newInstance(fecha.year(), fecha.month(), 1);
        
        Decimal pesoPromedio			= 0;
        Decimal porcentajeAlcanzadoPeso = 0;
        
        if(sumatorias[0].get('expr0') != null){
            pesoPromedio = (Decimal)sumatorias[0].get('expr0');
        }
        
        System.debug('==>pesoPromedio: ' + pesoPromedio);
        System.debug('==>pesoObjetivo: ' + pesoObjetivo);
        
        porcentajeAlcanzadoPeso = (pesoPromedio/pesoObjetivo)*100;
        
        System.debug('==>porcentajeAlcanzadoPeso: ' + porcentajeAlcanzadoPeso);
        System.debug('======FIN getPesoPromedio=====');
        
        return porcentajeAlcanzadoPeso;
    }
    
    public static List<Decimal> getObjetivosVolumenPeso (String anio){
        Objetivos_M3_y_Kg__mdt mObj= [SELECT Id, AnioObjetivo__c, Objetivo_Kg__c, Objetivo_volumen__c FROM Objetivos_M3_y_Kg__mdt WHERE AnioObjetivo__c =: anio];
        List<Decimal> objetivosVolumenPesoList = new List<Decimal>();
        
        objetivosVolumenPesoList.add(mObj.Objetivo_Kg__c);
        objetivosVolumenPesoList.add(mObj.Objetivo_volumen__c);
        
        system.debug('objetivosVolumenPesoList[0] KG : ' + objetivosVolumenPesoList[0]);
        system.debug('objetivosVolumenPesoList[1] VOLUMEN : ' + objetivosVolumenPesoList[1]);
    
    	return objetivosVolumenPesoList;
    }
    
    public static decimal getObjetivoProspecto (String experienciaEjec){
        
        Objetivos_Prospectos_y_Opportunidades__mdt objProspecto = [SELECT Id, Joven__c, Maduro__c, Nuevo__c, DeveloperName FROM Objetivos_Prospectos_y_Opportunidades__mdt WHERE DeveloperName = 'Prospectos'];
        
        if(experienciaEjec == 'Nuevo'){
            System.debug('objProspecto.Nuevo__c: ' + objProspecto.Nuevo__c);
            return (Decimal)objProspecto.Nuevo__c;
        }else if(experienciaEjec == 'Joven'){
            System.debug('objProspecto.Joven__c: ' + objProspecto.Joven__c);
            return (Decimal)objProspecto.Joven__c;
        }else{
            System.debug('objProspecto.Maduro__c: ' + objProspecto.Maduro__c);
            return (Decimal)objProspecto.Maduro__c;
        }
        
    }
    
    public static Decimal getObjetivoOportunidad (String experienciaEjec){
        
        Objetivos_Prospectos_y_Opportunidades__mdt objProspecto = [SELECT Id, Joven__c, Maduro__c, Nuevo__c, DeveloperName FROM Objetivos_Prospectos_y_Opportunidades__mdt WHERE DeveloperName = 'Oportunidades'];
        
        if(experienciaEjec == 'Nuevo'){
            System.debug('objProspecto.Nuevo__c: ' + objProspecto.Nuevo__c);
            return (Decimal)objProspecto.Nuevo__c;            
        }else if(experienciaEjec == 'Joven'){
            System.debug('objProspecto.Joven__c: ' + objProspecto.Joven__c);
            return (Decimal)objProspecto.Joven__c;
        }else{
            System.debug('objProspecto.Maduro__c: ' + objProspecto.Maduro__c);
            return (Decimal)objProspecto.Maduro__c;
        }
    
    }
    
    public static List<AggregateResult> getSumatoriasVentasTotal (Id ejecutivoId, Date fecha){
        
        Integer 	numberOfDays 	= Date.daysInMonth(fecha.year(), fecha.month());
		Date 		fechaFin 		= Date.newInstance(fecha.year(), fecha.month(), numberOfDays);
        Date 		fechaInicio 	= Date.newInstance(fecha.year(), fecha.month(), 1);
        
        return [SELECT  SUM(totalAntesdeImpuestos__c) FROM Ventas__c WHERE fechaId__c >=: fechaInicio AND fechaId__c <=: fechaFin AND ownerId =: ejecutivoId ];
    }
    
    public static List<AggregateResult> getSumatoriasPesoVolumen (Id ejecutivoId, String mesConsulta, String anio){
        
        return [SELECT  SUM(Precio_promedio_Kg__c), SUM(Precio_promedio_M3__c) FROM Historico_KG_M3__c  WHERE Ejecutivo__c =:ejecutivoId AND mes__c =: mesconsulta AND Anio__c =: anio];
    }
    
    // =====================>>> GERENTES, KAMS, GDN y DIR NUEVOS CALCULOS <<<=====================
     
    public static List<AggregateResult> getSumatoriasProductividadEjecutivos (List<Id> usersIdList, String mesConsulta, String anio, Id rtId){
        List<AggregateResult> sumProductividadList = [SELECT 
                                                      SUM (Venta_global_mes__c), 						// 0
                                                      SUM (Venta_global_mes_HE__c), 					// 1
                                                      SUM (Objetivo_prospectos__c), 					// 2
                                                      SUM (Total_prospectos_generados__c),				// 3
                                                      SUM (Objetivo_Oportunidades__c), 					// 4 
                                                      SUM (Total_oportunidades_generadas__c) 			// 5
                                                      FROM Productividad_Ejecutivo__c 
                                                      WHERE Ownerid IN: usersIdList 
                                                      AND Mes__c =:mesconsulta 
                                                      AND Anio__c=: anio 
                                                      AND recordTypeId =: rtId];
        
        System.debug('========= getSumatoriasProductividad() =========');
        System.debug('mesConsulta: ' 								+ mesConsulta);
        System.debug('anio: ' 										+ anio);
        System.debug('rtId: '		 								+ rtId);
        System.debug('LISTA USERS IDLIST: ' 						+ usersIdList.size());
        System.debug('SUMATORIA Venta_global_mes__c: ' 				+ sumProductividadList[0].get('expr0'));
        System.debug('SUMATORIA Venta_global_mes_HE__c: ' 			+ sumProductividadList[0].get('expr1'));
        System.debug('SUMATORIA Objetivo_prospectos__c: ' 			+ sumProductividadList[0].get('expr2'));
        System.debug('SUMATORIA Total_prospectos_generados__c: '	+ sumProductividadList[0].get('expr3'));
        System.debug('SUMATORIA Objetivo_Oportunidades__c: ' 		+ sumProductividadList[0].get('expr4'));
        System.debug('SUMATORIA Total_oportunidades_generadas__c: '	+ sumProductividadList[0].get('expr5'));
        return sumProductividadList;
    }
    
    public static Decimal getValoresGlobalComparativa (List<Id> usersIdList, String mesConsulta, String anio, Id rtId, String comparativa){
        
        Decimal 	porcentajeGlobal 	= 0; 
        
        System.debug('======getPresupuestoGlobal ' + comparativa + '=====');
        System.debug('ejecutivosId:' + usersIdList);
        System.debug('mesconsulta:' + mesconsulta);
        System.debug('anio:' + anio);
        System.debug('rtId:' + rtId);
        System.debug('Comparativa:' + comparativa);
        
        List<AggregateResult> sumPresupuestoGlobalList = [SELECT 
                                                      SUM (Total_presupuesto__c),	 					// 0
                                                      SUM (Total_Tendencia__c ) 						// 1
                                                      FROM Resumen_Tendencia__c 
                                                      WHERE Ownerid IN: usersIdList 
                                                      AND Mes__c =:mesconsulta 
                                                      AND Anio__c=: anio 
                                                      AND recordTypeId = '0122E000000tsSlQAI'
                                                      AND comparativa__c =: comparativa];
        
        
        system.debug('TAMAÑO sumPresupuestoGlobalList: ' + sumPresupuestoGlobalList.size());
        if(sumPresupuestoGlobalList.size()== 1){
            System.debug('TENDENCIA: '+ sumPresupuestoGlobalList[0].get('expr1'));
            System.debug('PRESUPUESTO: '+ sumPresupuestoGlobalList[0].get('expr0'));
        }
        
        if(sumPresupuestoGlobalList.size()== 1 && sumPresupuestoGlobalList[0].get('expr1') != null  && (Decimal)sumPresupuestoGlobalList[0].get('expr0') > 0){
            System.debug('ENTRA IF sumPresupuestoGlobalList.size()== 1');
            porcentajeGlobal = ((Decimal)sumPresupuestoGlobalList[0].get('expr1') / (Decimal)sumPresupuestoGlobalList[0].get('expr0'))*100;
        }
        
        System.debug('porcentajeGlobal: ' + porcentajeGlobal);
        System.debug('======FIN getPresupuestoGlobal=====');
        return porcentajeGlobal;             
    } 
    
    public static Decimal getValorHE (List<AggregateResult> sumProductividadList){
        System.debug('======FIN getValorHE=====');
        if((Decimal)sumProductividadList[0].get('expr0') > 0 && (Decimal)sumProductividadList[0].get('expr1')>0){
            System.debug('ENTRA IF VALORES >0');
            System.debug('VENTA HE 		sumProductividadList[0].get(expr1): ' + sumProductividadList[0].get('expr1'));
            System.debug('VENTA TOTAL 	sumProductividadList[0].get(expr0): ' + sumProductividadList[0].get('expr0'));
            System.debug('RESULTADO DE RETORNO HE: ' + ((Decimal)sumProductividadList[0].get('expr1') / (Decimal)sumProductividadList[0].get('expr0'))*100);
            System.debug('======FIN getPresupuestoGlobal=====');
            return ((Decimal)sumProductividadList[0].get('expr1') / (Decimal)sumProductividadList[0].get('expr0'))*100;
            
        }else{
            System.debug('======FIN getValorHE=====');
            return 0;    
            
        }
        
    }
    
    public static Decimal getValorPROSPECTOS (List<AggregateResult> sumProductividadList){
        System.debug('======getValorPROSPECTOS=====');
        if((Decimal)sumProductividadList[0].get('expr2') >0 && (Decimal)sumProductividadList[0].get('expr3') >0){
            System.debug('ENTRA IF VALORES >0');
            System.debug('SUMA OBJETIVO PROSPECTOS 		sumProductividadList[0].get(expr2): ' + sumProductividadList[0].get('expr2'));
            System.debug('SUMA PROSEPECTOS GENERADOS	sumProductividadList[0].get(expr3): ' + sumProductividadList[0].get('expr3'));
            System.debug('RESULTADO DE RETORNO PROSPECTOS: ' + ((Decimal)sumProductividadList[0].get('expr3') / (Decimal)sumProductividadList[0].get('expr2'))*100);
            System.debug('======FIN getValorPROSPECTOS=====');
            return ((Decimal)sumProductividadList[0].get('expr3') / (Decimal)sumProductividadList[0].get('expr2'))*100;
        }else{
            System.debug('======FIN getValorPROSPECTOS=====');
            return 0;    
        }
    }
    
    public static Decimal getValorOPORTUNIDADES (List<AggregateResult> sumProductividadList){
        System.debug('======getValorOPORTUNIDADES=====');
        if((Decimal)sumProductividadList[0].get('expr4') >0 && sumProductividadList[0].get('expr5') !=null){
            System.debug('ENTRA IF VALORES >0');
            System.debug('SUMA OBJETIVO OPPS  sumProductividadList[0].get(expr4): ' + sumProductividadList[0].get('expr4'));
            System.debug('SUMA OPPS GENERADAS sumProductividadList[0].get(expr5): ' + sumProductividadList[0].get('expr5'));
            System.debug('RESULTADO DE RETORNO OPPS: ' + ((Decimal)sumProductividadList[0].get('expr5') / (Decimal)sumProductividadList[0].get('expr4'))*100);
            System.debug('======FIN getValorOPORTUNIDADES=====');
            return ((Decimal)sumProductividadList[0].get('expr5') / (Decimal)sumProductividadList[0].get('expr4'))*100;
        }else{
            System.debug('======FIN getValorOPORTUNIDADES=====');
            return 0;    
        }
    }
    
    public static List<Decimal> getValoresKGyM3 (List<Id> usersIdList, String mesConsulta, String anio){
        
        Decimal precioPromKG = 0;
        Decimal alcanceKG	 = 0;
        
        Decimal precioPromM3 = 0;
        Decimal alcanceM3	 = 0;
        
        List<Decimal> ObjetivosKGyM3 = getObjetivosVolumenPeso(anio); // [0] KG y [1] M3
        List<Decimal> valoresKGyM3 = new List<Decimal>();
            
        List<AggregateResult> sumKGyM3 = [SELECT  	SUM(Total_antes_de_impuestos__c), 
                                          			SUM(Peso__c),
                                          			SUM(Volumen__c)
                                          FROM Historico_KG_M3__c  
                                          WHERE Ejecutivo__c IN:usersIdList 
                                          AND mes__c =: mesconsulta 
                                          AND Anio__c =: anio];
        
        
        System.debug('========= getValoresKGyM3 =========');
        System.debug('mesConsulta: ' 							+ mesConsulta);
        System.debug('anio		 : ' 							+ anio);
        System.debug('LISTA USERS IDLIST: ' 					+ usersIdList.size());
        
        if(sumKGyM3.size()>0  && ObjetivosKGyM3.size()>0){
            System.debug('ENTRA IF 433 VALIDACION KGyM3');
            System.debug('SUMATORIA Total_antes_de_impuestos__c: ' 	+ sumKGyM3[0].get('expr0'));
            System.debug('SUMATORIA Peso__c: ' 						+ sumKGyM3[0].get('expr1'));
            System.debug('SUMATORIA Volumen__c: ' 					+ sumKGyM3[0].get('expr2'));
            
            if((Decimal)sumKGyM3[0].get('expr1')>0){
                
                System.debug('ENTRA IF 440 validacion sumKGyM3');
                
            	precioPromKG 	= (Decimal) sumKGyM3[0].get('expr0') / (Decimal) sumKGyM3[0].get('expr1');  
                alcanceKG		= (precioPromKG / ObjetivosKGyM3[0])*100;
                    
                precioPromM3 	= (Decimal) sumKGyM3[0].get('expr0') / (Decimal) sumKGyM3[0].get('expr2');  
                alcanceM3		= (precioPromM3 / ObjetivosKGyM3[1])*100; 
                
                System.debug('Total_antes_de_impuestos__c: ' + sumKGyM3[0].get('expr0'));
                System.debug('================>> KG <<================');
                System.debug('Peso__c: ' 		+ sumKGyM3[0].get('expr1'));
                System.debug('precioPromKG: '	+ (Decimal) sumKGyM3[0].get('expr0') / (Decimal) sumKGyM3[0].get('expr1'));
                System.debug('alcanceKG: ' 		+ (precioPromKG / ObjetivosKGyM3[0])*100);
                System.debug('================>> M3 <<================');
                System.debug('Peso__c: ' 		+ sumKGyM3[0].get('expr2'));
                System.debug('precioPromM3: '	+ (Decimal) sumKGyM3[0].get('expr0') / (Decimal) sumKGyM3[0].get('expr2'));
                System.debug('alcanceM3: ' 		+ (precioPromM3 / ObjetivosKGyM3[1])*100);
                
            }
            
        }    
        
        valoresKGyM3.add(alcanceKG);
        valoresKGyM3.add(alcanceM3);
        System.debug('========= FIN getValoresKGyM3 =========');
        return valoresKGyM3;
    }
    
    // ===========================================================================================
    
    /*public static Productividad_Ejecutivo__c getValoresProductividad (List<Id> usersIdList, List<AggregateResult> sumatoriasProd){
        
        Productividad_Ejecutivo__c pe 			= new Productividad_Ejecutivo__c ();
        pe.Tendencia_Presupuesto__c 			= getPromedioTendenciaGlobal(sumatoriasProd, usersIdList);
        pe.Tendencia_Servicio_Internacional__c 	= getPromedioTendenciaInternacional(sumatoriasProd, usersIdList);
        pe.Tendencia_Servicio_Express__c		= getPromedioTendenciaExpress(sumatoriasProd, usersIdList);
        pe.Tendencia_Venta_Nueva__c 			= getPromedioTendenciaVentaNueva(sumatoriasProd, usersIdList);
        pe.Tendencia_Mantenimiento__c 			= getPromedioTendenciaVentaMantenimiento(sumatoriasProd, usersIdList);
        pe.Herramientas_electronicas__c			= getPromedioHerramientasElectronicas(sumatoriasProd, usersIdList);
        pe.Prospectos_generados__c	 			= getPromedioProspectos(sumatoriasProd, usersIdList);
        pe.Oportunidades_generadas__c 			= getPromedioOportunidades(sumatoriasProd, usersIdList);
        pe.Precio_promedio_Kg__c 				= getPromedioPesoKg(sumatoriasProd, usersIdList);
        pe.Precio_promedio_M3__c 				= getPromedioVolumenM3(sumatoriasProd, usersIdList);
        
        
        return pe;
    }*/
    
    /*public static Decimal getPromedioTendenciaGlobal (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
    	Decimal promedioTendenciaGlobal = 0;
        
        if(sumatoriasProd[0].get('expr0') != null){
            promedioTendenciaGlobal = (Decimal)sumatoriasProd[0].get('expr0') / usersIdList.size();
        }
        
        return promedioTendenciaGlobal;
    }*/
    
    /*public static Decimal getPromedioTendenciaInternacional (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
        Decimal promedioTendenciaInternacional = 0;
        
        if(sumatoriasProd[0].get('expr1') != null){
            promedioTendenciaInternacional = (Decimal)sumatoriasProd[0].get('expr1') / usersIdList.size();
        }
        
        return promedioTendenciaInternacional;
    }*/
    
    /*public static Decimal getPromedioTendenciaExpress (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
    	Decimal promedioTendenciaExpress = 0;
        
        if(sumatoriasProd[0].get('expr2') != null){
            promedioTendenciaExpress = (Decimal)sumatoriasProd[0].get('expr2') / usersIdList.size();
        }
        
        return promedioTendenciaExpress;
    }*/
    
    /*public static Decimal getPromedioTendenciaVentaNueva (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
    	Decimal promedioVentaNueva = 0;
        
        if(sumatoriasProd[0].get('expr3') != null){
            promedioVentaNueva = (Decimal)sumatoriasProd[0].get('expr3') / usersIdList.size();
        }
        
        return promedioVentaNueva;
    }*/
    
    /*public static Decimal getPromedioTendenciaVentaMantenimiento (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
    	Decimal promedioVentaMtto = 0;
        
        if(sumatoriasProd[0].get('expr4') != null){
            promedioVentaMtto = (Decimal)sumatoriasProd[0].get('expr4') / usersIdList.size();
        }
        
        return promedioVentaMtto;
    }*/
    
    /*public static Decimal getPromedioHerramientasElectronicas (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
        Decimal promedioHerramientasElectronicas = 0;
    
        if(sumatoriasProd[0].get('expr5') != null){
            promedioHerramientasElectronicas = (Decimal)sumatoriasProd[0].get('expr5') / usersIdList.size();
        }
        
        return promedioHerramientasElectronicas;
    }*/
    
    /*public static Decimal getPromedioProspectos (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
    	Decimal promedioProspectos = 0;
        
        if(sumatoriasProd[0].get('expr6') != null){
            promedioProspectos = (Decimal)sumatoriasProd[0].get('expr6') / usersIdList.size();
        }
        
        return promedioProspectos;
    }*/
   
    /*public static Decimal getPromedioOportunidades (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
        Decimal promedioOportunidades = 0;
        
        if(sumatoriasProd[0].get('expr7') != null){
            promedioOportunidades = (Decimal)sumatoriasProd[0].get('expr7') / usersIdList.size();
        }
        
        return promedioOportunidades;
    }*/
    
    /*public static Decimal getPromedioPesoKg (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
    	Decimal promedioPesoKg = 0;
        
        if(sumatoriasProd[0].get('expr8') != null){
            promedioPesoKg = (Decimal)sumatoriasProd[0].get('expr8') / usersIdList.size();
        }
        
        return promedioPesoKg;
    }*/
    
    /*public static Decimal getPromedioVolumenM3 (List<AggregateResult> sumatoriasProd, List<Id> usersIdList){
    	Decimal promedioVolumenM3 = 0;    
        
        if(sumatoriasProd[0].get('expr9') != null){
            promedioVolumenM3 = (Decimal)sumatoriasProd[0].get('expr9') / usersIdList.size();
        }
        
        return promedioVolumenM3;
    }*/
    
    public static List<AggregateResult> getSumatoriasProductividad (List<Id> usersIdList, String mesConsulta, String anio, Id rtId){
        List<AggregateResult> sumProductividadList = [SELECT 
                                                      SUM (Tendencia_Presupuesto__c), 					// 0
                                                      SUM (Tendencia_Servicio_Internacional__c), 		// 1
                                                      SUM (Tendencia_Servicio_Express__c), 				// 2
                                                      SUM (Tendencia_Venta_Nueva__c), 					// 3
                                                      SUM (Tendencia_Mantenimiento__c), 				// 4 
                                                      SUM (Herramientas_electronicas__c),  				// 5
                                                      SUM (Prospectos_generados__c), 					// 6
                                                      SUM (Oportunidades_generadas__c), 				// 7
                                                      SUM (Precio_promedio_Kg__c), 						// 8
                                                      SUM (Precio_promedio_M3__c)						// 9
                                                      FROM Productividad_Ejecutivo__c 
                                                      WHERE Ownerid IN: usersIdList 
                                                      AND Mes__c =:mesconsulta AND Anio__c=: anio AND recordTypeId =: rtId];

        System.debug('========= getSumatoriasProductividad() =========');
        System.debug('mesConsulta: ' 						+ mesConsulta);
        System.debug('mesConsulta: ' 						+ anio);
        System.debug('mesConsulta: ' 						+ rtId);
        System.debug('LISTA USERS IDLIST: ' 				+ usersIdList.size());
        System.debug('SUMATORIA PRESUPUESTO: ' 				+ sumProductividadList[0].get('expr0'));
        System.debug('SUMATORIA SERVICIO INTERNACIONAL: ' 	+ sumProductividadList[0].get('expr1'));
        System.debug('SUMATORIA EXPRESS: ' 					+ sumProductividadList[0].get('expr2'));
        System.debug('SUMATORIA NUEVA: ' 					+ sumProductividadList[0].get('expr3'));
        System.debug('SUMATORIA MANTENIMIENTO: ' 			+ sumProductividadList[0].get('expr4'));
        System.debug('SUMATORIA HERRAMIENTAS ELECTRONICAS: '+ sumProductividadList[0].get('expr5'));
        System.debug('SUMATORIA PROSPECTOS: ' 				+ sumProductividadList[0].get('expr6'));
        System.debug('SUMATORIA OPORTUNIDADES: ' 			+ sumProductividadList[0].get('expr7'));
        System.debug('SUMATORIA KG: ' 						+ sumProductividadList[0].get('expr8'));
        System.debug('SUMATORIA M3: ' 						+ sumProductividadList[0].get('expr9'));
        return sumProductividadList;
    }
    public static void generaSolicitudEmail(String mensaje, String strClase, Integer strLinea){
        try{
            List<string> toAddress              = new List<string>{'rreyes@paquetexpress.com.mx','sramirez@freewayconsulting.com'};
            Messaging.SingleEmailMessage mail   = new Messaging.SingleEmailMessage();
            String strTemplate                  = 'Error ocurrido en ' + strClase + '. El error es: ' + mensaje + '. Línea: ' + strLinea;
            mail.setToAddresses(toAddress);
            mail.setSubject('Cotización autorizada');
            mail.setHTMLBody(strTemplate);
            mail.setWhatId('a162f000000RFQe');
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);
            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            allmsg.add(mail);
            Messaging.sendEmail(allmsg,false);
        }catch (Exception e){
            system.debug('Error al mandar correo de error productividad ejecutivo: ' + e + '. Línea: ' +  e.getlinenumber() + '. Causa: ' + e.getCause());
        }

    }
}
