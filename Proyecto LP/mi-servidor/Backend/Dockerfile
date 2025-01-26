# Usa la versión de Java 21
FROM eclipse-temurin:21-jdk  

# Copia el archivo JAR generado
COPY target/mi-servidor.jar app.jar  

# Comando para ejecutar tu aplicación
ENTRYPOINT ["java", "-jar", "app.jar"] 
