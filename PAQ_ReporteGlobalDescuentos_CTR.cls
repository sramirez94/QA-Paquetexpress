/**
 * @description       : Controlador de reporte global de descuentos que se encarga de realizar la consulta para mostrar los datos en el documento
 * @author            : Salvador Ramírez López (sramirez@freewayconsulting.com)
 * @Project           : PaqueteXpress
 * @last modified on  : 06-25-2021
**/
public class PAQ_ReporteGlobalDescuentos_CTR {
    public List<String> listAccounts {get;set;}
    public Map<String, DescuentoGlobalAutorizado__c> mapDescuentoGlobal {get;set;}
    public PAQ_ReporteGlobalDescuentos_CTR() {
        this.listAccounts = new List<String>();
        this.mapDescuentoGlobal = new Map<String, DescuentoGlobalAutorizado__c>();
        this.ObtieneInfoReporte();
    }
    public void ObtieneInfoReporte(){
        try{
            for(DescuentoGlobalAutorizado__c DG : [SELECT Cuenta__c, Cuenta__R.NAME, cuenta__r.Plaza_Envio__r.Name, Id_sipweb__c, Descuento_autorizado__c,Defase_vs_SF__c, Descuento_real_SF__c, Defase_vs_BI__c, Descuento_BI__c, Cotizaciones__c FROM DescuentoGlobalAutorizado__c]){
                if(!this.mapDescuentoGlobal.containsKey(DG.Cuenta__c))
                    this.mapDescuentoGlobal.put(DG.Cuenta__c, DG);
                
                if(!this.listAccounts.contains(DG.Cuenta__c))
                    this.listAccounts.add(DG.Cuenta__c);
            }
        } catch(Exception ex){
            System.debug('Error al cargar reporte: ' + ex.getMessage() + '. ' + ex.getLineNumber());
        }
    }
}
