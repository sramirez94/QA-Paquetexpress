/**
 * @description       : Batch para actualizar los datos fiscales de los RFC recibidos
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com)
 * @Project           : Paquetexpress SEF
**/
global class PAQ_BatchActualizaDatosFiscales implements Database.Batchable<sObject> {
    public String strQuery                                          = ''; //SRL 03/08/2022: Variable para almacenar la consulta armada
    public Integer i                                                = 0;
    Map<String, PAQ_WS_UpdateDatosFiscales.wrapperCuenta> mapDatos  = new Map<String, PAQ_WS_UpdateDatosFiscales.wrapperCuenta>(); //SRL 03/08/2022: Respaldo de los datos fiscales recibidos del WS
    PAQ_WS_UpdateDatosFiscales.wrapperCuenta DatosFiscales          = new PAQ_WS_UpdateDatosFiscales.wrapperCuenta(); //SRL 03/08/2022: Objeto para no referenciar todo el tiempo el mapa de datos fiscales
    public PAQ_BatchActualizaDatosFiscales(Set<String> Idcuentas, Map<String, PAQ_WS_UpdateDatosFiscales.wrapperCuenta> mapDatosFiscales) {
        //SRL 03/08/2022: Armado de la consulta
        this.strQuery = 'SELECT Id, RazonSocial__c, RegimenCapital__c, Nombres__c, ApellidoPaterno__c, ApellidoMaterno__c, BillingStreet, NumeroInterior__c, Numero_de_facturacion__c, ' +
                    'BillingPostalCode, Regimen_fiscal_CCP__c, Uso_de_cfdi_CCP__c, BillingState, BillingCity, RFC__c, DatosFiscalesObtenidosDeSipWeb__c FROM Account WHERE RFC__c IN (';
        for(String StrId : Idcuentas){
            i++;
            if(i == Idcuentas.size()){
                strQuery += '\'' + StrId + '\')';
            } else {
                strQuery += '\'' + StrId + '\',';
            }
        }
        mapDatos = mapDatosFiscales;
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
    	return Database.getQueryLocator(this.strQuery); //SRL 03/08/2022: Ejecución de la consulta por medio de los RFC
    }
    global void execute(Database.BatchableContext bc, List<Account> records){
        try {
            for(Account ac : records){
                //SRL 03/08/2022: Se recorren las cuentas obtenidas de la consulta
                if(mapDatos.containsKey(ac.RFC__c)){
                    System.debug('RFC: ' + ac.RFC__c);
                    //SRL 03/08/2022: Si el mapa tiene el RFC de los datos recibidos del WS entonces los actualizará en la cuenta
                    DatosFiscales                           = mapDatos.get(ac.RFC__c);
                    if(DatosFiscales.taxDataClntType == 'M'){
                        ac.RazonSocial__c                   = DatosFiscales.taxDataBusinessName;
                        ac.RegimenCapital__c                = DatosFiscales.taxDataCapitalRegm;
                    } else {
                        ac.Nombres__c                       = DatosFiscales.taxDataFirstName;
                        ac.ApellidoPaterno__c               = DatosFiscales.taxDataLastName1;
                        ac.ApellidoMaterno__c               = DatosFiscales.taxDataLastName2;
                    }
                    ac.BillingStreet                        = DatosFiscales.taxDataStreet;
                    ac.NumeroInterior__c                    = DatosFiscales.taxDataNoInt;
                    ac.Numero_de_facturacion__c             = (DatosFiscales.taxDataNoExt == null || !DatosFiscales.taxDataNoExt.isNumeric())?null:Decimal.valueOf(DatosFiscales.taxDataNoExt);
                    ac.BillingPostalCode                    = DatosFiscales.taxDataZipCode;
                    ac.Regimen_fiscal_CCP__c                = PAQ_FuncionesGenericas.getValuePickList('RegimenFiscal', DatosFiscales.taxDataRegmFisc);
                    ac.Uso_de_cfdi_CCP__c                   = PAQ_FuncionesGenericas.getValuePickList('UsoCFDI', DatosFiscales.taxDataUsoCFDI);
                    ac.BillingState                         = DatosFiscales.taxDataState;
                    ac.BillingCity                          = DatosFiscales.taxDataCity;
                    ac.BillingCountry                       = DatosFiscales.taxDataCountry;
                    ac.ValidSAT__c                          = DatosFiscales.taxDataValidFlag == 'Y'?true:false;
                    ac.DatosFiscalesObtenidosDeSipWeb__c    = true;
                }
            }
            update records; //SRL 03/08/2022: Realiza la actualización
        } catch (Exception ex) {
            System.debug('Error PAQ_BatchActualizaDatosFiscales: ' + ex.getMessage() + 'Línea: ' + ex.getlineNumber());
        }
    }
    global void finish(Database.BatchableContext bc){
        
    }
}
