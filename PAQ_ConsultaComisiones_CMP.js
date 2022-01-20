import { LightningElement } from 'lwc';

export default class PAQ_ConsultaComisiones_CMP extends LightningElement {
    value = '';
    get options() {
        return [
            { label: '21 de diciembre de 2021 al 20 de enero de 2022', value: '21 de diciembre de 2021 al 20 de enero de 2022' },
            { label: '21 de enero de 2022 al 20 de febrero de 2022', value: '21 de enero de 2022 al 20 de febrero de 2022' },
            { label: '21 de febrero de 2022 al 20 de marzo del 2022', value: '21 de febrero de 2022 al 20 de marzo del 2022' },
        ];
    }
    handleChange(event) {
        this.value = event.detail.value;
    }
}
