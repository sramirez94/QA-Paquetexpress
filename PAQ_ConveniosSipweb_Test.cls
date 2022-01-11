@istest
global class PAQ_ConveniosSipweb_Test {
	@isTest
    static void CargaResponseCostosFijos(){
        test.startTest();
        Account cuenta = new Account(
            Name='MERCADO LIBRE - CUENTA DE PRUEBA',
            Numero__c = 1235,
            Colonia__c = 'test colonia',
            Piso_envio__c = 'test piso envio',
            Zona_envio__c = 'zona envio',
            Colonia_Facturaci_n__c = 'colonia facturacion',
            Potencial_mensual_de_envios__c = 1000000,
            Potencial_mensual_Total__c = 1000000,
            ShippingPostalCode = '01010',
            BillingPostalCode = '01010',
            Sucursal__c = 'a022E00000YQPtqQAH',
            Piso_facturacion__c = 'Piso',
            Zona_facturacion__c = 'Zona',
            RFC__c = 'OICN9010254P',
            Id_SIpWeb__c = '101112',
            Tipo_cotizador__c = 'Documentación en piso sipweb',
            OwnerId = UserInfo.getUserId()
	
        );
        insert cuenta;
        String strJson2='{\n'+
'"header":null,\n'+
'"body":{\n'+
'"request":null,\n'+
'"response":{\n'+
'"success":true,\n'+
'"messages":null,\n'+
'"data":{\n'+
'"clntId":"13075550",\n'+
'"aprvUser":"ABARJONA",\n'+
'"trifType":"C",\n'+
'"pieceMulti":"",\n'+
'"quotation":null,\n'+
'"weight":0.0,\n'+
'"vol":0.0,\n'+
'"editAvg":"N",\n'+
'"migrationFrom":"",\n'+
'"ptpConfig":null,\n'+
'"kmConfig":[\n'+
'{\n'+
'"kmServicesTrif":[\n'+
'{\n'+
'"fromKm":0,\n'+
'"toKm":400,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"ACK-P",\n'+
'"refServiceId":"ACK",\n'+
'"trifAmount":25.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02641"\n'+
'},\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":120.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":null,\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":983.61,\n'+
'"factor":"CUM",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":4.92,\n'+
'"factor":"KG",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":null\n'+
'},\n'+
'{\n'+
'"fromKm":401,\n'+
'"toKm":800,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"ACK-P",\n'+
'"refServiceId":"ACK",\n'+
'"trifAmount":25.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02641"\n'+
'},\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":120.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":null,\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":983.61,\n'+
'"factor":"CUM",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":4.92,\n'+
'"factor":"KG",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":null\n'+
'},\n'+
'{\n'+
'"fromKm":801,\n'+
'"toKm":1200,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"ACK-P",\n'+
'"refServiceId":"ACK",\n'+
'"trifAmount":25.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02641"\n'+
'},\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":120.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":null,\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":983.61,\n'+
'"factor":"CUM",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":4.92,\n'+
'"factor":"KG",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":null\n'+
'},\n'+
'{\n'+
'"fromKm":1201,\n'+
'"toKm":1600,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"ACK-P",\n'+
'"refServiceId":"ACK",\n'+
'"trifAmount":25.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02641"\n'+
'},\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":120.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":null,\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":983.61,\n'+
'"factor":"CUM",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":4.92,\n'+
'"factor":"KG",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":null\n'+
'},\n'+
'{\n'+
'"fromKm":1601,\n'+
'"toKm":2000,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"ACK-P",\n'+
'"refServiceId":"ACK",\n'+
'"trifAmount":25.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02641"\n'+
'},\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":120.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":null,\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":983.61,\n'+
'"factor":"CUM",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":4.92,\n'+
'"factor":"KG",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":null\n'+
'},\n'+
'{\n'+
'"fromKm":2001,\n'+
'"toKm":2400,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"ACK-P",\n'+
'"refServiceId":"ACK",\n'+
'"trifAmount":25.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02641"\n'+
'},\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":120.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":null,\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":983.61,\n'+
'"factor":"CUM",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":4.92,\n'+
'"factor":"KG",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":null\n'+
'},\n'+
'{\n'+
'"fromKm":2401,\n'+
'"toKm":9999,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"ACK-P",\n'+
'"refServiceId":"ACK",\n'+
'"trifAmount":25.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02641"\n'+
'},\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":120.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":null,\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":108.2,\n'+
'"factor":"CUM",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":983.61,\n'+
'"factor":"CUM",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"CUM",\n'+
'"factorValue":0.025,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"EAD-1",\n'+
'"refrServiceId":"EAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":0.54,\n'+
'"factor":"KG",\n'+
'"serviceId":"RAD-1",\n'+
'"refrServiceId":"RAD",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":22.54,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"trifAmountExce":4.92,\n'+
'"factor":"KG",\n'+
'"serviceId":"SHP-G",\n'+
'"refrServiceId":"PACKETS",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":204.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":5.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02641"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":null\n'+
'}\n'+
']\n'+
'}\n'+
']\n'+
'},\n'+
'"objectDTO":null,\n'+
'"time":null\n'+
'}\n'+
'}\n'+
'}';
        ObjDocEnLinea.documentacionRemota DR = (ObjDocEnLinea.documentacionRemota)JSON.deserialize(strJson2, ObjDocEnLinea.documentacionRemota.class);
        
        
        
        
        //Account cuenta = [SELECT Id_sipweb__c, ID from Account where Id = '0017i0000107JXtAAM'];
        PageReference pageRef = Page.GrabadoDocEnLinea;
        Apexpages.StandardController sc = new Apexpages.StandardController(cuenta);
        pageRef.getParameters().put('recordId', cuenta.Id_SIpWeb__c);
        PAQ_ConveniosSipweb_CTR PQ = new PAQ_ConveniosSipweb_CTR(sc);
        PQ.AsignaResponseTest(DR);
        //PQ.CargaInfoSipweb();
        Test.setCurrentPage(pageRef);
        Test.stopTest();    
    }
    @isTest
    static void CargaResponseCostosFijos2(){
        test.startTest();
        Account cuenta = new Account(
            Name='MERCADO LIBRE - CUENTA DE PRUEBA',
            Numero__c = 1235,
            Colonia__c = 'test colonia',
            Piso_envio__c = 'test piso envio',
            Zona_envio__c = 'zona envio',
            Colonia_Facturaci_n__c = 'colonia facturacion',
            Potencial_mensual_de_envios__c = 1000000,
            Potencial_mensual_Total__c = 1000000,
            ShippingPostalCode = '01010',
            BillingPostalCode = '01010',
            Sucursal__c = 'a022E00000YQPtqQAH',
            Piso_facturacion__c = 'Piso',
            Zona_facturacion__c = 'Zona',
            RFC__c = 'OICN9010254P',
            Id_SIpWeb__c = '456',
            Tipo_cotizador__c = 'Documentación en piso sipweb',
            OwnerId = UserInfo.getUserId()
	
        );
        insert cuenta;
        String strJson2 = '{\n'+
'"header":null,	\n'+
'"body":{	\n'+
'"request":null,	\n'+
'"response":{	\n'+
'"success":true,	\n'+
'"messages":null,	\n'+
'"data":{	\n'+
'"clntId":"13075550",	\n'+
'"aprvUser":"ABARJONA",	\n'+
'"trifType":"A",	\n'+
'"pieceMulti":"",	\n'+
'"quotation":null,	\n'+
'"weight":0.0,	\n'+
'"vol":0.0,	\n'+
'"editAvg":"N",	\n'+
'"migrationFrom":"",	\n'+
'"ptpConfig":[	\n'+
'{	\n'+
'"ptpServicesTrif":[	\n'+
'{	\n'+
'"orgnSite":"LMM",	\n'+
'"destSite":"CUL",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EXT-1",	\n'+
'"refServiceId":"EXT",	\n'+
'"trifAmount":116.23,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":"NON",	\n'+
'"factorValue":0.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
'],	\n'+
'"servicesTrifDtl":[	\n'+
'{	\n'+
'"slabNo":"S",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":16.23,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":16.23,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-E",	\n'+
'"refServiceId":"ENVELOPES",	\n'+
'"trifAmount":147.54,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T0",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":93.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T1",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":111.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T2",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":142.5,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T3",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":199.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T4",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":235.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T5",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":33.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":33.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":300.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T6",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":37.4,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":37.4,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":340.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T7P",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":0.56,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":0.56,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":5.1,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T7V",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":128.2,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":128.2,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":1165.5,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'}	\n'+
'],	\n'+
'"servicesTrifCbe":[	\n'+
'{	\n'+
'"trifAmountExce":6.0,	\n'+
'"factor":"KG",	\n'+
'"serviceId":"SEG-DS",	\n'+
'"refrServiceId":"SEG-D",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":null,	\n'+
'"refServiceId":null,	\n'+
'"trifAmount":200.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":"KG",	\n'+
'"factorValue":2.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'}	\n'+
'],	\n'+
'"otherServiceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-CITA-1",	\n'+
'"refServiceId":"EAD-CITA",	\n'+
'"trifAmount":200.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":"NON",	\n'+
'"factorValue":null,	\n'+
'"servicesCant":"E",	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"MAN-1",	\n'+
'"refServiceId":"MAN",	\n'+
'"trifAmount":150.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":"NON",	\n'+
'"factorValue":null,	\n'+
'"servicesCant":"E",	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"orgnSite":"LMM",	\n'+
'"destSite":"SLP",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EXT-1",	\n'+
'"refServiceId":"EXT",	\n'+
'"trifAmount":116.23,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":"NON",	\n'+
'"factorValue":0.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
'],	\n'+
'"servicesTrifDtl":[	\n'+
'{	\n'+
'"slabNo":"S",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":16.23,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":16.23,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-E",	\n'+
'"refServiceId":"ENVELOPES",	\n'+
'"trifAmount":147.54,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T0",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":28.27,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":215.5,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T1",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":29.32,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":29.32,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":266.5,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T2",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":36.3,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":36.3,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":330.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T3",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":45.76,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":45.76,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":416.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T4",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":48.29,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":48.29,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":439.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T5",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":70.4,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":70.4,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":640.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T6",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":73.81,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":73.81,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":671.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":null,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T7P",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":1.51,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":1.51,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":13.7,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'},	\n'+
'{	\n'+
'"slabNo":"T7V",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-1",	\n'+
'"refServiceId":"EAD",	\n'+
'"trifAmount":507.92,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"RAD-1",	\n'+
'"refServiceId":"RAD",	\n'+
'"trifAmount":507.92,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"SHP-G",	\n'+
'"refServiceId":"PACKETS",	\n'+
'"trifAmount":4617.5,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":null,	\n'+
'"factorValue":1.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'}	\n'+
'],	\n'+
'"servicesTrifCbe":[	\n'+
'{	\n'+
'"trifAmountExce":6.0,	\n'+
'"factor":"KG",	\n'+
'"serviceId":"SEG-DS",	\n'+
'"refrServiceId":"SEG-D",	\n'+
'"serviceTrif":[	\n'+
'{	\n'+
'"serviceId":null,	\n'+
'"refServiceId":null,	\n'+
'"trifAmount":200.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":"KG",	\n'+
'"factorValue":2.0,	\n'+
'"servicesCant":null,	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'}	\n'+
'],	\n'+
'"otherServiceTrif":[	\n'+
'{	\n'+
'"serviceId":"EAD-CITA-1",	\n'+
'"refServiceId":"EAD-CITA",	\n'+
'"trifAmount":1.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":"NON",	\n'+
'"factorValue":null,	\n'+
'"servicesCant":"K",	\n'+
'"quotation":"Q-02644"	\n'+
'},	\n'+
'{	\n'+
'"serviceId":"MAN-1",	\n'+
'"refServiceId":"MAN",	\n'+
'"trifAmount":1.0,	\n'+
'"trifAmntBase":0.0,	\n'+
'"discount":0.0,	\n'+
'"factor":"NON",	\n'+
'"factorValue":null,	\n'+
'"servicesCant":"K",	\n'+
'"quotation":"Q-02644"	\n'+
'}	\n'+
']	\n'+
'}	\n'+
']	\n'+
'}	\n'+
'],	\n'+
'"kmConfig":null	\n'+
'},	\n'+
'"objectDTO":null,	\n'+
'"time":null	\n'+
'}	\n'+
'}	\n'+
'	}';
        
        ObjDocEnLinea.documentacionRemota DR = (ObjDocEnLinea.documentacionRemota)JSON.deserialize(strJson2, ObjDocEnLinea.documentacionRemota.class);
        PageReference pageRef = Page.GrabadoDocEnLinea;
        Apexpages.StandardController sc = new Apexpages.StandardController(cuenta);
        pageRef.getParameters().put('recordId', cuenta.Id_SIpWeb__c);
        PAQ_ConveniosSipweb_CTR PQ = new PAQ_ConveniosSipweb_CTR(sc);
        PQ.AsignaResponseTest(DR);
        //PQ.CargaInfoSipweb();
        Test.setCurrentPage(pageRef);
        test.stopTest();
    }
    @isTest
    static void Prueba3(){
        Test.startTest();
        Account cuenta = new Account(
            Name='MERCADO LIBRE - CUENTA DE PRUEBA',
            Numero__c = 1235,
            Colonia__c = 'test colonia',
            Piso_envio__c = 'test piso envio',
            Zona_envio__c = 'zona envio',
            Colonia_Facturaci_n__c = 'colonia facturacion',
            Potencial_mensual_de_envios__c = 1000000,
            Potencial_mensual_Total__c = 1000000,
            ShippingPostalCode = '01010',
            BillingPostalCode = '01010',
            Sucursal__c = 'a022E00000YQPtqQAH',
            Piso_facturacion__c = 'Piso',
            Zona_facturacion__c = 'Zona',
            RFC__c = 'OICN9010254P',
            Id_SIpWeb__c = '789',
            Tipo_cotizador__c = 'Documentación en piso sipweb',
            OwnerId = UserInfo.getUserId()
	
        );
        insert cuenta;
        String strJson2='{\n'+
'"header":null,\n'+
'"body":{\n'+
'"request":null,\n'+
'"response":{\n'+
'"success":true,\n'+
'"messages":null,\n'+
'"data":{\n'+
'"clntId":"13075550",\n'+
'"aprvUser":"ABARJONA",\n'+
'"trifType":"A",\n'+
'"pieceMulti":"",\n'+
'"quotation":null,\n'+
'"weight":0.0,\n'+
'"vol":0.0,\n'+
'"editAvg":"N",\n'+
'"migrationFrom":"",\n'+
'"ptpConfig":null,\n'+
'"kmConfig":[\n'+
'{\n'+
'"kmServicesTrif":[\n'+
'{\n'+
'"fromKm":0,\n'+
'"toKm":400,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":118.04,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":[\n'+
'{\n'+
'"slabNo":"S",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-E",\n'+
'"refServiceId":"ENVELOPES",\n'+
'"trifAmount":163.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T0",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":93.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T1",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":111.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T2",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":142.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T3",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":199.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T4",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":235.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T5",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":33.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":33.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":300.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T6",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":37.4,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":37.4,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":340.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7P",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":89.17,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":89.17,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":810.66,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7V",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":128.2,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":128.2,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":1165.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":6.0,\n'+
'"factor":"KG",\n'+
'"serviceId":"SEG-DS",\n'+
'"refrServiceId":"SEG-D",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":200.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":2.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":[\n'+
'{\n'+
'"serviceId":"MAN-1",\n'+
'"refServiceId":"MAN",\n'+
'"trifAmount":100.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"fromKm":401,\n'+
'"toKm":800,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":118.04,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":[\n'+
'{\n'+
'"slabNo":"S",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-E",\n'+
'"refServiceId":"ENVELOPES",\n'+
'"trifAmount":163.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T0",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":106.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T1",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":142.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T2",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":180.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T3",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":243.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T4",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":30.08,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":30.08,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":273.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T5",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":37.95,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":37.95,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":345.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T6",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":43.45,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":43.45,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":395.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7P",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":179.34,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":179.34,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":1630.33,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7V",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":218.62,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":218.62,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":1987.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":6.0,\n'+
'"factor":"KG",\n'+
'"serviceId":"SEG-DS",\n'+
'"refrServiceId":"SEG-D",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":200.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":2.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":[\n'+
'{\n'+
'"serviceId":"MAN-1",\n'+
'"refServiceId":"MAN",\n'+
'"trifAmount":100.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"fromKm":801,\n'+
'"toKm":1200,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":118.04,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":[\n'+
'{\n'+
'"slabNo":"S",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-E",\n'+
'"refServiceId":"ENVELOPES",\n'+
'"trifAmount":163.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T0",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":190.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T1",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":239.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T2",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":31.4,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":31.4,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":285.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T3",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":39.71,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":39.71,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":361.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T4",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":43.89,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":43.89,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":399.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T5",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":61.05,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":61.05,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":555.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T6",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":65.62,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":65.62,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":596.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7P",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":269.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":269.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":2450.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7V",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":378.73,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":378.73,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":3443.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":6.0,\n'+
'"factor":"KG",\n'+
'"serviceId":"SEG-DS",\n'+
'"refrServiceId":"SEG-D",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":200.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":2.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":[\n'+
'{\n'+
'"serviceId":"MAN-1",\n'+
'"refServiceId":"MAN",\n'+
'"trifAmount":100.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"fromKm":1201,\n'+
'"toKm":1600,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":118.04,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":[\n'+
'{\n'+
'"slabNo":"S",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-E",\n'+
'"refServiceId":"ENVELOPES",\n'+
'"trifAmount":163.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T0",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":215.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T1",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":29.32,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":29.32,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":266.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T2",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":36.3,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":36.3,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":330.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T3",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":45.76,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":45.76,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":416.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T4",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":48.29,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":48.29,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":439.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T5",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":70.4,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":70.4,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":640.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T6",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":73.81,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":73.81,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":671.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7P",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":359.66,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":359.66,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":3269.67,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7V",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":507.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":507.92,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":4617.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":6.0,\n'+
'"factor":"KG",\n'+
'"serviceId":"SEG-DS",\n'+
'"refrServiceId":"SEG-D",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":200.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":2.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":[\n'+
'{\n'+
'"serviceId":"MAN-1",\n'+
'"refServiceId":"MAN",\n'+
'"trifAmount":100.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"fromKm":1601,\n'+
'"toKm":2000,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":118.04,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":[\n'+
'{\n'+
'"slabNo":"S",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-E",\n'+
'"refServiceId":"ENVELOPES",\n'+
'"trifAmount":163.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T0",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":28.27,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":241.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T1",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":34.7,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":34.7,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":315.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T2",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":44.11,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":44.11,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":401.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T3",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":52.3,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":52.3,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":475.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T4",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":62.59,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":62.59,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":569.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T5",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":82.94,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":82.94,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":754.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T6",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":90.31,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":90.31,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":821.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7P",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":449.83,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":449.83,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":4089.34,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7V",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":587.18,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":587.18,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":5338.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":6.0,\n'+
'"factor":"KG",\n'+
'"serviceId":"SEG-DS",\n'+
'"refrServiceId":"SEG-D",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":200.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":2.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":[\n'+
'{\n'+
'"serviceId":"MAN-1",\n'+
'"refServiceId":"MAN",\n'+
'"trifAmount":100.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"fromKm":2001,\n'+
'"toKm":2400,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":118.04,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":[\n'+
'{\n'+
'"slabNo":"S",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-E",\n'+
'"refServiceId":"ENVELOPES",\n'+
'"trifAmount":163.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T0",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":30.69,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":30.69,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":279.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T1",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":40.98,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":40.98,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":372.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T2",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":50.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":50.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":463.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T3",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":59.62,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":59.62,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":542.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T4",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":71.66,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":71.66,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":651.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T5",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":91.36,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":91.36,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":830.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T6",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":106.76,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":106.76,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":970.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7P",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":539.99,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":539.99,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":4909.02,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7V",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":667.48,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":667.48,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":6068.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":6.0,\n'+
'"factor":"KG",\n'+
'"serviceId":"SEG-DS",\n'+
'"refrServiceId":"SEG-D",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":200.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":2.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":[\n'+
'{\n'+
'"serviceId":"MAN-1",\n'+
'"refServiceId":"MAN",\n'+
'"trifAmount":100.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"fromKm":2401,\n'+
'"toKm":9999,\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EXT-1",\n'+
'"refServiceId":"EXT",\n'+
'"trifAmount":118.04,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":0.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
'],\n'+
'"servicesTrifDtl":[\n'+
'{\n'+
'"slabNo":"S",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":18.03,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-E",\n'+
'"refServiceId":"ENVELOPES",\n'+
'"trifAmount":163.93,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T0",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":33.77,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":33.77,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":307.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T1",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":45.1,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":45.1,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":410.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T2",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":55.99,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":55.99,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":509.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T3",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":66.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":66.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":600.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T4",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":77.33,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":77.33,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":703.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T5",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":100.48,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":100.48,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":913.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T6",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":115.28,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":115.28,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":1048.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":null,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7P",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":630.16,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":630.16,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":5728.69,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'},\n'+
'{\n'+
'"slabNo":"T7V",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":"EAD-1",\n'+
'"refServiceId":"EAD",\n'+
'"trifAmount":782.6,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"RAD-1",\n'+
'"refServiceId":"RAD",\n'+
'"trifAmount":782.6,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'},\n'+
'{\n'+
'"serviceId":"SHP-G",\n'+
'"refServiceId":"PACKETS",\n'+
'"trifAmount":7114.5,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":null,\n'+
'"factorValue":1.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"servicesTrifCbe":[\n'+
'{\n'+
'"trifAmountExce":6.0,\n'+
'"factor":"KG",\n'+
'"serviceId":"SEG-DS",\n'+
'"refrServiceId":"SEG-D",\n'+
'"serviceTrif":[\n'+
'{\n'+
'"serviceId":null,\n'+
'"refServiceId":null,\n'+
'"trifAmount":200.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"KG",\n'+
'"factorValue":2.0,\n'+
'"servicesCant":null,\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
'],\n'+
'"otherServiceTrif":[\n'+
'{\n'+
'"serviceId":"MAN-1",\n'+
'"refServiceId":"MAN",\n'+
'"trifAmount":100.0,\n'+
'"trifAmntBase":0.0,\n'+
'"discount":0.0,\n'+
'"factor":"NON",\n'+
'"factorValue":null,\n'+
'"servicesCant":"G",\n'+
'"quotation":"Q-02643"\n'+
'}\n'+
']\n'+
'}\n'+
']\n'+
'}\n'+
']\n'+
'},\n'+
'"objectDTO":null,\n'+
'"time":null\n'+
'}\n'+
'}\n'+
'}';
		ObjDocEnLinea.documentacionRemota DR = (ObjDocEnLinea.documentacionRemota)JSON.deserialize(strJson2, ObjDocEnLinea.documentacionRemota.class);
        PageReference pageRef = Page.GrabadoDocEnLinea;
        Apexpages.StandardController sc = new Apexpages.StandardController(cuenta);
        pageRef.getParameters().put('recordId', cuenta.Id_SIpWeb__c);
        PAQ_ConveniosSipweb_CTR PQ = new PAQ_ConveniosSipweb_CTR(sc);
        PQ.AsignaResponseTest(DR);
        //PQ.CargaInfoSipweb();
        Test.setCurrentPage(pageRef);
        Test.stopTest();
    }
}
