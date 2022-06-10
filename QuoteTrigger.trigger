trigger QuoteTrigger on SBQQ__Quote__c (after update) {
	QuoteTriggerHandler handler = new QuoteTriggerHandler();

	if(Trigger.isUpdate && Trigger.isAfter){
		handler.shareQuote(Trigger.new, Trigger.oldMap);
		handler.createTempleate(Trigger.new, Trigger.oldMap);
		//handler.sendTarifas(Trigger.new, Trigger.oldMap);
	}
}
