@Istest (SeeAllData=true)
public class TempleateTriggerHandler_Test {

     @IsTest
    static void TempleateTriggerHandler_Test_mthd(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a136s000000NaBMAA0' ORDER BY CreatedDate DESC LIMIT 1]; //Guía multipieza por destinos, T0 y T1
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if3eQAA' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }
    
    @IsTest
    static void TempleateTriggerHandler_Test_mthd2(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a136s000000NaBRAA0' ORDER BY CreatedDate DESC LIMIT 1]; //Costos fijos por tarifa T7 por volumen y por destinos
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if3oQAA' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.Fecha_de_creacion_sugar__c = Date.newInstance(2018, 12, 9);
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }
    
         @IsTest
    static void TempleateTriggerHandler_Test_mthd3(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a136s000000NaBbAAK' ORDER BY CreatedDate DESC LIMIT 1];
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if56QAA' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }
    
     @IsTest
    static void TempleateTriggerHandler_Test_mthd4(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a136s000000NaBWAA0' ORDER BY CreatedDate DESC LIMIT 1]; // CBME Rangos KM
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if5BQAQ' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.Fecha_de_creacion_sugar__c = Date.newInstance(2018, 12, 9);
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }
    
   /*  @IsTest
    static void TempleateTriggerHandler_Test_mthd5(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008iNNIQA2' ORDER BY CreatedDate DESC LIMIT 1];
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if3eQAA' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }
    
       @IsTest
    static void TempleateTriggerHandler_Test_mthd6(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008iNNNQA2' ORDER BY CreatedDate DESC LIMIT 1];
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if3eQAA' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }
    
      @IsTest
    static void TempleateTriggerHandler_Test_mthd7(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008iNNSQA2' ORDER BY CreatedDate DESC LIMIT 1];
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if3eQAA' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }
    
     @IsTest
    static void TempleateTriggerHandler_Test_mthd8(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008iNNcQAM' ORDER BY CreatedDate DESC LIMIT 1];
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if3eQAA' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }
    
       @IsTest
    static void TempleateTriggerHandler_Test_mthd9(){
        Test.startTest();
        //SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008iNNmQAM' ORDER BY CreatedDate DESC LIMIT 1];
        SBQQ__Quote__c objQuote = [SELECT Id, CreatedDate FROM SBQQ__Quote__c WHERE id = 'a132E000008if3eQAA' ORDER BY CreatedDate DESC LIMIT 1];
        objQuote.SBQQ__Status__c = 'Approved';
        update objQuote;
        TempleateTriggerHandler c = new TempleateTriggerHandler();
        Test.stopTest();
    }*/
    
   
}
