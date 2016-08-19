public class RCCEnums {
		public enum EVENT_STATUS_VALUES { ACTIVE, CANCELLED, EXPIRED}
		public static set<string> PARTICIPANT_STATUS_VALUES = new set<string>{'Yes', 'No', 'Maybe'};
		
		public static EVENT_STATUS_VALUES getEventStatus(String status){
			String myStatus = status.toLowerCase();
			EVENT_STATUS_VALUES statusType;
			if(myStatus == 'active')
				statusType = EVENT_STATUS_VALUES.ACTIVE;
			else if(myStatus == 'cancelled')
				statusType = EVENT_STATUS_VALUES.CANCELLED;
			else if (myStatus== 'expired')
				statusType = EVENT_STATUS_VALUES.EXPIRED;

			return statusType;
		}

}