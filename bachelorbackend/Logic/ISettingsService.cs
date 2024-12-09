using DefaultNamespace;

namespace bachelorbackend.Logic;

public interface ISettingsService
{
    public Task<bool> updateSettings(string imei, VehicleSetting settings, string currentToken);
    public Task<VehicleSetting> getSettings(string imei, string currentToken);


}