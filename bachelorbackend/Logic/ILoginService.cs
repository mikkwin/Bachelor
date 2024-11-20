using Microsoft.AspNetCore.Mvc;

namespace bachelorbackend.Logic;

public interface ILoginService
{
    public Task<string> Login(string username, string password);
    public Task<bool> Logout(string username);
    public Task<bool> CreateUser(string username, string password);
}