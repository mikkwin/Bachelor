using System.Security.Cryptography;
using System.Text;
using bachelorbackend.Data.DB;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace bachelorbackend.Logic;

public class LoginService : ILoginService
{
    private readonly IConfiguration config;
    private DataContext _context;
    
    public LoginService(IConfiguration config, DataContext context)
    {
        this.config = config;
        _context = context;
    }
    
    private static string Hasher(string input)
    {
        using (var md5 = MD5.Create())
        {
            input += "bachelorGE"; //salt
            var temp = md5.ComputeHash(Encoding.UTF8.GetBytes(input));
            var builder = new StringBuilder();
            for (var i = 0; i < temp.Length; i++) builder.Append(temp[i].ToString("x2"));

            return builder.ToString();
        }
    }

    public async Task<bool> Logout(string username)
    {
        try
        {
            if (_context.Teknikers.Any(u => u.Username == username))
            {
                Tekniker tekniker = _context.Teknikers.FirstOrDefault(u => u.Username == username)!;
                tekniker.CurrentToken = "";
                await _context.SaveChangesAsync();

                return true;
            }
        }
        catch (Exception e)
        {
            return false;
        }

        return false;
    }

    public async Task<string> Login(string username, string password)
    {
        try
        {
            if (_context.Teknikers.Any(u => u.Username == username))
            {
                Tekniker tekniker = _context.Teknikers.FirstOrDefault(u => u.Username == username)!;
                if (tekniker.Password.Equals(password))
                {
                    tekniker.LastLoginDateTime = DateTime.Now;
                    tekniker.CurrentToken = Hasher(username + password + DateTime.Now);
                    await _context.SaveChangesAsync();

                    return tekniker.CurrentToken;
                }
            }
            
        }
        catch (Exception e)
        {
            return "";
        }

        return "";

    }

    public async Task<bool> CreateUser(string username, string password)
    {
        try
        {
            Tekniker tekniker = new Tekniker()
            {
                Password = password,
                Username = username,
                CreatedDateTime = DateTime.Now,
                LastLoginDateTime = DateTime.Now,
                CurrentToken = ""
            };

            await _context.Teknikers.AddAsync(tekniker);
            await _context.SaveChangesAsync();

            return true;
        }
        catch (Exception e)
        {
            return false;
        }
    }
}