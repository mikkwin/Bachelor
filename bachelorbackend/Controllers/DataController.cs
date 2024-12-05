using bachelorbackend.Data;
using bachelorbackend.Data.DAO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace bachelorbackend.Controllers;

[ApiController]
[Route("[Controller]")]
public class DataController : ControllerBase
{

    private readonly DataService _dataService;

    public DataController(IDataService dataService)
    {
        _dataService = (DataService) dataService;
    }


    /*
    [HttpGet("GetHistory")]
    [AllowAnonymous]
    public List<Vehicle> GetHistory(int technicianID)
    {
        List<Vehicle> res = _dataService.getTechnicianHistory(technicianID);

        if (res.Count == 0)
        {
            return new List<Vehicle>();
        }
        
        return res;
    }

    [HttpGet("VehicleSearch")]
    [AllowAnonymous]
    public List<Vehicle> VehicleSearch(dynamic query)
    {
        List<Vehicle> res = _dataService.VehicleSearch(query);

        if (res.Count == 0)
        {
            return new List<Vehicle>();
        }
        
        return res;
        
    }
    
    

    [HttpGet("GetVehicle")]
    [AllowAnonymous]
    public VehicleInfo getVehicle(int IMEI)
    {
        VehicleInfo info = _dataService.getVehicleInfo(IMEI);

        return info;
    }

*/
    [HttpGet("VehicleSearch")]
    [AllowAnonymous]
    public async Task<List<Vehicle>> searchVehicle(string query, int filter, string currentToken, int offset, int amount)
    {
        List<Vehicle> vehicles = new List<Vehicle>();

        vehicles = await _dataService.vehicleSearch(query, filter, currentToken, offset, amount);

        return await Task.FromResult(vehicles);
    }
    
    
    [HttpGet("GetVehicle")]
    [AllowAnonymous]
    public Task<VehicleInfo> getVehicle(int imei, string currentToken)
    {
        
        VehicleInfo vehicleInfo = _dataService.getVehicleInfo(imei, currentToken).Result;

        return Task.FromResult(vehicleInfo);
    }

}