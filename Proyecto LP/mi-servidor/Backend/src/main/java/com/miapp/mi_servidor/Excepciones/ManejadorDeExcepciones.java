package com.miapp.mi_servidor.Excepciones;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/*@ControllerAdvice
public class ManejadorDeExcepciones {

    @ExceptionHandler(AutoNoEncontradoException.class)
    public ResponseEntity<Map<String, Object>> manejarAutoNoEncontrado(AutoNoEncontradoException ex) {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "error");
        response.put("message", ex.getMessage());
        
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }
}
*/