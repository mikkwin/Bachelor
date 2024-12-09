using bachelorbackend.Data.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace bachelorbackend.Data.DAO;

public class Vehicle
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [MaxLength(100)] 
    public string VehicleName { get; set; }

    [MaxLength(20)] 
    public string? LicensePlate { get; set; }

    [Required]
    public string IMEI { get; set; }

    [MaxLength(10)]
    public string? CompanyCVR { get; set; }

    [MaxLength(100)]
    public string? OrgName { get; set; }

    public int? LastTechnicianSearch { get; set; }
}