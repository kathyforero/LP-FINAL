package com.miapp.mi_servidor.Excepciones;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ControllerAdvice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ControllerAdvice(basePackages = "com.miapp.mi_servidor.Controladores")
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, Object>> handleValidationExceptions(MethodArgumentNotValidException ex) {
        // Obtener todos los errores de campo
        List<FieldError> fieldErrors = ex.getBindingResult().getFieldErrors();
        Map<String, Object> response = new HashMap<>();
        
        // Crear una lista para almacenar los mensajes de error
        StringBuilder errorMessages = new StringBuilder();
        
        // Recorrer todos los errores y agregar sus mensajes
        for (FieldError fieldError : fieldErrors) {
            errorMessages.append("Campo: ")
                          .append(fieldError.getField())
                          .append(" - ")
                          .append(fieldError.getDefaultMessage()) // Obtiene el mensaje de la validación
                          .append("\n");
        }
        
        // Agregar el resultado al cuerpo de la respuesta
        response.put("status", "error");
        response.put("message", "Hay errores en los datos proporcionados");
        response.put("errors", errorMessages.toString());

        // Devolver la respuesta con el código de estado 400 (Bad Request)
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<Map<String, Object>> manejarErroresDeFormato(HttpMessageNotReadableException ex) {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "error");
        response.put("message", "El formato de los datos es inválido. Verifica que los campos sean correctos.");
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    }
}
