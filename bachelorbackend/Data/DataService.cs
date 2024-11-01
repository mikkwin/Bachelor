using bachelorbackend.Data.DAO;

namespace bachelorbackend.Data;

public class DataService : IDataService
{
    private string URL_KEY = "db542dcc6b5cf658536d7db8e9e5e7c3 aceddd490d711d00a28fc2f6bec0050e27616b31d7093fc95b492335b36fbe24124839b795758b19b8e52daa81e0651f843941ad67854122136131448c4ef7c9380488b538b73fc1365e4593c092b7035584bda5d8e14529ea318bc816e8eca62386ac19d81e42445ea8a3d1e676031febed3b03ce3209b0a525484352d9b6a6e";
    private string DB_KEY = "aebguåaebgae9geaguae";


    public List<Vehicle> getTechnicianHistory(int techID)
    {
        List<Vehicle> vehicles = new List<Vehicle>();

        for (int i = 0; i < 10; i++)
        {

            Vehicle vehicle = new Vehicle("EG50979", DateTime.Now.Ticks, "" + 123532 * i, techID, i * DateTime.Now.Ticks, i);
            vehicles.Add(vehicle);
            
        }

        return vehicles;
    }
}