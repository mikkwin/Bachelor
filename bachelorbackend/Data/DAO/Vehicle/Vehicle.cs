using bachelorbackend.Data.Enums;

namespace bachelorbackend.Data.DAO;

public class Vehicle
{
    
    // Vehicle SEO
    public string VehicleName { get; set; }
    public string? LicensePlate { get; set; }
    public int IMEI { get; set; }
    public string? CompanyCVR { get; set; }
    public string? OrgName { get; set; }
    public int? LastTechnicianSearch { get; set; }
    
    

}