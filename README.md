# **BeTrend - Predicción del éxito musical**

**Tema:** Aplicación para la predicción del éxito de canciones a partir de características musicales y tendencias del mercado actual.

---

## Descripción

El presente trabajo aborda el desarrollo de una aplicación para la predicción del éxito de canciones a partir de características musicales y tendencias actuales del mercado. El objetivo principal es ofrecer una herramienta tecnológica que permita estimar el nivel de aceptación de una canción antes de su lanzamiento, apoyando a los artistas en la toma de decisiones estratégicas y fortaleciendo su independencia respecto a las discográficas. 

La metodología integró análisis exploratorio de datos sobre un dataset de Kaggle con características musicales extraídas de la API de Spotify, el desarrollo de un algoritmo estadístico propuesto basado en intervalos de confianza al 98%, y la implementación de modelos de aprendizaje automático (ElasticNet y K-Nearest Neighbors) como punto de referencia comparativo. Los resultados demostraron que el algoritmo estadístico propuesto, que combina estadística básica con análisis e intervención humana, alcanzó un error promedio de 2.4% frente al 26.3% de ElasticNet en diez pruebas realizadas, evidenciando su superioridad para este problema específico. 

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

El algoritmo calcula intervalos de confianza al 98% para cada característica usando el dataset de entrenamiento `AlgPropio.csv`:
```
IC₉₈% = X̄ᵢ ± 2.33 × (sᵢ / √n)
```

**Proceso:**
1. Calcula intervalos de confianza basados en las canciones del dataset de entrenamiento (`AlgPropio.csv`).
2. Compara cada característica de la canción del usuario contra estos rangos estadísticos.
3. Asigna +1 punto por cada característica dentro del rango establecido.
4. Porcentaje = (Puntos / 13) × 100%

**Ventaja del enfoque:** Al usar intervalos de confianza calculados a partir de canciones con viralidad conocida, el algoritmo captura los patrones reales del mercado musical sin necesidad de entrenar modelos ML complejos.

---

## Navegación Rápida

