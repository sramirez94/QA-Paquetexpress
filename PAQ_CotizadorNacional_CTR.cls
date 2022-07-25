/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-27-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   09-24-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class PAQ_CotizadorNacional_CTR {
    public String   strQuoteId      {get; set;}
    public String   strLeadId       {get; set;}
    public String   strCaseId       {get; set;}
    public String   strAccId        {get; set;}
    public String   strOppId        {get; set;}
    public String   profileObj      {get; set;}

    public PAQ_CotizadorNacional_CTR (){
        this.profileObj = getProfileObj();
    }

    @RemoteAction
    public static Wrapper InitialInfo(String strLeadId, String strQuoteId, String strOppId){
        Wrapper wp               = new Wrapper();
        String strYear           = '';
        Set<String> setDestinies = new Set<String>();
        if(String.isNotBlank(strQuoteId)) {
            wp.objQuote = queryQuote(strQuoteId);
            wp.listQuoteItem = queryQuoteItem(strQuoteId);
            for (SBQQ__QuoteLine__c quoyeItem : wp.listQuoteItem){
                if(quoyeItem.Servicio__c == 'Estándar terrestre (STD)' && wp.listPackages.isEmpty())
                    wp.listPackages = queryPackages(quoyeItem.Id);
                if(String.isNotBlank(quoyeItem.Destiny__c))
                    setDestinies.add(quoyeItem.Destiny__c);
            }

            for(Distancia_entre_sucursales__c objDestiny : queryDestinies(wp.objQuote.Plaza__c, setDestinies))
                if(!wp.mapDestiny.containsKey(objDestiny.Destino__c))
                    wp.mapDestiny.put(objDestiny.Destino__c, objDestiny.Rangos_km__c);

            if(wp.objQuote.Fecha_de_creacion_sugar__c != null){
                Date currentDate = Date.today();
                if(wp.objQuote.Fecha_de_creacion_sugar__c.year() < currentDate.year())
                    strYear = String.valueOf(wp.objQuote.Fecha_de_creacion_sugar__c.year());
            }
        }
        for(CapacidadSucursal__c tender : queryTender())
			wp.mapTender.put(tender.Name, tender);
        if(String.isBlank(strYear))
            for (AcusePorGuia__mdt objACK : queryACK())
                wp.mapACK.put(objACK.Label, objACK.Amount__c);
        if(String.isBlank(strYear))
        for(ServicioDomicilio__c objService : queryDomesticService()){
            if(!wp.mapDomesticService.containsKey(objService.Servicio__c))
                wp.mapDomesticService.put(objService.Servicio__c, new Map<String, ServicioDomicilio__c>{objService.Tamanio__c => objService});
            else if(!wp.mapDomesticService.get(objService.Servicio__c).containsKey(objService.Tamanio__c))
                wp.mapDomesticService.get(objService.Servicio__c).put(objService.Tamanio__c, objService);

        }
        else
            for(ServicioDomicilio__c objService : queryDomesticService(strYear))
                switch on objService.Servicio__c {
            when 'RAD' {
                if(!wp.mapDomesticService.containsKey(objService.Servicio__c))
                    wp.mapDomesticService.put(objService.Servicio__c, new Map<String, ServicioDomicilio__c>{objService.Tamanio__c => objService});
                else if(!wp.mapDomesticService.get(objService.Servicio__c).containsKey(objService.Tamanio__c))
                    wp.mapDomesticService.get(objService.Servicio__c).put(objService.Tamanio__c, objService);
            }
            when 'EAD' {
                if(!wp.mapDomesticService.containsKey(objService.Servicio__c))
                    wp.mapDomesticService.put(objService.Servicio__c, new Map<String, ServicioDomicilio__c>{objService.Tamanio__c => objService});
                else if(!wp.mapDomesticService.get(objService.Servicio__c).containsKey(objService.Tamanio__c))
                    wp.mapDomesticService.get(objService.Servicio__c).put(objService.Tamanio__c, objService);
            }
            when 'AEZP' {
                wp.mapCS.put('AEZP', objService.CostoMinimo__c);
            }
            when 'SEG' {
                wp.mapCS.put('SEG', objService.CostoMinimo__c);
            }
            when 'IVA' {
                wp.mapCS.put('IVA', objService.CostoSobreFlete__c);
            }
            when 'EAD-PP' {
                wp.mapCS.put('EAD', objService.CostoSobreFlete__c);
            }
            when 'RAD-PP' {
                wp.mapCS.put('RAD', objService.CostoSobreFlete__c);
            }
            when 'CPV' {
                wp.mapCS.put('CPV', objService.CostoMinimo__c);
            }
            when 'MinEAD' {
                wp.mapCS.put('MinEAD', objService.CostoMinimo__c);
            }
            when 'MinRAD' {
                wp.mapCS.put('MinRAD', objService.CostoMinimo__c);
            }
            when 'ACK-Interno' {
                wp.mapACK.put('Interno', objService.CostoMinimo__c);
            }
            when 'ACK-XT' {
                wp.mapACK.put('XT', objService.CostoMinimo__c);
            }
            when 'ACK-Empresa' {
                wp.mapACK.put('Empresa', objService.CostoMinimo__c);
            }
            /*when else {
			}*/
        }


        if(String.isBlank(strYear))
            wp.mapCS = queryCustomSetting([SELECT Id FROM Profile Where Name = 'System Administrator' OR Name = 'Administrador del sistema'].Id);

        if(String.isBlank(strYear)){
            for(Tarifario_general_terrestre__c objTarifarioT: queryTarifarioTFull())
                if(!wp.mapTarifarioT.containsKey(objTarifarioT.Tarifa__c))
                    wp.mapTarifarioT.put(objTarifarioT.Tarifa__c, new Map<String, Tarifario_general_terrestre__c>{objTarifarioT.RangoKM__c => objTarifarioT});
                else if (!wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).containsKey(objTarifarioT.RangoKM__c))
                    wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).put(objTarifarioT.RangoKM__c, objTarifarioT);
        }
        else {
            for (Tarifario_general_terrestre__c objTarifarioT : queryTarifarioTFull(strYear))
                if (!wp.mapTarifarioT.containsKey(objTarifarioT.Tarifa__c))
                wp.mapTarifarioT.put(objTarifarioT.Tarifa__c, new Map<String, Tarifario_general_terrestre__c>{
                        objTarifarioT.RangoKM__c => objTarifarioT
                });
                else if (!wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).containsKey(objTarifarioT.RangoKM__c))
                    wp.mapTarifarioT.get(objTarifarioT.Tarifa__c).put(objTarifarioT.RangoKM__c, objTarifarioT);
        }
        if( wp.objQuote.Modelo_de_tarifas__c == 'Tarifario abierto de piso'
                && wp.objQuote.TipoCotizacion__c == 'Por envío'
                && String.isNotBlank(wp.objQuote.OriginPostalCode__c)
                && String.isNotBlank(wp.objQuote.SBQQ__ShippingPostalCode__c)
                && String.isNotBlank(wp.objQuote.OriginCity__c)
                && String.isNotBlank(wp.objQuote.SBQQ__ShippingCity__c)
        ){
            if(String.isBlank(strYear)){
                Wrapper objWP = getSucursales(wp.objQuote.OriginPostalCode__c,  wp.objQuote.SBQQ__ShippingPostalCode__c, wp.objQuote.OriginCity__c, wp.objQuote.SBQQ__ShippingCity__c, null);
                wp.mapSursalByZipCode = objWP.mapSursalByZipCode;
                wp.objDistance = objWP.objDistance;
                wp.mapTarifario = objWP.mapTarifario;
            }
            else{
                Wrapper objWP = getSucursales(wp.objQuote.OriginPostalCode__c,  wp.objQuote.SBQQ__ShippingPostalCode__c, wp.objQuote.OriginCity__c, wp.objQuote.SBQQ__ShippingCity__c, strYear);
                wp.mapSursalByZipCode = objWP.mapSursalByZipCode;
                wp.objDistance = objWP.objDistance;
                wp.mapTarifario = objWP.mapTarifario;
            }
        }

        if(String.isNotBlank(strLeadId))
            wp.objLead = queryLead(strLeadId);
        else if(wp.objQuote != null && String.isNotBlank(wp.objQuote.Lead__c))
            wp.objLead = queryLead(wp.objQuote.Lead__c);

        if(String.isNotBlank(strOppId)){
            wp.objOpp = queryOpportunity(strOppId);
            wp.listPrevQuotes = queryPrevQuote(strOppId);

        }
        else if(wp.objQuote != null && String.isNotBlank(wp.objQuote.SBQQ__Opportunity2__c))
            wp.objOpp = queryOpportunity(wp.objQuote.SBQQ__Opportunity2__c);

        wp.objEstructura = queryEstructura(wp.objLead.Sucursal__c, wp.objOpp.Account.Sucursal__c);

        if(String.isBlank(strYear)){
            for(Tarifario__c tarifaEXP : queryFullTarifario())
                if(!wp.mapTarifarioEXP.containsKey(tarifaEXP.Tarifa__c))
                    wp.mapTarifarioEXP.put(tarifaEXP.Tarifa__c, new Map<String, Tarifario__c>{ tarifaEXP.Rango_km__c => tarifaEXP });
                else if(!wp.mapTarifarioEXP.get(tarifaEXP.Tarifa__c).containsKey(tarifaEXP.Rango_km__c))
                    wp.mapTarifarioEXP.get(tarifaEXP.Tarifa__c).put(tarifaEXP.Rango_km__c, tarifaEXP);
        }
        else{
            for(Tarifario__c tarifaEXP : queryFullTarifario(strYear))
                if(!wp.mapTarifarioEXP.containsKey(tarifaEXP.Tarifa__c))
                    wp.mapTarifarioEXP.put(tarifaEXP.Tarifa__c, new Map<String, Tarifario__c>{ tarifaEXP.Rango_km__c => tarifaEXP });
                else if(!wp.mapTarifarioEXP.get(tarifaEXP.Tarifa__c).containsKey(tarifaEXP.Rango_km__c))
                    wp.mapTarifarioEXP.get(tarifaEXP.Tarifa__c).put(tarifaEXP.Rango_km__c, tarifaEXP);
        }

        if(wp.objQuote.Tipo_de_documentacion__c == 'Documentación Remota')
            wp.listSS = querySS(wp.objQuote.Id);

        for(RecordType objRT: queryRecordType())
            wp.mapRecordType.put(objRT.DeveloperName , objRT.Id);

        return wp;
    }

    @RemoteAction
    public static Map<String, CoberturaPorCodigoPostal__c> getPlaceInfo(String strZipCode){
        Map<String, CoberturaPorCodigoPostal__c> mapPlace = new Map<String, CoberturaPorCodigoPostal__c>();
        for(CoberturaPorCodigoPostal__c objCob : querySucursalByZipCode(strZipCode))
            mapPlace.put(objCob.Colonia__c , objCob);
        return mapPlace;
    }

    @RemoteAction
    public static Wrapper getSucursales(String strOrigin, String strDestiny, String strColoniaOrigin, String strColoniaDestiny, String strYear){
        Wrapper wp              = new Wrapper();
        String strPlazaOrigen, strPlazaDestino;

        for (CoberturaPorCodigoPostal__c objSUC : querySucursales(strOrigin, strDestiny, strColoniaOrigin, strColoniaDestiny))
            if(wp.mapSursalByZipCode.containsKey(objSUC.CodigoPostal__c))
                wp.mapSursalByZipCode.get(objSUC.CodigoPostal__c).put(objSUC.Colonia__c, objSUC);
            else
                wp.mapSursalByZipCode.put(objSUC.CodigoPostal__c, new Map<String,CoberturaPorCodigoPostal__c>{ objSUC.Colonia__c => objSUC});



        if(wp.mapSursalByZipCode.keySet().size() == 2){
            if(wp.mapSursalByZipCode.get(strOrigin).containsKey(strColoniaOrigin))
                strPlazaOrigen = wp.mapSursalByZipCode.get(strOrigin).get(strColoniaOrigin).Plaza__c;

            if(wp.mapSursalByZipCode.get(strDestiny).containsKey(strColoniaDestiny))
                strPlazaDestino = wp.mapSursalByZipCode.get(strDestiny).get(strColoniaDestiny).Plaza__c;

            wp.objDistance = queryDistanceSuc(strPlazaOrigen, strPlazaDestino);

        }
        if(wp.objDistance != null){
            if(String.isBlank(strYear))
                for(Tarifario__c objTarifario : queryTarifario(wp.objDistance.Rangos_km__c))
                    wp.mapTarifario.put(objTarifario.Tarifa__c , objTarifario);
            else
                for(Tarifario__c objTarifario : queryTarifario(wp.objDistance.Rangos_km__c, strYear))
                    wp.mapTarifario.put(objTarifario.Tarifa__c , objTarifario);

            /*for(Tarifario_general_terrestre__c objTarifarioT: queryTarifarioT(wp.objDistance.Rangos_km__c))
				wp.mapTarifarioT.put(objTarifarioT.Tarifa__c , objTarifarioT);*/

        }
        return wp;
    }

    /*@RemoteAction
    public static DmlWrapper saveQuote(SBQQ__Quote__c Quote, List<SBQQ__QuoteLine__c> listQuoteItem, List<SBQQ__QuoteLinePricingGuidance__c> listPack, Lead objLead, Opportunity objOpp){
        System.debug(LoggingLevel.DEBUG,'[FR] saveQuote --> listPack size'+ listPack.size());
        for(SBQQ__QuoteLinePricingGuidance__c objPack: listPack)
            System.debug(LoggingLevel.DEBUG,'[FR] saveQuote --> listPack itertion'+ JSON.serialize(objPack));

        DmlWrapper wp = new DmlWrapper();
        Database.SaveResult quoteInsResult = Database.insert(Quote, false);
        if(quoteInsResult.isSuccess())
            wp.blnSuccess = true;
        else
            for(Database.Error errorInsQuote: quoteInsResult.getErrors())
                wp.listErrors.add('Insert Quote: ' + errorInsQuote.getMessage());

        if(wp.blnSuccess)
            wp.strIdQuote = quoteInsResult.getId();

        wp.objQuote = [SELECT Id
        , SBQQ__Status__c
        , PAQ_TipoServicio__c
        , Tipo_de_documentacion__c
        , Descuento_por_linea_o_rangokm__c
        , Descuento_Global__c
        , SBQQ__Opportunity2__c
        , Lead__c
        FROM SBQQ__Quote__c
        WHERE Id =: quoteInsResult.getId()
        ];

        for(SBQQ__QuoteLine__c quoteItem: listQuoteItem){
            quoteItem.SBQQ__Quote__c = quoteInsResult.getId();
            Database.SaveResult qItemInsResult = Database.insert(quoteItem, false);
            System.debug(LoggingLevel.DEBUG,'[FR] saveQuote --> quoteItem.Servicio__c'+ quoteItem.Servicio__c);
            if(!qItemInsResult.isSuccess()) {
                wp.blnSuccess = false;
                for (Database.Error errorInsItemQuote : qItemInsResult.getErrors())
                    wp.listErrors.add('Insert QuoteItem: ' + errorInsItemQuote.getMessage());
            }
            else if(quoteItem.Servicio__c == 'Estándar terrestre (STD)') {
                System.debug(LoggingLevel.DEBUG,'[FR] saveQuote --> qItemInsResult.getId()'+ qItemInsResult.getId());
                for (SBQQ__QuoteLinePricingGuidance__c packItem : listPack) {
                    packItem.SBQQ__QuoteLine__c = qItemInsResult.getId();
                    Database.SaveResult qPackIns = Database.insert(packItem, false);
                    System.debug(LoggingLevel.DEBUG,'[FR] saveQuote --> qPackIns'+ JSON.serialize(qPackIns));
                    if (!qPackIns.isSuccess()) {
                        wp.blnSuccess = false;
                        for (
                                Database.Error errorInsItemQuote
                                :
                        qPackIns.getErrors())
                            wp.listErrors.add('Insert Pack: ' + errorInsItemQuote.getMessage());
                    }
                }
            }
        }

        if(objLead != null){
            Database.SaveResult resLead = Database.update(objLead, false);
            if(!resLead.isSuccess()){
                wp.blnSuccess = false;
                for(Database.Error errLead : resLead.getErrors())
                    wp.listErrors.add(errLead.getMessage());
            }
        }
        if(objOpp != null) {
            Database.SaveResult resOpp = Database.update(objOpp, false);
            if (!resOpp.isSuccess()) {
                wp.blnSuccess = false;
                for (Database.Error errOpp : resOpp.getErrors())
                    wp.listErrors.add(errOpp.getMessage());
            }
        }

        return wp;
    }

    @RemoteAction
    public static DmlWrapper updateQuote(SBQQ__Quote__c Quote, List<SBQQ__QuoteLine__c> listQuoteItem, List<SBQQ__QuoteLinePricingGuidance__c> listPack, Lead objLead, Opportunity objOpp){
        DmlWrapper wp = new DmlWrapper();
        Database.UpsertResult quoteUpd = Database.upsert(Quote, false);
        if(quoteUpd.isSuccess())
            wp.blnSuccess = true;
        else
            for(Database.Error errorInsQuote: quoteUpd.getErrors())
                wp.listErrors.add('Update Quote: ' + errorInsQuote.getMessage());

        for(Database.UpsertResult qItemUpd : Database.upsert(listQuoteItem, false))
            if(!qItemUpd.isSuccess()){
                wp.blnSuccess = false;
                for(Database.Error errorInsQuote: qItemUpd.getErrors())
                    wp.listErrors.add('Update QuoteItem: ' + errorInsQuote.getMessage());
            }

        for(Database.UpsertResult qPackUpd : Database.upsert(listPack, false))
            if(!qPackUpd.isSuccess()){
                wp.blnSuccess = false;
                for(Database.Error errorInsQuote: qPackUpd.getErrors())
                    wp.listErrors.add('Update Pack: ' + errorInsQuote.getMessage());
            }
        if(objLead != null){
            Database.SaveResult resLead = Database.update(objLead, false);
            if(!resLead.isSuccess()){
                wp.blnSuccess = false;
                for(Database.Error errLead : resLead.getErrors())
                    wp.listErrors.add(errLead.getMessage());
            }
        }
        if(objOpp != null) {
            Database.SaveResult resOpp = Database.update(objOpp, false);
            if (!resOpp.isSuccess()) {
                wp.blnSuccess = false;
                for (Database.Error errOpp : resOpp.getErrors())
                    wp.listErrors.add(errOpp.getMessage());
            }
        }
        return wp;
    }*/

    @RemoteAction
    public static DmlWrapper saveQuoteConv(SBQQ__Quote__c objQuote, List<SBQQ__QuoteLine__c> listQuoteItem, Lead objLead, Opportunity objOpp, List<PAQ_SpecialService__c> listSS){
        DmlWrapper wp = new DmlWrapper();
        Database.SaveResult quoteInsResult = Database.insert(objQuote, false);
        if(quoteInsResult.isSuccess()){
            wp.objQuote = queryQuote(quoteInsResult.getId());
            wp.blnSuccess = true;
        }
        else{
			wp.blnSuccess = false;
			for(Database.Error errorInsQuote: quoteInsResult.getErrors())
				wp.listErrors.add('Error creando Cotización: ' + errorInsQuote.getMessage());
		}

        if(wp.blnSuccess){
            for(SBQQ__QuoteLine__c quoteItem : listQuoteItem){
                System.debug('tarifa que va a guardarse: ' + quoteItem.Tarifa__c);
                quoteItem.SBQQ__Quote__c = quoteInsResult.getId();
            }

            for(Database.SaveResult qItemInsResult : Database.insert(listQuoteItem, false)){
                if(!qItemInsResult.isSuccess()) {
					wp.blnSuccess = false;
					for (Database.Error errorInsItemQuote : qItemInsResult.getErrors())
						wp.listErrors.add('Error creando partida de cotización: ' + errorInsItemQuote.getMessage());
				}
            }
            wp.listQuoteItems = queryQuoteItem(wp.objQuote.Id);
        }
        if(objLead != null){
            if(quoteInsResult.isSuccess())
                objLead.Cotizacion_Principal__c = quoteInsResult.getId();
            Database.SaveResult resLead = Database.update(objLead, false);
            if(!resLead.isSuccess()){
                wp.blnSuccess = false;
                for(Database.Error errLead : resLead.getErrors())
                    wp.listErrors.add('Error actualizando Prospecto: ' + errLead.getMessage());
            }
        }
        if(objOpp != null){
            Database.SaveResult resOpp = Database.update(objOpp, false);
            if(!resOpp.isSuccess()){
				wp.blnSuccess = false;
                for(Database.Error errOpp : resOpp.getErrors())
                    wp.listErrors.add( 'Error actualizando Oportunidad: ' + errOpp.getMessage());
            }
        }
        if(listSS != null){
            for(PAQ_SpecialService__c SSitem: listSS)
                SSitem.Quote__c = quoteInsResult.getId();

            for(Database.SaveResult insSS : Database.insert(listSS, false)){
                if(!insSS.isSuccess()) {
					wp.blnSuccess = false;
					for (Database.Error ssErr : insSS.getErrors())
						wp.listErrors.add('Error creando Servicio Especial: ' + ssErr.getMessage());
				}
            }
        }
        return wp;
    }
    @RemoteAction
    public static DmlWrapper EliminaPartidasAnteriores(String strQuoteId, List<SBQQ__QuoteLine__c> listQuoteItem, SBQQ__Quote__c objQuote){
        /*Salvador Ramírez (sramirez@freewayconsulting.com): Se elabora esta función para uso especificamente del cotizador de costo base más excedente debido a los problemas que había para editar sus partidas de presupuesto puesto que no siempre coincidía el ID al que pertenecía.
                                                            Esta función elimina primero las partidas de presupuesto que existen en la cotización, actualiza la cabecera de la cotización y posteriormente crea las partidas con la nueva información.*/
        DmlWrapper wp = new DmlWrapper();
        System.debug('id de cotización: ' + strQuoteId);
        List<SBQQ__QuoteLine__c> QT = [SELECT Id, Tarifa__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :strQuoteId]; //Salvador Ramírez (sramirez@freewayconsulting.com): Se consultan las partidas de presupuesto existentes
        for(SBQQ__QuoteLine__c QL : QT){
            System.debug('tarifa que se va a borrar: ' + QL.Tarifa__c);
        }
        for(SBQQ__QuoteLine__c QL : listQuoteItem){
            System.debug('Tarifa que se va a guardar: ' + QL.Tarifa__c);
        }
        for(Database.DeleteResult delRes : Database.delete(QT, false)){ //Salvador Ramírez (sramirez@freewayconsulting.com): Se hace un recorrido sobre ellas para eliminarlas
            if(!delRes.isSuccess()){
                wp.blnSuccess = false;
                for(Database.Error errDel: delRes.getErrors())
                    wp.listErrors.add('Error eliminando partida de cotización: ' + errDel.getMessage());
            } else {
                wp.blnSuccess = true;
            }
        }
        Database.UpsertResult quoteInsResult = Database.upsert(objQuote, false); //Salvador Ramírez (sramirez@freewayconsulting.com): Se actualiza la cabecera de la cotización (SBQQ__Quote__c), esto ya que el subtotal, el total, los servicios y demás valores que se eligen en la cotización pueden variar
        if(quoteInsResult.isSuccess()){
			wp.objQuote = queryQuote(quoteInsResult.getId());
            wp.blnSuccess = true;
            /*for(SBQQ__QuoteLine__c quoteItem : listQuoteItem)
                quoteItem.SBQQ__Quote__c = quoteInsResult.getId();*/
		}
        else{
            wp.blnSuccess = false;
            for(Database.Error errorInsQuote: quoteInsResult.getErrors())
                wp.listErrors.add('Error actualizando Cotización: ' + errorInsQuote.getMessage());
        }
        /*for(Database.SaveResult qItemInsResult : Database.insert(listQuoteItem, false)){ //Salvador Ramírez (sramirez@freewayconsulting.com): Se crean las nuevas partidas de cotización
            if(!qItemInsResult.isSuccess()) {
                wp.blnSuccess = false;
                for (Database.Error errorInsItemQuote : qItemInsResult.getErrors())
                    wp.listErrors.add('Error creando partida de cotización: ' + errorInsItemQuote.getMessage());
            }
        }*/
        for(Database.UpsertResult qItemInsResult : Database.upsert(listQuoteItem, false)){
            if(!qItemInsResult.isSuccess()){
                wp.blnSuccess = false;
                for (Database.Error errorInsItemQuote : qItemInsResult.getErrors())
                    wp.listErrors.add('Error actualizando partida de cotización: ' + errorInsItemQuote.getMessage());
            }
        }
        return wp;
    }

    @RemoteAction
    public static DmlWrapper updateQuoteConv(SBQQ__Quote__c objQuote, List<SBQQ__QuoteLine__c> listQuoteItem, Lead objLead, Opportunity objOpp, List<String> listDeleteQuoteLine, List<PAQ_SpecialService__c> listSS, List<String> listDELSS){
        DmlWrapper wp = new DmlWrapper();
        Database.UpsertResult quoteInsResult = Database.upsert(objQuote, false);
        if(quoteInsResult.isSuccess()){
			wp.objQuote = queryQuote(quoteInsResult.getId());
            wp.blnSuccess = true;
		}
        else{
            wp.blnSuccess = false;
            for(Database.Error errorInsQuote: quoteInsResult.getErrors())
                wp.listErrors.add('Error actualizando Cotización: ' + errorInsQuote.getMessage());
        }

        for(Database.UpsertResult qItemInsResult : Database.upsert(listQuoteItem, false)){
            if(!qItemInsResult.isSuccess()){
                wp.blnSuccess = false;
                for (Database.Error errorInsItemQuote : qItemInsResult.getErrors())
                    wp.listErrors.add('Error actualizando partida de cotización: ' + errorInsItemQuote.getMessage());
            }
        }

		wp.listQuoteItems = queryQuoteItem(wp.objQuote.Id);

        if(objLead != null){
            Database.SaveResult resLead = Database.update(objLead, false);
            if(!resLead.isSuccess()){
                wp.blnSuccess = false;
                for(Database.Error errLead : resLead.getErrors()){
                    wp.listErrors.add( 'Error actualizando Prospecto: '+ errLead.getMessage());
                }
            }
        }
        if(objOpp != null) {
            Database.SaveResult resOpp = Database.update(objOpp, false);
            if (!resOpp.isSuccess()){
				wp.blnSuccess = false;
                for (Database.Error errOpp : resOpp.getErrors())
                    wp.listErrors.add('Error actualizando Oportunidad: ' + errOpp.getMessage());
            }
        }

        for(Database.DeleteResult delRes : Database.delete(listDeleteQuoteLine, false)){
            if(!delRes.isSuccess()){
                wp.blnSuccess = false;
                for(Database.Error errDel: delRes.getErrors())
                    wp.listErrors.add('Error eliminando partida de cotización: ' + errDel.getMessage());
            }
        }

        if(listSS != null) {
            for (Database.UpsertResult insSS : Database.upsert(listSS, false)) {
                if (!insSS.isSuccess()){
                    wp.blnSuccess = false;
                    for (Database.Error ssErr : insSS.getErrors())
                        wp.listErrors.add('Error actualizando Servicios Especiales: ' + ssErr.getMessage());
            	}
            }
        }
        if(listDELSS != null) {
            for(Database.DeleteResult delRes : Database.delete(listDELSS, false)){
                if(!delRes.isSuccess()){
                    wp.blnSuccess = false;
                    for(Database.Error errDel: delRes.getErrors())
                        wp.listErrors.add('Error eliminando Servicios Especiales:' + errDel.getMessage());

                }
            }
        }
        return wp;
    }

    @RemoteAction
    public static DmlWrapper sumbitAPP(String strIdQuote, String strApprovalProcess, String strComment) {
        DmlWrapper wp = new DmlWrapper();
        // Create an approval request for the account
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setObjectId(strIdQuote);
        // Submit on behalf of a specific submitter
        req.setSubmitterId(UserInfo.getUserId());
        // Add submition comments
        req.setComments(strComment);
        // Submit the record to specific process and skip the criteria evaluation
        //strApprovalProcess = getProcessName(strIdQuote);
        req.setProcessDefinitionNameOrId(strApprovalProcess);
        req.setSkipEntryCriteria(true);

        // Submit the approval request for the account
        if (String.isNotBlank(strApprovalProcess)){
            Approval.ProcessResult result = Approval.process(req);
            // Verify the result
            wp.blnSuccess = result.isSuccess();

            if (!result.isSuccess())
                for (Database.Error error : result.getErrors())
                    wp.listErrors.add(error.getMessage());
        }
        else {
            wp.blnSuccess = false;
            wp.listErrors.add('No se encontró ningun proceso de aprobación');
        }

       /* if(String.isNotBlank(gestorId)){
            // Create new sharing object for the custom object Quote.
            SBQQ__Quote__Share objShare  = new SBQQ__Quote__Share();

            // Set the ID of record being shared.
            objShare.ParentId = strIdQuote;

            // Set the ID of user or group being granted access.
            objShare.UserOrGroupId = gestorId;

            // Set the access level.
            objShare.AccessLevel = 'edit';

            // Set rowCause to 'manual' for manual sharing.
            // This line can be omitted as 'manual' is the default value for sharing objects.
            objShare.RowCause = Schema.SBQQ__Quote__Share.RowCause.Manual;

            // Insert the sharing record and capture the save result.
            // The false parameter allows for partial processing if multiple records passed
            // into the operation.
            Database.SaveResult resShareINS = Database.insert(objShare,false);

            if (!resShareINS.isSuccess()){
                wp.blnSuccess = resShareINS.isSuccess();
                for (Database.Error errorShare : resShareINS.getErrors())
                    wp.listErrors.add(errorShare.getMessage());
            }
        }*/

        return wp;
    }

    @RemoteAction
    public static Wrapper getHierarchyUser(){
        Wrapper wp = new Wrapper();
        User objManager;
        System.debug('userinfo nombre: ' + UserInfo.getName() + '. Id: ' + UserInfo.getUserId());
        objManager = getManager(UserInfo.getUserId());
        System.debug('name: ' + objManager.UserRole.Name);
        if(objManager.UserRole.Name != null && (objManager.UserRole.Name.Contains('EJECUTIVOS TELEMARKETING (18)') || objManager.UserRole.Name.Contains('SUPERVISOR TELEMARKETING') || objManager.UserRole.Name.Contains('GERENCIA MARKETING Y PDV'))){
            wp.mapHierarchy = functionUsers();
        }    
        for(CapacidadSucursal__c tender : queryTender())
			wp.mapTender.put(tender.Name, tender);
        return wp;
    }

    @RemoteAction
    public static DmlWrapper updateStatusQuote(SBQQ__Quote__c objQuote, String strAccount){
        DmlWrapper wp = new DmlWrapper();
        Database.SaveResult quoteInsResult = Database.update(objQuote, false);
        System.debug(LoggingLevel.DEBUG, 'quoteInsResult' + JSON.serialize(quoteInsResult));
        if(quoteInsResult.isSuccess())
            wp.blnSuccess = true;
        else
            for(Database.Error errorInsQuote: quoteInsResult.getErrors())
                wp.listErrors.add(errorInsQuote.getMessage());

        if(wp.blnSuccess)
            sentAlert(strAccount, objQuote.SBQQ__PaymentTerms__c, objQuote.Name, objQuote.Id, objQuote.Owner.Email);

        return wp;
    }

    @RemoteAction
    public static DmlWrapper checkDestiny(String strOrigin, String strDestiny){
        System.debug('Origen: ' + strOrigin + '. Destino: ' + strDestiny);
        DmlWrapper wp = new DmlWrapper();
        try{
            Distancia_entre_sucursales__c destiny = [SELECT Rangos_km__c FROM Distancia_entre_sucursales__c WHERE Origen__c =: strOrigin AND Destino__c =: strDestiny LIMIT 1];
            wp.strDestinyKM = destiny.Rangos_km__c;
            wp.blnSuccess = true;
        } catch (Exception Ex){
            System.debug(Ex.getMessage());
        }

        return wp;
    }
    
    @RemoteAction
    public static DmlWrapper checkCostoTender(String strOrigin, String strTender){
        System.debug('Entra a función');
        DmlWrapper wp = new DmlWrapper();
        try{
            System.debug('va a hacer consulta');
            CapacidadSucursal__C Tender = [SELECT Costo__C FROM CapacidadSucursal__C WHERE Name = :strTender LIMIT 1];
            System.debug('Hace consulta');
            wp.fltCosto = Tender.Costo__C;
            System.debug('Asigna valor');
            wp.blnSuccess = true;
            System.debug('activa bandera');
        } catch (Exception Ex){
            System.System.debug(Ex.getMessage());
        }
        return wp;
    }

    public static Wrapper getQuoteInfo(String strIdOpp){
        String strIdQuote = [SELECT Id
        FROM SBQQ__Quote__c
        WHERE SBQQ__Opportunity2__c=: strIdOpp
        AND SBQQ__Primary__c = true
        LIMIT 1].Id;

        Wrapper wp = InitialInfo('', strIdQuote, strIdOpp);
        return wp;
    }
    
    @RemoteAction
    public static map<string, string> functionUsers(){
        map<string, string> mapUs = new map<string, string>();
        set<String> setUser = new set<String>{
            'SUPERVISOR_TELEMARKETING',
            'GERENCIA_MARKETING_Y_PDV',
            'Director_Comercial'
        };
        list<User> Users = queryUser(setUser);
        
        for(integer i = 0; i < Users.size(); i++){
            mapUs.put(Users.get(i).UserRole.DeveloperName , Users.get(i).Id);
        }
        return mapUs;
    }

    /*
    public static Map<String, String> getHierarchy(){
        Map<String, String> mapH = new Map<String, String>();
        User objManager;
        objManager = getManager(UserInfo.getUserId());
        mapH.put(objManager.UserRole.Name, objManager.Id);
        if(String.isBlank(objManager.ManagerId))
            System.debug(objManager.UserRole.Name + ' Manager not found');

        while (String.isNotBlank(objManager.ManagerId)){
            objManager = getManager(objManager.ManagerId);
            mapH.put(objManager.UserRole.Name, objManager.Id);
        }
        return mapH;
    }*/

    public static void sentAlert(String strAccount, String strPaymentTerms, String strQuoteName, String strIdQuote, String strOwner){
        String strLink = 'https://paquetexpress--qa2020.lightning.force.com/lightning/r/SBQQ__Quote__c/'+ strIdQuote +'/view';
        String strTemplate  = '<table cellpadding="0" width="500" cellspacing="0" id="topTable" height="450"><tbody><tr valign="top"><td style=" background-color:#FFFFFF; bEditID:r1st1; bLabel:header; vertical-align:top; height:30px; text-align:left;"><img border="0" beditid="r1sp1" blabel="headerImage" id="r1sp1" src="https://paquetexpress--desarrollo.my.salesforce.com/servlet/servlet.ImageServer?id=0152f00000050H0&amp;oid=00D2f0000000OkA"></td></tr><tr valign="top"><td style=" background-color:#AAAAFF; bEditID:r2st1; bLabel:accent1; height:5;"></td></tr><tr valign="top"><td styleinsert="1" height="300" style=" background-color:#FFFFFF; bEditID:r3st1; color:#000000; bLabel:main; font-size:12pt; font-family:arial;"><table border="0" cellpadding="5" width="600" cellspacing="5" height="400"><tbody><tr valign="top" height="50"><td teditid="c1r1" style=" background-color:#FFFFFF; bEditID:r3st1; color:#000000; bLabel:main; font-size:12pt; font-family:arial;" aeditid="c1r1" locked="0"></td></tr><tr valign="top" height="300"><td teditid="c1r2" style=" background-color:#FFFFFF; bEditID:r3st1; color:#000000; bLabel:main; font-size:12pt; font-family:arial;" aeditid="c1r2" locked="0"><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin-bottom: 0.0001pt;"><span style="font-size:10.0pt" wfd-id="15">Se le notifica que su cotización para el cliente&nbsp;</span><b style="font-size: 12pt; background-color: rgb(255, 255, 255);"><span wfd-id="14" style="color: rgb(8, 7, 7); font-family: &quot;Salesforce Sans&quot;, Arial, sans-serif; font-size: 13px; white-space: pre-line;">'+ strAccount +'</span></b><span wfd-id="13" style="font-size: 10pt;">&nbsp;</span><b style="font-size: 12pt;"><span style="color: rgb(8, 7, 7); font-family: &quot;Salesforce Sans&quot;, Arial, sans-serif; font-size: 13px; white-space: pre-line;" wfd-id="12"></span></b><span wfd-id="11" style="font-size: 10pt;">&nbsp;ya se encuentra autorizada por todos los facultados.</span></p><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin-bottom: 0.0001pt;"><span style="font-size:10.0pt" wfd-id="10"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin-bottom: 0.0001pt;"><span style="font-size: 10pt;" wfd-id="9"><br>Favor de considerar que se añadieron lassiguientes condiciones especiales:</span></p><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin-bottom: 0.0001pt;"><span style="font-size:10.0pt;color:gray;mso-themecolor:background1;mso-themeshade:128" wfd-id="8"><br></span></p><p class="MsoNormal" style="margin: 0cm 0cm 0.0001pt 18pt;"><font color="#808080" face="arial"><span style="font-size: 13.3333px;" wfd-id="7"><i>'+ strPaymentTerms +'</i></span></font></p><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin: 0cm 0cm 0.0001pt 18pt;"><span style="font-size:10.0pt;color:gray;mso-themecolor:background1;mso-themeshade:128" wfd-id="6"><br></span></p><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin: 0cm 0cm 0.0001pt 18pt;"><br></p><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin-bottom: 0.0001pt;"><span style="font-size:10.0pt" wfd-id="5"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin-bottom: 0.0001pt;"><span style="color: rgb(0, 0, 0); font-family: arial; font-size: 10pt;" wfd-id="4">Folio de la cotización:&nbsp;</span><font face="arial"><span style="font-size: 13.3333px;" wfd-id="3">'+ strQuoteName +'.</span></font></p><p class="MsoNormal" style="color: rgb(0, 0, 0); font-family: arial; font-size: 12pt; margin-bottom: 0.0001pt;"><span style="font-size:10.0pt" wfd-id="1">Para más detalles <a href="'+ strLink +'"><span style="color:#0066FF" wfd-id="2">click aquí</span>.</a><o:p></o:p></span></p></td></tr><tr valign="top" height="50"><td teditid="c1r3" style=" background-color:#FFFFFF; bEditID:r3st1; color:#000000; bLabel:main; font-size:12pt; font-family:arial;" aeditid="c1r3" locked="0"></td></tr></tbody></table></td></tr><tr valign="top"><td style=" background-color:#AAAAFF; bEditID:r4st1; bLabel:accent2; height:5;"></td></tr><tr valign="top"><td style=" background-color:#FFFFFF; bEditID:r5st1; bLabel:footer; vertical-align:top; height:100; text-align:left;"></td></tr><tr valign="top"><td style=" background-color:#AAAAFF; bEditID:r6st1; bLabel:accent3; height:5;"></td></tr></tbody></table>';
        //EmailTemplate et = [SELECT Id,Subject, Body FROM EmailTemplate WHERE DeveloperName =:emailTemplateName];
        List<string> toAddress = new List<string>{
                'lzavala@paquetexpress.com.mx'
                , 'ktorres@paquetexpress.com.mx'
                , 'frojas@paquetexpress.com.mx'
                , strOwner
        };
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setTemplateId(et.Id);
        mail.setToAddresses(toAddress);
        mail.setSubject('Convenio autorizado');
        mail.setHTMLBody(strTemplate);
        // mail.setTargetObjectId(primaryContact);
        mail.setWhatId('a162f000000RFQe');
        mail.setSaveAsActivity(false);
        mail.setUseSignature(false);
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        allmsg.add(mail);

        try {
            Messaging.sendEmail(allmsg,false);
            return;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }

    /*
	*  Query Functions
	*/
    public static List<AcusePorGuia__mdt> queryACK(){
        List<AcusePorGuia__mdt> listACK = new List<AcusePorGuia__mdt>();
        try {
            listACK = [SELECT Id, Label, Amount__c FROM AcusePorGuia__mdt];
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage() + ' caused by: ' + ex.getCause());
        }
        return listACK;
    }

    public static Map<String, Decimal> queryCustomSetting(String pid){
        Map<String, Decimal> mapCS = new Map<String, Decimal>();
        Cotizador__c CSObj = Cotizador__c.getInstance(pid);
        mapCS.put('AEZP', CSObj.EntregaDomicilioZonaPlus__c);
        mapCS.put('SEG', CSObj.SeguroMillarDeclarado__c);
        mapCS.put('IVA', CSObj.IVA__c);
        mapCS.put('EAD', CSObj.EAD__c);
        mapCS.put('RAD', CSObj.RAD__c);
        mapCS.put('CPV', CSObj.CoeficientePV__c);
        mapCS.put('MinEAD', CSObj.MinEAD__c);
        mapCS.put('MinRAD', CSObj.MinRAD__c);
        return mapCS;
    }

    public static Distancia_entre_sucursales__c queryDistanceSuc(String strOrigin, String strDestiny){
        System.debug(LoggingLevel.DEBUG, strOrigin +', '+strDestiny);
        return [SELECT Id, Distancia__c, Rangos_km__c FROM Distancia_entre_sucursales__c WHERE Origen__c =: strOrigin AND Destino__c =: strDestiny];
    }

    public static List<ServicioDomicilio__c> queryDomesticService(){
        List<ServicioDomicilio__c> listService = new List<ServicioDomicilio__c>();
        try {
            listService = [SELECT Id
            , Name
            , CostoMinimo__c
            , CostoSobreFlete__c
            , Servicio__c
            , Tamanio__c
            , Guia__c
            , Paquete__c
            , RangoKM__c
            , PorKgBascula__c
            FROM ServicioDomicilio__c WHERE Year__c = null];
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage() + ' caused by: ' + ex.getCause());
        }
        return listService;
    }

    public static List<ServicioDomicilio__c> queryDomesticService(String strYear){
        List<ServicioDomicilio__c> listService = new List<ServicioDomicilio__c>();
        try {
            listService = [SELECT Id
            , Name
            , CostoMinimo__c
            , CostoSobreFlete__c
            , Servicio__c
            , Tamanio__c
            , Guia__c
            , Paquete__c
            , RangoKM__c
            , PorKgBascula__c
            FROM ServicioDomicilio__c
            WHERE Year__c =: strYear];
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage() + ' caused by: ' + ex.getCause());
        }
        return listService;
    }

    public static SBQQ__Quote__c queryQuote(String strQuoteId){
        return [SELECT Id
        , Acuse__c
        , AcuseCosto__c
        , Modelo_de_tarifas__c
        , Fecha_de_creacion_sugar__c
        , Servicios_adicionales__c
        , PAQ_TipoServicio__c
        , OriginPostalCode__c
        , SBQQ__ShippingPostalCode__c
        , OriginCity__c
        , SBQQ__ShippingCity__c
        , Descuento_maximo_de_servicios__c
        , OriginState__c
        , SBQQ__ShippingState__c
        , Tipo_de_documentacion__c
        , TipoCotizacion__c
        , AVRDeliveryACK__c
        , AVRPackByDelivery__c
        , Descuento_por_linea_o_rangokm__c
        , SBQQ__Status__c
        , SBQQ__Opportunity2__c
        , Lead__c
        , SBQQ__Account__c
        , CreatedDate
        , LastModifiedDate
        , Owner.Name
        , Name
        , Paquetes_Mensuales__c
        , Ingreso_Mensual__c
        , SBQQ__NetAmount__c
        , Descuento_Global__c
        , Owner.Email
        , SBQQ__PaymentTerms__c
        , Lead__r.Name
        , SBQQ__Account__r.Name
        , Descuento_M_ximo_por_Servicios_Express__c
        , Descuento_Global_Express__c
        , Descuento_por_linea_o_rango_km_Express__c
        , Plaza__c
        , RangosKM__c
        , Destinos__c
        ,Nombre_Prospecto__c
        ,Nombre_oportunidad__c
        ,Es_T7_Zona_plus__c
        FROM SBQQ__Quote__c
        WHERE Id =: strQuoteId];
    }

    public static List<SBQQ__Quote__c> queryPrevQuote(String strOppId){
        List<SBQQ__Quote__c> listApprovedQuotes = new List<SBQQ__Quote__c>();
        try {
            listApprovedQuotes = [SELECT
            Id
            , SBQQ__Status__c
            FROM SBQQ__Quote__c
            WHERE SBQQ__Opportunity2__c =: strOppId];
        } catch (Exception ex){
            System.debug('No Quotes Found');
        }
        return listApprovedQuotes;
    }

    public static Lead queryLead(String strLeadId){
        return [SELECT Hay_Cotizacion__c, Sucursal__c FROM Lead WHERE Id =: strLeadId];
    }
    
    public static List<User> queryUser(Set<String> strRole){
        return [SELECT id, UserRole.DeveloperName FROM  User WHERE IsActive = true AND UserRole.DeveloperName IN: strRole];
    }

    public static User getManager(String strRoleId){
        return [SELECT Id, UserRole.Name, ManagerId, UserRole.ParentRoleId FROM User WHERE Id =: strRoleId LIMIT 1];
    }

    public static Opportunity queryOpportunity(String strOppId){
        return [SELECT Hay_Cotizacion__c, Account.Sucursal__c FROM Opportunity WHERE Id =: strOppId];
    }

    public static String getProfileObj(){
        return [SELECT Name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name;
    }

    public static List<SBQQ__QuoteLine__c> queryQuoteItem(String strQuoteId){
        return [SELECT Id
        , SBQQ__Quantity__c
        , Pack_Seg__c
        , DiscountAcuse__c
        , DiscountFlete__c
        , DiscountRecolection__c
        , DiscountDelivery__c
        , DiscountSeg__c
        , DiscountGuia__c
        , Destiny__c
        , Servicio__c
        , PackWeightAVG__c
        , PackVolAVG__c
        , Weight__c
        , Large__c
        , High__c
        , Width__c
        , SBQQ__Discount__c
        , SBQQ__CustomerPrice__c
        , SBQQ__NetPrice__c
        , QuoteTotal__c
        , ACK__c
        , EAD__c
        , RAD__c
        , SEG__c
        , FLETE__c
        , GUIA__c
        , KG_ADICIONAL__c
        , Tarifa__c
        , Rango_KM__c
        , ZonaPlus__c
        , PAQ_QGuides__c
        , SBQQ__SpecialPrice__c
        , SBQQ__Description__c
        , PaqPorGuia__c
        , PaqPromPorGuia__c 
        FROM SBQQ__QuoteLine__c
        WHERE SBQQ__Quote__c =: strQuoteId
        ORDER BY CreatedDate ASC];
    }

    public static List<SBQQ__QuoteLinePricingGuidance__c> queryPackages(String strQuoteItemId){
        return [SELECT Id
        , PackHigh__c
        , PackWidth__c
        , PackQuantity__c
        , PackLarge__c
        , PackWeight__c
        , PackFee__c
        FROM SBQQ__QuoteLinePricingGuidance__c
        WHERE SBQQ__QuoteLine__c =: strQuoteItemId];
    }

    public static List<CoberturaPorCodigoPostal__c> querySucursales(String strOrigin, String strDestiny, String strColoniaOrigin, String strColoniaDestiny){
        List<CoberturaPorCodigoPostal__c> listSucursales = new List<CoberturaPorCodigoPostal__c>();
        try {
            listSucursales = [SELECT Id
            , Suc__c
            , Name
            , Plaza__c
            , Cobertura__c
            , Colonia__c
            , Estado__c
            , TamanioPlaza__c
            , CodigoPostal__c
            , Servicios_Disponibles__c
            FROM CoberturaPorCodigoPostal__c
            WHERE (Colonia__c =: strColoniaOrigin
            OR Colonia__c =: strColoniaDestiny)
            AND (CodigoPostal__c =: strOrigin
            OR CodigoPostal__c=: strDestiny)
            ];
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage() + ' caused by: ' + ex.getCause());
        }
        return listSucursales;
    }

    public static List<CoberturaPorCodigoPostal__c> querySucursalByZipCode(String strZipCode){
        List<CoberturaPorCodigoPostal__c> listSucursales = new List<CoberturaPorCodigoPostal__c>();
        try {
            listSucursales = [SELECT Id
            , Suc__c
            , Name
            , Plaza__c
            , Cobertura__c
            , Colonia__c
            , Estado__c
            , TamanioPlaza__c
            , Servicios_Disponibles__c
            , CodigoPostal__c  FROM CoberturaPorCodigoPostal__c WHERE CodigoPostal__c =: strZipCode ORDER BY Colonia__c];
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, ex.getMessage() + ' caused by: ' + ex.getCause());
        }
        return listSucursales;
    }

    public static List<Tarifario__c> queryTarifario(String strRangeKM){
        return [SELECT Id
        , GuiaDeArranque1Kg__c
        , Kg_adicional__c
        , Rango_km__c
        , Tarifa__c FROM Tarifario__c  WHERE Rango_km__c =: strRangeKM AND Year__c = null];
    }

    public static List<Tarifario__c> queryTarifario(String strRangeKM, String strYear){
        return [SELECT Id
        , GuiaDeArranque1Kg__c
        , Kg_adicional__c
        , Rango_km__c
        , Tarifa__c FROM Tarifario__c  WHERE Rango_km__c =: strRangeKM AND Year__c =: strYear];
    }

    public static List<Tarifario__c> queryFullTarifario(){
        return [SELECT Id
        , GuiaDeArranque1Kg__c
        , Kg_adicional__c
        , Rango_km__c
        , Tarifa__c FROM Tarifario__c WHERE Year__c = null];
    }

    public static List<Tarifario__c> queryFullTarifario(String strYear){
        return [SELECT Id
        , GuiaDeArranque1Kg__c
        , Kg_adicional__c
        , Rango_km__c
        , Tarifa__c FROM Tarifario__c WHERE Year__c =: strYear];
    }

    public static List<Tarifario_general_terrestre__c> queryTarifarioT(String strRangeKM){
        return [SELECT  Id
        , Tarifa__c
        , Flete__c
        , Name
        , PesoMaximo__c
        , VolumenMaximo__c
        , RangoKM__c
        FROM Tarifario_general_terrestre__c
        WHERE RangoKM__c =: strRangeKM];
    }

    public static List<Tarifario_general_terrestre__c> queryTarifarioTFull(){
        return [SELECT  Id
        , Tarifa__c
        , Flete__c
        , Name
        , PesoMaximo__c
        , VolumenMaximo__c
        , RangoKM__c
        FROM Tarifario_general_terrestre__c WHERE Year__c = null];
    }

    public static List<Tarifario_general_terrestre__c> queryTarifarioTFull(String strYear){
        return [SELECT  Id
        , Tarifa__c
        , Flete__c
        , Name
        , PesoMaximo__c
        , VolumenMaximo__c
        , RangoKM__c
        FROM Tarifario_general_terrestre__c
        WHERE Year__c =: strYear];
    }

    public static List<PAQ_SpecialService__c> querySS (String strIdQuote){
        List<PAQ_SpecialService__c> listSS = new List<PAQ_SpecialService__c>();
        try{
            listSS = [SELECT Id, Name, Amount__c, Option__c, Potencial__c, MainDesinations__c, RangoKM__c, Destiny__c FROM PAQ_SpecialService__c WHERE Quote__c =: strIdQuote];
        } catch (Exception ex){
            System.debug(ex.getMessage());
        }
        return listSS;
    }

    public static List<Distancia_entre_sucursales__c> queryDestinies(String strOrigin, Set<String> setDestinies){
        List<Distancia_entre_sucursales__c> listDestiny = new List<Distancia_entre_sucursales__c>();
        try{
            listDestiny = [SELECT Destino__c, Rangos_km__c FROM Distancia_entre_sucursales__c WHERE Origen__c =: strOrigin AND Destino__c IN: setDestinies ];
        }
        catch (Exception ex){
            System.debug(LoggingLevel.ERROR, ex.getMessage());
        }
        return listDestiny;
    }
    
    public static Estructura__c queryEstructura(String idSucLead, String idSucOpp){
        Estructura__c objEst;
        try {
            System.debug('idsuclead: ' + idSucLead + '. opp: ' + idSucOpp);
            if(String.isNotBlank(idSucLead))
                objEst = [SELECT Gerente_Sucursal__c, KAM_regional__c, Gerente_desarrollo_de_negocios__c, Director_Comercial__c FROM Estructura__c WHERE Sucursal__c =:idSucLead LIMIT 1];
            else if(String.isNotBlank(idSucOpp))
                objEst = [SELECT Gerente_Sucursal__c, KAM_regional__c, Gerente_desarrollo_de_negocios__c, Director_Comercial__c FROM Estructura__c WHERE Sucursal__c =:idSucOpp LIMIT 1];
        } catch (Exception ex){
            System.debug(LoggingLevel.ERROR, 'Error Query Estructura: ' + ex.getMessage());
        }
        return objEst;
    }

    public static List<RecordType> queryRecordType(){
        return [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = 'SBQQ__Quote__c'];
    }

    public static List<CapacidadSucursal__c> queryTender(){
		return [SELECT Name, Costo__c, Nivel__c, OP__c, Largo__c, Ancho__c, Alto__c, Peso__c FROM CapacidadSucursal__c ORDER BY Name];
	}
    /*
	*  Data Structure for calls
	*/
    public class Wrapper {
        public Map<String,Map<String, CoberturaPorCodigoPostal__c>>     mapSursalByZipCode  {get; set;}
        public Distancia_entre_sucursales__c                            objDistance         {get; set;}
        public Map<String, Tarifario__c>                                mapTarifario        {get; set;}
        public Map<String, Decimal>                                     mapACK              {get; set;}
        public Map<String, Decimal>                                     mapCS               {get; set;}
        public Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT       {get; set;}
        public Map<String, Map<String, Tarifario__c>>                   mapTarifarioEXP     {get; set;}
        public Map<String, Map<String, ServicioDomicilio__c>>           mapDomesticService  {get; set;}
        public Map<String, Map<String, ServicioDomicilio__c>>           mapSpecialService   {get; set;}
        public Map<String, String>                                      mapDestiny          {get; set;}
        public Map<String, String>                                      mapRecordType       {get; set;}
        public Lead                                                     objLead             {get; set;}
        public Opportunity                                              objOpp              {get; set;}
        public User                                                     objUser             {get; set;}
        public SBQQ__Quote__c                                           objQuote            {get; set;}
        public List<SBQQ__QuoteLine__c>                                 listQuoteItem       {get; set;}
        public List<SBQQ__QuoteLinePricingGuidance__c>                  listPackages        {get; set;}
        public Map<String, String>                                      mapHierarchy        {get; set;}
        public List<SBQQ__Quote__c>                                     listPrevQuotes      {get; set;}
        public List<PAQ_SpecialService__c>                              listSS              {get; set;}
        public Map<String, String>                                      mapUs               {get; set;}
        public Estructura__c                                            objEstructura       {get; set;}
        public Map<String, CapacidadSucursal__c> 		                mapTender			{get; set;}

        public Wrapper (){
            this.mapSursalByZipCode = new Map<String,Map<String, CoberturaPorCodigoPostal__c>>();
            this.mapTarifario       = new Map<String, Tarifario__c>();
            this.mapACK             = new Map<String, Decimal>();
            this.mapCS              = new Map<String, Decimal>();
            this.mapTarifarioT      = new Map<String, Map<String, Tarifario_general_terrestre__c>>();
            this.mapDomesticService = new Map<String, Map<String, ServicioDomicilio__c>>();
            this.mapSpecialService  = new Map<String, Map<String, ServicioDomicilio__c>>();
            this.listQuoteItem      = new List<SBQQ__QuoteLine__c>();
            this.listPackages       = new List<SBQQ__QuoteLinePricingGuidance__c>();
            this.mapHierarchy       = new Map<String, String>();
            this.mapTarifarioEXP    = new Map<String, Map<String, Tarifario__c>>();
            this.listPrevQuotes     = new List<SBQQ__Quote__c>();
            this.listSS             = new List<PAQ_SpecialService__c>();
            this.mapDestiny         = new Map<String, String>();
            this.mapRecordType      = new Map<String, String>();
            this.mapUs              = new map<String, String>();
            this.mapTender			= new Map<String, CapacidadSucursal__c>();
        }
    }

    public class DmlWrapper{
        public List<String> 			listErrors  	{get; set;}
        public Boolean      			blnSuccess  	{get; set;}
        public SBQQ__Quote__c 			objQuote  		{get; set;}
        public List<SBQQ__QuoteLine__c> listQuoteItems  {get; set;}
        public String                   strDestinyKM    {get; set;}
        public Decimal                  fltCosto        {get; set;}
        public DmlWrapper (){
            this.listErrors 	= new List<String>();
            this.blnSuccess 	= false;
            this.listQuoteItems = new List<SBQQ__QuoteLine__c>();
            this.fltCosto       = 0;
        }
    }
}
