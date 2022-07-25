/*
 * Created by Fran on 10/07/2020.
 * Modificada: 10/06/2022. Modificó: Salvador Ramírez (sramirez@freewayconsulting.com). Se agrega validación para que los ejecutivos de venta no puedan eliminar cotizaciones.
 */
public class QuoteTriggerHandler {
	public QuoteTriggerHandler(){

	}

	public void shareQuote(List<SBQQ__Quote__c> newQuoteList, Map<Id, SBQQ__Quote__c> oldMap){
		List<SBQQ__Quote__Share> listShare = new List<SBQQ__Quote__Share>();
		SBQQ__Quote__Share objShare;
		for(SBQQ__Quote__c objNewQuote : newQuoteList ){
			if(String.isNotBlank(objNewQuote.Gerente_de_sucursal_aprobacion__c)
				&& objNewQuote.SBQQ__Status__c == 'In Review'
				&& oldMap.get(objNewQuote.Id).SBQQ__Status__c == 'Draft'
			){
				System.debug(LoggingLevel.DEBUG, objNewQuote.Gerente_de_sucursal_aprobacion__c);
				// Create new sharing object for the custom object Quote.
				objShare  = new SBQQ__Quote__Share();
				// Set the ID of record being shared.
				objShare.ParentId = objNewQuote.Id;
				// Set the ID of user or group being granted access.
				objShare.UserOrGroupId = objNewQuote.Gerente_de_sucursal_aprobacion__c;
				// Set the access level.
				objShare.AccessLevel = 'edit';
				// Set rowCause to 'manual' for manual sharing.
				// This line can be omitted as 'manual' is the default value for sharing objects.
				objShare.RowCause = Schema.SBQQ__Quote__Share.RowCause.Manual;
				listShare.add(objShare);
			}
				// Insert the sharing record and capture the save result.
				// The false parameter allows for partial processing if multiple records passed
				// into the operation.
			for(Database.SaveResult resShareINS : Database.insert(listShare,false))
				if (!resShareINS.isSuccess())
					for (Database.Error errorShare : resShareINS.getErrors())
						System.debug(LoggingLevel.ERROR, errorShare.getMessage());

		}
	}

	public void	createTempleate(List<SBQQ__Quote__c> newQuoteList, Map<Id, SBQQ__Quote__c> oldMap) {
		List<Templeate__c> listTempleate = new List<Templeate__c>();
		for (SBQQ__Quote__c objNewQuote : newQuoteList)
			if (objNewQuote.SBQQ__Status__c == 'Approved' &&
					(
									oldMap.get(objNewQuote.Id).SBQQ__Status__c == 'Draft' ||
									oldMap.get(objNewQuote.Id).SBQQ__Status__c == 'In Review')
			)
				listTempleate.add(new Templeate__c(
						Quote__c = objNewQuote.Id
						, ServiciosAdicionales__c = objNewQuote.Servicios_adicionales__c
						, Acuse__c = objNewQuote.Acuse__c
						, Electronicas__c = objNewQuote.Electronicas__c
						, Impresas__c = objNewQuote.Impresas__c
						, FechaCreacionCotizacion__c = Date.valueOf(objNewQuote.CreatedDate)
                        , fecha_sugar__c = Date.valueOf(objNewQuote.Fecha_de_creacion_sugar__c)
						, TipoCotizacion__c = objNewQuote.TipoCotizacion__c
				));

		for (Database.SaveResult INSTempleate : Database.insert(listTempleate, false))
			if (!INSTempleate.isSuccess())
				for (Database.Error errINSTemp : INSTempleate.getErrors())
					System.debug(LoggingLevel.ERROR, errINSTemp.getMessage());
	}

	public  void ValidaEliminacion(List<SBQQ__Quote__c> lstQuote){
        //método para validar si un ejecutivo de ventas intenta eliminar una cotización para evitarlo
		String strPerfil = [SELECT NAME FROM PROFILE WHERE ID = :System.UserInfo.getProfileId()].Name; //Se obtiene el nombre del perfil
		for(SBQQ__Quote__c objQuote : lstQuote){
            //Se recorren los registros que se van a eliminar
			if(strPerfil == 'Ejecutivo de venta'){
                //Si es un ejecutivo de venta le restringe la eliminación
				objQuote.addError('Los ejecutivos de venta no tienen permitido eliminar cotizaciones. Consulte a su administrador de Salesforce para mas información');
			}
		}
	}
}
