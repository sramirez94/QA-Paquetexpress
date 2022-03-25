trigger Cuenta on Account (before insert, before update, after insert, after update) {
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
		TriggerCuenta.genera_Gerente_KAM(Trigger.New);    	
    }
    
    if(trigger.isBefore && trigger.isUpdate){
     	TriggerCuenta.AsignacionEjecutivoNuevo(Trigger.New, Trigger.OldMap);  
    }

}
