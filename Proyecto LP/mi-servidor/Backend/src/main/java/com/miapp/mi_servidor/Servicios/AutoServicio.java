package com.miapp.mi_servidor.Servicios;

import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import com.miapp.mi_servidor.Clases.Auto;
import org.springframework.stereotype.Service;
import com.miapp.mi_servidor.Excepciones.AutoNoEncontradoException;
import com.google.cloud.firestore.Query;


import java.util.List;
import java.util.concurrent.ExecutionException;

import com.miapp.mi_servidor.Enums.*;

@Service
public class AutoServicio{
    // Guardar un auto, usando la placa como document ID
    public String guardarAuto(Auto auto) {
        Firestore db = FirestoreClient.getFirestore();
        db.collection("autos").document(auto.getPlaca()).set(auto);
        return "Auto guardado exitosamente";
    }

    private void convertirEnum(Auto auto, DocumentSnapshot doc){
        auto.setEstado(doc.getString("estado") != null ? Estado.valueOf(doc.getString("estado")) : null);
        auto.setMarca(doc.getString("marca") != null ? MarcaDeAuto.valueOf(doc.getString("marca")) : null);
        auto.setTipo(doc.getString("tipo") != null ? Tipo.valueOf(doc.getString("tipo")) : null);
        auto.setMotor(doc.getString("motor") != null ? Motor.valueOf(doc.getString("motor")) : null);
        auto.setTransmision(doc.getString("transmision") != null ? Transmision.valueOf(doc.getString("transmision")) : null);
        auto.setUbicacion(doc.getString("ubicacion") != null ? Ubicacion.valueOf(doc.getString("ubicacion")) : null);
    }    
    
    // Obtener un auto por su placa
    public Auto obtenerAuto(String placa) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot doc = db.collection("autos").document(placa).get().get();

        if (!doc.exists()) {
            System.out.println("Error al obtener auto: El auto con placa "+ placa + " no existe.");
            throw new AutoNoEncontradoException("El auto con placa " + placa + " no existe.");
        }

        Auto auto = doc.toObject(Auto.class);

        // Conversión manual de enums si es necesario
        convertirEnum(auto, doc);

        return auto;
    }

    // Obtener un auto por su placa
    public boolean obtenerAutoValidar(String placa) {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot doc;
        try {
            doc = db.collection("autos").document(placa).get().get();

            if (!doc.exists()) {
                return false;
            }

            Auto auto = doc.toObject(Auto.class);

            // Conversión manual de enums si es necesario
            convertirEnum(auto, doc);


        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ExecutionException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }   
        
        return true;
    }

    // Listar todos los autos
    public List<Auto> obtenerTodosLosAutos() throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        List<Auto> autos = db.collection("autos").get().get().toObjects(Auto.class);

        // Conversión manual de enums si es necesario
        for (Auto auto : autos) {
            DocumentSnapshot doc = db.collection("autos").document(auto.getPlaca()).get().get();
            convertirEnum(auto, doc);
        }

        return autos;
    }

    // Eliminar un auto por su placa
    public String eliminarAuto(String placa) {
    try {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot doc = db.collection("autos").document(placa).get().get();

        if (!doc.exists()) {
            System.out.println("Error al eliminar auto: El auto con placa "+ placa + " no existe.");
            throw new AutoNoEncontradoException("El auto con placa " + placa + " no existe.");
        }

        db.collection("autos").document(placa).delete();
        return "Auto eliminado exitosamente";
    } catch (InterruptedException | ExecutionException e) {
        // Lanza una excepción personalizada o maneja el error
        throw new RuntimeException("Error al interactuar con Firestore: " + e.getMessage(), e);
    }
}

    // Actualizar un auto existente
    public String actualizarAuto(Auto auto) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot doc = db.collection("autos").document(auto.getPlaca()).get().get();

        if (!doc.exists()) {
            throw new RuntimeException("El auto con placa " + auto.getPlaca() + " no existe.");
        }

        db.collection("autos").document(auto.getPlaca()).set(auto);
        return "Auto actualizado exitosamente";
    }

    public List<Auto> obtenerAutosPorUsuario(String correoUsuario) throws Exception {
        Firestore db = FirestoreClient.getFirestore();

        // Consulta donde 'usuario' sea igual al correo del usuario
        QuerySnapshot querySnapshot = db.collection("autos")
                                        .whereEqualTo("usuario", correoUsuario)
                                        .get()
                                        .get();

        List<Auto> autos = querySnapshot.toObjects(Auto.class);

        // Conversión manual de enums si es necesario
        for (Auto auto : autos) {
            DocumentSnapshot doc = db.collection("autos").document(auto.getPlaca()).get().get();
            convertirEnum(auto, doc);
        }

        return autos;
    }

    public List<Auto> obtenerAutosFiltrados(String marca, Integer kilometrajeMin, Integer kilometrajeMax, 
                                        Double precioMin, Double precioMax, String tipo) throws Exception {
    Firestore db = FirestoreClient.getFirestore();

    CollectionReference autosRef = db.collection("autos");
    Query query = autosRef;

    // Aplicar filtros dinámicamente
    if (marca != null && !marca.isEmpty()) {
        query = query.whereEqualTo("marca", marca);
    }
    if (kilometrajeMin != null) {
        query = query.whereGreaterThanOrEqualTo("kilometraje", kilometrajeMin);
    }
    if (kilometrajeMax != null) {
        query = query.whereLessThanOrEqualTo("kilometraje", kilometrajeMax);
    }
    if (precioMin != null) {
        query = query.whereGreaterThanOrEqualTo("precio", precioMin);
    }
    if (precioMax != null) {
        query = query.whereLessThanOrEqualTo("precio", precioMax);
    }
    if (tipo != null && !tipo.isEmpty()) {
        query = query.whereEqualTo("tipo", tipo);
    }

    // Ejecutar la consulta
    QuerySnapshot querySnapshot = query.get().get();
    return querySnapshot.toObjects(Auto.class);
}


}