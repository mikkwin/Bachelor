using bachelorbackend.Data.Enums;

namespace bachelorbackend.Data.DAO;

public class VehicleInfo
{
    public int IMEI { get; set; }
    public string ProductType { get; set; }
    public double LatCords { get; set; }
    public double LonCords { get; set; }
    public List<ErrorCode> Errors { get; set; }
    public List<VehicleReadings> Readings { get; set; }

 
}

