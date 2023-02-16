public with sharing class ContactCController {
    public ContactCController() {

    }

    @RemoteAction
    public static List<ContactC__c> getAllContactC(){
        return [SELECT Id, Name__c, Gender__c, Address__c FROM ContactC__c LIMIT 50000];
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
        throw new ContactCException(e);
       }
    }

    class ContactCDto{
        public String Name {get;set;}
        public String Gender {get;set;} 
        public String Address {get;set;}  
    }

    class ContactCException extends Exception {}
}