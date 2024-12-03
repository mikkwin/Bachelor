using bachelorbackend.Data.DAO;
using Microsoft.AspNetCore.Mvc;

namespace bachelorbackend.Data;

public interface IDataService
{


    public List<Vehicle> getTechnicianHistory(int techID);
    public Task<VehicleInfo> getVehicleInfo(int imei, string currentToken);
    public Task<List<Vehicle>> vehicleSearch(string input, int filter, string currentToken);

}