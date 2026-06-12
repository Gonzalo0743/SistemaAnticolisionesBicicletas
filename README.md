# Smart Bike Safety System

Sistema inteligente anti-colisiones para bicicletas con detección ultrasónica, retroalimentación visual/auditiva e interfaz gráfica en tiempo real.

**Integrantes:**
- Esteban Castillo Vega — 2021040626
- Sofía Quesada Morera — 2021062248
- Gonzalo Acuña Madrigal — 2020113084
- Lucía Navarro Bloise — 2022157955

---

## Descripción general

El sistema detecta la distancia entre la bicicleta y objetos cercanos mediante un sensor ultrasónico HC-SR04. El microcontrolador Arduino procesa esa distancia y determina uno de tres estados de riesgo: **SAFE**, **WARNING** o **DANGER**. Según el estado, se activan un LED RGB y un buzzer como actuadores físicos, mientras que una interfaz desarrollada en Processing visualiza el estado y la distancia en tiempo real vía comunicación serial.

---

## Estructura del repositorio

```
/
├── LEDYSENSOR_buzzer_activo.ino   # Código Arduino: sensor, LED RGB y buzzer
├── GUI_ledysensor.pde             # Interfaz gráfica en Processing
└── README.md
```

---

## Requisitos de hardware

| Componente | Cantidad |
|---|---|
| Arduino Uno (o compatible) | 1 |
| Sensor ultrasónico HC-SR04 | 1 |
| LED RGB (cátodo común) | 1 |
| Buzzer activo | 1 |
| Resistencias 220Ω | 3 |
| Protoboard + cables dupont | — |

### Conexiones de pines

| Componente | Pin Arduino |
|---|---|
| HC-SR04 TRIG | D9 |
| HC-SR04 ECHO | D10 |
| LED Rojo | D2 |
| LED Verde | D3 |
| LED Azul | D4 |
| Buzzer (+) | D5 |
| Buzzer (–) | GND |

---

## Requisitos de software

- [Arduino IDE](https://www.arduino.cc/en/software) 1.8+ o 2.x
- [Processing](https://processing.org/download) 4.x
- Librería `processing.serial` (incluida por defecto en Processing)

---

## Instalación y montaje

### 1. Clonar el repositorio

```bash
git clone https://github.com/<usuario>/<repositorio>.git
cd <repositorio>
```

### 2. Cargar el sketch en Arduino

1. Abrir `LEDYSENSOR_buzzer_activo.ino` en Arduino IDE.
2. Seleccionar la placa: **Tools → Board → Arduino Uno**.
3. Seleccionar el puerto correcto: **Tools → Port → COMx** (Windows) o `/dev/ttyUSBx` / `/dev/cu.usbmodemXXXX` (Linux/macOS).
4. Hacer clic en **Upload** (→).

### 3. Configurar el puerto serial en Processing

Abrir `GUI_ledysensor.pde` y modificar la línea del puerto para que coincida con el puerto donde está conectado el Arduino:

```java
myPort = new Serial(this, "/dev/cu.usbmodem21401", 9600);
```

En Windows sería algo como `"COM3"`. En Linux, `/dev/ttyUSB0`.

### 4. Ejecutar la interfaz

Con el Arduino ya conectado y programado, abrir `GUI_ledysensor.pde` en Processing y presionar **Run** (▶). La ventana mostrará la distancia, el estado del sistema y las barras de proximidad en tiempo real.

---

## Uso

Una vez montado el circuito y con ambos programas corriendo:

- Colocar un objeto frente al sensor HC-SR04.
- El sistema actualiza el estado continuamente según la distancia detectada:

| Estado | Distancia | LED | Buzzer |
|---|---|---|---|
| SAFE | > 100 cm | Verde | Apagado |
| WARNING | 51 – 100 cm | Amarillo | Intermitente moderado (2 pitidos/s) |
| DANGER | ≤ 50 cm | Rojo | Intermitente rápido (3.33 pitidos/s) |

- La interfaz Processing refleja el mismo estado con color, distancia en centímetros y barras de proximidad.

---

## Evidencia

Capturas del circuito y la interfaz en funcionamiento disponibles en:  
[Google Drive — Evidencias Taller 11](https://drive.google.com/drive/folders/1z6Mi-cWerLyvZeKusKiwhpV_xwnb_6Z5?usp=sharing)
