public with sharing class ContactCController {
    public ContactCController() {

    }

    @RemoteAction
    public static List<ContactC__c> getAllContactC(){
        return [SELECT Id, Name__c, Gender__c, Address__c, CreatedDate FROM ContactC__c ORDER BY CreatedDate DESC LIMIT 50000];
    }

    @RemoteAction
    public static void createContactC(ContactCDto ctDto){
       try {
        ContactC__c ct = new ContactC__c();
        ct.Name__c = ctDto.Name;
        ct.Gender__c = ctDto.Gender;
        ct.Address__c = ctDto.Address;
        insert ct;
       } catch (Exception e) {
        String message = e.getMessage();
        if (message.contains('REQUIRED_FIELD_MISSING')) {
            message = message.substringBetween('REQUIRED_FIELD_MISSING,', ': [');
        }
        throw new ContactCException(message);
       }
    }

    @RemoteAction
    public static void removeContactCById(String ccId){
        System.debug('ccId: '+ccId);
        System.debug('user: '+userInfo.getName());
       try {
            if (String.isNotBlank(ccId)) {
                String query ='SELECT Id FROM Contactc__c WHERE Id = \''+String.escapeSingleQuotes(ccid)+'\'';
                delete Database.query(query);
            }else{
                throw new ContactCException('担当者Idが必須です。');
            }
        } catch (Exception e) {
            System.debug('e '+e.getMessage());
            throw new ContactCException('担当者を削除できまませんでした。システム管理者に問い合わせください。');
        }
    }

    class ContactCDto{
        public String Name {get;set;}
        public String Gender {get;set;} 
        public String Address {get;set;}
    }

    class ContactCException extends Exception {}
}