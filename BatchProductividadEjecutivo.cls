global class BatchProductividadEjecutivo implements Database.Batchable<sObject>,   Database.AllowsCallouts, Database.Stateful {

    public String query; 
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        if(test.isRunningTest()){
            query = 'Select ID, FederationIdentifier, Experiencia_del_vendedor__c  from User WHERE FederationIdentifier != null AND zona__c != null AND Region__c != null AND plaza__c != null AND Experiencia_del_vendedor__c != null LIMIT 1';
        }else{
            query = 'Select ID, FederationIdentifier, Experiencia_del_vendedor__c  from User WHERE FederationIdentifier != null AND zona__c != null AND Region__c != null AND plaza__c != null AND Experiencia_del_vendedor__c != null';
            //query = 'Select ID, FederationIdentifier, Experiencia_del_vendedor__c  from User WHERE FederationIdentifier != null AND zona__c != null AND Region__c != null AND plaza__c != null AND Experiencia_del_vendedor__c != null AND Id=\'0052E00000LTs5qQAD\'';
        }
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<User> records) { 
        
        Date 	hoy 					= AuxTendencia.getFechaEjecucion();
        if(test.isRunningTest()){hoy 	= date.newInstance(2020, 05, 28);}
        
        //hoy 	= date.newInstance(2020, 06, 22);
        
        String dia						= ''+hoy.day();
        String Mes						= ''+hoy.month();
        String anio						= ''+hoy.year();
        
        String mesconsulta				= ''+AuxTendencia.generaMesConsulta(mes);
        Id ejecutivoId	 				= 	records[0].ID;
        
        String experienciaVendedor		= 	records[0].Experiencia_del_vendedor__c;
        
        system.debug('ejecutivoId : ' 	+  ejecutivoId);
        system.debug('mesconsulta : ' 	+  mesconsulta);
        system.debug('hoy : ' 			+  hoy);
        
        
        
        if(ejecutivoId != null && mesconsulta != 'NA' && hoy != null && anio != '' && experienciaVendedor != ''){
            system.debug('ENTRA IF VALIDA INFO PRODUCTIVIDAD');
            AuxBatchProductividadEjecutivo.productividadEjecutivo(ejecutivoId, mesconsulta, hoy, anio, experienciaVendedor);
            
        }		    
    
    }  
    
    global void finish(Database.BatchableContext BC){
         if(!test.isRunningTest()){System.enqueueJob(new CallBatchProductividadEjecutivoPlaza());}
    }
    
}
