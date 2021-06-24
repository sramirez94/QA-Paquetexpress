/**
 * @description       : Controlador para iniciar el procesamiento del reporte global de descuentos autorizados
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com)
 * @last modified on  : 06-23-2021
 * Project            : PaqueteXpress
**/
public  class PAQ_FiltroReporteGlobalDescuentos_CTR {
    public List<SelectOption> listPlaza                 {get;set;}
    public Boolean blnSuccess                           {get;set;}
    public Boolean blnError                             {get;set;}
    public Boolean blnEnviador                          {get;set;}
    public Boolean blnReceptor                          {get;set;}
    public String strMensaje                            {get;set;}
    public String strPlaza                              {get;set;}
    public String StrDia1                               {get;set;}
    public String strMes1                               {get;set;}
    public String strAnio1                              {get;set;}
    public String StrDia2                               {get;set;}
    public String strMes2                               {get;set;}
    public String strAnio2                              {get;set;}
    public String strFecha1                             {get;set;}
    public String strFecha2                             {get;set;}
    public String StrDiaDR1                             {get;set;}
    public String strMesDR1                             {get;set;}
    public String strAnioDR1                            {get;set;}
    public String StrDiaDR2                             {get;set;}
    public String strMesDR2                             {get;set;}
    public String strAnioDR2                            {get;set;}
    public String strFechaDR1                           {get;set;}
    public String strFechaDR2                           {get;set;}
    public Date Inicio                                  {get;set;}
    public Date Fin                                     {get;set;}
    public Date InicioDR                                {get;set;}
    public Date FinDR                                   {get;set;}

