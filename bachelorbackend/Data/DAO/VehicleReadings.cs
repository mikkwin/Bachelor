using bachelorbackend.Data.Enums;

namespace bachelorbackend.Data.DAO;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
public class VehicleReadings
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    
    [Required]
    public string IMEI { get; set; }

    [Required]
    public DateTime Timestamp { get; set; }

    [Required]
    public double CumulativePower { get; set; }

    [Required]
    public int Fullcharges { get; set; }

    [Required]
    public double HardwareVersion { get; set; }

    [Required]
    public double MaxVolt { get; set; }

    [Required]
    public double OperationalTime { get; set; }

    [Required]
    public double Overdischarges { get; set; }

    [Required]
    public VehicleStatus State { get; set; }

    [Required]
    public double SoftwareVersion { get; set; }

    [Required]
    public double PanelCurrent { get; set; }

    [Required]
    public double PanelVoltage { get; set; }
}