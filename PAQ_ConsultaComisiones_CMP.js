import { api, LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import FederationIdentifier from '@salesforce/schema/user.FederationIdentifier';
import GetComisiones from '@salesforce/apex/CtrlConsultaComisiones.CallValidaEjecutivoComisiones';
import Id from '@salesforce/user/Id';
export default class PAQ_ConsultaComisiones_CMP extends LightningElement {
    @api recordId;
    strIdentifier;
    User;
    value = '';
    UserId = Id; //CallValidaEjecutivoComisiones(String FechaIni, String FechaFin, String FederationId)
    @wire(getRecord, {recordId: Id, fields: [FederationIdentifier]})
    userDetails({error, data}){
        if(data){
            //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene el id de sipweb del usuario
            this.strIdentifier = data.fields.FederationIdentifier.value;
        } else if(error){
            console.log('error');
        }
    }
    get options() {
        let currentTime = new Date();
        let year        = currentTime.getFullYear();
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
        this.value = event.detail.value;
    }
    handleClick(event){
        //Función que se encargará de mandar a ejecutar el servicio
        if(this.value !== '' && this.value !== undefined && this.value !== null){
            //Salvador Ramírez (sramirez@freewayconsulting.com): Si se seleccionó un valor en el picklist
            let arrayFechas     = [];
            let strInitDate     = '';
            let strendDate      = '';
            arrayFechas = this.value.split(' al '); //Salvador Ramírez (sramirez@freewayconsulting.com): Se genera un arreglo con las fechas seleccionadas
            strInitDate = arrayFechas[0]; //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene la primer fecha
            strendDate  = arrayFechas[1]; //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene la segunda fecha
            this.showMessage('Comienza la consulta de comisiones', true);
            this.getComisionesEjecutivo(strInitDate, strendDate, this.strIdentifier);
        } else {
            this.showMessage('Error. Debe seleccionar un periodo a consultar', false);
        }
    }
    getComisionesEjecutivo(Fecha_Ini, Fecha_Fin, FedIdentifier){
        GetComisiones({
            FechaIni : Fecha_Ini,
            FechaFin : Fecha_Fin,
            FedeerationId : FedIdentifier
        }).then(Respuesta => {
            if(Respuesta){
                console.log('ejecutado. Respuesta: ' + Respuesta);
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
