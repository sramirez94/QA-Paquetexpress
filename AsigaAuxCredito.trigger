/**
    * Modificado: 23/05/2022. Modificó: Salvador Ramírez (sramirez@freewayconsulting.com). Caso: 6755
**/
trigger AsigaAuxCredito on Credito__c (before insert, after update) { 
    try{
        if(trigger.isBefore && trigger.isUpdate){
            String M = '';
            String strProfileName = [SELECT NAME FROM PROFILE WHERE ID = :UserInfo.getProfileId()].Name; // Se obtiene el nombre del perfil
            System.debug('Concatenado: ' + UserInfo.getFirstName() + ' ' + UserInfo.getLastName() + '. Completo: ' + UserInfo.getName() + '. Nombre del perfil: ' + strProfileName);
            if(strProfileName != 'Administrador del sistema' && strProfileName != 'Auxiliar de crédito'){
                //Solo entrará cuando no sea admin o auxiliar de crédito ya que ellos siempre pueden editar los registros en aprobación
                if(trigger.new[0].Propietario_de_la_Cuenta__c == (UserInfo.getFirstName() + ' ' + UserInfo.getLastName())){
                    //Si el usuario que intenta modificar es el mismo que el propietario de la cuenta.
                    if(trigger.new[0].Estado__c == 'Pre-Autorizado'){
                        //Si el estado es preautorizado
                        M = AuxTriggerAsigaAuxCredito.EdicionEnAprobacion(Trigger.new[0].Id);
                        if(M != ''){
                            
                        }
                    }
                }
            }
        }
        if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
            System.debug('Inicia proceso de asiganción de aprobadores: ');
            AuxTriggerAsigaAuxCredito.AsignaAprobadores(Trigger.New);
            System.debug('Termina proceso de asiganción de aprobadores.');
        }
        else if(trigger.isAfter){
            String tipoCredito = [SELECT DeveloperName FROM RecordType WHERE SobjectType = 'Credito__c' AND Id =: Trigger.New[0].RecordTypeId].DeveloperName;
            if(trigger.isUpdate){
                System.debug('Trigger credito '+Trigger.New[0].Estado__c+' '+tipoCredito);
                if((Trigger.New[0].Estado__c=='Aprobado'||Trigger.New[0].Estado__c=='Extensión aprobada'||Trigger.New[0].Estado__c=='Cancelación aprobada')&&(Trigger.Old[0].Estado__c!=Trigger.New[0].Estado__c)){
                    if(tipoCredito=='Alta_de_credito'||tipoCredito=='Alta_de_credito_M'){
                        
                        //CreditoCalloutHandler.enviarAprobacion(Trigger.New[0]);
                        CreditoCalloutHandler.enviarAprobacionWS(Trigger.New[0].Id);
                    }
                    else if(tipoCredito=='Cancelacion_de_Credito'||tipoCredito=='Extension_de_credito'){
                        CreditoCalloutHandler.enviarSuspExtension(Trigger.New[0],tipoCredito);
                    }
                }
            }
        }
    }
    catch(Exception ex){
		System.debug('AsigaAuxCredito: '+ex.getLineNumber()+' '+ex.getMessage());        
    }
}
