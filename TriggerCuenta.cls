/**
 * Modificó: Salvador Ramírez (sramirez@freewayconsulting.com). Fecha: 12/04/2022. Caso: 6596. Se genera un nuevo caso para poder generar una nueva regla de colaboración para que los gerentes de sucursal puedan visualizar las cuentas de su sucursal
 * Modificó: Salvador Ramírez (sramirez@freewayconsulting.com). Fecha: 25/05/2022. Se agrega llamado a clase ValidaRFC para llamar WS que valide que el RFC sea correcto.
**/
public class TriggerCuenta {
    public Static Boolean blnRFCValido;
	public static void genera_Gerente_KAM(List<Account> accList){
        Set<Id> sucursalesId = new Set<Id>();
		List<Estructura__c> estructurasList = new List<Estructura__c>();
        List<Estructura__c> estructuraUser = new List<Estructura__c>();
        List<User> PlazaUser = new List<User>();
        List<String> Plazas = new List<String>();
        for(Account acc: accList){
            if(acc.Sucursal__c != null){
                sucursalesId.add(acc.Sucursal__c);
            }
        }
        if(sucursalesId.size()>0){
            estructurasList = [SELECT Id, Sucursal__c, Gerente_Sucursal__c, KAM_regional__c, Gerente_desarrollo_de_negocios__c FROM Estructura__c WHERE Sucursal__c IN: sucursalesId];
            if(estructurasList.size()>0){
            	for(Account acc: accList){
                    for(estructura__c est: estructurasList){
                        if(acc.Sucursal__c == est.Sucursal__c){
                            acc.Gerente_de_sucursal__c = est.Gerente_Sucursal__c;
                            acc.KAM_Regional__c = est.KAM_regional__c;
                            acc.Gerente_de_Desarrollo_de_Negocios__c = est.Gerente_desarrollo_de_negocios__c;
                        }
                    }
                }
            }
        }
        //Asigna gerente, kam y gdn para el usuario que se quiere asignar
		for(Account acc: accList){
            if(acc.Usuario_a_asignar__c != null){
				PlazaUser = [SELECT Id, Plaza__c FROM User WHERE Id=: acc.Usuario_a_asignar__c];
                System.debug('datos: ' + acc.Usuario_a_asignar__c);
            	Plazas.add(PlazaUser[0].Plaza__c);
            	System.debug('Plaza del usuario: ' + PlazaUser[0].Plaza__c);
            }
        }
        if(Plazas.size()>0){
            estructuraUser = [SELECT Id, Gerente_Sucursal__c, KAM_regional__c, Gerente_desarrollo_de_negocios__c, Plaza_sucursal__c FROM Estructura__c WHERE Plaza_sucursal__c IN: Plazas];
            System.debug('Plazas de estructuras encontradas: ' + estructuraUser.size());
            if(estructuraUser.size()>0){
                for(Account acc: accList){
                    System.debug('Plaza del usuario: ' + PlazaUser[0].Plaza__c);
                    for(estructura__c est: estructuraUser){
                        System.debug('Plaza de la estructura: ' + est.Plaza_sucursal__c);
                        if(acc.Usuario_a_asignar__c == PlazaUser[0].Id && PlazaUser[0].Plaza__c == est.Plaza_sucursal__c){
                            System.debug('Realiza asiganción');
                    		acc.Gerente_de_Sucursal_User__c = est.Gerente_Sucursal__c;
                    		acc.KAM_Regional_User__c = est.KAM_regional__c;
                    		acc.GDN_User__c = est.Gerente_desarrollo_de_negocios__c;
                        }
                    }
                }
            }
        }
    }
    public static void AsignacionEjecutivoNuevo (List<Account> accList, Map<Id, Account> accOldMap){

        String razonSocial;
        String RFC;
        String IdSipweb;
        String Plaza;

		List<String> args = new String[]{'0','number','###,###,##0.00'};

        for(Account acc: accList){
            Account AccOld = accOldMap.get(Acc.Id);

            System.debug('acc.AsignacionRegular_Mantenimiento__c: ' + acc.AsignacionRegular_Mantenimiento__c);
            System.debug('AccOld.AsignacionRegular_Mantenimiento__c: ' + AccOld.AsignacionRegular_Mantenimiento__c);
            System.debug('AccOld.AsignarEjecutivoACuentaEnSipweb__c ' + AccOld.AsignarEjecutivoACuentaEnSipweb__c);
            System.debug('acc.AsignarEjecutivoACuentaEnSipweb__c: ' + acc.AsignarEjecutivoACuentaEnSipweb__c);
            System.debug('acc.AsignacionRegular_Nuevo__c ' + acc.AsignacionRegular_Nuevo__c);
            System.debug('acc.RFC__c: ' + acc.RFC__c);
            System.debug('acc.Preasignar_Ejecutivo__c: ' + acc.Preasignar_Ejecutivo__c);
            System.debug('AccOld.Preasignar_Ejecutivo__c: ' + AccOld.Preasignar_Ejecutivo__c);
            System.debug('Usuario que detona el flujo: '+ UserInfo.getProfileId());

            if(acc.OwnerId == UserInfo.getUserId() && UserInfo.getProfileId() == '00e2E0000016QlkQAE'){
                acc.Usuario_a_asignar__c = acc.OwnerId;
            }

            if(acc.Preasignar_Ejecutivo__c != AccOld.Preasignar_Ejecutivo__c && acc.Preasignar_Ejecutivo__c == true ){
                //system.debug('ENTRA  PREASIGNACION IF 47'); 
                acc.OwnerId = acc.Usuario_a_asignar__c;
                acc.Preasignar_Ejecutivo__c = false;
            }else if (acc.Preasignacion_Mantenimiento__c != AccOld.Preasignacion_Mantenimiento__c && acc.Preasignacion_Mantenimiento__c == true ){
                system.debug('ENTRA  PREASIGNACION IF 47'); 
            }else{
                //INTERNACIONAL
                if(acc.AsignarEjecutivoACuentaEnSipweb__c != AccOld.AsignarEjecutivoACuentaEnSipweb__c 
                   && acc.AsignarEjecutivoACuentaEnSipweb__c == true && acc.Asignacion_Internacional__c == true
                   && acc.MigracionPrepagoADocumentacionEnLinea__c == false && acc.RFC__c != '' && acc.RFC__c != null){
                       if(getValidacionTareas(acc.Id, acc.Usuario_a_asignar__c, acc.CreatedDate) == false){
                           acc.addError('No hay suficientes registros que justifiquen su asignación');
                       }
                   }
                //PREPAGO
                if(acc.AsignarEjecutivoACuentaEnSipweb__c != AccOld.AsignarEjecutivoACuentaEnSipweb__c 
                   && acc.AsignarEjecutivoACuentaEnSipweb__c == true && acc.AsignacionNacionalPrepago__c == true
                   && acc.MigracionPrepagoADocumentacionEnLinea__c == false && acc.RFC__c != '' && acc.RFC__c != null){
                       if(getValidacionTareas(acc.Id, acc.Usuario_a_asignar__c, acc.CreatedDate) == false){
                           acc.addError('No hay suficientes registros que justifiquen su asignación');
                       }
                       if(getValidacionCotizaciones (acc.Id, acc.Usuario_a_asignar__c) == false){
                           acc.addError('No existen cotizaciones que justifiquen su asignación');
                       }
                   }
                // NUEVO
                if(acc.AsignarEjecutivoACuentaEnSipweb__c != AccOld.AsignarEjecutivoACuentaEnSipweb__c
                   && acc.AsignarEjecutivoACuentaEnSipweb__c == true && acc.AsignacionRegular_Nuevo__c == true
                   && acc.MigracionPrepagoADocumentacionEnLinea__c == false && acc.RFC__c != '' && acc.RFC__c != null){
                       System.debug('ENTRA VALIDACION NUEVO');
                       Integer posiciones  = 0;
                       if(acc.Name.length()>= 10){posiciones = 10;}else{posiciones = acc.Name.length();}
                       razonSocial = acc.Name.substring(0, posiciones);
                       if(razonSocial.endsWith(' ')){razonSocial = acc.Name.substring(0, 9);    if(razonSocial.endsWith(' ')){razonSocial = acc.Name.substring(0, 8);    }}
                       RFC			= acc.RFC__c;
                       IdSipweb 	= acc.Id_SIpWeb__c;
                       Plaza		= [SELECT Id, Plaza__c FROM Sucursal__c WHERE Id =: acc.Sucursal__c].Plaza__c;
                       wrapperAsignacionEjecutivoNuevo wAsigEjecNuevo = ValidaAsignacionEjecutivoNuevo (razonSocial, RFC, IdSipweb, Plaza);
                       acc.Validacion_Nuevo__c = wAsigEjecNuevo.valorDeRetorno;
                       System.debug('acc.Validacion_Nuevo__c: ' + acc.Validacion_Nuevo__c);
                       if(acc.Validacion_Nuevo__c == false && acc.OmitirValidacionDeInformacion__c == false){
                           acc.addError('El cliente ya cuenta con ventas mensuales promedio de $ '+ String.format(wAsigEjecNuevo.promedioVentasMensual.format(), args) +', Si está seguro de avanzar bajo el estatus solicitado, marque la casilla De acuerdo con validación de información');       
                       }
                       if(getValidacionTareas(acc.Id, acc.Usuario_a_asignar__c, acc.CreatedDate) == false){
                           acc.addError('No hay suficientes registros que justifiquen su asignación');
                       }
                       if(getValidacionCotizaciones (acc.Id, acc.Usuario_a_asignar__c) == false){
                           acc.addError('No existen cotizaciones que justifiquen su asignación');
                       }

                       if(acc.OmitirValidacionDeInformacion__c == true){
                           acc.Validacion_Nuevo__c = true;
                       }
                       System.debug('Crecimiento: ' + wAsigEjecNuevo.crecimiento);
                       acc.ALERTA_Revisa_su_Venta_existente__c = '<p style="color:red;">El cliente ya cuenta con ventas mensuales promedio de $ '+ String.format(wAsigEjecNuevo.promedioVentasMensual.format(), args) + ' y crecimiento = ' + wAsigEjecNuevo.crecimiento.setScale(2) + ' %</p>';
                   }

                // RECUPERADO
                if(acc.AsignarEjecutivoACuentaEnSipweb__c != AccOld.AsignarEjecutivoACuentaEnSipweb__c
                   && acc.AsignarEjecutivoACuentaEnSipweb__c == true && acc.AsignacionRegular_Recuperado__c == true
                   && acc.RFC__c != '' && acc.RFC__c != null){
                       System.debug('ENTRA VALIDACION RECUPERADO');

                       Integer posiciones  = 0;

                       if(acc.Name.length()>= 10){posiciones = 10;}else{posiciones = acc.Name.length();}

                       razonSocial = acc.Name.substring(0, posiciones);

                       if(razonSocial.endsWith(' ')){razonSocial = acc.Name.substring(0, 9);    if(razonSocial.endsWith(' ')){razonSocial = acc.Name.substring(0, 8);    }}

                       RFC			= acc.RFC__c;
                       IdSipweb 	= acc.Id_SIpWeb__c;
                       Plaza		= [SELECT Id, Plaza__c FROM Sucursal__c WHERE Id =: acc.Sucursal__c].Plaza__c;
                       String mensaje = '';

                       wrapperAsignacionEjecutivoRecuperado wAsigEjecRecuperado  = ValidaAsignacionEjecutivoRecuperado (razonSocial, RFC, IdSipweb, Plaza); 
                       acc.Validacion_Recuperado__c = wAsigEjecRecuperado.valorDeRetorno; 

                       if(acc.Validacion_Recuperado__c == false && acc.OmitirValidacionDeInformacion__c == false){
                           if(wAsigEjecRecuperado.valorVentaMes == null && wAsigEjecRecuperado.otrosIdsConVenta== true){
                               System.debug('ENTRA IF');   
                               mensaje = 'El cliente ya cuenta con ventas mensuales en otros ids de sipweb con la misma razon social';
                               acc.addError('El cliente ya cuenta con ventas mensuales en otros ids de sipweb con la misma razon social, Si está seguro de avanzar bajo el estatus solicitado, marque la casilla De acuerdo con validación de información');
                           }else if(wAsigEjecRecuperado.valorVentaMes != null && wAsigEjecRecuperado.otrosIdsConVenta== true){
                               System.debug('ENTRA IF ELSE');
                               mensaje = 'El cliente ya cuenta con las siguientes 	ventas: ';
                               for(String key: wAsigEjecRecuperado.valorVentaMes.keySet()){
                                   mensaje+= key +' : $ '+ String.format(  wAsigEjecRecuperado.valorVentaMes.get(key).format(), args) + '. ';
                               }
                               mensaje += 'y ventas de otros Ids con el mismo nombre de cuenta. ';
                               acc.addError(mensaje + 'Si está seguro de avanzar bajo el estatus solicitado, marque la casilla De acuerdo con validación de información');
                           }else{
                               System.debug('ENTRA ELSE');
                               mensaje = 'El cliente ya cuenta con las siguientes 	ventas: ';
                               for(String key: wAsigEjecRecuperado.valorVentaMes.keySet()){
                                   mensaje+= key +' : $ ' +String.format( wAsigEjecRecuperado.valorVentaMes.get(key).format(), args) + '. ';
                               }
                               acc.addError(mensaje + 'Si está seguro de avanzar bajo el estatus solicitado, marque la casilla De acuerdo con validación de información');
                           }
                       }
                       System.debug('MENSAJE: ' +  mensaje);
                        if(getValidacionTareas(acc.Id, acc.Usuario_a_asignar__c, acc.CreatedDate) == false){acc.addError('No hay suficientes registros que justifiquen su asignación');}
                        if(getValidacionCotizaciones (acc.Id, acc.Usuario_a_asignar__c) == false){acc.addError('No existen cotizaciones que justifiquen su asignación');}
                        if(acc.OmitirValidacionDeInformacion__c == true){
                           if(wAsigEjecRecuperado.valorVentaMes == null && wAsigEjecRecuperado.otrosIdsConVenta== true){
                               mensaje = 'El cliente ya cuenta con ventas mensuales en otros ids de sipweb con la misma razon social';
                           }else if(wAsigEjecRecuperado.valorVentaMes != null && wAsigEjecRecuperado.otrosIdsConVenta== true){
                               mensaje = 'El cliente ya cuenta con las siguientes 	ventas: ';
                               for(String key: wAsigEjecRecuperado.valorVentaMes.keySet()){mensaje+= key +' : $ '+String.format( wAsigEjecRecuperado.valorVentaMes.get(key).format(), args) + '. ';}
                               mensaje += 'y ventas de otros Ids con el mismo nombre de cuenta. ';
                           }else{
                               mensaje = 'El cliente ya cuenta con las siguientes 	ventas: ';
                               for(String key: wAsigEjecRecuperado.valorVentaMes.keySet()){mensaje+= key +' : $ '+String.format( wAsigEjecRecuperado.valorVentaMes.get(key).format(), args) + '. ';}
                           }
                           acc.Validacion_Recuperado__c = true;
                           acc.ALERTA_Revisa_su_Venta_existente__c  = '<p style="color:red;">' + mensaje +'</p>' ;
                           //acc.AnalisisDeValidacion__c  = '<p style="color:red;">' + mensaje +'</p>' ;
                        }
                   }
                // MIGRACION
                if(acc.AsignarEjecutivoACuentaEnSipweb__c != AccOld.AsignarEjecutivoACuentaEnSipweb__c
                   && acc.AsignarEjecutivoACuentaEnSipweb__c == true && acc.AsignacionRegular_Nuevo__c == true
                   && acc.MigracionPrepagoADocumentacionEnLinea__c == true && acc.RFC__c != '' && acc.RFC__c != null){
                       System.debug('ENTRA VALIDACION MIGRACION');
                       Integer posiciones  = 0;
                       if(acc.Name.length()>= 10){posiciones = 10;}else{posiciones = acc.Name.length();}
                       razonSocial = acc.Name.substring(0, posiciones);
                       if(razonSocial.endsWith(' ')){razonSocial = acc.Name.substring(0, 9); if(razonSocial.endsWith(' ')){razonSocial = acc.Name.substring(0, 8);    }}
                       RFC			= acc.RFC__c;
                       IdSipweb 	= acc.Id_SIpWeb__c;
                       Plaza		= [SELECT Id, Plaza__c FROM Sucursal__c WHERE Id =: acc.Sucursal__c].Plaza__c;
                       String mensaje = '';
                       wrapperAsignacionEjecutivoRecuperado wAsigEjecRecuperado  =  ValidaAsignacionEjecutivoMigracion(razonSocial, RFC, IdSipweb, Plaza); 
                       System.debug('wAsigEjecRecuperado.valorDeRetorno: ' + wAsigEjecRecuperado.valorDeRetorno);
                       System.debug('wAsigEjecRecuperado.otrosIdsConVenta: ' + wAsigEjecRecuperado.otrosIdsConVenta);
                       System.debug('wAsigEjecRecuperado.ventasUltimos6Meses: ' + wAsigEjecRecuperado.ventasUltimos6Meses);
                       if(wAsigEjecRecuperado.valorDeRetorno == false && acc.OmitirValidacionDeInformacion__c == false){
                           if(wAsigEjecRecuperado.valorVentaMes == null && wAsigEjecRecuperado.otrosIdsConVenta== true){
                               System.debug('ENTRA IF');
                               mensaje = 'El cliente ya cuenta con ventas mensuales en otros ids de sipweb con la misma razon social';
                               acc.addError('El cliente ya cuenta con ventas mensuales en otros ids de sipweb con la misma razon social, Si está seguro de avanzar bajo el estatus solicitado, marque la casilla De acuerdo con validación de información');
                           }else if(wAsigEjecRecuperado.valorVentaMes != null && wAsigEjecRecuperado.otrosIdsConVenta== true){
                               System.debug('ENTRA IF ELSE');
                               mensaje = 'El cliente ya cuenta con las siguientes 	ventas: ';
                               for(String key: wAsigEjecRecuperado.valorVentaMes.keySet()){
                                   mensaje+= key +' : $ '+ String.format(wAsigEjecRecuperado.valorVentaMes.get(key).format(), args)+ '. ';
                               }
                               mensaje += 'y ventas de otros Ids con el mismo nombre de cuenta. ';
                               acc.addError(mensaje + 'Si está seguro de avanzar bajo el estatus solicitado, marque la casilla De acuerdo con validación de información');
                           }else{
                               System.debug('ENTRA ELSE');
                               mensaje = 'El cliente ya cuenta con las siguientes 	ventas: ';
                               for(String key: wAsigEjecRecuperado.valorVentaMes.keySet()){
                                   mensaje+= key +' : $ '+ String.format( wAsigEjecRecuperado.valorVentaMes.get(key).format(), args)+ '. ';
                               }
                               acc.addError(mensaje + 'Si está seguro de avanzar bajo el estatus solicitado, marque la casilla De acuerdo con validación de información');
                           }
                       }
                       if(wAsigEjecRecuperado.valorDeRetorno==true){
                           acc.Validacion_Migracion_GERENTE_KAM__c = true;
                           acc.Validacion_Migracion_GERENTE_KAM_AUX__c = false;
                           acc.ValidacionMigracion__c = true;
                       }else{
                           acc.Validacion_Migracion_GERENTE_KAM_AUX__c = true;
                           acc.Validacion_Migracion_GERENTE_KAM__c = false;
                       }
                       if(getValidacionTareas(acc.Id, acc.Usuario_a_asignar__c, acc.CreatedDate) == false){acc.addError('No hay suficientes registros que justifiquen su asignación');}
                       if(getValidacionCotizaciones (acc.Id, acc.Usuario_a_asignar__c) == false){acc.addError('No existen cotizaciones que justifiquen su asignación');}
                       System.debug('MENSAJE: ' +  mensaje);
                       if(acc.OmitirValidacionDeInformacion__c == true){
                           if((wAsigEjecRecuperado.valorVentaMes == null && wAsigEjecRecuperado.otrosIdsConVenta== true) || test.isRunningTest()){
                               mensaje = 'El cliente ya cuenta con ventas mensuales en otros ids de sipweb con la misma razon social';
                           }else if(wAsigEjecRecuperado.valorVentaMes != null && wAsigEjecRecuperado.otrosIdsConVenta== true){
                               mensaje = 'El cliente ya cuenta con las siguientes 	ventas: ';
                               for(String key: wAsigEjecRecuperado.valorVentaMes.keySet()){mensaje+= key +' : $ '+String.format( wAsigEjecRecuperado.valorVentaMes.get(key).format(), args)  + '. ';}
                               mensaje += 'y ventas de otros Ids con el mismo nombre de cuenta. ';
                           }else{
                               mensaje = 'El cliente ya cuenta con las siguientes 	ventas: ';
                               for(String key: wAsigEjecRecuperado.valorVentaMes.keySet()){mensaje+= key +' : $ '+ +String.format( wAsigEjecRecuperado.valorVentaMes.get(key).format(), args)  + '. ';}
                           }
                           acc.ValidacionMigracion__c = true;
                           acc.ALERTA_Revisa_su_Venta_existente__c  = '<p style="color:red;">' +mensaje+'</p>' ;
                           //acc.AnalisisDeValidacion__c  = '<p style="color:red;">' +mensaje+'</p>' ;
                       }
                   }
                //MANTENIMIENTO
                if(acc.AsignarEjecutivoACuentaEnSipweb__c == true  && acc.AsignacionRegular_Mantenimiento__c == true
                   && acc.RFC__c != '' && acc.RFC__c != null ){
                       System.debug('ENTRA VALIDACION MTTO');
                       Integer posiciones  = 0;
                       if(acc.Name.length()>= 10){posiciones = 10;}else{posiciones = acc.Name.length();}
                       razonSocial = acc.Name.substring(0, posiciones);
                       if(razonSocial.endsWith(' ')){razonSocial = acc.Name.substring(0, 9);    if(razonSocial.endsWith(' ')){razonSocial = acc.Name.substring(0, 8);    }}
                       RFC			= acc.RFC__c;
                       IdSipweb 	= acc.Id_SIpWeb__c; 
                       Plaza		= [SELECT Id, Plaza__c FROM Sucursal__c WHERE Id =: acc.Sucursal__c].Plaza__c;
                       acc.PromedioMensualVentas__c = getVentaPromedioMensual (razonSocial, RFC, IdSipweb, Plaza);
                       if(getValidacionTareas(acc.Id, acc.Usuario_a_asignar__c, acc.CreatedDate) == false){		acc.addError('No hay suficientes registros que justifiquen su asignación');
                       }
                       if(getValidacionCotizaciones (acc.Id, acc.Usuario_a_asignar__c) == false){ 	acc.addError('No existen cotizaciones que justifiquen su asignación');
                       }
                       if(acc.Comisi_n_por_Mantenimiento_100__c == false && acc.Comision_diferenciada__c == false && acc.AsignacionRegular_Mantenimiento__c == true){
                       		acc.Comision_directa__c = true;
                       }
                       if(accOld.Comision_directa__c!= acc.Comision_directa__c && acc.Comision_directa__c == true && acc.AsignacionRegular_Mantenimiento__c == true && acc.Porcentaje_de_comision_directa__c == null){
                           acc.Porcentaje_de_comision_directa__c = .50;
                       }
                       system.debug('Porcentaje_de_comision_diferenciada__c: ' + acc.Porcentaje_de_comision_diferenciada__c);
                       system.debug('Porcentaje_de_comision_directa__c: ' + acc.Porcentaje_de_comision_directa__c);
                       if(acc.AsignacionRegular_Mantenimiento__c  == TRUE && ((acc.Comision_diferenciada__c  == TRUE && (acc.Porcentaje_de_comision_diferenciada__c == null || acc.Porcentaje_de_comision_directa__c != null) ))){
                           acc.addError('Si seleccionó Comisión diferenciada introduzca únicamente el porcentaje de comisión diferenciada <= 99%');
                       }else if ( acc.AsignacionRegular_Mantenimiento__c  == TRUE && acc.Comision_directa__c  == TRUE && acc.Porcentaje_de_comision_diferenciada__c != null ){
                           acc.addError('Si seleccionó comisión directa no coloque ningun valor en porcentaje de comisión diferenciada');
                       }else if ( acc.Comision_directa__c  == TRUE && acc.Porcentaje_de_comision_directa__c == null || acc.Porcentaje_de_comision_directa__c == 0){
                           acc.addError('Si seleccionó comisión directa coloque un valor en porcentaje de comisión directa mayor que 0 y menor a 1.5');
                       }
                       else if (acc.Porcentaje_de_comision_diferenciada__c> 99 || acc.Porcentaje_de_comision_directa__c>= 1.5 
                                || acc.Porcentaje_de_comision_diferenciada__c<= 0 || acc.Porcentaje_de_comision_directa__c<= 0){
                                    acc.addError('La comisión diferenciada debe ser <= 99% y el porcentaje de comisión directa debe ser <1.5 y mayor que 0 para ambos casos');
                                }
                   }else{
                       //Validar si se seleccionó mantenimiento, directa. Si %directa= null, guarda 0.5
                       //acc.Porcentaje_de_comision_directa__c = null;
                       if(acc.Comisi_n_por_Mantenimiento_100__c == false && acc.Comision_diferenciada__c == false && acc.AsignacionRegular_Mantenimiento__c == true){acc.Comision_directa__c = true;}
                       if(acc.AsignacionRegular_Mantenimiento__c == true && acc.Comision_directa__c == true && acc.Porcentaje_de_comision_directa__c == null){acc.Porcentaje_de_comision_directa__c = 0.5;}
                   }
                if(AccOld.Sincronizar_con_SW__c != acc.Sincronizar_con_SW__c && acc.Sincronizar_con_SW__c == true){
                    CallWS_AsignaEjecutivo.callGeneraEjecutivo(acc.Id);
                    acc.AsignarEjecutivoACuentaEnSipweb__c=false;
                }
                if(AccOld.AsignarEjecutivoACuentaEnSipweb__c != acc.AsignarEjecutivoACuentaEnSipweb__c && acc.AsignarEjecutivoACuentaEnSipweb__c == true){
                    CallWS_AsignaEjecutivo.callValidaEjecutivo(acc.Id);
                }
            }
        }
    }
    public static void GeneraColaboracionGerenteSucursal(List<Account> accList){
        /*Creada: 12/04/2022. Creó: Salvador Ramírez (sramirez@freewayconsulting.com). Caso: 6596. Descripción: Método creado para generar la regla de colaboración que permita al gerente de sucursal ver la cuenta de su sucursal
                                                                                                                aunque pertenezca a un usuario que no pertenezca a su jerarquía.*/
        List<User> lstUser = new List<User>(); //Salvador Ramírez (sramirez@freewayconsulting.com): Lista para los usuarios gerentes de sucursal
        List<AccountShare> lstInsertAccountShare = new List<AccountShare>(); //Salvador Ramírez (sramirez@freewayconsulting.com): Lista para almacenar las reglas de colaboración que se van a crear
        Map<Id, String> mapSucursal = new Map<Id, String>(); //Salvador Ramírez (sramirez@freewayconsulting.com): Mapa para almacenar la relación entre el usuario y la sucursal
        Id idGerenteSucursal = null;
        try {
            //Salvador Ramírez (sramirez@freewayconsulting.com): Se crean las relaciones entre la cuenta y su sucursal
            for(Account acc:accList){
                mapSucursal.put(acc.id, [SELECT NAME FROM Sucursal__c WHERE ID = :acc.Sucursal__c].Name.substring(0,3));
                System.debug('Sucursal: ' + mapSucursal.get(acc.id));
            }
            for(Account acc: accList){
                String strSucursal = '%' + mapSucursal.get(acc.id).substring(0,3) + '%';//Salvador Ramírez (sramirez@freewayconsulting.com): Se arma el like de la consulta
                System.debug('Like: ' + strSucursal);
                lstUser = [SELECT Id FROM USER WHERE UserRole.name like '%GERENTE%' AND UserRole.Name LIKE :strSucursal]; //Salvador Ramírez (sramirez@freewayconsulting.com): Se busca al gerente de la sucursal por medio de a función
                System.debug('Lista: ' + lstUser);
                if(lstUser.size() > 0){
                    System.debug('Entra');
                    idGerenteSucursal = lstUser[0].Id;
                    System.debug('Id gerente de sucursal: ' + idGerenteSucursal);
                    if([SELECT Id FROM AccountShare where UserOrGroupId = :idGerenteSucursal AND AccountId = :acc.Id].size() == 0){
                        System.debug('Entra 2');
                        //Salvador Ramírez (sramirez@freewayconsulting.com): Si no hay una regla de colaboración para el gerente la crea
                        AccountShare acs = new AccountShare();
                        acs.AccountId = acc.id;
                        acs.UserOrGroupId = idGerenteSucursal;
                        acs.RowCause = 'Manual';
                        acs.AccountAccessLevel = 'Edit';
                        acs.OpportunityAccessLevel = 'Edit';
                        acs.ContactAccessLevel = 'Edit';
                        lstInsertAccountShare.add(acs);
                    }
                }
            }
            if(lstInsertAccountShare.size() > 0){
                insert lstInsertAccountShare;
            }
        } catch (Exception ex) {
            System.debug('Error: ' + ex.getMessage() + '. Línea: ' + ex.getLineNumber());
        }
    }
    public static wrapperAsignacionEjecutivoNuevo ValidaAsignacionEjecutivoNuevo (String razonSocial, String RFC, String IdSipweb, String Plaza){
        List<Ventas__c> ventasList 			= new List<Ventas__c>();
        List<Opportunity> opportunityList	= new List<Opportunity>();
        Decimal sumaVenta 				= 0;
        Decimal promedioMensualVenta 	= 0;
        Decimal sumaOportunidades		= 0;
        Decimal sumaPromedioOpps		= 0;
        Decimal crecimiento 			= 0;
        Integer numberDays = date.daysInMonth(Date.today().Year(), Date.today().Month()-1);
        Date fechaFin = Date.newInstance(Date.today().Year(), Date.today().Month()-1, numberDays);
        system.debug('END_DATE: ' +  fechaFin);
        Date fechaInicio = Date.newInstance(Date.today().Year(), Date.today().Month()-6, 1);
        system.debug('START_DATE: ' +  fechaInicio);
        Boolean valorDeRetorno;
        System.debug('IdSipweb: ' 		+ IdSipweb);
        System.debug('razonSocial: ' 	+ razonSocial);
        System.debug('RFC: ' 			+ RFC);
        System.debug('fechaInicio: ' 	+ fechaInicio);
        System.debug('fechaFin: ' 		+ fechaFin);
		System.debug('Plaza: ' 			+ Plaza);
        ventasList= [SELECT Id, CreatedDate, Cuenta__c, totalAntesdeImpuestos__c, fechaId__c,Cuenta__r.Name, Cuenta__r.RFC__c, Cuenta__r.Id_Sipweb__c, Cuenta__r.Sucursal__r.Plaza__c
                     FROM Ventas__c
                     WHERE Cuenta__r.Name LIKE: '%'+ razonSocial +'%'
                     AND Cuenta__r.RFC__c =: RFC
                     AND fechaId__c >=: fechaInicio
                     AND fechaId__c <=: fechaFin
                     AND Cuenta__r.Sucursal__r.Plaza__c =: Plaza
                     ORDER BY fechaId__c ASC
                    ];
        system.debug('ventasList.size(): ' + ventasList.size());
        if(ventasList.size()==0){
            valorDeRetorno = true;
        }else{
            DateTime getfechePrimeraVenta = ventasList[0].fechaId__c;
            Date fechaPrimeraVenta = date.newinstance(getfechePrimeraVenta.year(), getfechePrimeraVenta.month(), getfechePrimeraVenta.day());
            Integer mesesAPromediar = fechaPrimeraVenta.monthsBetween(fechaFin);
            system.debug('fechePrimeraVenta: ' +  fechaPrimeraVenta);
            system.debug('fechaFin: ' +  fechaFin);
            system.debug('fechaInicio: ' +  fechaInicio);
            system.debug('Entra validación de mesesAPromediar: ' +  mesesAPromediar);
            if(mesesAPromediar == 0){
                mesesAPromediar = 1;
                System.debug('Nuevo Valor de meses = 1');
            } else {
                System.debug('El valor de meses se queda igual = ' + mesesAPromediar);
            }
            for(Ventas__c v: ventasList){sumaVenta += v.totalAntesdeImpuestos__c;
            }
            System.debug('sumaVenta: ' + sumaVenta);
            promedioMensualVenta = sumaVenta / mesesAPromediar;
            System.debug('promedioMensualVenta: ' + promedioMensualVenta);
            Integer contador =0;
            Date fechaInicioO = System.today().addMonths(-6);
        	Date fechaFinO = System.today()+1;
            System.debug('Fecha Inicio O ' + fechaInicioO);
            System.debug('Fecha Fin O ' + fechaFinO);
            for(Opportunity opp: [SELECT Amount, AccountId, Account.Name, Account.RFC__c, CloseDate,
                                  CreatedDate, Account.Id_Sipweb__c, Account.Sucursal__r.Plaza__c,
                                  Potencial_mensual_MXN__c, StageName
                                  FROM 	Opportunity
                                  WHERE Account.Name LIKE: '%'+ razonSocial +'%'
                                  AND   Account.RFC__c =: RFC
                                  AND   CreatedDate >=: fechaInicioO
                                  AND   CreatedDate <=: fechaFinO
                                  AND 	Account.Sucursal__r.Plaza__c =: Plaza
                                  AND  	StageName = 'Cerrada/Ganada']){
                                      sumaOportunidades += opp.Potencial_mensual_MXN__c;
                                      contador++;
                                  }
            if(contador>0){sumaPromedioOpps = sumaOportunidades / contador;
            }else{
                sumaPromedioOpps = 0;
            }
            System.debug('sumaOportunidades: ' 	+ sumaOportunidades);
            System.debug('contador: ' 			+ contador);
            System.debug('sumaPromedioOpps: ' 	+ sumaPromedioOpps);
            if(promedioMensualVenta > 0){crecimiento = (sumaPromedioOpps / promedioMensualVenta) -1;
            } else {
                crecimiento = 0;
            }
            System.debug('crecimiento: ' 		+ crecimiento);
            if(crecimiento >9){valorDeRetorno = false;
            }else{
                valorDeRetorno = false;
                //valorDeRetorno = true;
            }
        }
        wrapperAsignacionEjecutivoNuevo wAsigEjecNuevo = new wrapperAsignacionEjecutivoNuevo();
		wAsigEjecNuevo.valorDeRetorno = valorDeRetorno;
        wAsigEjecNuevo.promedioVentasMensual = promedioMensualVenta;
        wAsigEjecNuevo.crecimiento = crecimiento * 100;
        System.debug('valorDeRetorno: ' + valorDeRetorno);
        return wAsigEjecNuevo;
    }
    public static wrapperAsignacionEjecutivoRecuperado ValidaAsignacionEjecutivoRecuperado (String razonSocial, String RFC, String IdSipweb, String Plaza){
        Map<Integer, String> valorMes = new Map <Integer, String>();
        Map<String, Decimal> valorVentaMes = new Map <String, Decimal>();
        valorMes.put(1, 'ENERO');
        valorMes.put(2, 'FEBRERO');
        valorMes.put(3, 'MARZO');
        valorMes.put(4, 'ABRIL');
        valorMes.put(5, 'MAYO');
        valorMes.put(6, 'JUNIO');
        valorMes.put(7, 'JULIO');
        valorMes.put(8, 'AGOSTO');
        valorMes.put(9, 'SEPTIEMBRE');
        valorMes.put(10, 'OCTUBRE');
        valorMes.put(11, 'NOVIEMBRE');
        valorMes.put(12, 'DICIEMBRE');
       
        List<AggregateResult> ventasListOtrosIds 	= new List<AggregateResult>();
        List<AggregateResult> ventasList6MESES	 	= new List<AggregateResult>();
        List<Opportunity> opportunityList	= new List<Opportunity>();
        
        Decimal sumaVenta 				= 0;
        Decimal promedioMensualVenta 	= 0;
        
        Decimal sumaOportunidades		= 0;
        Decimal sumaPromedioOpps		= 0;
        Decimal crecimiento 			= 0;
        
        Integer mesesAPromediar = 6;
        
        Date fechaInicioANIOACTUAL 	= date.newinstance(Date.today().Year(), 1, 1);
        Date fechaFinANIOACTUAL 	= date.newinstance(Date.today().Year(), 12, 31);
        
        Date fechaInicio6MESES = System.today().addMonths(0);
        Date fechaFin6MESES = System.today().addMonths(-6);
        
        Boolean valorDeRetorno;
        
        System.debug('IdSipweb: ' 				+ IdSipweb);
        System.debug('razonSocial: ' 			+ razonSocial);
        System.debug('RFC: ' 					+ RFC);
        System.debug('fechaInicio 6 MESES: ' 	+ fechaInicio6MESES);
        System.debug('fechaFin 6 MESES: ' 		+ fechaFin6MESES);
		System.debug('Plaza: ' 					+ Plaza);
        
			
        ventasListOtrosIds= [SELECT calendar_month(fechaId__c), Cuenta__c, SUM(totalAntesdeImpuestos__c)   
                     FROM Ventas__c 
                     WHERE Cuenta__r.Name LIKE: '%'+ razonSocial +'%' 
                     AND Cuenta__r.RFC__c =: RFC 
                     AND fechaId__c <=: fechaInicio6MESES 
                     AND fechaId__c >=: fechaFin6MESES
                     AND Cuenta__r.Id_SIpWeb__c !=: IdSipweb
                     AND Cuenta__r.Sucursal__r.Plaza__c =: Plaza
                     GROUP BY calendar_month(fechaId__c), Cuenta__c
                    ]; 
        
        system.debug('ventasListOtrosIds.size(): ' + ventasListOtrosIds.size());
        
        ventasList6MESES= [SELECT calendar_month(fechaId__c), Cuenta__c, SUM(totalAntesdeImpuestos__c)   
                     FROM Ventas__c 
                     WHERE Cuenta__r.Name LIKE: '%'+ razonSocial +'%' 
                     AND Cuenta__r.RFC__c =: RFC 
                     AND fechaId__c <=: fechaInicio6MESES 
                     AND fechaId__c >=: fechaFin6MESES  
                     AND Cuenta__r.Id_SIpWeb__c =: IdSipweb
                     AND Cuenta__r.Sucursal__r.Plaza__c =: Plaza
                     GROUP BY calendar_month(fechaId__c), Cuenta__c
                     ORDER BY calendar_month(fechaId__c)
                    ]; 
        
        system.debug('ventasList6MESES.size(): ' + ventasList6MESES.size());
        
        
        if(ventasList6MESES.size()>0){
            for (AggregateResult ar : ventasList6MESES)  {
                System.debug('MES: ' + ar.get('expr0'));
                System.debug('VALOR: ' + ar.get('expr1'));
                valorVentaMes.put((String)valorMes.get((Integer)ar.get('expr0')), (Decimal)ar.get('expr1'));
            }
        }    
        
        
        wrapperAsignacionEjecutivoRecuperado wAsigEjecRecuperado = new wrapperAsignacionEjecutivoRecuperado ();
        
        
        if(ventasList6MESES.size()>0){wAsigEjecRecuperado.valorVentaMes 	= valorVentaMes;    }
        
        if(ventasListOtrosIds.size()>0 ){wAsigEjecRecuperado.otrosIdsConVenta = true;	        
        }else{
			wAsigEjecRecuperado.otrosIdsConVenta = false;           
        }
        
        if(ventasListOtrosIds.size()>0 || ventasList6MESES.size()>0 ){valorDeRetorno= false;
        }else{
            valorDeRetorno= true;
        }
        
        wAsigEjecRecuperado.valorDeRetorno 	= valorDeRetorno;
        System.debug('valorDeRetorno: ' + valorDeRetorno);
        
        return wAsigEjecRecuperado;
    }
    
