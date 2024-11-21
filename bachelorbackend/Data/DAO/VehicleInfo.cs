using bachelorbackend.Data.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace bachelorbackend.Data.DAO;

public class VehicleInfo
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    public int IMEI { get; set; }

    [Required]
    [MaxLength(50)] // Adjust based on expected ProductType length
    public string ProductType { get; set; }

    [Required]
    public double LatCords { get; set; }

    [Required]
    public double LonCords { get; set; }

    public List<ErrorCode> Errors { get; set; } = new List<ErrorCode>();

    public List<VehicleReadings> Readings { get; set; } = new List<VehicleReadings>();
}


