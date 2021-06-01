package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    //CONEXION A LA BASE DE DATOS
    private static final String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String url="jdbc:sqlserver://azuredatabases.database.windows.net:1433;database=MultiTasks;user=local@azuredatabases;password=pbw,8vpn;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30";

    public static Connection conexion(){
        Connection conexion=null;
        try{
            Class.forName(driver);
            conexion= DriverManager.getConnection(url);
            System.out.println("Conexion Exitosa");
        }catch(ClassNotFoundException | SQLException e){
            System.out.println("Conexion Fallida");
        }
        return conexion;
    }
}
