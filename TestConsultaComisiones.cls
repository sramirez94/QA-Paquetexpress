@Istest()
public class TestConsultaComisiones {

    
     @isTest static void validaComision(){
        // FAVORITO
     	Sucursal__c suc 			= AuxTestBatchTendencias.generaSucursal();   
     	User 		usr				= AuxTestBatchTendencias.generaUsuario();
        Account 	acc 			= new Account ();
        acc.Name 							= 'TEST ACC';
        acc.Numero__c 						= 1;
        acc.Colonia__c 						= 'test colonia';
        acc.Piso_envio__c 					= 'test piso envio';
        acc.Zona_envio__c 					= 'zona envio';
        acc.Colonia_Facturaci_n__c 			= 'colonia facturacion';
        acc.Potencial_mensual_de_envios__c 	= 1000000;
        acc.Potencial_mensual_Total__c		= 1000000;
        acc.ShippingPostalCode				= '01010';
        acc.BillingPostalCode				= '01010';
        acc.Sucursal__c						= suc.Id;
        insert acc;
        
        
        AuxTestBatchTendencias.generaVenta(acc.Id, suc.Id, usr.Id);
        AuxTestBatchTendencias.generaVenta2(acc.Id, suc.Id, usr.Id);
        AuxTestBatchTendencias.generaVenta3(acc.Id, suc.Id, usr.Id);
         
        Ano_Calendario__c calendario= AuxTestBatchTendencias.generaCalendario();
        AuxTestBatchTendencias.generaDetalleCalendario(calendario.Id); 
        
        AuxTestBatchTendencias.generaEnlaceEjecutivoCalendario(calendario.Id, usr.Id);
         
        
        PageReference pageRef = Page.ConsultaComisiones;
        
        
     	Test.startTest();
         	Test.setCurrentPage(pageRef);
        	Test.setMock(HttpCalloutMock.class, new CallWS_Rastreo_Test());
         	CtrlConsultaComisiones tcf = new CtrlConsultaComisiones ();
         	tcf.getPeriodoOptions();
         	tcf.periodoSeleccionado = '21 de Diciembre al 20 de Enero';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Enero al 20 de Febrero';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Febero al 20 de Marzo';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Marzo al 20 de Abril';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Abril al 20 de Mayo';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Mayo al 20 de Junio';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Junio al 20 de Julio';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Julio al 20 de Agosto';
         	tcf.validaConsulta();
         	/*tcf.periodoSeleccionado = '21 de Agosto al 20 de Septiembre';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Septiembre al 20 de Octubre';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Octubre al 20 de Noviembre';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '21 de Noviembre al 20 de Diciembre';
         	tcf.validaConsulta();
         	tcf.periodoSeleccionado = '--Seleccione un periodo año en curso--';
         	tcf.validaConsulta();*/
            
     	Test.stopTest();
     }
}
