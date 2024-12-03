using bachelorbackend.Data.DAO;
using bachelorbackend.Data.DB;
using bachelorbackend.Data.Enums;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace bachelorbackend.Data;

public class DataService : IDataService
{
    private string URL_KEY = "db542dcc6b5cf658536d7db8e9e5e7c3 aceddd490d711d00a28fc2f6bec0050e27616b31d7093fc95b492335b36fbe24124839b795758b19b8e52daa81e0651f843941ad67854122136131448c4ef7c9380488b538b73fc1365e4593c092b7035584bda5d8e14529ea318bc816e8eca62386ac19d81e42445ea8a3d1e676031febed3b03ce3209b0a525484352d9b6a6e";
    private string DB_KEY = "aebguåaebgae9geaguae";

    
    private readonly IConfiguration config;
    private DataContext _context;


    public DataService(IConfiguration config, DataContext context)
    {
        this.config = config;
        _context = context;
    }

    private List<VehicleReadings> RandomVehicleReadingsGen()
    {
        List<VehicleReadings> readings = new List<VehicleReadings>();

        Random random = new Random();
        
        for (int i = 0; i < 50; i++)
        {
            DateTime time = DateTime.Now;

            VehicleReadings reading = new VehicleReadings()
            {
                Timestamp = time.AddMinutes(i),
                Fullcharges = random.Next(10000),
                CumulativePower = random.NextDouble() * 1000,
                HardwareVersion = 1.1,
                MaxVolt = random.Next(30),
                Overdischarges = random.Next(100),
                State = i % 10 == 0 ? VehicleStatus.INACTIVE : VehicleStatus.ACTIVE,
                OperationalTime = DateTime.Now.Second,
                SoftwareVersion = 1.1,
                PanelCurrent = random.NextDouble() * 2000,
                PanelVoltage = random.Next(30)
            };
            
            readings.Add(reading);
        }

        return readings;
    }

    private List<ErrorCode> returnRandomErrors()
    {
        List<ErrorCode> codes = new List<ErrorCode>();

        for (int i = 0; i < 2; i++)
        {
            if (DateTime.Now.Second % 10 == 0)
            {
                codes.Add(ErrorCode.CTRL_TEMP_HIGH);
            }
            else
            {
                codes.Add(ErrorCode.NO_ERR);
            }

        }

        return codes;
    }
    

    public List<Vehicle> getTechnicianHistory(int techID)
    {
        List<Vehicle> vehicles = new List<Vehicle>();

        /*
            
        for (int i = 0; i < 10; i++)
        {

            Vehicle vehicle = new Vehicle("EG50979", DateTime.Now.Ticks, "" + 123532 * i, techID, i * DateTime.Now.Ticks, i);
            vehicles.Add(vehicle);
            
        }

*/
        return vehicles;
    }

    private List<Vehicle> generateVehicleSearch(int offset, int amount)
    {
        List<Vehicle> vehicles = new List<Vehicle>();
        
        for (int i = offset; i < amount; i++)
        {
        }

        return vehicles;

    }

    public async Task<List<Vehicle>> vehicleSearch(string input, int filter, string currentToken, int offset, int amount)
    {
        
        
        
        
        List<Vehicle> vehicles = new List<Vehicle>();

        IQueryable<Vehicle> query = _context.Vehicles;

        switch (filter)
        {
            case 1: 
                query = query.Where(vehicle => EF.Functions.Like(vehicle.OrgName, input));
                break;
            case 2:
                query = query.Where(vehicle => EF.Functions.Like(vehicle.LicensePlate, input));
                break;
            case 3:
                query = query.Where(vehicle => EF.Functions.Like(vehicle.VehicleName, input));
                break;
            case 4:
                query = query.Where(vehicle => EF.Functions.Like("" + vehicle.IMEI, input));
                break;
            case 5:
                query = query.Where(vehicle => EF.Functions.Like(vehicle.CompanyCVR, input));
                break;
        }

        // Apply offset and amount for pagination
        vehicles = await query
            .Skip(offset)
            .Take(amount)
            .ToListAsync();

        return vehicles;
    }


    public async Task<bool> createSkaderapport(Skaderapport skaderapport, string currentToken)
    {
        if (checkCurrentToken(currentToken))
        {
            try
            {
                await _context.Skaderapports.AddAsync(skaderapport);
                await _context.SaveChangesAsync();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        return false;
    }

    public async Task<Skaderapport> getLatestSkadeRapport(int imei, string currentToken)
    {
        if (checkCurrentToken(currentToken))
        {
            try
            {
                if (_context.Skaderapports.Any(u => u.IMEINumber == ""+imei))
                {
                    Skaderapport temp = (await _context.Skaderapports.FirstOrDefaultAsync(u => u.IMEINumber == ""+imei))!;
                    return temp;
                }
            }
            catch (Exception e)
            {
                return null;
            }
        }
        return null;
    }

    public async Task<bool> updateSkadeRapport(Skaderapport skaderapport, string currentToken)
    {
        if (checkCurrentToken(currentToken))
        {
            try
            {
                if (_context.Skaderapports.Any(u => u.IMEINumber == skaderapport.IMEINumber))
                {
                    Skaderapport temp =
                        (await _context.Skaderapports.FirstOrDefaultAsync(u => u.IMEINumber == skaderapport.IMEINumber))
                        !;
                    temp.A = skaderapport.A;
                    temp.B = skaderapport.B;
                    temp.C = skaderapport.C;
                    temp.D = skaderapport.D;
                    temp.LastEditedDateTime = DateTime.Now;
                    temp.TeknikerId = skaderapport.TeknikerId;

                    await _context.SaveChangesAsync();
                    return true;
                }
            }
            catch (Exception e)
            {
                return false;
            }
        }

        return false;
    }


    public async Task<VehicleInfo> getVehicleInfo(int imei, string currentToken)
    {

        if(checkCurrentToken(currentToken))
        {
            if (_context.VehicleInfos.Any(u => u.IMEI == imei))
            {
                VehicleInfo info = (await _context.VehicleInfos.FirstOrDefaultAsync(u => u.IMEI == imei))!;
                return info;
            }
        }

        return null!;
    }

    public VehicleInfo getVehicleInfo(int imei)
    {
        
        VehicleInfo vehicleInfo = new VehicleInfo
        {
            Errors = returnRandomErrors(),
            Readings = RandomVehicleReadingsGen(),
            LatCords = 5.5,
            LonCords = 10.10,
            ProductType = "MPPT DTU",
            IMEI = imei
        };

        return vehicleInfo;

    }

    private bool checkCurrentToken(string currentToken)
    {
        if (_context.Teknikers.Any(u => u.CurrentToken == currentToken))
        {
            return true;
        }
        return false;
    }
}