| Carpeta | Contenido | Archivos Clave |
|---------|-----------|----------------|
| **Datasets/** | Datos para análisis y entrenamiento | `song_data.csv` (19k+ canciones virales), `AlgPropio.csv` (training) |
| **SQL Scripts/** | Scripts de base de datos | `tablas_tesis1.sql` (esquema completo) |
| **FrontEnd - BackEnd/** | Código fuente de la aplicación | `Usuario.java` **[CORE]** (algoritmo), `music2.dart` (resultados) |
| **Machine Learning/** | Análisis y modelos ML | `Tesis.ipynb` (análisis completo y comparaciones) |

---

## Archivos Importantes del Proyecto

### Datasets/
- **`AlgPropio.csv`** - Dataset de entrenamiento utilizado por el algoritmo estadístico propuesto. Contiene canciones seleccionadas con sus 13 características musicales y su nivel de viralidad. Este dataset es la base para calcular los intervalos de confianza al 98% que luego se usan para evaluar nuevas canciones.
- **`song_data.csv`** - Dataset principal con 19,400+ canciones virales y sus 13 características musicales extraídas de la API de Spotify. Utilizado para el análisis exploratorio de datos (EDA) y entrenamiento de los modelos de Machine Learning (ElasticNet y KNN) que sirven como punto de comparación.

### SQL Scripts/
- **`tablas_tesis1.sql`** - Script completo de creación del esquema `tesis1`, tablas (`usuarios`, `top_canciones`, `usuario_canciones`) e inserción de datos iniciales. Incluye la carga del dataset de entrenamiento `AlgPropio.csv` como canciones de referencia para los cálculos del algoritmo estadístico.

### FrontEnd - BackEnd/BackEndTesis/ (Java + Spring Boot)
- **`Usuario.java`** - **[ARCHIVO PRINCIPAL]** Contiene la implementación del algoritmo estadístico propio. Incluye el método `compararCaracteristicas()` que:
  - Calcula intervalos de confianza al 98% para cada característica musical.
  - Compara las características de la canción del usuario contra los rangos de canciones virales.
  - Retorna el porcentaje de tendencia (0-100%).
- **`ServicioRestApplication.java`** - Controlador REST que expone los endpoints de la API (`/signIn`, `/signUp`, `/music1`, `/profile`).
- **`DatabaseConnector.java`** - Gestiona la conexión con la base de datos MySQL.
- **`UsuarioCancion.java`** - Modelo de datos que representa una canción con sus 13 características musicales (duración, tempo, energía, bailabilidad, acústica, instrumentalidad, valencia, volumen, vivacidad, modo, tonalidad, compás, cantidad de palabras).
- **`DemoApplication.java`** - Punto de entrada principal de la aplicación Spring Boot.

### FrontEnd - BackEnd/FrontEndTesis/ (Flutter + Dart)
- **`main.dart`** - Punto de entrada de la aplicación Flutter, configura el Provider y define las rutas.
- **`inicio.dart`** - Splash screen inicial que se muestra durante 3 segundos antes de redirigir al login.
- **`signin.dart`** - Pantalla de inicio de sesión con validación de credenciales.
- **`signup.dart`** - Pantalla de registro de nuevos usuarios.
- **`menu.dart`** - Menú principal de la aplicación con navegación a las diferentes secciones.
- **`music1.dart`** - Pantalla para buscar/ingresar el nombre de la canción y sus 13 características musicales.
- **`music2.dart`** - **[PANTALLA CLAVE]** Pantalla que muestra los resultados de la predicción con:
  - Porcentaje de tendencia calculado por el algoritmo estadístico
  - Desglose visual de cada característica (dentro/fuera del rango)
  - Gráfico circular del porcentaje de éxito
- **`profile.dart`** - Pantalla de perfil del usuario con historial de canciones analizadas y sus porcentajes.
- **`logout.dart`** - Pantalla de cierre de sesión con confirmación.
- **`union.dart`** - Archivo de servicios que maneja todas las peticiones HTTP al backend (signIn, signUp, music1, profile).
- **`usuario_provider.dart`** - Gestión de estado global usando Provider (almacena userId y nombre de canción actual).

### Machine Learning/
- **`Tesis.ipynb`** - Jupyter Notebook con:
  - Análisis exploratorio de datos (EDA) del dataset `song_data.csv` (19k+ canciones virales)
  - Creación y análisis del dataset de entrenamiento `AlgPropio.csv` para el algoritmo estadístico
  - Implementación de modelos de Machine Learning: ElasticNet y K-Nearest Neighbors (KNN)
  - Optimización de hiperparámetros usando GridSearchCV
  - Comparación de resultados: ElasticNet y KNN.
  - Pruebas de validación cruzada comparando el algoritmo estadístico propuesto vs modelos ML
  - Visualizaciones y métricas de error (MAE, RMSE)

---

## Instalación

### Prerrequisitos
```bash
# Instalar dependencias
- Java JDK 17+
- MySQL 9.4+
- Flutter SDK 3.0+
- Maven 3.6+
- Python 3.8+ (opcional, solo para ejecutar el Jupyter Notebook)
```

### 1. Base de Datos
```sql
# Navegar a la carpeta SQL Scripts/
cd "SQL Scripts"

# Ejecutar el script en MySQL
mysql -u root -p
CREATE SCHEMA tesis1;
USE tesis1;
SOURCE tablas_tesis1.sql;
```

### 2. Backend
```bash
# Navegar a la carpeta del backend
cd "FrontEnd - BackEnd/BackEndTesis"

# Compilar y ejecutar con Maven
mvn clean install
mvn spring-boot:run

# Servidor disponible en http://localhost:8080
```

### 3. Frontend
```bash
# Navegar a la carpeta del frontend
cd "FrontEnd - BackEnd/FrontEndTesis"

# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run

# O para compilar:
flutter build apk        # Android
flutter build ios        # iOS
```

### 4. Análisis de Datos (Opcional)
```bash
# Navegar a la carpeta Machine Learning/
cd "Machine Learning"

# Instalar dependencias de Python
pip install jupyter pandas numpy scikit-learn matplotlib seaborn

# Abrir el notebook
jupyter notebook Tesis.ipynb
```

---

## Estructura del Proyecto
```
BeTrend/
├── Datasets/                    # Datos utilizados en el análisis
│   ├── AlgPropio.csv           # Dataset para validación del algoritmo propio
│   └── song_data.csv           # Dataset principal con características musicales de Spotify
│
├── FrontEnd - BackEnd/          # Código fuente de la aplicación
│   ├── BackEndTesis/           # API REST en Java + Spring Boot
│   │   ├── Usuario.java        # ⭐ Implementación del algoritmo estadístico
│   │   ├── ServicioRestApplication.java  # Controladores REST
│   │   ├── DatabaseConnector.java        # Conexión a MySQL
│   │   ├── UsuarioCancion.java          # Modelo de datos
│   │   └── DemoApplication.java         # Punto de entrada
│   │
│   └── FrontEndTesis/          # Aplicación móvil en Flutter
│       ├── main.dart           # Punto de entrada de la app
│       ├── inicio.dart         # Splash screen
│       ├── signin.dart         # Pantalla de inicio de sesión
│       ├── signup.dart         # Pantalla de registro
│       ├── menu.dart           # Menú principal
│       ├── music1.dart         # Búsqueda de canciones
│       ├── music2.dart         # Resultados de predicción
│       ├── profile.dart        # Perfil del usuario
│       ├── logout.dart         # Cierre de sesión
│       ├── union.dart          # Servicios HTTP al backend
│       └── usuario_provider.dart  # Gestión de estado global
│
├── Machine Learning/            # Análisis y modelos ML
│   └── Tesis.ipynb             # Jupyter Notebook con análisis exploratorio,
│                                # implementación de ElasticNet y KNN,
│                                # y comparación de resultados
│
├── SQL Scripts/                 # Scripts de base de datos
│   └── tablas_tesis1.sql       # Creación del esquema, tablas e inserción
│                                # de datos iniciales (usuarios, canciones virales)
│
└── README.md                    # Este archivo
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
