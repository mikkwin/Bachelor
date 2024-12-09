using bachelorbackend.Data.DAO;
using Microsoft.AspNetCore.Mvc;

namespace bachelorbackend.Data;

public interface IDataService
{


    public List<Vehicle> getTechnicianHistory(int techID);
    public Task<VehicleInfo> getVehicleInfo(string imei, string currentToken);
    public Task<List<Vehicle>> vehicleSearch(string input, int filter, string currentToken, int offset, int amount);

    public Task<ActionResult<string>> fillDatabase();
}