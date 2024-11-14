using bachelorbackend.Data.Enums;

namespace bachelorbackend.Data.DAO;

public class VehicleReadings
{
    
    //Readings
    public DateTime Timestamp { get; set; }
    public double CumulativePower { get; set; }
    public int Fullcharges { get; set; }
    public double HardwareVersion { get; set; }
    public double MaxVolt { get; set; }
    public double OperationalTime { get; set; }
    public double Overdischarges { get; set; }
    public VehicleStatus State { get; set; }
    public double SoftwareVersion { get; set; }
    public double PanelCurrent { get; set; }
    public double PanelVoltage { get; set; }
    
    
    
    
    
    
    
}