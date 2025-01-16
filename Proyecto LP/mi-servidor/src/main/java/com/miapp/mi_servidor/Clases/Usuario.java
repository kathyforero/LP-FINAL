package com.miapp.mi_servidor.Clases;

import java.util.List;

public class Usuario {
    private String nombre;
    private String apellido;
    private String correo;
    private String contraseña;
    private List<String> favoritos;

    public Usuario(String nombre, String apellido, String correo, String contraseña) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.contraseña = contraseña;
    }

    public boolean validarUsuario(String correo, String contraseña) {
        if (correo.equals(this.correo) && contraseña.equals(this.contraseña)) {
            return true;
        } else {
            return false;
        }
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getCorreo() {
        return correo;
    }

    public String getContraseña() {
        return contraseña;
    }

    public List<String> getFavoritos() {
        return favoritos;
    }

    public void addFavorito(String auto) {
        favoritos.addLast(auto);
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public void setFavorito(List<String> favoritos) {
        this.favoritos = favoritos;
    }

    public String toString() {
        return nombre + " " + apellido + " con correo electronico: " + correo + " y tiene " + favoritos.size()
                + " carros favoritos";
    }
}
