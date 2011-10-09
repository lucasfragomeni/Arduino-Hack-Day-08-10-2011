//Motor esquerdo
const int E_FRENTE = 3;
const int E_TRAS = 5;

//Motor direito
const int D_FRENTE = 6;
const int D_TRAS = 9;

//Velocidade dos motores
const int VELOCIDADE = 255;

void setup() {
  Serial.begin(9600);

  //Inicialização do motor esquerdo
  pinMode(E_FRENTE, OUTPUT);
  pinMode(E_TRAS, OUTPUT);

  //Inicialização do motor direito
  pinMode(D_FRENTE, OUTPUT);
  pinMode(D_TRAS, OUTPUT);
}

void loop() {
  //TODO: Implementar...
}

/************************
 * Funções de movimento *
 ************************/
 
/*
 * Anda pra frente por x milisegundos e pára.
 */
void frente(int milisegundos) {
  frenteDireita();
  frenteEsquerda();  
  delay(milisegundos);
  parar();
}

/*
 * Anda pra trás por x milisegundos e pára.
 */
void tras(int milisegundos) {
  trasDireita();
  trasEsquerda();  
  delay(milisegundos);
  parar();
}

/*
 * Anda pra direita por x milisegundos e pára.
 */
void direita(int direcao, int milisegundos) {
  frenteEsquerda();
  delay(milisegundos);
  parar();
}

/*
 * Anda pra esquerda por x milisegundos e pára.
 */
void esquerda(int direcao, int milisegundos) {
  frenteDireita();
  delay(milisegundos);
  parar();
}

/************************
 * Controle dos Motores *
 ************************/
 
void frenteEsquerda() {
  digitalWrite(E_FRENTE, HIGH);
  digitalWrite(E_TRAS, LOW);
}

void frenteDireita() {
  digitalWrite(D_FRENTE, HIGH);
  digitalWrite(D_TRAS, LOW);
}

void trasEsquerda() {
  digitalWrite(E_FRENTE, LOW);
  digitalWrite(E_TRAS, HIGH);
}

void trasDireita() {
  digitalWrite(D_FRENTE, LOW);
  digitalWrite(D_TRAS, HIGH);
}

void parar() {
  digitalWrite(E_FRENTE, LOW);
  digitalWrite(E_TRAS, LOW);
  digitalWrite(D_FRENTE, LOW);
  digitalWrite(D_TRAS, LOW);
}
