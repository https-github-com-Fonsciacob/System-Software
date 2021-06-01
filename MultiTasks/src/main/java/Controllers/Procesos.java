package Controllers;

import Models.Notes;
import Models.TaskList;
import Models.Tasks;
import Models.Users;
import conexion.Conexion;

import java.lang.reflect.Type;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Procesos {

    private static Conexion con = new Conexion();
    private static final Connection cn = con.conexion();
    private CallableStatement objStm;
    public String resultado;


    /**PROCEDIMIENTOS ALMACENADOS (VISTA)**/

    public List<Users> showUser(Users users) throws SQLException {

        ResultSet objRs = null;
        List<Users> listUser = new ArrayList<>();

        objStm= cn.prepareCall("Sp_searchUser ?,?");
        objStm.setString(1,users.getCorreo());
        objStm.setString(2,users.getContraseña());
        objStm.execute();
        objRs=objStm.getResultSet();

        while (objRs.next()){
            Users user = new Users();
            user.setId(objRs.getString(1));
            user.setNombre(objRs.getString(2));
            listUser.add(user);
        }
        return listUser;
    }

    public List<TaskList> showList() throws SQLException {

        ResultSet objRs = null;
        List<TaskList> listaTask= new ArrayList<>();
        objStm = cn.prepareCall("Sp_MostrartaskList");
        objStm.execute();
        objRs=objStm.getResultSet();

        while (objRs.next()){
            TaskList list = new TaskList();

            list.setId(objRs.getString(1));
            list.setIdUser(objRs.getString(2));
            list.setNombreLista(objRs.getString(3));

            listaTask.add(list);
        }
        return  listaTask;
    }

    public List<Tasks> showTasks() throws SQLException {

        ResultSet objRs=null;
        List<Tasks> tasks = new ArrayList<>();
        objStm=cn.prepareCall("Sp_MostrarTask");
        objStm.execute();
        objRs=objStm.getResultSet();

        while (objRs.next()){
            Tasks task = new Tasks();

            task.setId(objRs.getString(1));
            task.setIdTaskList(objRs.getString(2));
            task.setNombreTarea(objRs.getString(3));
            task.setNombreLista(objRs.getString(4));
            task.setEstado(objRs.getString(5));

            tasks.add(task);
        }
        return tasks;
    }

    public List<Notes> showNotes() throws SQLException {

        ResultSet objRs=null;
        List<Notes> notes = new ArrayList<>();
        objStm = cn.prepareCall("Sp_MostrarNotes");
        objStm.execute();
        objRs=objStm.getResultSet();

        while (objRs.next()){
            Notes list = new Notes();

            list.setId(objRs.getString(1));
            list.setIdTask(objRs.getString(2));
            list.setNameNotes(objRs.getString(3));

            notes.add(list);
        }
        return notes;
    }


    /**PROCEDIMIENTOS ALMACENADOS (INSERTAR)**/

    public void newUser(Users users) throws SQLException {

        objStm=cn.prepareCall("Sp_InsertarUser ?,?,?,?,?");
        objStm.setString(1, users.getNombre());
        objStm.setString(2,users.getApellido());
        objStm.setString(3,users.getUsername());
        objStm.setString(4,users.getCorreo());
        objStm.setString(5, users.getContraseña());

        objStm.execute();
    }

    public void newTaskList(TaskList taskList) throws SQLException {

        objStm=cn.prepareCall("Sp_InsertarTaskList ?,?");
        objStm.setString(1,taskList.getIdUser());
        objStm.setString(2,taskList.getNombreLista());

        objStm.execute();
    }

    public void newTasks(Tasks tasks) throws SQLException {

        objStm=cn.prepareCall("Sp_InsertarTasks ?,?,?");
        objStm.setString(1,tasks.getIdTaskList());
        objStm.setString(2,tasks.getNombreTarea());
        objStm.setString(3,tasks.getNombreLista());

        objStm.execute();
    }

    public void newNotes(Notes notes) throws SQLException {

        objStm=cn.prepareCall("Sp_InsertarNotes ?,?");
        objStm.setString(1,notes.getIdTask());
        objStm.setString(2,notes.getNameNotes());

        objStm.execute();
    }

    /**PROCEDIMIENTOS ALMACENADOS (ACTUALIZAR)**/

    public void updateUser (Users users) throws SQLException {

        objStm = cn.prepareCall("Sp_UpdateUsers ?,?,?,?,?,?,?");
        objStm.setString(1, users.getId());
        objStm.setString(2, users.getNombre());
        objStm.setString(3, users.getApellido());
        objStm.setString(4, users.getUsername());
        objStm.setString(5, users.getCorreo());
        objStm.setString(6, users.getContraseña());
        objStm.registerOutParameter(7, Types.VARCHAR);
        objStm.execute();

        resultado=objStm.getString(7);
    }

    public void updateTaskList(TaskList taskList) throws SQLException {

        objStm= cn.prepareCall("Sp_UpdateList ?,?,?");
        objStm.setString(1, taskList.getId());
        objStm.setString(2, taskList.getNombreLista());
        objStm.registerOutParameter(3, Types.VARCHAR);
        objStm.execute();

        resultado=objStm.getString(3);
    }

    public void updateTasks (Tasks tasks) throws SQLException {

        objStm=cn.prepareCall("Sp_UpdateTask ?,?,?,?");
        objStm.setString(1,tasks.getId());
        objStm.setString(2,tasks.getNombreTarea());
        objStm.setString(3, tasks.getNombreLista());
        objStm.registerOutParameter(4,Types.VARCHAR);
        objStm.execute();

        resultado=objStm.getString(4);
    }

    public void updateNotes (Notes notes) throws SQLException {

        objStm= cn.prepareCall("Sp_UpdateNotes ?,?,?");
        objStm.setString(1,notes.getId());
        objStm.setString(2,notes.getNameNotes());
        objStm.registerOutParameter(3, Types.VARCHAR);
        objStm.execute();

        resultado=objStm.getString(3);
    }

    /**PROCEDIMIENTOS ALMACENADOS (ELIMINAR)**/

    public void deleteUser (Users users) throws SQLException {
        objStm= cn.prepareCall("Sp_DeleteUser ?");
        objStm.setString(1,users.getId());
        objStm.execute();
    }

    public void deleteTaskList(TaskList taskList) throws SQLException {
        objStm= cn.prepareCall("Sp_DeleteTaskList ?");
        objStm.setString(1,taskList.getId());
        objStm.execute();
    }

    public void deleteTasks (Tasks tasks) throws SQLException {
        objStm= cn.prepareCall("Sp_DeleteTasks ?");
        objStm.setString(1,tasks.getId());
        objStm.execute();
    }

    public void deleteNotes (Notes notes) throws SQLException {
        objStm= cn.prepareCall("Sp_DeleteNote ?");
        objStm.setString(1,notes.getId());
        objStm.execute();
    }
}
