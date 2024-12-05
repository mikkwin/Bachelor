using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace bachelorbackend.Data.DB;

public class Tekniker
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [MaxLength(50)] // Adjust max length as needed
    public string Username { get; set; }

    [Required]
    [MaxLength(32)] // MD5 hashes are 32 characters long
    public string Password { get; set; }

    [Required]
    public DateTime CreatedDateTime { get; set; }

    public DateTime? LastLoginDateTime { get; set; }

    [MaxLength(32)] // MD5 hashes are 32 characters long
    public string CurrentToken { get; set; }
}