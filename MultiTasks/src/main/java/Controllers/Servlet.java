package Controllers;

import Models.TaskList;
import Models.Tasks;
import Models.Users;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/multi")
public class Servlet extends HttpServlet {

    public Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String result=request.getParameter("option");
        Procesos procesos = new Procesos();

        if(result.equals("prueba")) {
            
            List<TaskList> lista = new ArrayList<>();
            List<Tasks> tasks = new ArrayList<>();

            try {
                lista=procesos.showList();
                tasks=procesos.showTasks();
                request.setAttribute("tasks",tasks);
                request.setAttribute("listTask",lista);
                RequestDispatcher ruta =request.getRequestDispatcher("prueba.jsp");
                ruta.forward(request,response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String result=request.getParameter("option");
        Procesos procesos = new Procesos();

        if (result.equals("verificar")){
            Users users = new Users();
            List<Users> list = new ArrayList<>();

            users.setCorreo(request.getParameter("mail"));
            users.setContraseña(request.getParameter("pass"));

            try {
                list = procesos.showUser(users);
                request.setAttribute("user",list);
                RequestDispatcher ruta =request.getRequestDispatcher("prueba.jsp");
                ruta.forward(request,response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
