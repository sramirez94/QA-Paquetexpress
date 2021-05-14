/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-20-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-20-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class Inicio_descuento_real_Ctrl {
    
    public Account 	Acc			        {get;set;}
    public String 	AccountId	        {get;set;}
    public String   StrDia1             {get;set;}
    public String   strMes1             {get;set;}
    public String   strAnio1            {get;set;}
    public String   StrDia2             {get;set;}
    public String   strMes2             {get;set;}
    public String   strAnio2            {get;set;}
    public String   strFecha1           {get;set;}
    public String   strFecha2           {get;set;}
    public String   strModelo           {get;set;}
    public Inicio_descuento_real_Ctrl (ApexPages.StandardController controller){
        try{
        	this.Acc 		= (Account) controller.getRecord();
        	this.AccountId 	= Acc.Id;
        } catch (Exception ex){
            System.debug('Error en el constructor ' +ex.getLineNumber()+' '+EX.getMessage());
        }
    }
    public void quicksave(){
        try{
            Database.SaveResult resDeducUPD = Database.update(this.Acc, false);
            
            if(resDeducUPD.isSuccess()) {
                System.debug('se guardaron cambios en la cuenta');
                if(this.Acc.Tipo_cotizador__c == 'Documentación en piso sipweb'){
                    BatchSeguimiento1 batch1 = new BatchSeguimiento1(this.AccountId); 
                    database.executeBatch(batch1);
                    system.debug('Se llamó al primer Batch...');
                } else if (this.Acc.Tipo_cotizador__c == 'Costo base más excedente' || this.Acc.Tipo_cotizador__c == 'Guía multipieza'){
                    if(this.Acc.Tipo_cotizador__c == 'Costo base más excedente')
                        this.strModelo = 'Costo base más excedente: Por Destinos / Por rangos de km';
                    else this.strModelo = 'Guía multipieza: Por Destinos / Por Rangos de km';
                    //01/03/2021: Armado de la fecha de inicio
                    this.strAnio1 = String.valueOf(this.Acc.Inicio_seguimiento__c.year());
                    if(this.Acc.Inicio_seguimiento__c.month() < 10)
                        this.strMes1 = '0' + this.Acc.Inicio_seguimiento__c.month().format();
                    else this.strMes1 = this.Acc.Inicio_seguimiento__c.month().format();
                    if(this.Acc.Inicio_seguimiento__c.Day() < 10)
                        this.StrDia1 = '0' + this.Acc.Inicio_seguimiento__c.Day().format(); 
                    else this.StrDia1 = String.valueOf(this.Acc.Inicio_seguimiento__c.Day());
                    this.strFecha1 = this.strAnio1 + '-' + this.strMes1 + '-' + this.StrDia1;
                    //01/03/2021: Armado de la fecha final
                    this.strAnio2 = String.valueOf(this.Acc.Fin_seguimiento__c.year());
                    if(this.Acc.Fin_seguimiento__c.month() < 10)
                        this.strMes2 = '0' + this.Acc.Fin_seguimiento__c.month().format();
                    else this.strMes2 = this.Acc.Fin_seguimiento__c.month().format();
                    if(this.Acc.Fin_seguimiento__c.Day() < 10)
                        this.StrDia2 = '0' + this.Acc.Fin_seguimiento__c.Day().format(); 
                    else this.StrDia2 = String.valueOf(this.Acc.Fin_seguimiento__c.Day());
                    this.strFecha2 = this.strAnio2 + '-' + this.strMes2 + '-' + this.StrDia2;
                    BatchSeguimientoCBME batchCBME = new BatchSeguimientoCBME(this.AccountId, this.strFecha1, this.strFecha2, this.strModelo);
                    database.executeBatch(batchCBME);
                    system.debug('Se llamó a batch cbme');
                }
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'El proceso se ha iniciado. Recibirá una notificación cuando los resultados esten disponibles.'));
            }
            else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se produjo un error. Favor de comunicarse con un administrador'));
                for(Database.Error insError: resDeducUPD.getErrors())
                    System.debug('Error al guardar la cuenta: ' + insError.getMessage());
            }
        } catch (Exception ex){
            System.debug('Error al generar batch ' + ex.getLineNumber()+' '+ex.getMessage());
        }
    }

}
