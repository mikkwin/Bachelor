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


    [HttpGet]
    [AllowAnonymous]
    public List<Vehicle> GetHistory(int technicianID)
    {
        List<Vehicle> vehicles;


        vehicles = _dataService.getTechnicianHistory(technicianID);


        return vehicles;
            
        
    }
    
}