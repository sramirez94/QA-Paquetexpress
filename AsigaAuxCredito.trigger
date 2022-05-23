trigger AsigaAuxCredito on Credito__c (before insert, after update) { 
    try{
        if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
            System.debug('Inicia proceso de asiganción de aprobadores: ');
            AuxTriggerAsigaAuxCredito.AsignaAprobadores(Trigger.New);
            System.debug('Termina proceso de asiganción de aprobadores.');
        }
        else if(trigger.isAfter){
            String tipoCredito = [SELECT DeveloperName FROM RecordType WHERE SobjectType = 'Credito__c' AND Id =: Trigger.New[0].RecordTypeId].DeveloperName ;
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
