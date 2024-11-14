using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using bachelorbackend.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddScoped<IDataService, DataService>();
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

builder.WebHost.ConfigureKestrel(options =>
{
    // Bind to HTTP on port 5000
    options.ListenAnyIP(5000, listenOptions =>
    {
        listenOptions.UseHttps();  // Enable HTTPS on port 5001
    });
    // Bind to HTTPS on port 5001
    options.ListenAnyIP(5001, listenOptions =>
    {
        listenOptions.UseHttps();  // Make sure you have a valid certificate for this
    });
});


var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // Comment out or remove the HSTS middleware for now
    // app.UseHsts();  // Removed to disable HSTS
}

// Disable HTTPS redirection
// app.UseHttpsRedirection(); // Comment out or remove this line to avoid redirection to HTTPS

app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

// Map controllers (API routes)
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=Home}/{action=Index}/{id?}");
});

// Enable static files middleware (this line is already present above)
app.UseStaticFiles();

// Ensure routing and authorization
app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();