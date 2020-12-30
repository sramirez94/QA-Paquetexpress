public class DefinicionesServiciosGrabado {
    public class tarifaDescuento{
        public string slabNo;
        public string actvFlag;
        public decimal discount;
    }
    public class discountZone{
    	public string zone;
        public string actvFlag;
        public List<tarifaDescuento> discountTrfs;
    }
    public class data{
        public List<discountZone> discountZones;
        public string user;
        public string clntId;
        public string quotation;
    }
    public class request{
        public data data;
        public string objectDTO = null;      
    }
    public class body{
        public request request;
        public string response;        
    }
    public class bodyRequest{
        public request request;
    }
    public class security{
        public string user;
        public string token;
    }
    public class header{
        public security security;
    }
    public class bodyRequestODC {
        public requestODC request;
    }
    public class requestODC {
        public requestDataODC data;
    }
    public class requestDataODC {
        public String clntId;
    }
    public class requestTarifaDcto{
        public header header;
        public body body;
    }
// Descuentos de piso
    public class discountService{
        public string refrSrvcId;
        public string srvcId;
        public decimal discount;
        public integer isNational;
        public integer toDelete;
    }
    public class dataDescPiso{
        public string user;
        public string clntId;
        public List<discountService> discountServiceList;
    }
    public class requestDescPiso{
        public string objectDTO = null;
        public dataDescPiso data;
    }
    public class bodyDescPiso{
        public requestDescPiso request;
        public string response = null;
    }
    public class requestDctoPiso{
        public header header;
        public bodyDescPiso body;
    }   
    //Respuesta general
    public class message{
        public string code;
        public string description;
        public string typeError;
    }
    public class response{
        public string success;
        public List<message> messages;
        public string data;
		public string objectDTO;
        public string timeR;
    }
    public class bodyResponse {
        public string request;
        public response response;
        
    }
    public class responseGrabado{
        public bodyResponse body;
        public string header;
    }
    //Usuario Web
    public class dataUser{
		public string authBy;
		public string clntId;
		public string clntUser;
		public string clntPass;
		public string clntAprvSite;
		public string clntAprvBrnc;
		public string clntTarifType;
		public string clntAddSrvcDips;
		public string setShipmentLetterQty;
		public string clntInvcPerd;
    }
    public class requestU{
        public dataUser data;
        public string objectDTO;
    }
    public class bodyU{
        public requestU request;
    	public string response;
    }
    public class securityU{
		public string user;
		public string password;
		public string type;
		public string token;
    }
    public class headerU{
        public string device;
        public string target;
        public string output;
        public string language;        
        public securityU security;
    }
    public class requestWebUser{
        public headerU header;
        public bodyU body;
    }
    ///Verificar usuario
    public class securityVU{
        public string user;
        public string password;
        public string typeR;
        public string token;
    }
    public class headerVU{
        public securityVU security;
        public string device;
        public string target;
        public string output;
        public string language;
    }
    public class dataVU{
        public string clntUser;
        public string clntId;
    }
    public class requestVU{
        public dataVU data;
        public string objectDTO;
    }
    public class bodyVU{
        public requestVU request;
        public string response;
    }
    public class VerificarUsuario{
        public bodyVU body;
        public headerVU header;
    }
    //Verificar Usuario Response
    public class messageVU{
		public string code;
		public string description;
		public string typeError;
    }
    public class responseVU{
        public string success;
        public List<messageVU> messages;
		public string data;
		public string objectDTO;
		public string timeR;
    }
    public class bResponseVU{
        public string request;
        public responseVU response;
    }
    public class verificarUsuarioR{
        public string header;
        public bResponseVU body;
    }
//Documentación remota    
    public class serviceTrif{
        public string serviceId;
        public string refServiceId;
        public string trifAmount;
        public string trifAmntBase;
        public string discount;
        public string factorValue;
        public string factor;
        public string servicesCant;
    }
    public class servicesTrifDtl{
        public List<serviceTrif> serviceTrif;
        public string slabNo;
    }
    public class ptpServicesTrif{
		public string orgnSite;
        public string destSite;
        public List<serviceTrif> serviceTrif;
        //public string serviceTrif;
        public servicesTrifDtl servicesTrifDtl;
        public List<servicesTrifCbe> servicesTrifCbe;
        public String otherServiceTrif;
    }
    
    public class dataDRemota{
        public string clntId;
        public string aprvUser;
        public string trifType;
        public string pieceMulti;
        public List<ptpConfig> ptpConfig;
        public List<kmConfig> kmConfig;
    }
    public class requestDRemota{
        //public requestDataODC data;
        public header header;
        public bodyRequestODC body;
    }
    public class bodyDRemota{
        public requestDRemota request;
    }
    public class documentacionRemota{
        public bodyDRemota body;
        public header header;
    }
    public class responseODC {
        public header header;
        public bodyODC body;
        public string objectDTO = null;
        public string timeR;
    }
    public class bodyODC {
        public request request;
        public responseDOC response;

    }
    public class responseDOC {
        public String success;
        public List<message> messages;
        public dataDRemota data;
        public string objectDTO = null;
        public string timeR;
    }
    public class servicesTrifCbe {
        public String trifAmountExce;
        public String factor;
        public string serviceId;
        public String refrServiceId;
        public list<serviceTrif> serviceTrif;
        public String otherServiceTrif;
    }
    public class kmConfig {
        public List<kmServicesTrif> kmServicesTrif;
    }
    public class kmServicesTrif {
        public String fromKm;
        public String toKm;
        public List<serviceTrif> serviceTrif;
        public servicesTrifDtl servicesTrifDtl;
        public list<servicesTrifCbe> servicesTrifCbe;
        public String otherServiceTrif;
    }
    public class ptpConfig {
        public List<ptpServicesTrif> ptpServicesTrif;
    }
}
