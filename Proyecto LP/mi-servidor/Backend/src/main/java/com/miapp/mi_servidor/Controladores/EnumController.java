package com.miapp.mi_servidor.Controladores;

import java.util.Arrays;
import java.util.stream.Collectors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import com.miapp.mi_servidor.Enums.*;


@RestController
@RequestMapping("/api/enums")
public class EnumController {

    @GetMapping("/estados")
    public List<String> obtenerEstados() {
        return Arrays.stream(Estado.values())
                     .map(Estado::getDisplayName)
                     .collect(Collectors.toList());
    }

    @GetMapping("/tipos")
    public List<String> obtenerTipos() {
        return Arrays.stream(Tipo.values())
                     .map(Tipo::getDisplayName)
                     .collect(Collectors.toList());
    }

    @GetMapping("/motor")
    public List<String> obtenerMotor() {
        return Arrays.stream(Motor.values())
                     .map(Motor::getDisplayName)
                     .collect(Collectors.toList());
    }

    @GetMapping("/marcas")
    public List<String> obtenerMarcas() {
        return Arrays.stream(MarcaDeAuto.values())
                     .map(MarcaDeAuto::getName)
                     .collect(Collectors.toList());
    }

    @GetMapping("/transmision")
    public List<String> obtenerTransmision() {
        return Arrays.stream(Transmision.values())
                     .map(Transmision::getDisplayName)
                     .collect(Collectors.toList());
    }

    @GetMapping("/ubicacion")
    public List<String> obtenerUbicacion() {
        return Arrays.stream(Ubicacion.values())
                     .map(Ubicacion::getDisplayName)
                     .collect(Collectors.toList());
    }

    public boolean esMarcaValida(String marca) {
        return Arrays.stream(MarcaDeAuto.values())
                     .map(MarcaDeAuto::name)
                     .anyMatch(marca.toUpperCase()::equals);
    }
    
    @GetMapping("/modelos/{marca}")
    public List<String> obtenerModelos(@PathVariable String marca) {
        try {
            MarcaDeAuto marcaEnum = MarcaDeAuto.valueOf(marca.toUpperCase());
            return marcaEnum.getModels();
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Marca no válida: " + marca);
        }
    }


}
