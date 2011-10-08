int luz;

void setup() {
  //Inicia uma comunicacao serial a 9600 kpbs
  Serial.begin(57600);
  
  //Define o pino 3 como INPUT
  pinMode(3, INPUT);
  
  //Define os pinos 4, 7, 8, 12 e 13 como OUTPUT
  pinMode(4, OUTPUT);  //LED 5
  pinMode(7, OUTPUT);  //LED 4
  pinMode(8, OUTPUT);  //LED 3
  pinMode(12, OUTPUT); //LED 2
  pinMode(13, OUTPUT); //LED 1
}

void loop() {
  //Le o pino 3 analogico
  luz = analogRead(3);

  digitalWrite(13, LOW);
  digitalWrite(12, LOW);
  digitalWrite(8, LOW);
  digitalWrite(7, LOW);
  digitalWrite(4, LOW);
  
  if(luz < 200) {
    digitalWrite(4, HIGH);
  }
  if(luz < 400) {
    digitalWrite(7, HIGH);
  }
  if(luz < 600) {
    digitalWrite(8, HIGH);
  }
  if(luz < 800) {
    digitalWrite(12, HIGH);
  }
  if(luz < 1023) {
    digitalWrite(13, HIGH);
  }
}
