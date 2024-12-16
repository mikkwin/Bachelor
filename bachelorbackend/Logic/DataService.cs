using bachelorbackend.Data.DAO;
using bachelorbackend.Data.DB;
using bachelorbackend.Data.Enums;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace bachelorbackend.Data;

public class DataService : IDataService
{
    
    private readonly IConfiguration config;
    private DataContext _context;


    public DataService(IConfiguration config, DataContext context)
    {
        this.config = config;
        _context = context;
    }
    
    private IEnumerable<DateTime> EachInstance(DateTime from, DateTime thru, int filter)
    {

        switch (filter)
        {
            case 1: //day
                for(var day = from.Date; day.Date <= thru.Date; day = day.AddDays(1))
                    yield return day;
                break;
            case 2: //hour
                for (var hour = from.Date; hour.Date <= thru.Date; hour = hour.AddHours(1))
                    yield return hour;
                break;
            case 3: //10 minute interval
                for (var fifteen = from.Date; fifteen.Date <= thru.Date; fifteen = fifteen.AddMinutes(15))
                    yield return fifteen;
                break; 
            case 4: //1 min interval
                for (var min = from.Date; min.Date <= thru.Date; min = min.AddMinutes(1))
                    yield return min;
                break; 
        }
        
        
        for(var day = from.Date; day.Date <= thru.Date; day = day.AddDays(1))
            yield return day;
    }

