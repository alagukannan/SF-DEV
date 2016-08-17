public with sharing class helper {
    private static helper classInstance;

    static {
        classInstance = new helper();
    }

    private helper() {
        
    }

    public static helper getInstance() {
        return classInstance;
    }

    public string generateRandomString(Integer length)
    {
		Blob blobKey = crypto.generateAesKey(192);
		String key = EncodingUtil.base64encode(blobKey);
		return key.substring(0,length);
    }
}