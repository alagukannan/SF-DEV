public class RCCEnums {
		public enum EVENT_STATUS_VALUES { ACTIVE, CANCELLED, EXPIRED}
		public static set<string> PARTICIPANT_STATUS_VALUES = new set<string>{'Yes', 'No', 'Maybe'};
		
		public static EVENT_STATUS_VALUES getEventStatus( String status)
		{
			String _status = status.toLowerCase();
			if(_status == 'active')
				return EVENT_STATUS_VALUES.ACTIVE;
			else if(_status == 'cancelled')
				return EVENT_STATUS_VALUES.CANCELLED;
			else if (_status== 'expired')
				return EVENT_STATUS_VALUES.EXPIRED;
		}

}