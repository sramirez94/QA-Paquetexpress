/**
 * @description       : Controlador para iniciar el procesamiento del reporte global de descuentos autorizados
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com)
 * @last modified on  : 06-22-2021
 * Project            : PaqueteXpress
**/
public  class PAQ_FiltroReporteGlobalDescuentos_CTR {
    public List<SelectOption> listPlaza                 {get;set;}
    public List<Sucursal__c> listSucursales             {get;set;}
    public Boolean blnSuccess                           {get;set;}
    public Boolean blnError                             {get;set;}
    public Boolean blnEnviador                          {get;set;}
    public Boolean blnReceptor                          {get;set;}
    public String strMensaje                            {get;set;}
    public String strPlaza                              {get;set;}
    public Date Inicio                                  {get;set;}
    public Date Fin                                     {get;set;}

    public PAQ_FiltroReporteGlobalDescuentos_CTR() {
        this.listPlaza = new list<SelectOption>();
        this.listSucursales = new List<Sucursal__c>();
        this.blnSuccess     = false;
        this.blnError = false;
        this.blnEnviador = false;
        this.blnReceptor = false;
        this.strPlaza = '';
        this.strMensaje = '';
        try{
            this.strMensaje = 'Proporcione la información solicitada en el filtro para comenzar el procesamiento de la información para su reporte global de descuentos autorizados.';
            this.blnSuccess = true;
            this.listSucursales = querySucursales();
            LlenaSucursales();
        }catch(Exception ex){
            this.strMensaje = 'Error al iniciar: ' +ex.getMessage();
            this.blnError   = true;
            this.blnSuccess = false;
            System.debug('Error en constructor: ' +ex.getMessage() + ' .' + ex.getLineNumber());
        }
    }
    public void ProcesarReporte(){
        try{
            this.strMensaje = 'El proceso se ha iniciado correctamente, una vez que termine el procesamiento de la información recibirá un correo electrónico con la liga para descargar el reporte global de descuentos.';
            this.blnSuccess = true;
            this.blnError   = false;
            System.debug('inicio: ' + this.inicio + '. Fin: ' + this.Fin);
        }catch(Exception ex){

        }
    }
    public void LlenaSucursales(){
        try{
            list<String> listPlazasC = new list<String>();
            for(Sucursal__c s : querySucursales()){
                if(!listPlazasC.Contains(s.Plaza__c) && s.plaza__c != null){
                    this.listPlaza.add(new SelectOption(s.Id, s.plaza__c));
                    listPlazasC.add(s.Plaza__c);
                }
            }
            this.listPlaza.add(new SelectOption('ALL', 'TODAS'));
        }catch(Exception ex){
            this.strMensaje = 'Error interno: ' + ex.getMessage();
            this.blnSuccess = false;
            this.blnError   = true;
            System.debug('Error en LlenaSucursales: ' + ex.getMessage() + ' .' + ex.getLineNumber());
        }
    }
    public static List<Sucursal__c> querySucursales(){
        return [SELECT Id, plaza__c FROM Sucursal__c];
    }
}
