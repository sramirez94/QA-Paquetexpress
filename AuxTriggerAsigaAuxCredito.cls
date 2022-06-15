/**
**/
public class AuxTriggerAsigaAuxCredito {
    public static void AsignaAprobadores(List<Credito__c> creditos){
        List<Id> sucursales                     = new List<Id>();
        List<Credito__c> montos                 = new List<Credito__c>();
        List<String> sucursalesAnalista         = new List<String>();
        List<AnalistaDeCredito__c> lstAnalistas = new List<AnalistaDeCredito__c>();
        List<Account> cuentas                   = new List<Account>();
        for(Credito__c credito : creditos){
            cuentas = [SELECT Id, Sucursal__c, Sucursal__r.name FROM Account WHERE ID = :credito.cuenta__c];
            if(credito.RecordTypeId == '0122E0000012hrBQAQ' && credito.Estado__c == 'Extensión en proceso'){
                system.debug('ES UNA EXTENSIÓN DE CRÉDITO...');
            	montos = [SELECT Id, RecordType.DeveloperName, Estado__c, Cuenta__c, Cuenta__r.Name, Monto2__c FROM Credito__c 
                          WHERE Cuenta__c =: cuenta
                          AND (RecordType.DeveloperName = 'Alta_de_credito' OR RecordType.DeveloperName = 'Alta_de_credito_M')
                          AND Estado__c = 'Aprobado'];
            }
        }
        if(cuentas != null && cuentas.size() > 0){
            for(Account acc: cuentas){
                sucursales.add(acc.Sucursal__c);
                sucursalesAnalista.add(acc.Sucursal__r.name.subString(0,3));
            }
        }
        /*if(sucursalesAnalista != null && sucursalesAnalista.size() > 0){
            lstAnalistas = [SELECT ID, Usuario__c FROM AnalistaDeCredito__c WHERE Sucursal__c in :sucursalesAnalista];
            if(lstAnalistas != null && lstAnalistas.size() > 0){

            }
        }*/
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
