public class ObjDocEnLinea {
    public class security{
        public string user;
        public string token;
    }
    public class header{
        public security security;
    }    
    public class serviceTrif{
        public string serviceId;
        public string refServiceId;
        public decimal trifAmount;
        public decimal trifAmntBase;
        public decimal discount;
        public string factor;
        public string factorValue;
        public string servicesCant;
    }
    public class servicesTrifDtl{
        public List<servicesTrifDtlSub> servicesTrifDtl;
    }
    public class servicesTrifDtlSub{
        public List<serviceTrif> serviceTrif;
        public string slabNo;
    }
    public class ptpServicesTrif{
		public List<ptpServicesTrifSub> ptpServicesTrif;
    }
    public class ptpServicesTrifSub{
        public string orgnSite;
        public string destSite;
        public string serviceTrif;
        public List<servicesTrifDtlSub> servicesTrifDtl;
    }
    
    public class dataDRemota{
        public string clntId;
        //public string quotation;
        public string aprvUser;
        public string trifType;
        public string pieceMulti;
        public List<ptpServicesTrif> ptpConfig;
        public List<kmServicesTrif> kmConfig;
    }
    public class kmServicesTrif{
        public List<kmServicesTrifList> kmServicesTrif;
    }
	public class kmServicesTrifList{
        public string fromKm;
        public string toKm;
        public List<serviceTrif> serviceTrif;
        public List<servicesTrifDtlSub> servicesTrifDtl;
        public List<serviceTrifCbe> servicesTrifCbe;
    }    
    public class serviceTrifCbe{
        public string trifAmountExce;
        public string factor;
        public string serviceId;
		public string refServiceId;       
        public List<serviceTrif> serviceTrif;
    }
    public class requestDRemota{
        public dataDRemota data;
    }
    public class bodyDRemota{
        public requestDRemota request;
    }
    public class documentacionRemota{
        public bodyDRemota body;
        public header header;
    }
    

}
