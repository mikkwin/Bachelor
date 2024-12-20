using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace bachelorbackend.Data.DB;

public class Skaderapport
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [MaxLength(255)] // Adjust max length as needed
    public string A { get; set; }

    [MaxLength(255)]
    public string B { get; set; }

    [MaxLength(255)]
    public string C { get; set; }

    [MaxLength(255)]
    public string D { get; set; }

    [Required]
    [MaxLength(15)] // Typical IMEI length
    public string IMEI { get; set; }

    [Required]
    public int TeknikerId { get; set; }

    [ForeignKey(nameof(TeknikerId))]
    public Tekniker Tekniker { get; set; }

    [Required]
    public DateTime CreatedDateTime { get; set; }

    public DateTime? LastEditedDateTime { get; set; }
}