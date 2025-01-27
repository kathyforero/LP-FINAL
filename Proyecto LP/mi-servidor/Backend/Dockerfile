# Usa la versión de Java 21
FROM eclipse-temurin:21-jdk  

# Copia el archivo JAR generado
COPY target/mi-servidor-0.0.1-SNAPSHOT.jar app.jar  

# Comando para ejecutar tu aplicación
ENTRYPOINT ["java", "-jar", "app.jar"] 
