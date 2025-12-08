# **BeTrend - Predicción del éxito musical**

**Tema:** Aplicación para la predicción del éxito de canciones a partir de características musicales y tendencias del mercado actual.

---

## Descripción

El presente trabajo aborda el desarrollo de una aplicación para la predicción del éxito de canciones a partir de características musicales y tendencias actuales del mercado. El objetivo principal es ofrecer una herramienta tecnológica que permita estimar el nivel de aceptación de una canción antes de su lanzamiento, apoyando a los artistas en la toma de decisiones estratégicas y fortaleciendo su independencia respecto a las discográficas. 

La metodología integró análisis exploratorio de datos sobre un dataset de Kaggle con características musicales extraídas de la API de Spotify, el desarrollo de un algoritmo estadístico propio basado en intervalos de confianza al 98%, y la implementación de modelos de aprendizaje automático (ElasticNet y K-Nearest Neighbors) como punto de referencia comparativo. Los resultados demostraron que el algoritmo estadístico propio, que combina estadística básica con análisis e intervención humana, alcanzó un error promedio de 2.4% frente al 26.3% de ElasticNet en diez pruebas realizadas, evidenciando su superioridad para este problema específico. 

Con base en estos hallazgos, se desarrolló una aplicación móvil multiplataforma utilizando Flutter para el front end y Java con Spring Boot para el back end, integrando el algoritmo estadístico como motor predictivo. El proyecto demuestra que, en ciertos contextos, los enfoques estadísticos diseñados con conocimiento del dominio pueden superar a los modelos de aprendizaje automático puro, ofreciendo a los artistas ecuatorianos una alternativa accesible para evaluar el potencial comercial de sus composiciones sin depender de intermediarios tradicionales.

**Proyecto de Titulación - Ingeniería en Ciencias de la Computación, Universidad San Francisco de Quito (USFQ)**

---

## Objetivos

- Evaluar el potencial de éxito de canciones usando características musicales.
- Ofrecer autonomía a artistas frente a discográficas tradicionales.
- Comparar modelos estadísticos vs modelos de aprendizaje automático.
- Proporcionar retroalimentación detallada sobre atributos musicales.

---

## Tecnologías

**Frontend**
- Flutter (Dart)
- Provider (gestión de estado)

**Backend**
- Java + Spring Boot
- MySQL 9.4

**Análisis de Datos**
- Python (Pandas, NumPy, Scikit-learn)
- Jupyter Notebook

---

## Características Evaluadas

El sistema analiza 13 atributos musicales:
- Duración, tempo, energía, bailabilidad
- Acústica, instrumentalidad, valencia
- Volumen, vivacidad, modo musical
- Tonalidad, compás, cantidad de palabras

---

## Algoritmo Estadístico

El algoritmo calcula intervalos de confianza al 98% para cada característica:
```
IC₉₈% = X̄ᵢ ± 2.33 × (sᵢ / √n)
```

**Proceso:**
1. Calcula intervalos basados en canciones virales del dataset
2. Compara cada característica de la canción del usuario
3. Asigna +1 punto por cada característica dentro del rango
4. Porcentaje = (Puntos / 13) × 100%

---

## Archivos Importantes del Proyecto

### Base de Datos
- **`Tablas_tesis1.sql`** - Script completo de creación del esquema, tablas (`usuarios`, `top_canciones`, `usuario_canciones`) e inserción de datos iniciales. Incluye los 10 ejemplos de prueba del notebook y la carga del dataset de canciones virales.

### Backend (Java + Spring Boot)
- **`DemoApplication.java`** - Punto de entrada principal de la aplicación Spring Boot.
- **`ServicioRestApplication.java`** - Controlador REST que expone los endpoints de la API (`/signIn`, `/signUp`, `/music1`, `/profile`).
- **`DatabaseConnector.java`** - Gestiona la conexión con la base de datos MySQL.
- **`Usuario.java`** - **Archivo principal** que contiene la implementación del algoritmo estadístico propio. Incluye el método `compararCaracteristicas()` que calcula intervalos de confianza, compara las características musicales de la canción del usuario contra los rangos establecidos por canciones virales, y retorna el porcentaje de tendencia.
- **`UsuarioCancion.java`** - Modelo de datos que representa una canción con sus 13 características musicales.

