package Models;

public class Tasks {

    protected String id;
    protected String idTaskList;
    private String nombreTarea;
    private String nombreLista;
    private String estado;

    public Tasks() {
        super();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdTaskList() {
        return idTaskList;
    }

    public void setIdTaskList(String idTaskList) {
        this.idTaskList = idTaskList;
    }

    public String getNombreTarea() {
        return nombreTarea;
    }

    public void setNombreTarea(String nombreTarea) {
        this.nombreTarea = nombreTarea;
    }

    public String getNombreLista() {
        return nombreLista;
    }

    public void setNombreLista(String nombreLista) {
        this.nombreLista = nombreLista;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
