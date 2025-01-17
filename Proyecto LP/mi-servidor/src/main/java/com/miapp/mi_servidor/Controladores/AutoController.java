package com.miapp.mi_servidor.Controladores;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class AutoController {

    @GetMapping("/autos")
    public List<String> obtenerAutos() {
        return List.of("Auto 1", "Auto 2", "Auto 3");
    }


}