    public static wrapperAsignacionEjecutivoRecuperado ValidaAsignacionEjecutivoMigracion (String razonSocial, String RFC, String IdSipweb, String Plaza){
        
        wrapperAsignacionEjecutivoRecuperado wAsigEjecRecuperado = new wrapperAsignacionEjecutivoRecuperado ();
        
        Map<Integer, String> valorMes = new Map <Integer, String>();
        Map<String, Decimal> valorVentaMes = new Map <String, Decimal>();
        valorMes.put(1, 'ENERO');
        valorMes.put(2, 'FEBRERO');
        valorMes.put(3, 'MARZO');
        valorMes.put(4, 'ABRIL');
        valorMes.put(5, 'MAYO');
        valorMes.put(6, 'JUNIO');
        valorMes.put(7, 'JULIO');
        valorMes.put(8, 'AGOSTO');
        valorMes.put(9, 'SEPTIEMBRE');
        valorMes.put(10, 'OCTUBRE');
        valorMes.put(11, 'NOVIEMBRE');
        valorMes.put(12, 'DICIEMBRE');
       
        List<AggregateResult> ventasListANIOACTUAL 	= new List<AggregateResult>();
        List<AggregateResult> ventasList6MESES	 	= new List<AggregateResult>();
        List<Opportunity> opportunityList	= new List<Opportunity>();
        List<String> valoresConsultaMigracion = new List<String>();
        valoresConsultaMigracion.add('DOCUMLINEA');
        valoresConsultaMigracion.add('ECOMMERCE');
        valoresConsultaMigracion.add('SERVICIOWEB');
        
        Decimal sumaVenta 				= 0;
        Decimal promedioMensualVenta 	= 0;
        
        Decimal sumaOportunidades		= 0;
        Decimal sumaPromedioOpps		= 0;
        Decimal crecimiento 			= 0;
        
        Integer mesesAPromediar = 6;
        
        Date fechaInicioANIOACTUAL 	= date.newinstance(Date.today().Year(), 1, 1);
        Date fechaFinANIOACTUAL 	= date.newinstance(Date.today().Year(), 12, 31);
        
        Date fechaInicio6MESES = System.today();
        Date fechaFin6MESES = System.today().addMonths(-6);
        
        Boolean valorDeRetorno;
        
        System.debug('IdSipweb: ' 				+ IdSipweb);
        System.debug('razonSocial: ' 			+ razonSocial);
        System.debug('RFC: ' 					+ RFC);
        System.debug('fechaInicio AÑO ACTUAL: ' + fechaInicioANIOACTUAL);
        System.debug('fechaFin AÑO ACTUAL: ' 	+ fechaFinANIOACTUAL);
        System.debug('fechaInicio 6 MESES: ' 	+ fechaInicio6MESES);
        System.debug('fechaFin 6 MESES: ' 		+ fechaFin6MESES);
		System.debug('Plaza: ' 					+ Plaza);
        
			
        ventasListANIOACTUAL= [SELECT calendar_month(fechaId__c), Cuenta__c, SUM(totalAntesdeImpuestos__c), OrigenDoc__c   
                     FROM Ventas__c 
                     WHERE Cuenta__r.Name LIKE: '%'+ razonSocial +'%' 
                     AND Cuenta__r.RFC__c =: RFC 
                     AND fechaId__c >=: fechaInicioANIOACTUAL 
                     AND fechaId__c <=: fechaFinANIOACTUAL
                     AND Cuenta__r.Sucursal__r.Plaza__c =: Plaza
                     AND OrigenDoc__c IN: valoresConsultaMigracion 
                     GROUP BY calendar_month(fechaId__c), Cuenta__c, OrigenDoc__c
                     ORDER BY calendar_month(fechaId__c)
                    ]; 
        
        system.debug('ventasListANIOACTUAL.size(): ' + ventasListANIOACTUAL.size());
        
        ventasList6MESES= [SELECT calendar_month(fechaId__c), Cuenta__c, SUM(totalAntesdeImpuestos__c) , OrigenDoc__c      
                     FROM Ventas__c 
                     WHERE Cuenta__r.Name LIKE: '%'+ razonSocial +'%' 
                     AND Cuenta__r.RFC__c =: RFC 
                     AND fechaId__c <=: fechaInicio6MESES 
                     AND fechaId__c >=: fechaFin6MESES  
                     //AND Cuenta__r.Id_SIpWeb__c =: IdSipweb
                     AND Cuenta__r.Sucursal__r.Plaza__c =: Plaza
                     AND OrigenDoc__c IN: valoresConsultaMigracion      
                     GROUP BY calendar_month(fechaId__c), Cuenta__c, OrigenDoc__c      
                     ORDER BY calendar_month(fechaId__c)
                    ]; 
        
        system.debug('ventasList6MESES.size(): ' + ventasList6MESES.size());
        
        if(ventasListANIOACTUAL.size()==0 && ventasList6MESES.size()==0){
            valorDeRetorno = true;
        }else{
            if(ventasList6MESES.size()>0){
                for (AggregateResult ar : ventasList6MESES)  {
                    System.debug('MES: ' + ar.get('expr0'));
                    System.debug('VALOR: ' + ar.get('expr1'));
                    valorVentaMes.put((String)valorMes.get((Integer)ar.get('expr0')), (Decimal)ar.get('expr1'));
                }
                wAsigEjecRecuperado.valorVentaMes 	= valorVentaMes;    
            	wAsigEjecRecuperado.ventasUltimos6Meses = true;	
            }else{
                wAsigEjecRecuperado.ventasUltimos6Meses = false;	
            }    
            valorDeRetorno = false;
        } 
                
        if(ventasListANIOACTUAL.size()>0){wAsigEjecRecuperado.otrosIdsConVenta = true;	        
        }else{
			wAsigEjecRecuperado.otrosIdsConVenta = false;           
        }
        
        wAsigEjecRecuperado.ventasUltimos6Meses = true;	
        wAsigEjecRecuperado.valorDeRetorno = valorDeRetorno;
        
        System.debug('valorDeRetorno: ' + valorDeRetorno);
        return wAsigEjecRecuperado;
    }
    
