package com.miapp.mi_servidor.Controladores;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.miapp.mi_servidor.Clases.Auto;
import com.miapp.mi_servidor.Excepciones.AutoNoEncontradoException;
import com.miapp.mi_servidor.Servicios.AutoServicio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;

@RestController
@RequestMapping("/api/autos")
public class AutoController {

    private final AutoServicio autoServicio;

    public AutoController(AutoServicio autoServicio) {
        this.autoServicio = autoServicio;
    }

    @GetMapping
    public List<Auto> obtenerTodosLosAutos() throws Exception {
        return autoServicio.obtenerTodosLosAutos();
    }

    @GetMapping("/usuario/{correo}")
    public ResponseEntity<List<Auto>> obtenerAutosPorUsuario(@PathVariable String correo) {
        try {
            List<Auto> autos = autoServicio.obtenerAutosPorUsuario(correo);
            return ResponseEntity.ok(autos);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }


    @GetMapping("/{placa}")
    public Auto obtenerAuto(@PathVariable String placa) throws Exception {
        return autoServicio.obtenerAuto(placa);
    }

    @PostMapping
    public ResponseEntity<Map<String, Object>> guardarAuto(@Valid @RequestBody Auto auto, BindingResult bindingResult) throws Exception {
        
        if(autoServicio.obtenerAutoValidar(auto.getPlaca())==true){
            return ResponseEntity.badRequest().body(Map.of(
                "status", "error",
                "message", "Errores en los datos enviados",
                "errors", "El auto ya existe!!"
            ));
        }
        
        if (bindingResult.hasErrors()) {
            // Construir el mapa de errores
            Map<String, Object> errores = new HashMap<>();
            bindingResult.getFieldErrors().forEach(error -> 
                errores.put(error.getField(), error.getDefaultMessage())
            );

            // Retornar una respuesta con los errores y un estado 400 (Bad Request)
            return ResponseEntity.badRequest().body(Map.of(
                "status", "error",
                "message", "Errores en los datos enviados",
                "errors", errores
            ));
        }

        // Si no hay errores, continuar con la lógica normal
        String mensajeExitoso = autoServicio.guardarAuto(auto);
        Map<String, Object> response = new HashMap<>();
        response.put("mensaje", mensajeExitoso);
        response.put("auto", auto);

        return ResponseEntity.ok(response);
    }

    @PutMapping
    public ResponseEntity<Map<String, Object>> actualizarAuto(@Valid @RequestBody Auto auto, BindingResult bindingResult) throws Exception {
        try {
            // Validación de existencia del auto
            if (autoServicio.obtenerAutoValidar(auto.getPlaca()) == false) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                    "status", "error",
                    "message", "Error al actualizar el auto",
                    "errors", "El auto con la placa proporcionada no existe"
                ));
            }

            if (bindingResult.hasErrors()) {
                Map<String, Object> errores = new HashMap<>();
                bindingResult.getFieldErrors().forEach(error -> 
                    errores.put(error.getField(), error.getDefaultMessage())
                );

                return ResponseEntity.badRequest().body(Map.of(
                    "status", "error",
                    "message", "Errores en los datos enviados",
                    "errors", errores
                ));
            }

            String mensajeExitoso = autoServicio.actualizarAuto(auto);
            Map<String, Object> response = new HashMap<>();
            response.put("mensaje", mensajeExitoso);
            response.put("auto", auto);

            return ResponseEntity.ok(response);
        } catch (AutoNoEncontradoException e) {
            // Capturar la excepción personalizada y devolver 404
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "status", "error",
                "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "status", "error",
                "message", "Error interno del servidor",
                "errors", e.getMessage()
            ));
        }
    }

    @DeleteMapping("/{placa}")
    public ResponseEntity<Map<String, Object>> eliminarAuto(@PathVariable String placa) throws Exception {
        try {
            // Validación de existencia del auto
            if (autoServicio.obtenerAutoValidar(placa) == false) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                    "status", "error",
                    "message", "Error al eliminar el auto",
                    "errors", "El auto con la placa proporcionada no existe"
                ));
            }
    
            // Eliminar el auto
            String mensajeExitoso = autoServicio.eliminarAuto(placa);
            Map<String, Object> response = new HashMap<>();
            response.put("mensaje", mensajeExitoso);
            response.put("auto", placa);
    
            return ResponseEntity.ok(response);
    
        } catch (Exception e) {
            // Captura cualquier error y devuelve un mensaje adecuado
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "status", "error",
                "message", "Error interno del servidor",
                "errors", e.getMessage()
            ));
        }
    }
}