### Frontend (Flutter + Dart)
- **`inicio.dart`** - Splash screen inicial que se muestra durante 3 segundos.
- **`signin.dart`** - Pantalla de inicio de sesión.
- **`signup.dart`** - Pantalla de registro de nuevos usuarios.
- **`menu.dart`** - Menú principal de la aplicación.
- **`music1.dart`** - Pantalla para buscar/ingresar el nombre de la canción.
- **`music2.dart`** - Pantalla que muestra los resultados de la predicción con el porcentaje de tendencia y las características detalladas.
- **`profile.dart`** - Pantalla de perfil del usuario con sus canciones y porcentajes.
- **`logout.dart`** - Pantalla de cierre de sesión.
- **`union.dart`** - Archivo de servicios que maneja todas las peticiones HTTP al backend.
- **`usuario_provider.dart`** - Gestión de estado global usando Provider (almacena userId y nombre de canción).

### Análisis de Datos
- **`Tesis.ipynb`** - Jupyter Notebook con el análisis exploratorio de datos, implementación de modelos ML (ElasticNet, KNN), optimización de hiperparámetros, y comparación de resultados.

---

## Instalación

### Prerrequisitos
```bash
# Instalar dependencias
- Java JDK 17+
- MySQL 9.4+
- Flutter SDK 3.0+
- Maven 3.6+
```

### 1. Base de Datos
```sql
CREATE SCHEMA tesis1;
USE tesis1;
SOURCE Tablas_tesis1.sql;
```

### 2. Backend
```bash
cd backend
mvn spring-boot:run
# Servidor en http://localhost:8080
```

### 3. Frontend
```bash
cd frontend
flutter pub get
flutter run
```

---

## Estructura del Proyecto
```
BeTrend/
├── backend/           # Java + Spring Boot
│   ├── Usuario.java   # Lógica del algoritmo estadístico
│   ├── ServicioRestApplication.java
│   ├── DatabaseConnector.java
│   ├── UsuarioCancion.java
│   └── DemoApplication.java
├── frontend/          # Flutter + Dart
│   ├── main.dart
│   ├── inicio.dart
│   ├── signin.dart
│   ├── signup.dart
│   ├── menu.dart
│   ├── music1.dart
│   ├── music2.dart
│   ├── profile.dart
│   ├── logout.dart
│   ├── union.dart
│   └── usuario_provider.dart
├── notebooks/
│   └── Tesis.ipynb    # Análisis de datos y ML
└── database/
    └── Tablas_tesis1.sql
```

---

## API Endpoints

- `POST /signIn` - Autenticación
- `POST /signUp` - Registro
- `GET /music1` - Predicción musical
- `GET /profile` - Perfil de usuario

---

## Resultados

| Métrica | Algoritmo Estadístico | ElasticNet |
|---------|----------------------|------------|
| Error promedio | **2.4%** | 26.3% |
| Error máximo | **6%** | 37% |

El algoritmo estadístico superó significativamente a los modelos de ML evaluados.

---

## Autora

**Anahí Micaela Andrade Sánchez**  
Ingeniería en Ciencias de la Computación - USFQ

**Director de Tesis:** José David Vega Sánchez, PhD

---

## Referencias

1. Kim, J. (2021). "Music Popularity Prediction Through Data Analysis"
2. Jung & Mayer (2024). "Beyond Beats: A Recipe to Song Popularity?"
3. Sardana, V. (2024). "Machine Learning Models for Song Popularity"
4. Jiang, S. (2025). "Predicting Music Popularity Using Spotify Data"

---

## Licencia

Proyecto académico - Universidad San Francisco de Quito (USFQ)  
Los derechos de propiedad intelectual están sujetos a las políticas de la USFQ.

---

**Versión:** 1.0.0  
**Fecha:** Diciembre 2025
