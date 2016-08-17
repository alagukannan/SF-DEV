/*
Run as service account s
sch_dailyjobs notify = new sch_hourlyJobs(); 
String sch = '0 00 * * * ?'; //sec, min, hour
system.schedule('RCC Hourly job',sch, notify);
*/

global class sch_hourlyJobs implements Schedulable {
	global void execute(SchedulableContext sc) {
		sch_hourlyJobs myjob = new sch_hourlyJobs();
		myjob.expireEvent();
	}

	public void expireEvent()
	{
		List<alagukannan__Event__c> updatedEvents = new List<alagukannan__Event__c>();
		Datetime currentTime = Datetime.now();
		for(alagukannan__Event__c event : [select Id,alagukannan__Status__c from alagukannan__Event__c where alagukannan__Status__c = 'Active' and alagukannan__End_Time__c < :currentTime])
		{
			event.alagukannan__Status__c = 'Expired';
			updatedEvents.add(event);
		}

		if (updatedEvents.size() > 0)
		{
			update updatedEvents;
		}

	}
}