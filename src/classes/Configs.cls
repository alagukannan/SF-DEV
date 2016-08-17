public with sharing class Configs {
    private static Configs classInstance;
    //constants
    private String RCC_LEAD_SOURCE = 'Redlands Cricket Club';
    private integer TOKEN_LENGTH = 32;

    static {
        classInstance = new Configs();
    }

    private Configs() {
        
    }

    public static Configs getInstance() {
        return classInstance;
    }

    public string RCCLeadSource{
    	get {return RCC_LEAD_SOURCE;}
    }
    public integer tokenLength{
    	get {return TOKEN_LENGTH;}
    }



}