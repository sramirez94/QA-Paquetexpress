/**
 * @description       : Clase para almacenar funciones genéricas que se repitan en varios puntos del código para evitar sobrepasar el límite de caracteres en las clases de apex.
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com)
 * @Project           : Paquetexpress SEF
 * @Created Date      : 03-08-2022
**/
public with sharing class PAQ_FuncionesGenericas {
    public static String getValuePickList(String strCampo, String strCadena){
        String result = '';
        List<Schema.PicklistEntry> entries = new List<Schema.PicklistEntry>();
        if(strCampo == 'UsoCFDI'){
            entries = Account.Uso_de_cfdi_CCP__c.getDescribe().getPickListValues();
        }else if(strCampo == 'RegimenFiscal'){
            entries  = Account.Regimen_fiscal_CCP__c.getDescribe().getPickListValues();
        }
        for(Schema.PicklistEntry p : entries){
            if(p.getLabel().contains(strCadena)){
                result = p.getLabel();
                break;
            }
        }
        return result;
    }
    public static String ValidaDatosFiscales(Account acc){
        //Función para validar que los dato fiscales se hayan capturado
        String result = '';
        //Valida los datos de la cuenta recibida
        if(acc.RFC__c != 'XAXX010101000'){
            //Si se recibió un RFC diferente al RFC genérico
            RecordType rt = [SELECT Name FROM RecordType WHERE Id = :acc.RecordTypeId WITH SECURITY_ENFORCED];
            if(acc.Regimen_fiscal_CCP__c == null || acc.Uso_de_cfdi_CCP__c == null || acc.RFC__c == null || acc.BillingPostalCode == null || //Datos fiscales generales.
                (rt.Name == 'Persona moral' && acc.RazonSocial__c == null) || //Datos fiscales solo para personas morales.
                (rt.Name == 'Persona física' && (acc.Nombres__c == null || acc.ApellidoPaterno__c == null))){ //Dato fiscales para personas físicas.
                    result = 'Cuenta con datos fiscales obligatorios incompletos. Verificarlos antes de intentar continuar.'; //Se compone del número de elemento de la cuenta y el mensaje de error
                    system.debug('2');
            }
        }
        return result;
    }
    public static void publicarEvento(Boolean ejecucionCorrecta, String mensaje){
        try{
            List<ResultadoGrabado__e> inkEvents = new List<ResultadoGrabado__e>();
            inkEvents.add(new ResultadoGrabado__e(Mensaje__c=mensaje, Usuario__c=System.UserInfo.getUserId()
                                                  , Ejecucion_correcta__c = ejecucionCorrecta));
            List<Database.SaveResult> results = EventBus.publish(inkEvents);
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    System.debug('Successfully published event.');
                } else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Error returned: ' +
                                     err.getStatusCode() +
                                     ' - ' +
                                     err.getMessage());
                    }
                }
            }
        }catch(Exception ex){
            System.debug('publicarEvento: '+ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public static String GetNombreTipoDeRegistro(String id){
        return [SELECT NAME FROM RecordType WHERE ID = :id].Name;
    }
}
