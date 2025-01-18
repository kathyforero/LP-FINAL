package com.miapp.mi_servidor.Clases;

import java.util.ArrayList;
import java.util.List;

public class Usuario {
    private String nombre;
    private String apellido;
    private String correo;
    private String contrasena;
    private List<String> favoritos = new ArrayList<>();

    public Usuario() {} // Constructor vacío para Firebase

    public Usuario(String nombre, String apellido, String correo, String contrasena) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.contrasena = HashUtil.md5(contrasena);
    }

    public boolean validarContrasena(String contrasena) {
        return this.contrasena.equals(HashUtil.md5(contrasena));
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

    public String getContrasena() {
        return contrasena;
    }

    public List<String> getFavoritos() {
        return favoritos;
    }

    public void addFavorito(String auto) {
        favoritos.add(auto);
    }

    public void removeFavorito(String autoId) {
        favoritos.remove(autoId);
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

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public void setFavorito(List<String> favoritos) {
        this.favoritos = favoritos;
    }

    public String toString() {
        return nombre + " " + apellido + " con correo electronico: " + correo + " y tiene " + favoritos.size()
                + " carros favoritos";
    }
}
