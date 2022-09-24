@isTest (SeeAllData=true)
global class GrabadoDocenLinea_Test{
    @isTest
    static void test_GrabadoCostosFijos(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();  
        mock.setStaticResource('respuestaCostosFijos');        
        Test.setMock(HttpCalloutMock.class, mock);    
        /*SBQQ__QUOTE__C Quote = [SELECT Id,Tipo_de_documentacion__c, SBQQ__Account__c, SBQQ__Account__r.Id_SIpWeb__c, Modelo_de_tarifas__c, Acuse__c, AcuseCosto__c, TipoCotizacion__c, Destinos__c, SBQQ__Status__c, OwnerId, Flujo_del_mes__c, Descuento_prepago_unico__c,
                                Confirmacion_de_Grabado_Unico__c, Plaza__c, Name, Servicios_adicionales__c, SBQQ__Opportunity2__r.StageName, SBQQ__Account__r.Plaza_Envio__r.Name, SBQQ__Account__r.Plaza_Facturacion__r.name FROM SBQQ__Quote__c WHERE ID = 'a136s000000O7RBAA0'];//Q-42977 QA*/
        SBQQ__QUOTE__C Quote = [SELECT Id,Tipo_de_documentacion__c, SBQQ__Account__c, SBQQ__Account__r.Id_SIpWeb__c, Modelo_de_tarifas__c, Acuse__c, AcuseCosto__c, TipoCotizacion__c, Destinos__c, SBQQ__Status__c, OwnerId, Flujo_del_mes__c, Descuento_prepago_unico__c,
                                Confirmacion_de_Grabado_Unico__c, Plaza__c, Name, Servicios_adicionales__c, SBQQ__Opportunity2__r.StageName, SBQQ__Account__r.Plaza_Envio__r.Name, SBQQ__Account__r.Plaza_Facturacion__r.name FROM SBQQ__Quote__c WHERE ID = 'a132E000008ijy8QAA']; //Q-38305
        PageReference pageRef = Page.GrabadoDocEnLinea;
        Apexpages.StandardController sc = new Apexpages.StandardController(Quote);
        pageRef.getParameters().put('recordId', Quote.Id);//'cas',presupuesto
        pageRef.getParameters().put('SBQQ__Quote__c.Tipo_de_documentacion__c',Quote.Tipo_de_documentacion__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.SBQQ__Account__r.Id_SIpWeb__c',Quote.SBQQ__Account__r.Id_SIpWeb__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.SBQQ__Status__c',Quote.SBQQ__Status__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.OwnerId',Quote.OwnerId);//
        pageRef.getParameters().put('SBQQ__Quote__c.Plaza__c',Quote.Plaza__c);
        pageRef.getParameters().put('SBQQ__Quote__c.Name',Quote.Name);
        pageRef.getParameters().put('SBQQ__Quote__c.Name',Quote.Servicios_adicionales__c);
        Test.startTest();        
        GrabadoDocEnLinea gc = new GrabadoDocEnLinea(sc);
        //PageReference result = gc.procesar(); 
        //gc.ValidacionDocLinea(Quote);      
        Test.setCurrentPage(pageRef);
        Test.stopTest();         
    }
    @isTest
    static void test_GrabadoCostoBaseGMP(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();  
        mock.setStaticResource('respuestaCostosFijos');        
        Test.setMock(HttpCalloutMock.class, mock);    
        /*SBQQ__QUOTE__C Quote = [SELECT Id,Tipo_de_documentacion__c, SBQQ__Account__c, SBQQ__Account__r.Id_SIpWeb__c, Modelo_de_tarifas__c, Acuse__c, AcuseCosto__c, TipoCotizacion__c, Destinos__c, SBQQ__Status__c, OwnerId, Flujo_del_mes__c, Descuento_prepago_unico__c,
                                Confirmacion_de_Grabado_Unico__c, Plaza__c, Name, Servicios_adicionales__c, SBQQ__Opportunity2__r.StageName, SBQQ__Account__r.Plaza_Envio__r.Name , SBQQ__Account__r.Plaza_Facturacion__r.name FROM SBQQ__Quote__c WHERE ID = 'a136s000000O7RGAA0']; //Q-42978*/
        SBQQ__QUOTE__C Quote = [SELECT Id,Tipo_de_documentacion__c, SBQQ__Account__c, SBQQ__Account__r.Id_SIpWeb__c, Modelo_de_tarifas__c, Acuse__c, AcuseCosto__c, TipoCotizacion__c, Destinos__c, SBQQ__Status__c, OwnerId, Flujo_del_mes__c, Descuento_prepago_unico__c,
                                Confirmacion_de_Grabado_Unico__c, Plaza__c, Name, Servicios_adicionales__c, SBQQ__Opportunity2__r.StageName, SBQQ__Account__r.Plaza_Envio__r.Name, SBQQ__Account__r.Plaza_Facturacion__r.name FROM SBQQ__Quote__c WHERE ID = 'a132E000008ikWVQAY']; //Q38419
        PageReference pageRef = Page.GrabadoDocEnLinea;
        Apexpages.StandardController sc = new Apexpages.StandardController(Quote);
        pageRef.getParameters().put('recordId', Quote.Id);//'cas',presupuesto
        pageRef.getParameters().put('SBQQ__Quote__c.Tipo_de_documentacion__c',Quote.Tipo_de_documentacion__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.SBQQ__Account__r.Id_SIpWeb__c',Quote.SBQQ__Account__r.Id_SIpWeb__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.SBQQ__Status__c',Quote.SBQQ__Status__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.OwnerId',Quote.OwnerId);//
        pageRef.getParameters().put('SBQQ__Quote__c.Plaza__c',Quote.Plaza__c);
        pageRef.getParameters().put('SBQQ__Quote__c.Name',Quote.Name);
        pageRef.getParameters().put('SBQQ__Quote__c.Name',Quote.Servicios_adicionales__c);
        Test.startTest();        
        GrabadoDocEnLinea gc = new GrabadoDocEnLinea(sc);
        //PageReference result = gc.procesar(); 
        //gc.ValidacionDocLinea(Quote);      
        Test.setCurrentPage(pageRef);
        Test.stopTest();         
    }
    @isTest
    static void test_GrabadoCostosFijos2(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();  
        mock.setStaticResource('respuestaCostosFijos');        
        Test.setMock(HttpCalloutMock.class, mock);    
        /*SBQQ__QUOTE__C Quote = [SELECT Id,Tipo_de_documentacion__c, SBQQ__Account__c, SBQQ__Account__r.Id_SIpWeb__c, Modelo_de_tarifas__c, Acuse__c, AcuseCosto__c, TipoCotizacion__c, Destinos__c, SBQQ__Status__c, OwnerId, Flujo_del_mes__c, Descuento_prepago_unico__c,
                                Confirmacion_de_Grabado_Unico__c, Plaza__c, Name, Servicios_adicionales__c, SBQQ__Opportunity2__r.StageName, SBQQ__Account__r.Plaza_Envio__r.Name, SBQQ__Account__r.Plaza_Facturacion__r.name FROM SBQQ__Quote__c WHERE ID = 'a136s000000O7RLAA0']; // Q-42979 QA*/
        SBQQ__QUOTE__C Quote = [SELECT Id,Tipo_de_documentacion__c, SBQQ__Account__c, SBQQ__Account__r.Id_SIpWeb__c, Modelo_de_tarifas__c, Acuse__c, AcuseCosto__c, TipoCotizacion__c, Destinos__c, SBQQ__Status__c, OwnerId, Flujo_del_mes__c, Descuento_prepago_unico__c,
                                Confirmacion_de_Grabado_Unico__c, Plaza__c, Name, Servicios_adicionales__c, SBQQ__Opportunity2__r.StageName, SBQQ__Account__r.Plaza_Envio__r.Name, SBQQ__Account__r.Plaza_Facturacion__r.name FROM SBQQ__Quote__c WHERE ID = 'a132E000008ijzBQAQ']; // Q-38317
        PageReference pageRef = Page.GrabadoDocEnLinea;
        Apexpages.StandardController sc = new Apexpages.StandardController(Quote);
        pageRef.getParameters().put('recordId', Quote.Id);//'cas',presupuesto
        pageRef.getParameters().put('SBQQ__Quote__c.Tipo_de_documentacion__c',Quote.Tipo_de_documentacion__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.SBQQ__Account__r.Id_SIpWeb__c',Quote.SBQQ__Account__r.Id_SIpWeb__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.SBQQ__Status__c',Quote.SBQQ__Status__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.OwnerId',Quote.OwnerId);//
        pageRef.getParameters().put('SBQQ__Quote__c.Plaza__c',Quote.Plaza__c);
        pageRef.getParameters().put('SBQQ__Quote__c.Name',Quote.Name);
        pageRef.getParameters().put('SBQQ__Quote__c.Name',Quote.Servicios_adicionales__c);
        Test.startTest();        
        GrabadoDocEnLinea gc = new GrabadoDocEnLinea(sc);
        //PageReference result = gc.procesar(); 
        //gc.ValidacionDocLinea(Quote);      
        Test.setCurrentPage(pageRef);
        gc.GrabarTarifaDocLinea();
        Test.stopTest();         
    }
    @isTest
    static void test_GrabadoCostoBaseGMP1(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();  
        mock.setStaticResource('respuestaCostosFijos');        
        Test.setMock(HttpCalloutMock.class, mock);    
        /*SBQQ__QUOTE__C Quote = [SELECT Id,Tipo_de_documentacion__c, SBQQ__Account__c, SBQQ__Account__r.Id_SIpWeb__c, Modelo_de_tarifas__c, Acuse__c, AcuseCosto__c, TipoCotizacion__c, Destinos__c, SBQQ__Status__c, OwnerId, Flujo_del_mes__c, Descuento_prepago_unico__c,
                                Confirmacion_de_Grabado_Unico__c, Plaza__c, Name, Servicios_adicionales__c, SBQQ__Opportunity2__r.StageName, SBQQ__Account__r.Plaza_Envio__r.Name, SBQQ__Account__r.Plaza_Facturacion__r.name FROM SBQQ__Quote__c WHERE ID = 'a136s000000O7RQAA0'];//Q-42980 QA*/
        SBQQ__QUOTE__C Quote = [SELECT Id,Tipo_de_documentacion__c, SBQQ__Account__c, SBQQ__Account__r.Id_SIpWeb__c, Modelo_de_tarifas__c, Acuse__c, AcuseCosto__c, TipoCotizacion__c, Destinos__c, SBQQ__Status__c, OwnerId, Flujo_del_mes__c, Descuento_prepago_unico__c,
                                Confirmacion_de_Grabado_Unico__c, Plaza__c, Name, Servicios_adicionales__c, SBQQ__Opportunity2__r.StageName, SBQQ__Account__r.Plaza_Envio__r.Name, SBQQ__Account__r.Plaza_Facturacion__r.name FROM SBQQ__Quote__c WHERE ID = 'a132E000008ikSwQAI']; // Q-38399
        PageReference pageRef = Page.GrabadoDocEnLinea;
        Apexpages.StandardController sc = new Apexpages.StandardController(Quote);
        pageRef.getParameters().put('recordId', Quote.Id);//'cas',presupuesto
        pageRef.getParameters().put('SBQQ__Quote__c.Tipo_de_documentacion__c',Quote.Tipo_de_documentacion__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.SBQQ__Account__r.Id_SIpWeb__c',Quote.SBQQ__Account__r.Id_SIpWeb__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.SBQQ__Status__c',Quote.SBQQ__Status__c);//
        pageRef.getParameters().put('SBQQ__Quote__c.OwnerId',Quote.OwnerId);//
        pageRef.getParameters().put('SBQQ__Quote__c.Plaza__c',Quote.Plaza__c);
        pageRef.getParameters().put('SBQQ__Quote__c.Name',Quote.Name);
        pageRef.getParameters().put('SBQQ__Quote__c.Name',Quote.Servicios_adicionales__c);
        Test.startTest();        
        GrabadoDocEnLinea gc = new GrabadoDocEnLinea(sc);
        //PageReference result = gc.procesar();     
        Test.setCurrentPage(pageRef);
        Boolean result = false;
        result = gc.crearUsuarioWeb(Quote, 'A');
        Test.stopTest();         
    }
    @isTest
    static void test1(){
        String var = '';
        var = GrabadoDocEnLinea.obtieneAcuse('Empresa');
        var = GrabadoDocEnLinea.obtieneAcuse('Interno');
        var = GrabadoDocEnLinea.obtieneAcuse('');
        var = GrabadoDocEnLinea.obtieneTipoAcuse('P');
        var = GrabadoDocEnLinea.obtieneTipoAcuse('A');
        var = GrabadoDocEnLinea.obtieneTarifaExpress('SEG-DS');
        var = GrabadoDocEnLinea.obtieneTarifaExpress('SEG-2D');
        var = GrabadoDocEnLinea.obtieneTarifa('TARIFA T7-V');
        var = GrabadoDocEnLinea.obtieneTarifa('TARIFA T7-P');
        var = GrabadoDocEnLinea.obtieneTarifa('TARIFA T7');
        var = GrabadoDocEnLinea.obtieneTarifa('');
    }
}
