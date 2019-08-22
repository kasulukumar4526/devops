@RestResource(urlMapping='/secureApexRest')  
 global with sharing class SecureApexRest {  
   @HttpGet  
   global static Contact doGet(){  
     Id recordId = RestContext.request.params.get('id');  
     Contact result;  
     List<Contact> results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId WITH SECURITY_ENFORCED];  
     if (!results.isEmpty()) {  
        result = results[0];  
      }  
      else{  
       throw new QueryException('You don\'t have access to all contact fields required to use this API');  
     }  
     return result;  
   }  
    public class QueryException extends Exception{}  
 }