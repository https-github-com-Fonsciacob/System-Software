package Models;

public class TaskList {

    protected String id;
    protected String idUser;
    private String nombreLista;

    public TaskList() {
        super();
    }

    public TaskList(String id, String idUser, String nombreLista) {
        this.id = id;
        this.idUser = idUser;
        this.nombreLista = nombreLista;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdUser() {
        return idUser;
    }

    public void setIdUser(String idUser) {
        this.idUser = idUser;
    }

    public String getNombreLista() {
        return nombreLista;
    }

    public void setNombreLista(String nombreLista) {
        this.nombreLista = nombreLista;
    }
}
