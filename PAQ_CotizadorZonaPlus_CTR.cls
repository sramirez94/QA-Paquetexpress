public class PAQ_CotizadorZonaPlus_CTR {
	public String   strQuoteId      {get; set;}
	public String   strLeadId       {get; set;}
	public String   strCaseId       {get; set;}
	public String   strAccId        {get; set;}
	public String   strOppId        {get; set;}
    public String   profileObj      {get; set;}
    public String   strIdQuote      {get; set;}

	public PAQ_CotizadorZonaPlus_CTR (){
        this.strIdQuote = '';
		this.profileObj = getProfileObj();
	}

	@RemoteAction
	public static Wrapper InitialInfo(String strLeadId, String strQuoteId, String StrOp){
		Wrapper wp               = new Wrapper();
		String strYear           = '';
		Set<String> setDestinies = new Set<String>();
		for(CapacidadSucursal__c tender : queryTender())
			wp.mapTender.put(tender.Name, tender);

		wp.mapCS = queryCustomSetting([SELECT Id FROM Profile Where Name = 'System Administrator' OR Name = 'Administrador del sistema'].Id);
		if(String.isNotBlank(strQuoteId)) {
			wp.objQuote = queryQuote(strQuoteId);
			wp.listQuoteItem = queryQuoteItem(strQuoteId);
			for (SBQQ__QuoteLine__c quoyeItem : wp.listQuoteItem){
                if(quoyeItem.Servicio__c == 'Estándar terrestre (STD)' && wp.listPackages.isEmpty())
                    wp.listPackages = queryPackages(quoyeItem.Id);
                if(String.isNotBlank(quoyeItem.Destiny__c))
                    setDestinies.add(quoyeItem.Destiny__c);
            }
        }
		if(String.isNotBlank(strLeadId))
			wp.objLead = queryLead(strLeadId);
		else if(wp.objQuote != null && String.isNotBlank(wp.objQuote.Lead__c))
			wp.objLead = queryLead(wp.objQuote.Lead__c);
		
		if(String.isNotBlank(StrOp)){
			wp.objOpp = queryOpportunity(StrOp);
			wp.listPrevQuotes = queryPrevQuote(StrOp);
		}
        wp.objEstructura = queryEstructura(wp.objLead.Sucursal__c, wp.objOpp.Account.Sucursal__c);
        wp.mapHierarchy = getHierarchy();
		return wp;
	}

	@RemoteAction
	public static Wrapper getHierarchyUser(){
		Wrapper wp = new Wrapper();
		wp.mapHierarchy = getHierarchy();
		return wp;
	}
    @remoteAction
    public static DmlWrapper GeneraClaveAutorizacion(String Id){
        String M = '';
        DmlWrapper wp = new DmlWrapper();
        M = CreaClaveDeAutorizacion(Id);
        if(M != '')
            wp.listErrors.add('Error al generar clave de autorización: ' + M);
        return wp;
    }
	/*
	*  Query Functions
    */
    public static  String CreaClaveDeAutorizacion(String strIdQuote){
        String strNuevaClave = '';
        String ClaveAut = '';
        Integer consecutivo = 0;
        String dia = '';
        String strCuenta = '';
        Integer intdia = 0;
        SBQQ__Quote__c Clave;
        SBQQ__Quote__c DatosCot;
        List<SBQQ__Quote__c> ClavesAut = [SELECT Clave_de_autorizacion__c FROM SBQQ__Quote__c WHERE Fecha_de_autorizacion__c = :Date.Today() ORDER BY Fecha_de_autorizacion_s__c  DESC LIMIT 1];
        SBQQ__Quote__c Quote = [SELECT Clave_de_autorizacion__c, Fecha_de_autorizacion__c, Fecha_de_autorizacion_s__c FROM SBQQ__Quote__c WHERE id = :strIdQuote LIMIT 1];
        if(Date.today().day() < 10)
            dia = '0' + Date.today().day();
        else{
            intdia = Date.today().day();
            dia = String.valueOf(intdia);
        }
        if(ClavesAut.size() > 0){
            Clave = ClavesAut.get(0);
            ClaveAut = Clave.Clave_de_autorizacion__c;
            consecutivo = Integer.valueOf(ClaveAut.substringAfter('-'));
            consecutivo += 1;
            strNuevaClave = 'CRMSF' + Date.Today().year() + Date.Today().month() + dia + '-' + consecutivo;
        } else
            strNuevaClave = 'CRMSF' + Date.Today().year() + Date.Today().month() + dia + '-1';
        Quote.Clave_de_autorizacion__c = strNuevaClave;
        Quote.Fecha_de_autorizacion__c = system.today();
        Quote.Fecha_de_autorizacion_s__c = system.now();
        //update Quote;
        Database.SaveResult resQuote = Database.update(Quote, false);
        if(!resQuote.isSuccess()){
            Database.Error errQt;
            return 'Error actualizando Oportunidad: ' + errQt.getMessage();
        } else {
            DatosCot = [SELECT Name, SBQQ__Account__r.Name, owner.Email, Clave_de_autorizacion__c FROM SBQQ__Quote__c WHERE Clave_de_autorizacion__c = :strNuevaClave];
            EnviaCorreoAutorizacion(DatosCot.Name, DatosCot.SBQQ__Account__r.Name, DatosCot.Clave_de_autorizacion__c, DatosCot.owner.Email);
            return '';
        }
    }
    public static void EnviaCorreoAutorizacion(String StrCot, String strCli, String strClave, String strEmail){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        List<String> emails = new List<String>{'lzavala@paquetexpress.com.mx', 'asistentecomercial@paquetexpress.com.mx'};
        List<String> correo = new List<String>{strEmail};
        email.setSubject('Cotización autorizada');
        email.setHtmlBody('<hr color="purple" Style="border:15px;"/><br><br>Se le notifica que la cotización para el cliente <strong>' + strCli + '</strong> ya se encuentra con clave de autorización generada <strong>' + strClave + '</strong> para documentar en piso. <br/>Folio de cotización: <strong>' + StrCot + '.</strong><br><br><hr color="purple" Style="border:15px;"/>');
        email.setToAddresses(correo);
        email.setCcAddresses(emails);
        Messaging.SendEmailResult[]r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    public static Boolean TieneClaveAutorizacion(String strIdQuote){
        SBQQ__Quote__c Quote = [SELECT Clave_de_autorizacion__c FROM SBQQ__Quote__c WHERE Id = :strIdQuote LIMIT 1];
        if(Quote.Clave_de_autorizacion__c != '')
            return true;
        else return false;
    }
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

	@RemoteAction
    public static DmlWrapper saveQuoteConv(SBQQ__Quote__c objQuote, List<SBQQ__QuoteLine__c> listQuoteItem/*, Lead objLead, Opportunity objOpp, List<PAQ_SpecialService__c> listSS*/){
        DmlWrapper wp = new DmlWrapper();
        Database.SaveResult quoteInsResult = Database.insert(objQuote, false);
        if(quoteInsResult.isSuccess()){
            wp.objQuote = queryQuote(quoteInsResult.getId());
            wp.blnSuccess = true;
        }
        else{
			wp.blnSuccess = false;
            for(Database.Error errorInsQuote: quoteInsResult.getErrors())
				wp.listErrors.add('Error creando cotización: ' + errorInsQuote.getMessage());
		}

        if(wp.blnSuccess){
            for(SBQQ__QuoteLine__c quoteItem : listQuoteItem)
                quoteItem.SBQQ__Quote__c = quoteInsResult.getId();

            for(Database.SaveResult qItemInsResult : Database.insert(listQuoteItem, false)){
                if(!qItemInsResult.isSuccess()) {
					wp.blnSuccess = false;
					for (Database.Error errorInsItemQuote : qItemInsResult.getErrors())
						wp.listErrors.add('Error creando partida de cotización: ' + errorInsItemQuote.getMessage());
				}
            }
            wp.listQuoteItems = queryQuoteItem(wp.objQuote.Id);
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

	public static String getProfileObj(){
		return [SELECT Name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name;
	}

	public static List<CapacidadSucursal__c> queryTender(){
		return [SELECT Name, Costo__c, Nivel__c, OP__c, Largo__c, Ancho__c, Alto__c, Peso__c FROM CapacidadSucursal__c];
	}

	public static User getManager(String strRoleId){
		return [SELECT Id, UserRole.Name, ManagerId, UserRole.ParentRoleId FROM User WHERE Id =: strRoleId LIMIT 1];
	}

	public static Lead queryLead(String strLeadId){
        return [SELECT Hay_Cotizacion__c, Sucursal__c FROM Lead WHERE Id =: strLeadId];
	}

	public static Estructura__c queryEstructura(String idSucLead, String idSucOpp){
        Estructura__c objEst;
        try {
            if(String.isNotBlank(idSucLead))
                objEst = [SELECT Gerente_Sucursal__c, KAM_regional__c, Gerente_desarrollo_de_negocios__c, Director_Comercial__c FROM Estructura__c WHERE Sucursal__c =:idSucLead LIMIT 1];
            else if(String.isNotBlank(idSucOpp))
                objEst = [SELECT Gerente_Sucursal__c, KAM_regional__c, Gerente_desarrollo_de_negocios__c, Director_Comercial__c FROM Estructura__c WHERE Sucursal__c =:idSucOpp LIMIT 1];
        } catch (Exception ex){
            System.debug(LoggingLevel.ERROR, 'Error Query Estructura: ' + ex.getMessage());
        }
        return objEst;
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
        , Clave_de_autorizacion__c
        //,Nombre_Prospecto__c
        //,Nombre_oportunidad__c
        FROM SBQQ__Quote__c
        WHERE Id =: strQuoteId];
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
        , Destiny__c
        , PAQ_QGuides__c
        , SBQQ__Description__c 
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
	public static Opportunity queryOpportunity(String strOppId){
        return [SELECT Hay_Cotizacion__c, Account.Sucursal__c FROM Opportunity WHERE Id =: strOppId];
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
	/*
	*  Data Structure for calls
	*/
	public class Wrapper {
		public Map<String, CapacidadSucursal__c> 		mapTender			{get; set;}
		public Map<String, String> 						mapHierarchy        {get; set;}
		public Map<String, Decimal>                 	mapCS               {get; set;}
		public Lead                                		objLead             {get; set;}
		public SBQQ__Quote__c 							objQuote      		{get; set;}
		public List<SBQQ__QuoteLine__c>					listQuoteItem       {get; set;}
		public Opportunity                         		objOpp              {get; set;}
		public Estructura__c                        	objEstructura       {get; set;}
		public List<SBQQ__QuoteLinePricingGuidance__c>	listPackages        {get; set;}
		public List<SBQQ__Quote__c>                     listPrevQuotes      {get; set;}

		public Wrapper (){
			this.mapTender			= new Map<String, CapacidadSucursal__c>();
			this.mapHierarchy       = new Map<String, String>();
			this.mapCS				= new Map<String, Decimal>();
			this.listQuoteItem      = new List<SBQQ__QuoteLine__c>();
			this.listPackages       = new List<SBQQ__QuoteLinePricingGuidance__c>();
			this.listPrevQuotes     = new List<SBQQ__Quote__c>();
		}
	}

	public class DmlWrapper{
		public List<String> 			listErrors      {get; set;}
		public Boolean      			blnSuccess      {get; set;}
		public String       			strIdQuote      {get; set;}
		public String       			strName         {get; set;}
		public String 					strDestinyKM	{get; set;}
		public List<SBQQ__QuoteLine__c> listQuoteItems  {get; set;}
		public SBQQ__Quote__c 			objQuote  		{get; set;}
		public DmlWrapper (String strName){
			this.listErrors = new List<String>();
			this.blnSuccess = false;
			this.strName = strName;
		}

		public DmlWrapper (){
			this.listErrors = new List<String>();
			this.blnSuccess = false;
			this.listQuoteItems = new List<SBQQ__QuoteLine__c>();
		}
	}
}
