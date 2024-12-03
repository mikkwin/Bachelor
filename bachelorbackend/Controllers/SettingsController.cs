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
    public async Task<ActionResult> getSettings(int imei, string currentToken)
    {
        VehicleSetting setting = await _settingsService.getSettings(imei, currentToken);

        return BadRequest();
    }
    
    [HttpPatch("UpdateSettings")]
    [AllowAnonymous]
    public async Task<ActionResult> updateSettings([FromBody] VehicleSetting settings, string currentToken)
    {
        if (await _settingsService.updateSettings(int.Parse(settings.IMEI), settings, currentToken))
        {
            return Ok();
        }

        return BadRequest();
    }

}