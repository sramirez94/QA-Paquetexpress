public class Inicio_descuento_real_Ctrl {
    
    public Account 	Acc			{get;set;}
    public String 	AccountId	{get;set;}
    
    public Inicio_descuento_real_Ctrl (ApexPages.StandardController controller){
        try{
        	this.Acc 		= (Account) controller.getRecord();
        	this.AccountId 	= Acc.Id;
        } catch (Exception ex){
            System.debug('Error en el constructor ' +ex.getLineNumber()+' '+EX.getMessage());
        }
    }

}
