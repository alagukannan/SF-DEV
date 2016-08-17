/*
Run as service account s
sch_dailyjobs notify = new sch_dailyjobs(); 
String sch = '0 06 01 * * ?'; //sec, min, hour
system.schedule('RCC daily job',sch, notify);
*/


global class sch_dailyjobs implements Schedulable {
	global void execute(SchedulableContext sc) {
		sch_dailyjobs myjob = new sch_dailyjobs();
		myjob.eventRegistrationReminder();
	}


	public void eventRegistrationReminder()
	{
		List<alagukannan__Participant__c> updatedParticipants = new List<alagukannan__Participant__c>();
		for(alagukannan__Participant__c participant : [select Id,alagukannan__Email_Sent__c from alagukannan__Participant__c where alagukannan__Email_Sent__c = false and alagukannan__status__c = null and alagukannan__Event__r.alagukannan__Status__c = 'Active'])
		{
			participant.alagukannan__Email_Sent__c = true;
			updatedParticipants.add(participant);
		}

		if (updatedParticipants.size() > 0)
		{
			update updatedParticipants;
		}
	}



}