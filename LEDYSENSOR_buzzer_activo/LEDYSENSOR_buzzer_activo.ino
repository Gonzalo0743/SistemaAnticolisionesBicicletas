#define TRIG 9
#define ECHO 10

#define RED 2
#define GREEN 3
#define BLUE 4
#define BUZZER 5   // Positivo del buzzer al pin 5, negativo a GND

long duration;
int distance;

void setup() {

  pinMode(TRIG, OUTPUT);
  pinMode(ECHO, INPUT);

  pinMode(RED, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLUE, OUTPUT);
  pinMode(BUZZER, OUTPUT);

  Serial.begin(9600);
}

void loop() {

  // Medir distancia
  digitalWrite(TRIG, LOW);
  delayMicroseconds(2);

  digitalWrite(TRIG, HIGH);
  delayMicroseconds(10);

  digitalWrite(TRIG, LOW);

  duration = pulseIn(ECHO, HIGH);
  distance = duration * 0.034 / 2;

  String state;

  // SAFE / VERDE
  if (distance > 100) {

    state = "SAFE";

    digitalWrite(RED, LOW);
    digitalWrite(GREEN, HIGH);
    digitalWrite(BLUE, LOW);

    // En verde no suena
    digitalWrite(BUZZER, LOW);
    delay(100);
  }

  // WARNING / AMARILLO
  else if (distance > 50) {

    state = "WARNING";

    digitalWrite(RED, HIGH);
    digitalWrite(GREEN, HIGH);
    digitalWrite(BLUE, LOW);

    // Amarillo: sonido menos intenso/intermitente
    digitalWrite(BUZZER, HIGH);
    delay(120);
    digitalWrite(BUZZER, LOW);
    delay(380);
  }

  // DANGER / ROJO
  else {

    state = "DANGER";

    digitalWrite(RED, HIGH);
    digitalWrite(GREEN, LOW);
    digitalWrite(BLUE, LOW);

    // Rojo: sonido más intenso y rápido
    digitalWrite(BUZZER, HIGH);
    delay(220);
    digitalWrite(BUZZER, LOW);
    delay(80);
  }

  // Enviar a Processing
  Serial.print(state);
  Serial.print(",");
  Serial.println(distance);
}
