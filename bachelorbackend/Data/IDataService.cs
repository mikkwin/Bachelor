using bachelorbackend.Data.DAO;

namespace bachelorbackend.Data;

public interface IDataService
{


    public List<Vehicle> getTechnicianHistory(int techID);
    
}