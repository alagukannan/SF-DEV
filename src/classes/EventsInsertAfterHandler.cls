public with sharing class EventsInsertAfterHandler implements EventsDomainController.HandlerInterface {

	Configs myconfig = Configs.getInstance();
	helper myhelper = helper.getInstance();
	public EventsInsertAfterHandler() {
		
	}

	public void handle()
	{
		// handle the Insert After event
		List<alagukannan__Participant__c> newParticipants = new List<alagukannan__Participant__c>();
		List<Contact> contacts = [select Id,Name from Contact where leadsource in (:myconfig.RCCLeadSource) and DoNotCall = false];
		set<Id> eventIds = trigger.newMap.keyset();
		for(Contact contact : contacts)
		{
			system.debug('contact name: ' + contact.Name);
			for(Id eventId : eventIds)
			{
				system.debug('Event Id: ' + eventId);
				alagukannan__Participant__c particpant = new alagukannan__Participant__c();
				particpant.alagukannan__Event__c = eventId;
				particpant.alagukannan__Player__c = contact.Id;
				particpant.alagukannan__token__c = myhelper.generateRandomString(myconfig.tokenLength);				
				newParticipants.add(particpant);
			}			
		}

		if (newParticipants.size() > 0)
		{
			insert newParticipants;		
		}

	}

	public void handle(List<SObject> beforeNewList){}
}