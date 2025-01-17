package com.miapp.mi_servidor.Servicios;

import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import com.miapp.mi_servidor.Clases.Auto;
import org.springframework.stereotype.Service;
import java.util.List;

public class AutoServicio{
    public String guardarAuto(Auto auto) {
        Firestore db = FirestoreClient.getFirestore();
        db.collection("autos").document(auto.getPlaca()).set(auto);
        return "Auto guardado exitosamente";
    }

    public Auto obtenerAuto(String placa) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot doc = db.collection("autos").document(placa).get().get();

        if (!doc.exists()) {
            throw new RuntimeException("El auto con placa " + placa + " no existe.");
        }

        return doc.toObject(Auto.class);
    }


    public String eliminarAuto(String placa) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot doc = db.collection("autos").document(placa).get().get();

        if (!doc.exists()) {
            throw new RuntimeException("El auto con placa " + placa + " no existe.");
        }

        db.collection("autos").document(placa).delete();
        return "Auto eliminado exitosamente";
    }

}