    private List<VehicleReadings> RandomVehicleReadingsGen(DateTime start, DateTime end, string imei)
    {
        List<VehicleReadings> readings = new List<VehicleReadings>();
        
        TimeSpan span = end.Subtract(start);
        int spanInt = (int)span.TotalMinutes / 15;

        Random random = new Random();

        for (int i = 0; i < spanInt; i++)
        {
            start = start.AddMinutes(15);

            VehicleReadings reading = new VehicleReadings()
            {
                IMEI = imei,
                Timestamp = start,
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
            Console.WriteLine("Reading added");
            
            readings.Add(reading);
        }

        return readings;
    }

    private List<ErrorCode> returnRandomErrors()
    {
        List<ErrorCode> codes = new List<ErrorCode>();

        for (int i = 0; i < 2; i++)
        {
            if (DateTime.Now.Second % 3 == 0)
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
    
    


    private bool isInDateRange(DateTime from, DateTime to, DateTime query)
    {
        return (from.Ticks >= query.Ticks) && (to.Ticks >= query.Ticks);
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

    private List<Vehicle> generateVehicleSearch(int offset, int amount, string imei)
    {
        List<Vehicle> vehicles = new List<Vehicle>();
        
        for (int i = offset; i < offset+amount; i++)
        {
            Vehicle vehicle = new Vehicle()
            {
                Id = i,
                IMEI = imei,
                LicensePlate = $"EG{i}979",
                OrgName = $"Org{i}",
                VehicleName = $"Vehicle{i}",
                CompanyCVR = $"Company{i}",
                LastTechnicianSearch = DateTime.Now.DayOfYear,
            };
            vehicles.Add(vehicle);
        }

        return vehicles;

    }

    public async Task<List<Vehicle>> vehicleSearch(string input, int filter, string currentToken, int offset, int amount)
    {
        
        List<Vehicle> vehicles = new List<Vehicle>();

        if (input == "default")
        {
            vehicles = _context.Vehicles.Take(amount).ToList();
            return vehicles;
        }

        IQueryable<Vehicle> query = _context.Vehicles;

        switch (filter)
        {
            case 1:
                Console.WriteLine("OrgName");
                query = query.Where(vehicle => vehicle.OrgName != null && vehicle.OrgName.Contains(input));
                break;
            case 2:
                Console.WriteLine("LP");
                query = query.Where(vehicle => vehicle.LicensePlate != null && vehicle.LicensePlate.Contains(input));
                break;
            case 3:
                Console.WriteLine("VehicleName");
                query = query.Where(vehicle => vehicle.VehicleName != null && vehicle.VehicleName.Contains(input));
                break;
            case 4:
                Console.WriteLine("IMEI");
                query = query.Where(vehicle => vehicle.IMEI != null && vehicle.IMEI.Contains(input));
                break;
            case 5:
                Console.WriteLine("CVR");
                query = query.Where(vehicle => vehicle.CompanyCVR != null && vehicle.CompanyCVR.Contains(input));
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
                if (_context.Skaderapports.Any(u => u.IMEI == ""+imei))
                {
                    Skaderapport temp = (await _context.Skaderapports.FirstOrDefaultAsync(u => u.IMEI == ""+imei))!;
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
                if (_context.Skaderapports.Any(u => u.IMEI == skaderapport.IMEI))
                {
                    Skaderapport temp =
                        (await _context.Skaderapports.FirstOrDefaultAsync(u => u.IMEI == skaderapport.IMEI))
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


    public async Task<VehicleInfo> getVehicleInfo(string imei, string currentToken)
    {
        
        if(checkCurrentToken(currentToken))
        {
            if (_context.VehicleInfos.Any(u => u.IMEI == imei))
            {
                VehicleInfo info = (await _context.VehicleInfos.FirstOrDefaultAsync(u => u.IMEI == imei))!;
                List<VehicleReadings> readingsList = (await _context.VehicleReadings.Where(x => x.IMEI == imei).ToListAsync());
                info.Readings = readingsList;
                return info;
            }
        }

        return null!;
    }

    public async Task<VehicleInfo> getVehicleInfo(string imei, string currentToken, DateTime start, DateTime end)
    {
        if(checkCurrentToken(currentToken))
        {
            if (_context.VehicleInfos.Any(u => u.IMEI == imei))
            {
                VehicleInfo info = (await _context.VehicleInfos.FirstOrDefaultAsync(u => u.IMEI == imei))!;
                List<VehicleReadings> readingsList = (await _context.VehicleReadings.Where(x => x.IMEI == imei).ToListAsync());
                info.Readings = filterReadingsByDate(readingsList, start, end);
                return info;
            }
        }

        return null!;
    }


    private List<VehicleReadings> filterReadingsByDate(List<VehicleReadings> readings, DateTime startDate, DateTime endDate)
    {
        List<VehicleReadings> filteredReadings = new List<VehicleReadings>();

        foreach (var reading in readings)
        {
            if(isInDateRange(startDate, endDate, reading.Timestamp))
            {
                filteredReadings.Add(reading);
            }
        }
        
        return filteredReadings;
    }
    

    public async Task<VehicleInfo> getVehicleInfo(string imei)
    {
        Console.WriteLine(imei);
        
        VehicleInfo vehicleInfo = new VehicleInfo
        {
            Errors = returnRandomErrors(),
            Readings = RandomVehicleReadingsGen(DateTime.Now.AddDays(-1), DateTime.Now, imei) ,
            LatCords = 5.5,
            LonCords = 10.10,
            ProductType = "MPPT DTU",
            IMEI = imei
        };

        await _context.VehicleInfos.AddAsync(vehicleInfo);
        await _context.SaveChangesAsync();
        

        return vehicleInfo;

    }

    public async Task<ActionResult<string>> fillDatabase()
    {
        Random random = new Random();
        for (int i = 0; i < 30; i++)
        {

            string prefix = random.Next(0, 2) == 0 ? "8945" : "8633";
            string randomDigits = "";
            for (int j = 0; j < 11; j++)
            {
                randomDigits += random.Next(0, 10).ToString();
            }
            
            string imei = prefix + randomDigits;

            if (!_context.Vehicles.Any(x => x.IMEI == imei))
            {
                
                char firstLetter = (char)random.Next('A', 'Z' + 1);
                char secondLetter = (char)random.Next('A', 'Z' + 1);
                
                string digits = "";
                for (int k = 0; k < 5; k++)
                {
                    digits += random.Next(0, 10).ToString();
                }

                string licensePlate = $"{firstLetter}{secondLetter}{digits}";
                
                string cvrNumber = "";
                for (int l = 0; l < 8; l++)
                {
                    cvrNumber += random.Next(0, 10).ToString();
                }

                Vehicle vehicle = new Vehicle()
                {
                    IMEI = imei,
                    LicensePlate = licensePlate,
                    VehicleName = "MPPT DTU",
                    CompanyCVR = cvrNumber,
                    LastTechnicianSearch = 0,
                    OrgName = i % 2 == 0 ? "VIA" : "GreenEnergy"
                };
                
                
                
                await _context.Vehicles.AddAsync(vehicle);
                _context.SaveChanges();
                
                VehicleInfo vehicleInfo = new VehicleInfo()
                {
                    Errors = returnRandomErrors(),
                    Readings = RandomVehicleReadingsGen(DateTime.Today.AddDays(-1), DateTime.Now, imei),
                    IMEI = imei,
                    LatCords = random.NextDouble() * 5.5,
                    LonCords = random.NextDouble() * 10.10,
                    ProductType = "MPPT DTU",
                };

                await _context.VehicleInfos.AddAsync(vehicleInfo);
                await _context.SaveChangesAsync();
            }
            await _context.SaveChangesAsync();
        }

        return new ActionResult<string>("good");

    }
    
    
    private async Task<VehicleInfo> getVehicleInfoNoErrors(string imei)
    {
        
        if (_context.VehicleInfos.Any(u => u.IMEI == imei))
        {
            VehicleInfo info = (await _context.VehicleInfos.FirstOrDefaultAsync(u => u.IMEI == imei))!;

            List<ErrorCode> errorCodes = new List<ErrorCode>();
            ErrorCode NoFails = ErrorCode.NO_ERR;
            errorCodes.Add(NoFails);

            info.Errors = errorCodes;
            await _context.SaveChangesAsync();
            
            return info;
        }

        return null;

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