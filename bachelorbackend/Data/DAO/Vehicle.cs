namespace bachelorbackend.Data.DAO;

public class Vehicle
{
    
    // Vehicle SEO
    public string? LicensePlate { get; set; }
    public long IMEI { get; set; }
    public string? CompanyCVR { get; set; }
    public int? LastTechnicianSearch { get; set; }
    
    //Vehicle Specs
    public double KM_Count { get; set; }
    public int recharges { get; set; }

    public Vehicle(string? licensePlate, long imei, string? companyCvr, int? lastTechnicianSearch, double kmCount, int recharges)
    {
        LicensePlate = licensePlate;
        IMEI = imei;
        CompanyCVR = companyCvr;
        LastTechnicianSearch = lastTechnicianSearch;
        KM_Count = kmCount;
        this.recharges = recharges;
    }
}