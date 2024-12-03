using bachelorbackend.Data.DB;
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
    
    public async Task<bool> updateSettings(int imei, VehicleSetting settings, string currentToken)
    {
        if (_context.VehicleSettings.Any(u => u.IMEI == ""+imei))
        {
            VehicleSetting setting = (await _context.VehicleSettings.FirstOrDefaultAsync(u => u.IMEI == ""+imei))!;
            setting = settings;
            await _context.SaveChangesAsync();

            return true;
        }

        return false;
    }

    public Task<VehicleSetting> getSettings(int imei, string currentToken)
    {
        throw new NotImplementedException();
    }
}