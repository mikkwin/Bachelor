using bachelorbackend.Data.DAO;
using bachelorbackend.Logic;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace bachelorbackend.Controllers;

[ApiController]
[Route("[Controller]")]
public class LoginController : ControllerBase
{
    private readonly LoginService _loginService;

    public LoginController(ILoginService loginService)
    {
        _loginService = (LoginService) loginService;
    }

    
    [HttpGet("Login")]
    [AllowAnonymous]
    public async Task<ActionResult<string>> Login(string username, string password)
    {
        
        string currentToken = _loginService.Login(username, password).Result;
        if (currentToken != "")
        {
            return Ok(currentToken);
        }
        
        return BadRequest();
    }

    [HttpGet("Logout")]
    [AllowAnonymous]
    public async Task<ActionResult> Logout(string username)
    {
        if (await _loginService.Logout(username))
        {
            return Ok();
        }

        return BadRequest();
    }
    
    [HttpPost("Create")]
    [AllowAnonymous]
    public async Task<ActionResult<string>> CreateUser(string username, string password)
    {
        if (await _loginService.CreateUser(username, password))
        {
            return Ok();
        }

        return BadRequest();
    }
}