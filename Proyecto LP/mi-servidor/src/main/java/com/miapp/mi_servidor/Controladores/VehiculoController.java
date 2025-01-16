package com.miapp.mi_servidor.Controladores;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class VehiculoController {

    @GetMapping("/vehiculos")
    public List<String> obtenerVehiculos() {
        return List.of("Auto 1", "Auto 2", "Auto 3");
    }
}
