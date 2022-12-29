/**
 * Created by Salvador Ramírez (sramirez@freewayconsulting.com) on 13/12/2022.
 * Clase encargada de validar en la tabla de vacaciones si es que hay una festividad en la que hayan salido temprano
 */

public class PAQ_ValidaHorario {
    public class Respuesta {
        @InvocableVariable(required = true)
        public Boolean blnInhabil;
        @InvocableVariable(required = true)
        public String strMensaje;
    }
    @InvocableMethod(label='Valida feriado parcial')
    public static List<Respuesta> ValidaVacaciones(){
        Integer intMinutes              = 0; //sramirez 13/12/2022: Almacenará el total de minutos transcurridos en el día
        Respuesta resp                  = new Respuesta();//sramirez 13/12/2022: Wrapper con la respuesta
        List<Respuesta> lstRespuesta    = new List<Respuesta>(); //sramirez 13/12/2022: Lista que devolverá la respuesta al bot
        List<Holiday> lstHolidays       = [SELECT Id, StartTimeInMinutes, EndTimeInMinutes, Name, ActivityDate, IsAllDay FROM Holiday WHERE ActivityDate = :System.today() AND IsAllDay = FALSE AND StartTimeInMinutes != NULL AND EndTimeInMinutes != NULL];//sramirez 13/12/2022: Se consultan todas las vacaciones de hoy y que no sean de todo el día
        if (lstHolidays.size() > 0) {
            //sramirez 13/12/2022: Si hay vacaciones
            intMinutes = (System.now().hour() * 60) + System.now().minute();//sramirez 13/12/2022: Se obtiene la cantidad de minutos por hora y luego se suma la cantidad de minutos que van de la hora para obtener el total.
            if (intMinutes > lstHolidays[0].StartTimeInMinutes && intMinutes < lstHolidays[0].EndTimeInMinutes) {
                //sramirez 13/12/2022: Si el total de minutos se encuentra entre el rango de tiempo estipulado en el registro de vacaciones
                resp.blnInhabil = true; //sramirez 13/12/2022: Se activa el flag para indicar que es inhabil
                resp.strMensaje = Label.MensajeHorarioInhabil; //sramirez 13/12/2022: Se obtiene el mensaje desde la etiqueta personalizada
            } else {
                resp.strMensaje = '';
                resp.blnInhabil = false;
            }
        } else {
            resp.strMensaje = '';
            resp.blnInhabil = false;
        }
        lstRespuesta.add(resp);
        return lstRespuesta;
    }
}
