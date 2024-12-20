﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using bachelorbackend.Data.DB;

#nullable disable

namespace bachelorbackend.Migrations
{
    [DbContext(typeof(DataContext))]
    partial class DataContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "6.0.36");

            modelBuilder.Entity("bachelorbackend.Data.DAO.Vehicle", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("CompanyCVR")
                        .HasMaxLength(10)
                        .HasColumnType("TEXT");

                    b.Property<string>("IMEI")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int?>("LastTechnicianSearch")
                        .HasColumnType("INTEGER");

                    b.Property<string>("LicensePlate")
                        .HasMaxLength(20)
                        .HasColumnType("TEXT");

                    b.Property<string>("OrgName")
                        .HasMaxLength(100)
                        .HasColumnType("TEXT");

                    b.Property<string>("VehicleName")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.ToTable("Vehicles");
                });

            modelBuilder.Entity("bachelorbackend.Data.DAO.VehicleInfo", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("Errors")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("IMEI")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<double>("LatCords")
                        .HasColumnType("REAL");

                    b.Property<double>("LonCords")
                        .HasColumnType("REAL");

                    b.Property<string>("ProductType")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.ToTable("VehicleInfos");
                });

            modelBuilder.Entity("bachelorbackend.Data.DAO.VehicleReadings", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<double>("CumulativePower")
                        .HasColumnType("REAL");

                    b.Property<int>("Fullcharges")
                        .HasColumnType("INTEGER");

                    b.Property<double>("HardwareVersion")
                        .HasColumnType("REAL");

                    b.Property<double>("MaxVolt")
                        .HasColumnType("REAL");

                    b.Property<double>("OperationalTime")
                        .HasColumnType("REAL");

                    b.Property<double>("Overdischarges")
                        .HasColumnType("REAL");

                    b.Property<double>("PanelCurrent")
                        .HasColumnType("REAL");

                    b.Property<double>("PanelVoltage")
                        .HasColumnType("REAL");

                    b.Property<double>("SoftwareVersion")
                        .HasColumnType("REAL");

                    b.Property<int>("State")
                        .HasColumnType("INTEGER");

                    b.Property<DateTime>("Timestamp")
                        .HasColumnType("TEXT");

                    b.Property<int?>("VehicleInfoId")
                        .HasColumnType("INTEGER");

                    b.HasKey("Id");

                    b.HasIndex("VehicleInfoId");

                    b.ToTable("VehicleReadings");
                });

            modelBuilder.Entity("bachelorbackend.Data.DB.Skaderapport", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("A")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("TEXT");

                    b.Property<string>("B")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("TEXT");

                    b.Property<string>("C")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("TEXT");

                    b.Property<DateTime>("CreatedDateTime")
                        .HasColumnType("TEXT");

                    b.Property<string>("D")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("TEXT");

                    b.Property<string>("IMEI")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("TEXT");

                    b.Property<DateTime?>("LastEditedDateTime")
                        .HasColumnType("TEXT");

                    b.Property<int>("TeknikerId")
                        .HasColumnType("INTEGER");

                    b.HasKey("Id");

                    b.HasIndex("TeknikerId");

                    b.ToTable("Skaderapports");
                });

            modelBuilder.Entity("bachelorbackend.Data.DB.Tekniker", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<DateTime>("CreatedDateTime")
                        .HasColumnType("TEXT");

                    b.Property<string>("CurrentToken")
                        .IsRequired()
                        .HasMaxLength(32)
                        .HasColumnType("TEXT");

                    b.Property<DateTime?>("LastLoginDateTime")
                        .HasColumnType("TEXT");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(32)
                        .HasColumnType("TEXT");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.ToTable("Teknikers");
                });

            modelBuilder.Entity("DefaultNamespace.VehicleSetting", b =>
                {
                    b.Property<int>("SerialId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("IMEI")
                        .IsRequired()
                        .HasMaxLength(15)
                        .HasColumnType("TEXT");

                    b.Property<double>("S010a")
                        .HasColumnType("REAL");

                    b.Property<double>("e003")
                        .HasColumnType("REAL");

                    b.Property<double>("e004")
                        .HasColumnType("REAL");

                    b.Property<double>("e005")
                        .HasColumnType("REAL");

                    b.Property<double>("e006")
                        .HasColumnType("REAL");

                    b.Property<double>("e007")
                        .HasColumnType("REAL");

                    b.Property<double>("e008")
                        .HasColumnType("REAL");

                    b.Property<double>("e009")
                        .HasColumnType("REAL");

                    b.Property<double>("e00a")
                        .HasColumnType("REAL");

                    b.Property<double>("e00b")
                        .HasColumnType("REAL");

                    b.Property<double>("e00c")
                        .HasColumnType("REAL");

                    b.Property<double>("e00d")
                        .HasColumnType("REAL");

                    b.Property<double>("e00e")
                        .HasColumnType("REAL");

                    b.Property<double>("e010")
                        .HasColumnType("REAL");

                    b.Property<double>("e011")
                        .HasColumnType("REAL");

                    b.Property<double>("e012")
                        .HasColumnType("REAL");

                    b.Property<double>("e013")
                        .HasColumnType("REAL");

                    b.Property<double>("e014")
                        .HasColumnType("REAL");

                    b.HasKey("SerialId");

                    b.ToTable("VehicleSettings");
                });

            modelBuilder.Entity("bachelorbackend.Data.DAO.VehicleReadings", b =>
                {
                    b.HasOne("bachelorbackend.Data.DAO.VehicleInfo", null)
                        .WithMany("Readings")
                        .HasForeignKey("VehicleInfoId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("bachelorbackend.Data.DB.Skaderapport", b =>
                {
                    b.HasOne("bachelorbackend.Data.DB.Tekniker", "Tekniker")
                        .WithMany()
                        .HasForeignKey("TeknikerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Tekniker");
                });

            modelBuilder.Entity("bachelorbackend.Data.DAO.VehicleInfo", b =>
                {
                    b.Navigation("Readings");
                });
#pragma warning restore 612, 618
        }
    }
}
