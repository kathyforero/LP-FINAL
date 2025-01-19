package com.miapp.mi_servidor.Excepciones;

public class AutoNoEncontradoException extends RuntimeException {
    public AutoNoEncontradoException(String mensaje) {
        super(mensaje);
    }
}
