using bachelorbackend.Data.DAO;
using bachelorbackend.Data.DB;
using bachelorbackend.Data.Enums;
using DefaultNamespace;
using Microsoft.EntityFrameworkCore;

namespace bachelorbackend.Logic;

public class SettingsService : ISettingsService
{
    private readonly IConfiguration config;
    private DataContext _context;
    
    public SettingsService(IConfiguration config, DataContext context)
    {
        this.config = config;
        _context = context;
    }
    
    public async Task<bool> updateSettings(string imei, VehicleSetting settings, string currentToken)
    {
        var existingSetting = await _context.VehicleSettings.FirstOrDefaultAsync(u => u.IMEI == "" + imei);

        if (existingSetting != null)
        {
            existingSetting.S010a = settings.S010a;
            existingSetting.e003 = settings.e003;
            existingSetting.e004 = settings.e004;
            existingSetting.e005 = settings.e005;
            existingSetting.e006 = settings.e006;
            existingSetting.e007 = settings.e007;
            existingSetting.e008 = settings.e008;
            existingSetting.e009 = settings.e009;
            existingSetting.e00a = settings.e00a;
            existingSetting.e00b = settings.e00b;
            existingSetting.e00c = settings.e00c;
            existingSetting.e00d = settings.e00d;
            existingSetting.e00e = settings.e00e;
            existingSetting.e010 = settings.e010;
            existingSetting.e011 = settings.e011;
            existingSetting.e012 = settings.e012;
            existingSetting.e013 = settings.e013;
            existingSetting.e014 = settings.e014;

            await _context.SaveChangesAsync();
            getVehicleInfoNoErrors(imei);

            return true;
        }

        return false;
    }
    
    private async void getVehicleInfoNoErrors(string imei)
    {
        
        if (_context.VehicleInfos.Any(u => u.IMEI == imei))
        {
            VehicleInfo info = (await _context.VehicleInfos.FirstOrDefaultAsync(u => u.IMEI == imei))!;

            List<ErrorCode> errorCodes = new List<ErrorCode>();
            ErrorCode noFails = ErrorCode.NO_ERR;
            errorCodes.Add(noFails);

            info.Errors = errorCodes;
            await _context.SaveChangesAsync();
            Console.WriteLine("All good");
        }
    }

    public Task<VehicleSetting> getSettings(string imei, string currentToken)
    {
        throw new NotImplementedException();
    }
}