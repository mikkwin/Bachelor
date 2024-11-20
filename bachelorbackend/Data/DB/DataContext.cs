using bachelorbackend.Data.DAO;
using bachelorbackend.Data.Enums;
using DefaultNamespace;
using Microsoft.EntityFrameworkCore;

namespace bachelorbackend.Data.DB;

public class DataContext : DbContext
{
    public DataContext(DbContextOptions<DataContext> options) : base(options) { }

    public DbSet<Tekniker> Teknikers { get; set; }
    public DbSet<Skaderapport> Skaderapports { get; set; }
    public DbSet<Vehicle> Vehicles { get; set; }
    public DbSet<VehicleInfo> VehicleInfos { get; set; }
    public DbSet<VehicleReadings> VehicleReadings { get; set; }
    public DbSet<VehicleSetting> VehicleSettings { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Skaderapport>()
            .HasOne(s => s.Tekniker)
            .WithMany()
            .HasForeignKey(s => s.TeknikerId)
            .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<VehicleReadings>()
            .HasOne<VehicleInfo>()
            .WithMany(v => v.Readings)
            .HasForeignKey("VehicleInfoId")
            .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<VehicleReadings>()
            .Property(v => v.State)
            .HasConversion<int>();

        modelBuilder.Entity<VehicleInfo>()
            .Property(v => v.Errors)
            .HasConversion(
                v => string.Join(",", v),
                v => v.Split(",", StringSplitOptions.RemoveEmptyEntries)
                    .Select(e => Enum.Parse<ErrorCode>(e))
                    .ToList());
    }
}