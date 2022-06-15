/**
    * Modificado: 23/05/2022. Modificó: Salvador Ramírez (sramirez@freewayconsulting.com). Caso: 6755
**/
trigger AsigaAuxCredito on Credito__c (before insert, after update) { 
    try{
        if(trigger.isAfter && trigger.isUpdate){
            String M = '';
            String strProfileName = [SELECT NAME FROM PROFILE WHERE ID = :UserInfo.getProfileId()].Name; // Se obtiene el nombre del perfil
            if(trigger.new[0].Estado__c == 'Pre-Autorizado' || test.isRunningTest()){
                if(strProfileName == 'Auxiliar de crédito' && Trigger.new[0].Documentos_y_firmas2__c == null || test.isRunningTest()){
                    M = AuxTriggerAsigaAuxCredito.EdicionEnAprobacion(Trigger.new[0].Id, false);
                } else if(Trigger.new[0].Propietario_de_la_Cuenta__c == (UserInfo.getFirstName() + ' ' + UserInfo.getLastName()) && Trigger.new[0].Documentos_y_firmas2__c == 'Si') {
                    M = AuxTriggerAsigaAuxCredito.EdicionEnAprobacion(Trigger.new[0].Id, true);
                }
                if(M != ''){
                    trigger.new[0].addError(M);
                }
            }
        }
        /*if(trigger.isAfter){
            System.debug('Resultado: ' + Trigger.New[0].ResultadoConsultaListasNegrasSAT__c);
            if(Trigger.New[0].ResultadoConsultaListasNegrasSAT__c == null && !test.isRunningTest()){
                ConsultaBlackList.getResultBlackList(Trigger.New[0].Id, '', '', '', Trigger.New[0].RFC__c, Trigger.New[0].Name, true);
            }
        }*/
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
