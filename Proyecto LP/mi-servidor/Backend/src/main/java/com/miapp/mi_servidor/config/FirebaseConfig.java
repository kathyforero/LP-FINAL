package com.miapp.mi_servidor.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import java.io.InputStream;

@Configuration
public class FirebaseConfig {

    @PostConstruct
    public void initialize() {
        try {
            // Obtiene las credenciales desde una variable de entorno
             

            //String firebaseConfig = System.getenv("GOOGLE_APPLICATION_CREDENTIALS_JSON");

            //if (firebaseConfig == null || firebaseConfig.isEmpty()) {
            //    throw new IllegalStateException("La variable de entorno GOOGLE_APPLICATION_CREDENTIALS_JSON no está configurada.");
            //}

            // Carga las credenciales desde la variable de entorno
            //ByteArrayInputStream serviceAccount = new ByteArrayInputStream(firebaseConfig.getBytes());

            InputStream serviceAccount = getClass().getClassLoader().getResourceAsStream("firebase/serviceAccountKey.json");
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl("https://<tu-database>.firebaseio.com")
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
}