    public PAQ_FiltroReporteGlobalDescuentos_CTR() {
        this.listPlaza      = new list<SelectOption>(); //Salvador Ramírez (sramirez@freewayconsulting.com): Lista que va a mostrar las plazas en el front
        this.blnSuccess     = false; //Salvador Ramírez (sramirez@freewayconsulting.com): Variable para mostrar un mensaje exitoso (en verde) en el front
        this.blnError       = false; //Salvador Ramírez (sramirez@freewayconsulting.com): Muestra un mensaje de error (en rojo) en el front
        this.blnEnviador    = false; //Salvador Ramírez (sramirez@freewayconsulting.com): Recibe el valor del checkbox que indica si es un enviador
        this.blnReceptor    = false; //Salvador Ramírez (sramirez@freewayconsulting.com): Recibe el valor del checkbox que indica si es receptor
        this.strPlaza       = ''; //Salvador Ramírez (sramirez@freewayconsulting.com): Recibe el valor de la plaza seleccionada
        this.strMensaje     = ''; //Salvador Ramírez (sramirez@freewayconsulting.com): Muestra el mensaje de error o exitoso, se debe llenar con el mensaje
        try{
            this.strMensaje     = 'Proporcione la información solicitada en el filtro para comenzar el procesamiento de la información para su reporte global de descuentos autorizados.';
            this.blnSuccess     = true;
            LlenaSucursales();
        }catch(Exception ex){
            this.strMensaje = 'Error al iniciar: ' +ex.getMessage();
            this.blnError   = true;
            this.blnSuccess = false;
            System.debug('Error en constructor: ' +ex.getMessage() + ' .' + ex.getLineNumber());
        }
    }
    public void ProcesarReporte(){
        //Salvador Ramírez (sramirez@freewayconsulting.com): Función que manda a llamar los batch que procesarán la información del reporte
        try{
            if(!this.blnEnviador && !this.blnReceptor){
                this.strMensaje = 'Debe indicar si se buscarán cuentas de tipo enviador y receptor o ambas. No puede quedar el filtro vacío';
                this.blnSuccess = false;
                this.blnError   = true;
                return;
            } else{
                if(Inicio == null || Fin == null){
                    this.strMensaje = 'Debe indicar un rango de fechas valido de cotizaciones autorizadas';
                    this.blnSuccess = false;
                    this.blnError   = true;
                    return;
                }
                if(InicioDR == null || FinDR == null){
                    this.strMensaje = 'Debe indicar un rango de fechas valido de descuento real';
                    this.blnSuccess = false;
                    this.blnError   = true;
                    return;
                }
                this.strAnio1 = String.valueOf(this.Inicio.year());
                if(this.Inicio.month() < 10)
                    this.strMes1 = '0' + this.Inicio.month().format();
                else this.strMes1 = this.Inicio.month().format();
                if(this.Inicio.Day() < 10)
                    this.StrDia1 = '0' + this.Inicio.Day().format(); 
                else this.StrDia1 = String.valueOf(this.Inicio.Day());
                this.strFecha1 = this.strAnio1 + '-' + this.strMes1 + '-' + this.StrDia1;
                //01/03/2021: Armado de la fecha final
                this.strAnio2 = String.valueOf(this.Fin.year());
                if(this.Fin.month() < 10)
                    this.strMes2 = '0' + this.Fin.month().format();
                else this.strMes2 = this.Fin.month().format();
                if(this.Fin.Day() < 10)
                    this.StrDia2 = '0' + this.Fin.Day().format(); 
                else this.StrDia2 = String.valueOf(this.Fin.Day());
                this.strFecha2 = this.strAnio2 + '-' + this.strMes2 + '-' + this.StrDia2;

                this.strAnioDR1 = String.valueOf(this.InicioDR.year());
                if(this.InicioDR.month() < 10)
                    this.strMesDR1 = '0' + this.InicioDR.month().format();
                else this.strMesDR1 = this.InicioDR.month().format();
                if(this.InicioDR.Day() < 10)
                    this.StrDiaDR1 = '0' + this.InicioDR.Day().format(); 
                else this.StrDiaDR1 = String.valueOf(this.InicioDR.Day());
                this.strFechaDR1 = this.strAnioDR1 + '-' + this.strMesDR1 + '-' + this.StrDiaDR1;
                //01/03/2021: Armado de la fecha final
                this.strAnioDR2 = String.valueOf(this.FinDR.year());
                if(this.FinDR.month() < 10)
                    this.strMesDR2 = '0' + this.FinDR.month().format();
                else this.strMesDR2 = this.FinDR.month().format();
                if(this.FinDR.Day() < 10)
                    this.StrDiaDR2 = '0' + this.FinDR.Day().format(); 
                else this.StrDiaDR2 = String.valueOf(this.FinDR.Day());
                this.strFechaDR2 = this.strAnioDR2 + '-' + this.strMesDR2 + '-' + this.StrDiaDR2;

                this.strMensaje = 'El proceso se ha iniciado correctamente, una vez que termine el procesamiento de la información recibirá un correo electrónico con la liga para descargar el reporte global de descuentos.';
                this.blnSuccess = true;
                this.blnError   = false;
                batchReporteGlobal batch1 = new batchReporteGlobal(this.strPlaza,this.strFecha1, this.strFecha2, this.strFechaDR1, this.strFechaDR2, this.blnEnviador, this.blnReceptor);
                database.executeBatch(batch1);
                System.debug('terminaron de ejecutarse los batch');
            }
        }catch(Exception ex){
            this.strMensaje = 'Error interno: ' + ex.getMessage();
            this.blnSuccess = false;
            this.blnError   = true;
            System.debug('Error al iniciar procesamiento: ' + ex.getMessage()+ '. ' + ex.getLineNumber());
        }
    }
    public void LlenaSucursales(){
        //Salvador Ramírez (sramirez@freewayconsulting.com): Función que llena la lista de selección de plazas que se muestra en el front
        try{
            list<String> listPlazasC = new list<String>(); //Salvador Ramírez (sramirez@freewayconsulting.com): Con esta lista se valida si la plaza ya fue agregada a la lista de selección. No era posible hacerlo desde la lista de selección
            for(Sucursal__c s : querySucursales()){ //Salvador Ramírez (sramirez@freewayconsulting.com): Iteración sobre las sucursales
                if(!listPlazasC.Contains(s.Plaza__c) && s.plaza__c != null){
                    this.listPlaza.add(new SelectOption(s.Id, s.plaza__c));
                    listPlazasC.add(s.Plaza__c);
                }
            }
            this.listPlaza.add(new SelectOption('ALL', 'TODAS')); //Salvador Ramírez (sramirez@freewayconsulting.com): Se agrega un elemento que diga "TODAS" para poder indicar que se van a buscar sobre todas las sucursales.
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
