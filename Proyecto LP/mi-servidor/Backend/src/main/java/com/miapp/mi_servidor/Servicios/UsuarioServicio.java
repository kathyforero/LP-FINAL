package com.miapp.mi_servidor.Servicios;

import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.miapp.mi_servidor.Clases.HashUtil;
import com.miapp.mi_servidor.Clases.Usuario;
import com.miapp.mi_servidor.Excepciones.UsuarioNoEncontradoException;

import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;
import java.util.List;

@Service
public class UsuarioServicio {


    public String crearUsuario(Usuario usuario) {
        try {
            Firestore db = FirestoreClient.getFirestore();
    
            // Verificar si el correo ya está registrado
            DocumentSnapshot doc = db.collection("usuarios").document(usuario.getCorreo()).get().get();
            if (doc.exists()) {
                return "El correo ya está registrado.";
            }
    
            // Guardar el usuario
            usuario.setContrasena(HashUtil.md5(usuario.getContrasena()));
            db.collection("usuarios").document(usuario.getCorreo()).set(usuario);
            return "Usuario creado exitosamente.";
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException("Error al interactuar con Firestore: " + e.getMessage(), e);
        }
    }
    

    // Buscar usuario por correo
    public Usuario buscarUsuarioPorCorreo(String correo) {
        try {
            Firestore db = FirestoreClient.getFirestore();
            DocumentSnapshot doc = db.collection("usuarios").document(correo).get().get();

            if (!doc.exists()) {
                throw new UsuarioNoEncontradoException("El usuario con correo " + correo + " no existe.");
            }

            return doc.toObject(Usuario.class);
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException("Error al interactuar con Firestore: " + e.getMessage(), e);
        }
    }


    // Autenticar usuario
    public boolean autenticarUsuario(String correo, String contrasena){
        Usuario usuario = buscarUsuarioPorCorreo(correo);
        if (usuario != null) {
            return usuario.getContrasena().equals(HashUtil.md5(contrasena));
        }
        return false;
    }

    public List<Usuario> obtenerTodosLosUsuarios() throws Exception {
        Firestore db = FirestoreClient.getFirestore();
    
        // Obtener todos los documentos de la colección "usuarios" y convertirlos en objetos Usuario
        List<Usuario> usuarios = db.collection("usuarios").get().get().toObjects(Usuario.class);
    
        return usuarios; // Devolver la lista de usuarios
    }
    
    public String eliminarUsuario(String correo) {
        try {
            Firestore db = FirestoreClient.getFirestore();
            DocumentSnapshot doc = db.collection("usuarios").document(correo).get().get();
    
            if (!doc.exists()) {
                throw new UsuarioNoEncontradoException("El usuario con correo " + correo + " no existe.");
            }
    
            db.collection("usuarios").document(correo).delete();
            return "Usuario eliminado exitosamente";
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException("Error al interactuar con Firestore: " + e.getMessage(), e);
        }
    }
    
}