    public static Decimal getVentaPromedioMensual (String razonSocial, String RFC, String IdSipweb, String Plaza){
        
        List<Ventas__c> ventasList 			= new List<Ventas__c>();
        
        Decimal sumaVenta 				= 0;
        Decimal promedioMensualVenta 	= 0;
        
        Integer numberDays = date.daysInMonth(Date.today().Year(), Date.today().Month()-1);
        Date fechaFin = Date.newInstance(Date.today().Year(), Date.today().Month()-1, numberDays);
        system.debug('END_DATE: ' +  fechaFin);
        
        Date fechaInicio = Date.newInstance(Date.today().Year(), Date.today().Month()-6, 1);
        system.debug('START_DATE: ' +  fechaInicio);
        
        Boolean valorDeRetorno;
        
        System.debug('IdSipweb: ' 		+ IdSipweb);
        System.debug('razonSocial: ' 	+ razonSocial);
        System.debug('RFC: ' 			+ RFC);
        System.debug('fechaInicio: ' 	+ fechaInicio);
        System.debug('fechaFin: ' 		+ fechaFin);
		System.debug('Plaza: ' 			+ Plaza);
        
			
        ventasList= [SELECT Id, CreatedDate, Cuenta__c, totalAntesdeImpuestos__c, fechaId__c,Cuenta__r.Name, Cuenta__r.RFC__c, Cuenta__r.Id_Sipweb__c, Cuenta__r.Sucursal__r.Plaza__c   
                     FROM Ventas__c 
                     WHERE Cuenta__r.Name LIKE: '%'+ razonSocial +'%' 
                     AND Cuenta__r.RFC__c =: RFC 
                     AND fechaId__c >=: fechaInicio 
                     AND fechaId__c <=: fechaFin 
                     AND Cuenta__r.Id_SIpWeb__c =: IdSipweb
                     AND Cuenta__r.Sucursal__r.Plaza__c =: Plaza
                     ORDER BY fechaId__c ASC
                    ]; 
        
        system.debug('ventasList.size(): ' + ventasList.size());
        
        if(ventasList.size()==0){
            
            valorDeRetorno = true;
            
        }else{
            
            DateTime getfechePrimeraVenta = ventasList[0].fechaId__c;	
            Date fechaPrimeraVenta = date.newinstance(getfechePrimeraVenta.year(), getfechePrimeraVenta.month(), 1);	
            Integer mesesAPromediar = fechaPrimeraVenta.monthsBetween(fechaFin);
            
            system.debug('fechePrimeraVenta: ' +  fechaPrimeraVenta);
            system.debug('fechaFin: ' +  fechaFin);
            system.debug('fechaInicio: ' +  fechaInicio);
            system.debug('mesesAPromediar: ' +  mesesAPromediar);
            
            if(mesesAPromediar == 0){
                mesesAPromediar = 1;
                System.debug('Nuevo Valor de meses = 1');
            } else {
                System.debug('El valor de meses se queda igual = ' + mesesAPromediar);
            }
            
            for(Ventas__c v: ventasList){sumaVenta += v.totalAntesdeImpuestos__c;                   
            }
            
            System.debug('sumaVenta: ' + sumaVenta);
            
            promedioMensualVenta = sumaVenta / mesesAPromediar;
            System.debug('promedioMensualVenta: ' + promedioMensualVenta);
        }
    
        return promedioMensualVenta;
    }
    
