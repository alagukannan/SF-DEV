 global class participantResponseV2 {
	public Participant participant {get; set;}
	public Event event {get; set;}

	public participantResponseV2()
	{
	}

	public class Participant {
		public Id Id {get;set;}
		public string fullname {get;set;}
		public string status {get;set;}
		public Decimal guests {get;set;}
		public string comments {get;set;}

		public Participant(Id id, string fullname, string status, Decimal guests, string comments)
		{
			this.Id = id;
			this.fullname = fullname;
			this.status = status;
			this.guests = guests;
			this.comments = comments;
		}
	}

	public class Event{
		public Id Id {get;set;}
		public string name {get;set;}
		public string status {get;set;}
		public datetime starttime {get;set;}
		public string description {get;set;}
		public Ground ground {get;set;}
		public Decimal totalGuestCount {get;set;}
		public Decimal totalYesCount {get;set;}
		public Decimal totalNoCount {get;set;}
		public Decimal totalMaybeCount {get;set;}
		public Decimal totalParticipantCount {get;set;}
		public List<Participant> participants {get;set;}
	}

	public class Ground{
		public Id Id {get;set;}
		public string name {get;set;}	

		public Ground(Id id, string name)
		{
			this.Id = id;
			this.name = name;
		}
	}
}