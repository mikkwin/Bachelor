using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DefaultNamespace
{
    public class VehicleSetting
    {
        [Key]
        public int SerialId { get; set; }

        [Required]
        [StringLength(16)]
        public string IMEI { get; set; }

        [Required]
        public double S010a { get; set; }

        [Required]
        public double e003 { get; set; }

        [Required]
        public double e004 { get; set; }

        [Required]
        public double e005 { get; set; }

        [Required]
        public double e006 { get; set; }

        [Required]
        public double e007 { get; set; }

        [Required]
        public double e008 { get; set; }

        [Required]
        public double e009 { get; set; }

        [Required]
        public double e00a { get; set; }

        [Required]
        public double e00b { get; set; }

        [Required]
        public double e00c { get; set; }

        [Required]
        public double e00d { get; set; }

        [Required]
        public double e00e { get; set; }

        [Required]
        public double e010 { get; set; }

        [Required]
        public double e011 { get; set; }

        [Required]
        public double e012 { get; set; }

        [Required]
        public double e013 { get; set; }

        [Required]
        public double e014 { get; set; }
    }
}