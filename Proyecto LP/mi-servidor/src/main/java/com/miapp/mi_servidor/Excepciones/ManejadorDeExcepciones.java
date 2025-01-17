package com.miapp.mi_servidor.Excepciones;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ManejadorDeExcepciones {

    @ExceptionHandler(AutoNoEncontradoException.class)
    public ResponseEntity<String> manejarAutoNoEncontrado(AutoNoEncontradoException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
    }
}
