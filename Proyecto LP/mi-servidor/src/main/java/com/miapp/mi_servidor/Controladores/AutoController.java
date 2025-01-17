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
import com.miapp.mi_servidor.Servicios.AutoServicio;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.validation.Valid;

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

    @PostMapping
    public ResponseEntity<Map<String, Object>> guardarAuto(@Valid @RequestBody Auto auto, BindingResult bindingResult) throws Exception {
        
        if(autoServicio.obtenerAuto(auto.getPlaca())!=null){
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
    public String actualizarAuto(@RequestBody Auto auto) throws Exception {
        return autoServicio.actualizarAuto(auto);
    }

    @DeleteMapping("/{placa}")
    public String eliminarAuto(@PathVariable String placa) throws Exception {
        return autoServicio.eliminarAuto(placa);
    }
}
