package Models;

public class CreditCard {

    protected String IdUser;
    protected String NumeroT;
    private String FechaExpiracion;
    protected String CVR;

    public CreditCard() {
        super();
    }

    public String getIdUser() {
        return IdUser;
    }

    public void setIdUser(String idUser) {
        IdUser = idUser;
    }

    public String getNumeroT() {
        return NumeroT;
    }

    public void setNumeroT(String numeroT) {
        NumeroT = numeroT;
    }

    public String getFechaExpiracion() {
        return FechaExpiracion;
    }

    public void setFechaExpiracion(String fechaExpiracion) {
        FechaExpiracion = fechaExpiracion;
    }

    public String getCVR() {
        return CVR;
    }

    public void setCVR(String CVR) {
        this.CVR = CVR;
    }
}
