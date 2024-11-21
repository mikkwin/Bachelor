using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace bachelorbackend.Migrations
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Teknikers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Username = table.Column<string>(type: "TEXT", maxLength: 50, nullable: false),
                    Password = table.Column<string>(type: "TEXT", maxLength: 32, nullable: false),
                    CreatedDateTime = table.Column<DateTime>(type: "TEXT", nullable: false),
                    LastLoginDateTime = table.Column<DateTime>(type: "TEXT", nullable: true),
                    CurrentToken = table.Column<string>(type: "TEXT", maxLength: 32, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Teknikers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "VehicleInfos",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    IMEI = table.Column<int>(type: "INTEGER", nullable: false),
                    ProductType = table.Column<string>(type: "TEXT", maxLength: 50, nullable: false),
                    LatCords = table.Column<double>(type: "REAL", nullable: false),
                    LonCords = table.Column<double>(type: "REAL", nullable: false),
                    Errors = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VehicleInfos", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Vehicles",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    VehicleName = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    LicensePlate = table.Column<string>(type: "TEXT", maxLength: 20, nullable: true),
                    IMEI = table.Column<int>(type: "INTEGER", nullable: false),
                    CompanyCVR = table.Column<string>(type: "TEXT", maxLength: 10, nullable: true),
                    OrgName = table.Column<string>(type: "TEXT", maxLength: 100, nullable: true),
                    LastTechnicianSearch = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Vehicles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Skaderapports",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    A = table.Column<string>(type: "TEXT", maxLength: 255, nullable: false),
                    B = table.Column<string>(type: "TEXT", maxLength: 255, nullable: false),
                    C = table.Column<string>(type: "TEXT", maxLength: 255, nullable: false),
                    D = table.Column<string>(type: "TEXT", maxLength: 255, nullable: false),
                    IMEINumber = table.Column<string>(type: "TEXT", maxLength: 15, nullable: false),
                    TeknikerId = table.Column<int>(type: "INTEGER", nullable: false),
                    CreatedDateTime = table.Column<DateTime>(type: "TEXT", nullable: false),
                    LastEditedDateTime = table.Column<DateTime>(type: "TEXT", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Skaderapports", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Skaderapports_Teknikers_TeknikerId",
                        column: x => x.TeknikerId,
                        principalTable: "Teknikers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "VehicleReadings",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Timestamp = table.Column<DateTime>(type: "TEXT", nullable: false),
                    CumulativePower = table.Column<double>(type: "REAL", nullable: false),
                    Fullcharges = table.Column<int>(type: "INTEGER", nullable: false),
                    HardwareVersion = table.Column<double>(type: "REAL", nullable: false),
                    MaxVolt = table.Column<double>(type: "REAL", nullable: false),
                    OperationalTime = table.Column<double>(type: "REAL", nullable: false),
                    Overdischarges = table.Column<double>(type: "REAL", nullable: false),
                    State = table.Column<int>(type: "INTEGER", nullable: false),
                    SoftwareVersion = table.Column<double>(type: "REAL", nullable: false),
                    PanelCurrent = table.Column<double>(type: "REAL", nullable: false),
                    PanelVoltage = table.Column<double>(type: "REAL", nullable: false),
                    VehicleInfoId = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VehicleReadings", x => x.Id);
                    table.ForeignKey(
                        name: "FK_VehicleReadings_VehicleInfos_VehicleInfoId",
                        column: x => x.VehicleInfoId,
                        principalTable: "VehicleInfos",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Skaderapports_TeknikerId",
                table: "Skaderapports",
                column: "TeknikerId");

            migrationBuilder.CreateIndex(
                name: "IX_VehicleReadings_VehicleInfoId",
                table: "VehicleReadings",
                column: "VehicleInfoId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Skaderapports");

            migrationBuilder.DropTable(
                name: "VehicleReadings");

            migrationBuilder.DropTable(
                name: "Vehicles");

            migrationBuilder.DropTable(
                name: "Teknikers");

            migrationBuilder.DropTable(
                name: "VehicleInfos");
        }
    }
}
