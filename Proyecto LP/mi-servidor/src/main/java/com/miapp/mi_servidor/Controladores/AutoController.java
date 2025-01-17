package com.miapp.mi_servidor.Controladores;

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

import java.util.List;

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
    public String guardarAuto(@RequestBody Auto auto) {
        return autoServicio.guardarAuto(auto);
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
