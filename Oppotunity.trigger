/**
**/
trigger Oppotunity on Opportunity (after insert, after update) {
    Set<Id> IdAccforUpdate = new Set<Id>();
    List<Account> accList = new List<Account>();
    if(Trigger.isAfter){
        if(trigger.IsInsert || Trigger.IsUpdate){
            for(Opportunity opp: trigger.New){
                if(opp.stageName == 'Cerrada/Ganada'){
                    system.debug('Oportunidad con ETAPA: ' + opp.StageName);
                    IdAccforUpdate.add(opp.AccountId);
                }
            }
            if(IdAccforUpdate.size()>0){
                System.debug('ENTRA IdAccforUpdate.size()>0');
                system.debug('IdAccforUpdate : ' + IdAccforUpdate);
                accList = [SELECT Id, Id_Sipweb__c, RFC_valido__c, Regimen_fiscal_CCP__c, Uso_de_cfdi_CCP__c FROM Account WHERE Id IN:IdAccforUpdate];
                System.debug('ACC LIST: ' + accList );
                if(accList.size()>0){
                    for(Account acc: accList){
                        if(!acc.RFC_valido__c){
                            Trigger.new[0].addError('Imposible continuar. RFC de la cuenta invalido');
                        }
                        if(acc.Uso_de_cfdi_CCP__c == null || acc.Regimen_fiscal_CCP__c == null){
                            Trigger.new[0].addError('Imposible crear cuenta en sipweb. Defina un uso de CFDI o Régimen fiscal en la cuenta de Salesforce para poder continuar');
                        }
                        System.debug('acc.Id_Sipweb__c : ' + acc.Id_Sipweb__c);
                        if(acc.Id_SIpWeb__c == null || acc.Id_SIpWeb__c == ''){
                            if(!test.isRunningTest()){
                                System.debug('LLAMA WS CON ID ' + acc.Id);
                                CallWS_Cuentas.callCuentas(''+acc.Id, 'add');
                            }
                        }
                    }
                }
            }
        }
    }
}
