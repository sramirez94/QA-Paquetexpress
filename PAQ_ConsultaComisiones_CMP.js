import { api, LightningElement, wire }  from 'lwc';
import { ShowToastEvent }               from 'lightning/platformShowToastEvent';
import { getRecord }                    from 'lightning/uiRecordApi';
import FederationIdentifier             from '@salesforce/schema/User.FederationIdentifier';
import GetComisiones                    from '@salesforce/apex/CtrlConsultaComisiones.CallValidaEjecutivoComisiones';
import GetSales                         from '@salesforce/apex/CtrlConsultaComisiones.getTotalSales';
import Id                               from '@salesforce/user/Id';
var arrayComisiones = [];
export default class PAQ_ConsultaComisiones_CMP extends LightningElement {
    @api recordId;
    User;
    /*Variables String*/
    strIdentifier       = '';
    value               = '';
    strInitDate         = '';
    strendDate          = '';
    UserId              = Id;
    arrayComisiones     = arrayComisiones;
    /*Variables booleanas*/
    renderComisiones    = false;
    showSpinner         = false;
    /*Variables decimales*/
    decTotalComisiones  = 0;
    decTotalCobranza    = 0;
    decTotalVentas      = 0;
    @wire(getRecord, {recordId: Id, fields: [FederationIdentifier]})//Salvador Ramírez (sramirez@freewayconsulting.com): Se obtienen los datos del objeto de acuerdo al ID del registro
    userDetails({error, data}){
        if(data){
            //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene el id de sipweb del usuario
            this.strIdentifier = data.fields.FederationIdentifier.value;
        } else if(error){
            this.showMessage('Error inesperado al obtener le Id del usuario', false);
        }
    }
    get options() {
        //Salvador Ramírez (sramirez@freewayconsulting.com): Función para añadir los valores de rangos de fechas al picklist
        let currentTime = new Date();
        let year        = currentTime.getFullYear();
        //Salvador Ramírez (sramirez@freewayconsulting.com): Arreglo con los rangos de fechas
        return [
            { label: '21 de diciembre de '+(year -1)+' al 20 de enero de ' + year , value: (year -1) + '-12-21 al ' + year + '-01-20'},
            { label: '21 de enero de '+year+' al 20 de febrero de ' + year, value: year + '-01-21 al ' + year + '-02-20'},
            { label: '21 de febrero de '+year+' al 20 de marzo del ' + year, value: year + '-02-21 al ' + year + '-03-20'},
            { label: '21 de marzo de '+year+' al 20 de abril del ' + year, value: year + '-03-21 al ' + year + '-04-20'},
            { label: '21 de abril de '+year+' al 20 de mayo del ' + year, value: year + '-04-21 al ' + year + '-05-20'},
            { label: '21 de mayo de '+year+' al 20 de junio del ' + year, value: year + '-05-21 al ' + year + '-06-20'},
            { label: '21 de junio de '+year+' al 20 de julio del ' + year, value: year + '-06-21 al ' + year + '-07-20'},
            { label: '21 de julio de '+year+' al 20 de agosto del ' + year, value: year + '-07-21 al ' + year + '-08-20'},
            { label: '21 de agosto de '+year+' al 20 de septiembre del ' + year, value: year + '-08-21 al ' + year + '-09-20'},
            { label: '21 de septiembre de '+year+' al 20 de octubre del ' + year, value: year + '-09-21 al ' + year + '-10-20'},
            { label: '21 de octubre de '+year+' al 20 de noviembre del ' + year, value: year + '-10-21 al ' + year + '-11-20'},
            { label: '21 de noviembre de '+year+' al 20 de diciembre del ' + year, value: year + '-11-21 al ' + year + '-12-20'},
        ];
    }
    handleChange(event) {
        //Salvador Ramírez (sramirez@freewayconsulting.com): Evento que se ejecuta cuando cambia el valor del picklist
        this.value = event.detail.value; //Salvador Ramírez (sramirez@freewayconsulting.com): Se almacena el valor del picklist
    }
    handleClick(event){
        //Salvador Ramírez (sramirez@freewayconsulting.com): Función ejecutada al dar clic al botón de consulta.
        if(this.value !== '' && this.value !== undefined && this.value !== null){
            //Salvador Ramírez (sramirez@freewayconsulting.com): Si se seleccionó un valor en el picklist
            this.showSpinner    = true; //Salvador Ramírez (sramirez@freewayconsulting.com): Se muestra el spinner para que el usuario serpa que está cargando la página
            let arrayFechas     = []; //Salvador Ramírez (sramirez@freewayconsulting.com): Arreglo para guardar el rango de fechas seccionado por inicio y fin
            arrayFechas = this.value.split(' al '); //Salvador Ramírez (sramirez@freewayconsulting.com): Se genera un arreglo con las fechas seleccionadas
            this.strInitDate = arrayFechas[0]; //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene la primer fecha
            this.strendDate  = arrayFechas[1]; //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene la segunda fecha
            this.showMessage('Comienza la consulta de comisiones', true); //Salvador Ramírez (sramirez@freewayconsulting.com): Se le indica al usuario que comienza la consulta
            this.getComisionesEjecutivo(this.strInitDate.replace('-','').slice(0,-3), this.strendDate.replace('-','').slice(0,-3), this.strIdentifier);
        } else {
            this.showMessage('Error. Debe seleccionar un periodo a consultar', false);
        }
    }
    getComisionesEjecutivo(Fecha_Ini, Fecha_Fin, FedIdentifier){
        //Salvador Ramírez (sramirez@freewayconsulting.com): Función que ejecuta los servicios de consulta de comisiones y del total de ventas
        GetComisiones({
            FechaIni : Fecha_Ini,
            FechaFin : Fecha_Fin,
            FederationId : FedIdentifier
        }).then(Respuesta => {
            //Salvador Ramírez (sramirez@freewayconsulting.com): Resultado de la función llamada al servidor
            debugger;
            if(Respuesta){
                //Salvador Ramírez (sramirez@freewayconsulting.com): Se reinician las variables que se mostrarán en la ventana
                this.decTotalComisiones = 0;
                this.decTotalCobranza   = 0;
                this.arrayComisiones    = [];
                //Salvador Ramírez (sramirez@freewayconsulting.com): El string que regresa la función se vuelve un JSON
                let objResponse         = JSON.parse(Respuesta);
                if(objResponse.body.response.success){
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Si el resultado del JSON fue un success
                    if(objResponse.body.response.data && objResponse.body.response.data.length > 0){
                        //Salvador Ramírez (sramirez@freewayconsulting.com): Si contiene información de comisiones
                        for(let i = 0;objResponse.body.response.data.length;i++){
                            //Salvador Ramírez (sramirez@freewayconsulting.com): Se recorren todas las comisiones devueltas por el servicio para añadirlas al arreglo
                            let data = objResponse.body.response.data[i];
                            if(data){
                                this.decTotalComisiones += data.totalComision;
                                this.decTotalCobranza += data.totalAntesDeImpuestos;
                                let comision = {
                                    Id : 'com' + i,
                                    Periodo : data.comisionPeriodo,
                                    ClaveCliente: data.clienteClave,
                                    NombreCte : data.nombre,
                                    TipoCteCve : data.tipoClienteClave,
                                    RangoFlete : data.rangoFlete,
                                    TotalAntesImpuestos : data.totalAntesDeImpuestos,
                                    Comision : data.comision,
                                    Bono : data.bono,
                                    TotalComision : data.totalComision
                                };
                                this.arrayComisiones.push(comision);
                            } else {
                                break;
                            }
                        }
                    } else {
                        arrayComisiones = [];
                    }
                } else{
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Si el resultado del JSON no fué satisfactorio recorrerá los mensajes que devolvió y los mostrará en pantalla
                    if(objResponse.body.response.messages){
                        for(let i = 0;objResponse.body.response.messages.length; i++){
                            if(objResponse.body.response.messages[i]){
                                this.showMessage('Error en el servicio: ' +objResponse.body.response.messages[i].description, false);
                            } else {
                                break;
                            }
                        }
                    }
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Se oculta el spinner y la tabla de comisiones y se rompe el flujo.
                    this.showSpinner        = false;
                    this.renderComisiones   = false;
                    return;
                }
                if(this.arrayComisiones.length > 0){
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Si el arreglo que guarda las comisiones tiene información
                    if(this.decTotalCobranza > 0){
                        //Salvador Ramírez (sramirez@freewayconsulting.com): Se le da formato a los totales que se van a visualizar
                        this.decTotalCobranza = '$' + Number(this.decTotalCobranza).toLocaleString('en');
                        this.decTotalComisiones = '$' + Number(this.decTotalComisiones).toLocaleString('en');
                    }
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Se llama la función que regresará el total de ventas en salesforce
                    this.getVentas(this.UserId, this.strInitDate, this.strendDate);
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Se muestra la tabla de comisiones
                    this.renderComisiones = true;
                } else {
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Si no hay datos entonces oculta la tabla de comisiones y muestra el mensaje de error
                    this.renderComisiones = false;
                    this.showMessage('No se encontró información de comisiones en el periodo seleccionado', false);
                }
                this.showSpinner = false;
            } else {
                this.showMessage('Error inesperado durante la consulta de comisiones. Verifique con un consultor de Salesforce', false);
            }
        })
    }
    getVentas(UserId, Fecha_Ini, Fecha_Fin){
        //Salvador Ramírez (sramirez@freewayconsulting.com): método que consumirá una función del servidor para obtener el total de ventas del ejecutivo en Salesforce
        GetSales({
            IdUser : UserId,
            FechaIni : Fecha_Ini,
            FechaFin : Fecha_Fin
        }).then(Respuesta => {
            if(Respuesta){
                if(Respuesta.includes('Error')){
                    this.showMessage(Respuesta, false);
                    return;
                } else {
                    this.decTotalVentas = '$' + Number(Respuesta).toLocaleString('en');
                }
            } else {
                console.log('Error');
            }
        })
    }
    showMessage(strMessage, blnSuccess){
        //Salvador Ramírez (sramirez@freewayconsulting.com): Esta función se encarga de mostrar al usuario algún mensaje ya sea de error o de exito
        let strSuccess;
        if(!blnSuccess){
            strSuccess = 'error';
        } else {
            strSuccess = 'success';
        }
        const evt = new ShowToastEvent({
            title   : 'Consulta de comisiones',
            message : strMessage,
            variant : strSuccess,
            mode    : 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}