    public static Boolean getValidacionTareas (Id accId, Id usuarioAAsignar, Datetime fechaCreacion){
        
        Boolean validaActividad = false;
        
        System.debug('fechaCreacion: ' + fechaCreacion);
        System.debug('usuarioAAsignar: ' + usuarioAAsignar);
        System.debug('accId: ' + accId);
        
        Account papaId = [SELECT Id, ParentId FROM Account WHERE Id=:accId];
        System.debug('ParentId: ' + papaId.ParentId);
        
        List<Opportunity> oppo = new List<Opportunity>();
        List<String> OppsIds = new List<String>();
        
        if(papaId.ParentId != null) {
        	oppo = [SELECT Id, AccountId, OwnerId FROM Opportunity 
                WHERE (AccountId=:accId OR AccountId=:papaId.ParentId)
                AND OwnerId=:usuarioAAsignar];    
        } else {
        oppo = [SELECT Id, AccountId, OwnerId FROM Opportunity 
                WHERE AccountId=:accId 
                AND OwnerId=:usuarioAAsignar];
        }
        
        System.debug('opportunities: ' + oppo.size());
        
        if(oppo.size() > 0) {
            for(Opportunity o : oppo){
                OppsIds.add(o.Id);
            }
        }
        
        System.debug('OppsIds.size(): ' + OppsIds.size());
        
        List<Task> tareasGeneradas = new List<Task>();
        List<Event> EventosGenerados = new List<Event>();
        
        if(OppsIds.size() > 0){
            if(papaId.ParentId != null){
            	system.debug('ParentId != null');
        		tareasGeneradas = [SELECT Id, OwnerId, CreatedDate, WhatId 
                                      	  FROM Task 
                                      	  WHERE (WhatId =: papaId.ParentId OR WhatId =: accId OR WhatId IN: OppsIds)
                                      	  AND OwnerId =: usuarioAAsignar];
            
            	EventosGenerados = [SELECT Id, OwnerId, CreatedDate, WhatId 
                                        	FROM EVENT 
                                        	WHERE (WhatId =: papaId.ParentId OR WhatId =: accId OR WhatId IN: OppsIds)
                                        	AND OwnerId =: usuarioAAsignar];
        	} else {
        		system.debug('ParentId == null');
        		tareasGeneradas = [SELECT Id, OwnerId, CreatedDate, WhatId 
                                      FROM Task 
                                      WHERE (WhatId =: accId OR WhatId IN: OppsIds)
                                      AND OwnerId =: usuarioAAsignar];
        
        		EventosGenerados = [SELECT Id, OwnerId, CreatedDate, WhatId 
                                        FROM EVENT 
                                        WHERE (WhatId =: accId OR WhatId IN: OppsIds)
                                        AND OwnerId =: usuarioAAsignar];
        	}
            
        } else {
        	if(papaId.ParentId != null){
            	system.debug('ParentId != null');
        		tareasGeneradas = [SELECT Id, OwnerId, CreatedDate, WhatId 
                                      	  FROM Task 
                                      	  WHERE (WhatId =: papaId.ParentId OR WhatId =: accId)
                                      	  AND OwnerId =: usuarioAAsignar];
            
            	EventosGenerados = [SELECT Id, OwnerId, CreatedDate, WhatId 
                                        	FROM EVENT 
                                        	WHERE (WhatId =: papaId.ParentId OR WhatId =: accId)
                                        	AND OwnerId =: usuarioAAsignar];
        	} else {
        		system.debug('ParentId == null');
        		tareasGeneradas = [SELECT Id, OwnerId, CreatedDate, WhatId 
                                      FROM Task 
                                      WHERE WhatId =: accId 
                                      AND OwnerId =: usuarioAAsignar];
        
        		EventosGenerados = [SELECT Id, OwnerId, CreatedDate, WhatId 
                                        FROM EVENT 
                                        WHERE WhatId =: accId 
                                        AND OwnerId =: usuarioAAsignar];
        	}
        }
        
        System.debug('tareasGeneradas.size(): ' + tareasGeneradas.size());
        System.debug('EventosGenerados.size(): ' + EventosGenerados.size());
        
        if((tareasGeneradas.size()>0 || EventosGenerados.size()>0)){
            validaActividad = true;
        }
        
        return validaActividad;
    }
    
