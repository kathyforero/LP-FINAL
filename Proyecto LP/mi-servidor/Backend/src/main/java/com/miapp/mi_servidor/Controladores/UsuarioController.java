package com.miapp.mi_servidor.Controladores;

import com.miapp.mi_servidor.Clases.Usuario;
import com.miapp.mi_servidor.Servicios.UsuarioServicio;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    private final UsuarioServicio usuarioServicio;

    public UsuarioController(UsuarioServicio usuarioServicio) {
        this.usuarioServicio = usuarioServicio;
    }

    // Crear un nuevo usuario
    @PostMapping
    public ResponseEntity<String> crearUsuario(@RequestBody Usuario usuario) {
        String mensaje = usuarioServicio.crearUsuario(usuario);
        return ResponseEntity.ok(mensaje);
    }

    // Obtener un usuario por ID
    @GetMapping("/{correo}")
    public ResponseEntity<Usuario> obtenerUsuarioPorId(@PathVariable String id) {
        Usuario usuario = usuarioServicio.buscarUsuarioPorCorreo(id);
        if (usuario != null) {
            return ResponseEntity.ok(usuario);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Autenticar un usuario
    @PostMapping("/autenticar")
    public ResponseEntity<String> autenticarUsuario(@RequestParam String correo, @RequestParam String contrasena) {
        boolean autenticado = usuarioServicio.autenticarUsuario(correo, contrasena);
        if (autenticado) {
            return ResponseEntity.ok("Usuario autenticado exitosamente.");
        } else {
            return ResponseEntity.status(401).body("Credenciales incorrectas.");
        }
    }

    // Obtener todos los usuarios (opcional)
    @GetMapping
    public List<Usuario> obtenerTodosLosUsuarios() throws Exception {
        return usuarioServicio.obtenerTodosLosUsuarios();
    }

    
}

