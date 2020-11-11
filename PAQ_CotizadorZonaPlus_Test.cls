@IsTest
public class PAQ_CotizadorzonaPlus_Test {
    public PAQ_CotizadorzonaPlus_Test(){
        
    }
    @IsTest
    static void test_InitialInfo_mthd(){
        Test.startTest();
        	CreateDataRAD();
            Opportunity objOp = [SELECT Id FROM OPPORTUNITY LIMIT 1];
            SBQQ__Quote__c objQ = [SELECT Id FROM SBQQ__Quote__c LIMIT 1];
        	Lead objLead = [SELECT Id FROM LEAD LIMIT 1];
            PAQ_CotizadorZonaPlus_CTR.InitialInfo(objLead.Id, objQ.Id, objOp.Id);
        	PAQ_CotizadorZonaPlus_CTR PQ = new PAQ_CotizadorZonaPlus_CTR();
        Test.stopTest();
    }
    @IsTest
    static void test_getHierarchyUser(){
        Test.startTest();
        	PAQ_CotizadorZonaPlus_CTR.getHierarchyUser();
        Test.stopTest();
    }
    @isTest
    static void Test_getProfileObj(){
        Test.startTest();
        	PAQ_CotizadorZonaPlus_CTR.getProfileObj();
        Test.stopTest();
    }
    @isTest
    static void Test_GeneraClaveAutorizacion(){
        Test.startTest();
        	CreateDataRAD();
        	SBQQ__Quote__c quote = [SELECT Id FROM SBQQ__Quote__c LIMIT 1];
        	PAQ_CotizadorZonaPlus_CTR.GeneraClaveAutorizacion(quote.Id);
        Test.stopTest();
    }
    @isTest
    static void Test_EnviaCorreoAutorizacion(){
        Test.startTest();
 
        	//PAQ_CotizadorZonaPlus_CTR.EnviaCorreoAutorizacion('0062f00000FtKDPAA3','0012f00000Y1IoOAAV', 'CRMSF20201111-1','sramirez@freewayconsulting.com');
        Test.stopTest();
    }
    @isTest
    static void Test_queryQuoteItem(){
        Test.startTest();
        	CreateDataRAD();
        	SBQQ__QuoteLine__c QL = [SELECT Id FROM SBQQ__QuoteLine__c LIMIT 1];
        	PAQ_CotizadorzonaPlus_CTR.queryQuoteItem(QL.Id);
        Test.stopTest();
    }
    @isTest
    static void Test_CreaClaveDeAutorizacion(){
        Test.startTest();
        	CreateDataRAD();
        	SBQQ__Quote__c QL = [SELECT Id FROM SBQQ__Quote__c LIMIT 1];
        	PAQ_CotizadorZonaPlus_CTR.CreaClaveDeAutorizacion(QL.Id);
        Test.stopTest();
    }
    @isTest
    static void Test_sumbitAPP(){
        Test.startTest();
        	CreateDataRAD();
        	SBQQ__Quote__c QL = [SELECT Id FROM SBQQ__Quote__c LIMIT 1];
        	PAQ_CotizadorZonaPlus_CTR.sumbitAPP(QL.Id, '', '');
        Test.stopTest();
    }
    @isTest
    static void Test_saveQuoteConv(){
        Test.startTest();
            Sucursal__c suc = new Sucursal__c();
            suc.Name = 'ver03';
            insert suc;
        	Account cuenta 	= new Account (Name = 'CUENTA PARA PRUEBAS', Industry = 'TECNOLOGIA', Giro__c = 'EQUIPO DE TELECOMUNICACIONES', Sucursal__c = suc.Id, ShippingPostalCode = '0', BillingPostalCode = '0');
        	Opportunity o 	= new Opportunity(CloseDate = Date.today(), Name = 'Oportunidad para test clas', StageName = 'Oportunidad viable', AccountId = cuenta.id);
        	CapacidadSucursal__c Tender = new CapacidadSucursal__c(Name = 'ACA70', Costo__c = 5.77, Nivel__c = 'BAJO', OP__c = 'CAPACIDAD', Largo__c = 300, Ancho__c = 170, Alto__c = 170, Peso__c = 300);
        	Insert Tender;
        	SBQQ__Quote__c quote = new SBQQ__Quote__c(SBQQ__Account__c = cuenta.Id, SBQQ__Opportunity2__c = o.id, Servicios_adicionales__c = 'RAD;',Modelo_de_tarifas__c = 'Tarifa T7 zona plus');
            insert quote;
            /*List<SBQQ__QuoteLine__c> objQL = new List<SBQQ__QuoteLine__c>{new SBQQ__QuoteLine__c(Destiny__c = 'TIJ70', SBQQ__Quantity__c = 1, SBQQ__Description__c = 'TARIMA', Large__c = 35, Width__c = 80, High__c = 80, Weight__c = 95,
                                                             SBQQ__CustomerPrice__c = 493.05, SBQQ__NetPrice__c = 571.94, QuoteTotal__c = 571.94, RAD__c = 208.5, Tarifa__c = 'T7 ZP', SBQQ__Quote__c = quote.Id)};
            insert ObjQL;*/
        	PAQ_CotizadorZonaPlus_CTR.saveQuoteConv(quote, null);
        Test.stopTest();
    }
    public static void CreateDataRAD(){
        Test.setMock(HttpCalloutMock.class, new CallWS_Rastreo_Test());
        Sucursal__c suc = new Sucursal__c();
        suc.Name = 'ver02';
        insert suc;
        Account cuenta 	= new Account (Name = 'CUENTA PARA PRUEBAS', Industry = 'TECNOLOGIA', Giro__c = 'EQUIPO DE TELECOMUNICACIONES', Sucursal__c = suc.id, ShippingPostalCode = '0', BillingPostalCode = '0');
        insert cuenta;
        Opportunity o 	= new Opportunity(CloseDate = Date.today(), Name = 'Oportunidad para test clas', StageName = 'Oportunidad viable', AccountId = cuenta.id);
        insert o;
        CapacidadSucursal__c Tender = new CapacidadSucursal__c(Name = 'TIJ70', Costo__c = 5.77, Nivel__c = 'BAJO', OP__c = 'CAPACIDAD', Largo__c = 300, Ancho__c = 170, Alto__c = 170, Peso__c = 300);
        Insert Tender;
        SBQQ__Quote__c quote = new SBQQ__Quote__c(SBQQ__Account__c = cuenta.Id, SBQQ__Opportunity2__c = o.id, Servicios_adicionales__c = 'RAD;',Modelo_de_tarifas__c = 'Tarifa T7 zona plus');
        insert quote;
        Lead objLead = new Lead(
				LastName = 'Test'
				, LeadSource = 'Referido'
				, Status = 'Nuevo'
				, Company = 'STAR LABS'
				, Email = 'address@email.com'
				, Phone = '1234567890'
				, Otro_telefono__c = '1234567890'
		);
		insert objLead;
        /*SBQQ__QuoteLine__c objQL = new SBQQ__QuoteLine__c(Destiny__c = 'TIJ70', SBQQ__Quantity__c = 1, SBQQ__Description__c = 'TARIMA', Large__c = 35, Width__c = 80, High__c = 80, Weight__c = 95,
                                                         SBQQ__CustomerPrice__c = 493.05, SBQQ__NetPrice__c = 571.94, QuoteTotal__c = 571.94, RAD__c = 208.5, Tarifa__c = 'T7 ZP', SBQQ__Quote__c = quote.Id,
                                                         SBQQ__Discount__c = 0, SBQQ__SpecialPrice__c = 0, PackVolAVG__c = 0, PackWeightAVG__c = 0, FLETE__c = 0, ACK__c = 0, SEG__c = 0, KG_ADICIONAL__c = 0,
                                                         GUIA__c = 0, Rango_KM__c = '', Pack_Seg__c = 0, DiscountAcuse__c = 0, DiscountFlete__c = 0, DiscountRecolection__c = 0, DiscountDelivery__c = 0, DiscountSeg__c = 0,
                                                         Servicio__c = 'Estándar terrestre (STD)', ZonaPlus__c = false);
        insert ObjQL;*/
    }
}
