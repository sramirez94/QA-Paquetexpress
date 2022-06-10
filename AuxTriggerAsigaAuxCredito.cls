/**
**/
public class AuxTriggerAsigaAuxCredito {
    public static void AsignaAprobadores(List<Credito__c> creditos){
        List<Estructura__c> estructuras = new List<Estructura__c>();
    	List<Id> sucursales = new List<Id>();
        List<Account> cuentas = new List<Account>();
        List<Credito__c> montos = new List<Credito__c>();
        for(Credito__c credito : creditos){
            System.debug('Id de la cuenta: ' + credito.Cuenta__c);
            Id cuenta = credito.Cuenta__c;
            cuentas = [SELECT Id, Name, Sucursal__c, Sucursal__r.Name FROM Account WHERE Id=:cuenta];
            system.debug('Tipo de Registro: ' + credito.RecordTypeId);
            system.debug('Estado del crédito: ' + credito.Estado__c);
            if(credito.RecordTypeId == '0122E0000012hrBQAQ' && credito.Estado__c == 'Extensión en proceso'){
                system.debug('ES UNA EXTENSIÓN DE CRÉDITO...');
            	montos = [SELECT Id, RecordType.DeveloperName, Estado__c, Cuenta__c, Cuenta__r.Name, Monto2__c FROM Credito__c 
                          WHERE Cuenta__c =: cuenta
                          AND (RecordType.DeveloperName = 'Alta_de_credito' OR RecordType.DeveloperName = 'Alta_de_credito_M')
                          AND Estado__c = 'Aprobado'];
            }
        }
        if(cuentas.size()>0){
            for(Account acc: cuentas){
                System.debug('Nombre de la cuenta: ' + acc.Name);
                sucursales.add(acc.Sucursal__c);
                System.debug('Id de la sucursal de la cuenta: ' + acc.Sucursal__c);
                System.debug('Nombre de la sucursal de la cuenta: ' + acc.Sucursal__r.Name);
            }
        }
        if(sucursales.size()>0){
            estructuras = [SELECT Id, Sucursal__c, Director_Comercial__c, Gerente_de_Cr_dito__c, Auxiliar_de_Cr_dito__c, Gerente_Sucursal__c FROM Estructura__c WHERE Sucursal__c IN: sucursales];
            if(estructuras.size()>0){
                for(Credito__c credito : creditos){
                    for(Account acc: cuentas){
                        if(credito.Cuenta__c == acc.Id){
                    		for(estructura__c est: estructuras){
                        		if(acc.Sucursal__c == est.Sucursal__c){
                           			credito.Director_Comercial__c = est.Director_Comercial__c;
                            		credito.Gerente_de_credito__c = est.Gerente_de_Cr_dito__c;
                            		credito.Auxiliar_de_credito__c = est.Auxiliar_de_Cr_dito__c;
                                    credito.GerenteSucursal__c = est.Gerente_Sucursal__c;
                        		}
                    		}
                		}
            		}
        		}
        	}
    	}
        system.debug('montos.size(): ' + montos.size());
        if(montos.size()>0){
            for(Credito__c cr: montos){
            	system.debug('Cuenta crédito aprobado: ' + cr.Cuenta__c);
                for(Credito__c credito : creditos){
                	system.debug('Cuenta petición de extensión: ' + credito.Cuenta__c);
                    if(cr.Cuenta__c == credito.Cuenta__c){
                        system.debug('Crédito aprobado == Petición de Extensión');
                        system.debug('Tipo de Crédito a actualizar: ' + credito.RecordTypeId);
                        if(credito.RecordTypeId == '0122E0000012hrBQAQ'){
                            system.debug('Monto del Crédito Aprobado: ' + cr.Monto2__c);
                        	credito.Monto__c = cr.Monto2__c;
                            system.debug('MONTO ASIGNADO');
                        }
                    }
                }
            }
        }
    }
    public static String EdicionEnAprobacion(Id credito, Boolean blnBloquear){
        String result = '';
        try{
            Credito__c[] cr = [SELECT ID FROM Credito__c WHERE ID = :credito];
            if(cr.size() != 0){
                if(!blnBloquear){
                    Approval.UnLockResult[] urList = Approval.Unlock(cr, false);
                    for(Approval.UnLockResult ur : urList){
                        if(!ur.IsSuccess()){for(Database.Error err : ur.getErrors()){result += err.getMessage();}}
                    }
                } else {
                    Approval.LockResult[] lrList = Approval.lock(cr, false);
                    for(Approval.LockResult lr : lrList){
                        if(!lr.IsSuccess()){for(Database.Error err : lr.getErrors()){result += err.getMessage();}}
                    }
                }
            } else {
                result = 'No existe ningúna solicitud de crédito con el ID ' + credito;
            }
        } catch (Exception ex){
            result = 'Error EdicionEnAprobacion: ' + ex.getMessage() + '. Línea: ' + ex.getLineNumber();
        }
        return result;
    }
}
