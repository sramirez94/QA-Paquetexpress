import { LightningElement } from 'lwc';

export default class PAQ_ConsultaComisiones_CMP extends LightningElement {
    value = '';
    get options() {
        let currentTime = new Date();
        let year        = currentTime.getFullYear();
        return [
            { label: '21 de diciembre de '+(year -1)+' al 20 de enero de ' + year , value: '21 de diciembre de '+(year -1)+' al 20 de enero de ' + year},
            { label: '21 de enero de '+year+' al 20 de febrero de ' + year, value: '21 de enero de '+year+' al 20 de febrero de ' + year },
            { label: '21 de febrero de '+year+' al 20 de marzo del ' + year, value: '21 de febrero de '+year+' al 20 de marzo del ' + year },
            { label: '21 de marzo de '+year+' al 20 de abril del ' + year, value: '21 de marzo de '+year+' al 20 de abril del ' + year },
            { label: '21 de abril de '+year+' al 20 de mayo del ' + year, value: '21 de abril de '+year+' al 20 de mayo del ' + year },
            { label: '21 de mayo de '+year+' al 20 de junio del ' + year, value: '21 de mayo de '+year+' al 20 de junio del ' + year },
            { label: '21 de junio de '+year+' al 20 de julio del ' + year, value: '21 de junio de '+year+' al 20 de julio del ' + year },
            { label: '21 de julio de '+year+' al 20 de agosto del ' + year, value: '21 de julio de '+year+' al 20 de agosto del ' + year },
            { label: '21 de agosto de '+year+' al 20 de septiembre del ' + year, value: '21 de agosto de '+year+' al 20 de septiembre del ' + year },
            { label: '21 de septiembre de '+year+' al 20 de octubre del ' + year, value: '21 de septiembre de '+year+' al 20 de octubre del ' + year },
            { label: '21 de octubre de '+year+' al 20 de noviembre del ' + year, value: '21 de octubre de '+year+' al 20 de noviembre del ' + year },
            { label: '21 de noviembre de '+year+' al 20 de diciembre del ' + year, value: '21 de noviembre de '+year+' al 20 de diciembre del ' + year },
        ];
    }
    handleChange(event) {
        this.value = event.detail.value;
        console.log('periodo: ' + this.value);
    }
}