    public static Boolean getValidacionCotizaciones (Id accId, Id usuarioAAsignar){
        
        Boolean validaCotizaciones = false;
        
        System.debug('usuarioAAsignar: ' + usuarioAAsignar);
        System.debug('accId: ' + accId);
        
        Account papaId = [SELECT Id, ParentId FROM Account WHERE Id=:accId];
        System.debug('ParentId: ' + papaId.ParentId);
        
        List<SBQQ__Quote__c> cotizacionesGeneradas = new List<SBQQ__Quote__c>();
        
        if(papaId.ParentId != null){
        	system.debug('ParentId != null');
        	cotizacionesGeneradas = [SELECT Id, OwnerId, SBQQ__Account__c FROM SBQQ__Quote__c WHERE SBQQ__Account__c=:papaId.ParentId OR SBQQ__Account__c=:accId];
        } else {
            system.debug('ParentId == null');
            cotizacionesGeneradas = [SELECT Id, OwnerId, SBQQ__Account__c FROM SBQQ__Quote__c WHERE SBQQ__Account__c=:accId];
        }
        
        System.debug('cotizacionesGeneradas.size(): ' + cotizacionesGeneradas.size());
        
        if(cotizacionesGeneradas.size()>0){
            validaCotizaciones = true;
        }
        
        return validaCotizaciones;
    }
    public static void validaRFC(List<Account> lstAcc, Map<Id, Account> accOldMap){
        for(Account acc : lstAcc){
            String strTipo = [SELECT NAME FROM RECORDTYPE WHERE ID = :acc.RecordTypeId].Name;
            String strRFCOld = '';
            if(accOldMap != null){
                strRFCOld = accOldMap.get(acc.Id).RFC__c;
            }
            if(acc.RFC__c != strRFCOld){
                validaRFC.ValidaRFC(acc.id, acc.RFC__c, strTipo);
            }
        }
    }
    public static void pre_asignaEjecutivo (Id accId, Id usuarioAAsignar){
        
    }
    class wrapperAsignacionEjecutivoRecuperado{
    	public Map<String, Decimal> valorVentaMes;
        public Boolean valorDeRetorno;
        public Boolean otrosIdsConVenta;
        public Boolean ventasUltimos6Meses;
    }
    class wrapperAsignacionEjecutivoNuevo{
    	public Boolean valorDeRetorno;
        public Decimal promedioVentasMensual;
        public Decimal crecimiento;
    }
    public class ConsultaRFC{
        public header header;
        public body body;
    }
    public class header{
        public Security security;
    }
    public class Security{
        public String user;
        public String password;
        public Integer type;
        public String token;
    }
    public class body{
        public request request;
        public response response;
    }
    public class request {
        public data data;
    }
    public class data{
        public String rfc;
    }
    public class response{
        public Boolean success;
        public List<messages> messages;
        public dataresponse data;
        public String objectDTO;
    }
    public class dataresponse{
        public String rfcGenerico;
    }
    public class messages{
        public String code;
        public String description;
        public String typeError;
    }
}
