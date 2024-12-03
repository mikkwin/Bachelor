using DefaultNamespace;

namespace bachelorbackend.Logic;

public interface ISettingsService
{
    public Task<bool> updateSettings(int imei, VehicleSetting settings, string currentToken);
    public Task<VehicleSetting> getSettings(int imei, string currentToken);


}