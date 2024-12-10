using bachelorbackend.Data.DAO;
using bachelorbackend.Logic;
using DefaultNamespace;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace bachelorbackend.Controllers;

[ApiController]
[Route("[Controller]")]
public class SettingsController : ControllerBase
{
    private readonly SettingsService _settingsService;

    public SettingsController(ISettingsService settingsService)
    {
        _settingsService = (SettingsService)settingsService;
    }


    
    
    [HttpGet("GetSettings")]
    [AllowAnonymous]
    public async Task<ActionResult> getSettings(string imei, string currentToken)
    {
        var setting = await _settingsService.getSettings(imei, currentToken);

        if (setting != null)
        {
            
        }
        

        return BadRequest("Invalid token or IMEI");
    }
    
    [HttpPatch("UpdateSettings")]
    [AllowAnonymous]
    public async Task<ActionResult> updateSettings([FromBody] VehicleSetting settings, string currentToken)
    {
        Console.WriteLine(settings.ToString());
        
        if (await _settingsService.updateSettings(settings.IMEI, settings, currentToken))
        {
            return Ok();
        }

        return BadRequest();
    }

    [HttpGet("FillSettings")]
    [AllowAnonymous]
    public async Task<ActionResult<string>> generateSetings()
    {
        await _settingsService.generateSettingsForAllVehicles();
        return Ok("Settings has been created");
    }

}