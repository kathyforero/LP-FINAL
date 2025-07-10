


# Resumen del Proyecto GuayacoCar

## Descripción General

GuayacoCar es una aplicación completa de marketplace para vehículos que permite a los usuarios navegar, listar y gestionar anuncios de automóviles en una plataforma en línea. [1](#0-0)  El sistema implementa una arquitectura moderna de full-stack con frontend Flutter, backend Spring Boot y servicios en la nube de Firebase.

## Funcionalidades Principales

- **Navegación y filtrado de vehículos**: Los usuarios pueden explorar listados disponibles con filtros avanzados por marca, modelo, tipo, rango de precio y kilometraje
- **Gestión de anuncios**: Creación y administración de listados propios de vehículos
- **Gestión de imágenes**: Subida y manejo de fotos de vehículos a través de Firebase Storage
- **Autenticación de usuarios**: Sistema de autenticación y mantenimiento de sesiones
- **Búsqueda y ordenamiento**: Capacidades de búsqueda y ordenamiento por diversos criterios

## Arquitectura Tecnológica

### Frontend
- **Flutter Framework**: Framework de UI multiplataforma
- **Lenguaje Dart**: Lenguaje de programación principal [2](#0-1) 
- **Material Design**: Biblioteca de componentes UI
- **Integración Firebase**: Autenticación y almacenamiento en la nube

### Backend
- **Spring Boot**: Framework backend basado en Java
- **Java 21**: Entorno de ejecución
- **Spring Web MVC**: Implementación de API REST [3](#0-2) 
- **Maven**: Gestión de construcción y dependencias

### Base de Datos y Almacenamiento
- **Firestore**: Base de datos NoSQL de documentos
- **Firebase Storage**: Almacenamiento en la nube para imágenes [4](#0-3) 
- **Firebase Authentication**: Servicio de autenticación de usuarios

## Compatibilidad Multiplataforma

La aplicación está configurada para despliegue multiplataforma a través del sistema de construcción de Flutter, incluyendo:
- Capacidad de despliegue web
- Soporte nativo para Windows [5](#0-4) 
- Compatibilidad con Android y Linux
- UI consistente en todas las plataformas usando Material Design

## Estructura del Proyecto

El proyecto sigue una arquitectura de capas bien definida:
- **Capa de Cliente**: Pantallas de Flutter (LoginScreen, MainScreen, CrearAutoScreen, etc.)
- **Capa de Servicio**: ApiServicio, FirebaseStorageService, gestión de estado de Usuario
- **Servicios Backend**: Controladores (AutoController, UsuarioController) y servicios de negocio
- **Capa de Datos**: Colecciones de Firestore, Firebase Storage y Firebase Authentication

## Notes

Este es un proyecto de práctica académica (LP-FINAL) que demuestra una implementación completa de una aplicación marketplace para automóviles utilizando tecnologías modernas de desarrollo web y móvil. La aplicación integra servicios de Firebase para almacenamiento y autenticación, con una API REST desarrollada en Spring Boot y una interfaz de usuario construida con Flutter para compatibilidad multiplataforma.
