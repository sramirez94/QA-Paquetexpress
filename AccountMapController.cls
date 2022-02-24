/**
 * Modificada: 18/02/2022. Modificó: Salvador Ramírez (sramirez@freewayconsulting.com). Caso 6315. Se mejora el registro de la actualización de coordenadas de las cuentas y de los prospectos
**/
public with sharing class AccountMapController {
  
    @AuraEnabled
    public static String insertVisit( Id account, Decimal lat, Decimal lng, String tipovisita, String nolograda, String lograda) {
        Localizacion__c localizacion=new Localizacion__c(Cliente__c=account, data__Latitude__s=lat, data__Longitude__s=lng);
        if (lograda == 'Si') {
            localizacion.Tipo_de_Visita__c=tipovisita;
        } else {
            if (lograda == 'No') {
                localizacion.Visita_Fallida__c=nolograda;
            }
        }
        Account cuentaseleccionada=[SELECT Id, Name, Location__Latitude__s, Location__Longitude__s from Account WHERE Id=:account LIMIT 1];
        Location actualLocation=Location.newInstance(lat, lng);
        Location accountLocation=Location.newInstance(cuentaseleccionada.Location__Latitude__s, cuentaseleccionada.Location__Longitude__s);
        Double dist = Location.getDistance(actualLocation, accountLocation, 'km');
        localizacion.Inicio__c=System.now();
        if (lograda == 'No') {
            localizacion.Final__c=System.now();
        }
        Id idusuario=UserInfo.getUserId();
        User usuario= [SELECT Id, Visita__c FROM User WHERE Id=:idusuario];
        /*switch on vehiculo {
            when 'Vehículo #1' {
                localizacion.Vehiculo_Utilizado__c='Vehículo #1';
            }  
            when 'Vehículo #2' {
                localizacion.Vehiculo_Utilizado__c='Vehículo #2';
            }
            when else {
                
            }
        }*/
        if (dist<= 0.2) {
          insert localizacion;
            if (lograda == 'Si') {
                usuario.Visita__c=localizacion.Id;
                update usuario;
                return 'exito';
            } else {
                return 'exitonolograda';
            }
              
        } else {
            return 'nocerca';
        }  
    }
    
    @AuraEnabled
    public static String insertVisit2( Id lead, Decimal lat, Decimal lng, String tipovisita, String nolograda, String lograda) {
        Localizacion__c localizacion=new Localizacion__c(Prospecto__c=lead, data__Latitude__s=lat, data__Longitude__s=lng);
        if (lograda == 'Si') {
            localizacion.Tipo_de_Visita__c=tipovisita;
        } else {
            if (lograda == 'No') {
                localizacion.Visita_Fallida__c=nolograda;
            }
        }
        Lead prospectoseleccionado=[SELECT Id, Name, Location__Latitude__s, Location__Longitude__s from Lead WHERE Id=:lead LIMIT 1];
        Location actualLocation=Location.newInstance(lat, lng);
        Location leadLocation=Location.newInstance(prospectoseleccionado.Location__Latitude__s, prospectoseleccionado.Location__Longitude__s);
        Double dist = Location.getDistance(actualLocation, leadLocation, 'km');
        localizacion.Inicio__c=System.now();
        if (lograda == 'No') {
            localizacion.Final__c=System.now();
        }
        Id idusuario=UserInfo.getUserId();
        User usuario= [SELECT Id, Visita__c FROM User WHERE Id=:idusuario];
        if (dist<= 0.2) {
          insert localizacion;
            if (lograda == 'Si') {
                usuario.Visita__c=localizacion.Id;
                update usuario;
                return 'exito';
            } else {
                return 'exitonolograda';
            }
        } else {
            return 'nocerca';
        }
    }
    @AuraEnabled
    public static String endVisit() {
        Id idusuario=UserInfo.getUserId();
        User usuario= [SELECT Id, Visita__c FROM User WHERE Id=:idusuario];
        Id idvisita=usuario.Visita__c;
        Localizacion__c visita=[SELECT Id, Inicio__c, Final__c FROM Localizacion__c WHERE Id=:idvisita];
        visita.Final__c=System.now();
        update visita;
        usuario.Visita__c='';
        update usuario;
    return 'exito';
    }
    @AuraEnabled
    public static String checkVisit() {
        Id idusuario=UserInfo.getUserId();
        User usuario= [SELECT Id, Visita__c FROM User WHERE Id=:idusuario];
        System.debug('usuario visita:' + usuario.Visita__c);
        if (usuario.Visita__c!=null) {
            return 'si';
        } else {
            return 'no';
        }
    }
    @AuraEnabled
    public static String changeLocation(Id account, Decimal lat, Decimal lng) {
        Account cuentaseleccionada=[SELECT Id, Name, Location__Latitude__s, Location__Longitude__s from Account WHERE Id=:account LIMIT 1];
        cuentaseleccionada.Location__Latitude__s=lat;
        cuentaseleccionada.Location__Longitude__s=lng;
        String result = '';
        Database.SaveResult resCuenta = Database.update(cuentaseleccionada, false);
        if(!resCuenta.isSuccess()){
            for(Database.Error errCuenta : resCuenta.getErrors()){
                result += errCuenta.getMessage();
            }
        } else {
            result = 'exito';
        }
        return result;
    }
    @AuraEnabled
    public static String changeLocation2(Id lead, Decimal lat, Decimal lng) {
        Lead prospectoseleccionado=[SELECT Id, Name, Location__Latitude__s, Location__Longitude__s from Lead WHERE Id=:lead LIMIT 1];
        prospectoseleccionado.Location__Latitude__s=lat;
        prospectoseleccionado.Location__Longitude__s=lng;
        update prospectoseleccionado;
        return 'exito';
    }
}
