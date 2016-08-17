public with sharing class participantResponseV2 {
	public Participant participant {get; set;}
	public Event event {get; set;}

	public class Participant {
		public Id Id {get;set;}
		public string fullname {get;set;}
		public string status {get;set;}
		public Integer guests {get;set;}
		public string comments {get;set;}
	}

	public class Event{
		public Id Id {get;set;}
		public string name {get;set;}
		public string status {get;set;}
		public datetime starttime {get;set;}
		public string description {get;set;}
		public Ground ground {get;set;}
		public Integer totalGuestCount {get;set;}
		public Integer totalYesCount {get;set;}
		public Integer totalNoCount {get;set;}
		public Integer totalMaybeCount {get;set;}
		public Integer totalParticipantCount {get;set;}
		public List<Participant> participants {get;set;}
	}

	public class Ground{
		public Id Id {get;set;}
		public string name {get;set;}	
	}
}

