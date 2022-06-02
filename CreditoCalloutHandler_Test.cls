@isTest
global class CreditoCalloutHandler_Test {
    private static Account generarCuenta(){
        Account acc = new Account();
        acc.Id_SIpWeb__c = 'test';
        acc.Name ='TestAccount';
        acc.BillingPostalCode = '14111';
        acc.Potencial_mensual_de_envios__c = 41;
        acc.Potencial_mensual_Total__c =41;
        acc.Numero__c = 777;
        acc.Colonia__c = 'TestColonia';
        acc.Piso_envio__c = 'test';
        acc.Zona_envio__c= 'Z1';    
        return acc;
    }
    @isTest static void AddCredito(){
        Sucursal__c s = new Sucursal__c();
        insert s;
        Account acc = generarCuenta();
        acc.Sucursal__c = s.Id;
        insert acc;
        
        Map<String,String> mapRecordTypes = getRecordTypeByName('Credito__c');
        
        Credito__c c = new Credito__c();        
        c.Cuenta__c = acc.Id;
        c.RecordTypeId = mapRecordTypes.get('Alta_de_credito');
        c.Estado__c = 'Nuevo';
        insert c;
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();        
        //TestUtils.setDoNotRunTrigger();
        mock.setStaticResource('responseCredito');
        mock.setStatusCode(200);        
        Test.setMock(HttpCalloutMock.class, mock);                 
        Test.startTest();            
        CreditoCalloutHandler.enviarAprobacion(c);
        CreditoCalloutHandler.enviarAprobacionWS(c.id);
        Test.stopTest();
    }
    @isTest static void ExtendCredito(){
        Sucursal__c s = new Sucursal__c();
        insert s;
        Account acc = generarCuenta();
        acc.Sucursal__c = s.Id;        
        acc.Id_SIpWeb__c = 'test';
        insert acc;
       
        Map<String,String> mapRecordTypes = getRecordTypeByName('Credito__c');
        
        Credito__c c = new Credito__c();
        c.Cuenta__c = acc.Id;
        c.RecordTypeId = mapRecordTypes.get('Alta_de_credito');
        c.Estado__c = 'Pre-Autorizado';
        
        insert c;
        
        Cuenta_Hija__c ch = new Cuenta_Hija__c();
        ch.Credito__c = c.Id;
        insert ch;
        
        c.Estado__c = 'Aprobado';
        update c;
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();        
        //TestUtils.setDoNotRunTrigger();
        mock.setStaticResource('responseCredito');
        mock.setStatusCode(200);        
        Test.setMock(HttpCalloutMock.class, mock);                 
        Test.startTest();            
        CreditoCalloutHandler.enviarSuspExtension(c, 'Extension_de_credito');        
        Test.stopTest();
    }
    
    @isTest static void CancelCredito(){
        Sucursal__c s = new Sucursal__c();
        insert s;
        Account acc = generarCuenta();
        acc.Sucursal__c = s.Id;
        acc.Id_SIpWeb__c = 'test';
        insert acc;
        
        Map<String,String> mapRecordTypes = getRecordTypeByName('Credito__c');
        
        Credito__c c = new Credito__c();
        c.Cuenta__c = acc.Id;
        c.Estado__c = 'Aprobado';
        
        insert c;
        Cuenta_Hija__c ch = new Cuenta_Hija__c();
        ch.Credito__c = c.Id;
        insert ch;
        
        
        c.RecordTypeId = mapRecordTypes.get('Cancelacion_de_Credito');
        c.Estado__c = 'Cancelación aprobada';
        update c;
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();        
        //TestUtils.setDoNotRunTrigger();
        mock.setStaticResource('responseCredito');
        mock.setStatusCode(200);        
        Test.setMock(HttpCalloutMock.class, mock);                 
        Test.startTest();            
		CreditoCalloutHandler.enviarSuspExtension(c, 'Cancelacion_de_Credito');
        Test.stopTest();
    }
    
    public static Map<String,Id> getRecordTypeByName(String sObjectType){
        Map<String,Id> result = new Map<String,Id>();
        for(RecordType rt : [Select id, Name, DeveloperName from RecordType where sObjectType=:sObjectType]){
            result.put(rt.DeveloperName, rt.id); 
        }
        return result;
    }
}
