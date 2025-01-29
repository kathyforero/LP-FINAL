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

    @GetMapping("/{placa}")
    public Auto obtenerAuto(@PathVariable String placa) throws Exception {
        return autoServicio.obtenerAuto(placa);
    }

    @GetMapping("/usuario/{user}")
    public List<Auto> AutosPorUsuario(@PathVariable String user) throws Exception {
        return autoServicio.obtenerAutosPorUsuario(user);
    }

    @PostMapping
    public ResponseEntity<Map<String, Object>> guardarAuto(@Valid @RequestBody Auto auto, BindingResult bindingResult) throws Exception {
        System.out.println(auto);
        // Validar si el auto ya existe
        if (autoServicio.obtenerAutoValidar(auto.getPlaca())) {
            return ResponseEntity.badRequest().body(Map.of(
                "status", "error",
                "message", "El auto ya existe!"
            ));
        }

        // Validar errores en los campos enviados
        if (bindingResult.hasErrors()) {
            bindingResult.getFieldErrors().forEach(error -> {
                System.out.println("Error en el campo: " + error.getField() + " - " + error.getDefaultMessage());
            });
            return ResponseEntity.badRequest().body(Map.of(
                "status", "error",
                "message", "Errores en los datos enviados",
                "errors", bindingResult.getFieldErrors()
            ));
        }
        

        // Validar que las URLs de fotos sean válidas
        if (auto.getFotos() == null || auto.getFotos().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of(
                "status", "error",
                "message", "Se requieren al menos una URL en 'fotos'."
            ));
        }

        for (String url : auto.getFotos()) {
            if (!url.startsWith("https://firebasestorage.googleapis.com/")) {
                return ResponseEntity.badRequest().body(Map.of(
                    "status", "error",
                    "message", "Una o más URLs de las fotos no son válidas."
                ));
            }
        }

        // Guardar el auto en la base de datos
        String mensajeExitoso = autoServicio.guardarAuto(auto);
        return ResponseEntity.ok(Map.of(
            "status", "success",
            "message", mensajeExitoso,
            "auto", auto
        ));
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

