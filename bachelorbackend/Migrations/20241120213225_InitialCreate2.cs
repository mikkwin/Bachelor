using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace bachelorbackend.Migrations
{
    public partial class InitialCreate2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "VehicleSettings",
                columns: table => new
                {
                    SerialId = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    IMEI = table.Column<string>(type: "TEXT", maxLength: 15, nullable: false),
                    S010a = table.Column<double>(type: "REAL", nullable: false),
                    e003 = table.Column<double>(type: "REAL", nullable: false),
                    e004 = table.Column<double>(type: "REAL", nullable: false),
                    e005 = table.Column<double>(type: "REAL", nullable: false),
                    e006 = table.Column<double>(type: "REAL", nullable: false),
                    e007 = table.Column<double>(type: "REAL", nullable: false),
                    e008 = table.Column<double>(type: "REAL", nullable: false),
                    e009 = table.Column<double>(type: "REAL", nullable: false),
                    e00a = table.Column<double>(type: "REAL", nullable: false),
                    e00b = table.Column<double>(type: "REAL", nullable: false),
                    e00c = table.Column<double>(type: "REAL", nullable: false),
                    e00d = table.Column<double>(type: "REAL", nullable: false),
                    e00e = table.Column<double>(type: "REAL", nullable: false),
                    e010 = table.Column<double>(type: "REAL", nullable: false),
                    e011 = table.Column<double>(type: "REAL", nullable: false),
                    e012 = table.Column<double>(type: "REAL", nullable: false),
                    e013 = table.Column<double>(type: "REAL", nullable: false),
                    e014 = table.Column<double>(type: "REAL", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VehicleSettings", x => x.SerialId);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "VehicleSettings");
        }
    }
}
