/**
**/
trigger Oppotunity on Opportunity (after insert, after update) {
    Set<Id> IdAccforUpdate = new Set<Id>();
    List<Account> accList = new List<Account>();
    String M = '';
    if(Trigger.isAfter){
        if(trigger.IsInsert || Trigger.IsUpdate){
            for(Opportunity opp: trigger.New){
                if(opp.stageName == 'Cerrada/Ganada'){
                    IdAccforUpdate.add(opp.AccountId);
                }
            }
            if(IdAccforUpdate.size()>0){
                accList = [SELECT Id, Id_Sipweb__c, RFC_valido__c, Regimen_fiscal_CCP__c, Uso_de_cfdi_CCP__c, RecordType.Name, RFC__c, BillingPostalCode, RazonSocial__c, Nombres__c, ApellidoMaterno__c, ApellidoPaterno__c, RecordTypeId FROM Account WHERE Id IN:IdAccforUpdate];
                if(accList.size()>0){
                    for(Account acc: accList){
                        M = '';
                        M = PAQ_FuncionesGenericas.ValidaDatosFiscales(acc);
                        if( M != ''){
                            Trigger.new[0].addError(M);
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
