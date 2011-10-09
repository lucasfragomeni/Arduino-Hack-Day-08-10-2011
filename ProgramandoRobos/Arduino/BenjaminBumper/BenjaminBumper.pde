//Motor esquerdo
const int E_FRENTE = 3;
const int E_TRAS = 5;

//Motor direito
const int D_FRENTE = 6;
const int D_TRAS = 9;

//Velocidade dos motores
const int VELOCIDADE = 255;
int rodaesquerda, rodadireita;

void setup() {
  Serial.begin(9600);

  //Inicialização do motor esquerdo
  pinMode(E_FRENTE, OUTPUT);
  pinMode(E_TRAS, OUTPUT);

  //Inicialização do motor direito
  pinMode(D_FRENTE, OUTPUT);
  pinMode(D_TRAS, OUTPUT);
  
  pinMode(0, INPUT);
}

#define time90 120


void loop() {
  if(isEsquerdaAtivo()){
      frente(-1);
    }else{
      while(!isEsquerdaAtivo()){
        esquerda(100);
      }
    }
    
  if(isDireitaAtivo() && isEsquerdaAtivo()) {
    parar();
    delay(100);
    tras (200);
    parar();
    delay(100);
    direita (time90 * 4);
    delay(50);
    frente(100);
    
  }
  
}

/************************
 * Funções de sensor *
 ************************/

boolean isDireitaAtivo() {
  return (digitalRead(2) == HIGH);
}

boolean isEsquerdaAtivo() {
  return (digitalRead(7) == HIGH);
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
  if(milisegundos >= 0) { 
    delay(milisegundos);
    parar();
  }
}

/*
 * Anda pra trás por x milisegundos e pára.
 */
void tras(int milisegundos) {
  trasDireita();
  trasEsquerda();  
  if(milisegundos >= 0) { 
    delay(milisegundos);
    parar();
  }
}

/*
 * Anda pra direita por x milisegundos e pára.
 */
void direita(int milisegundos) {
  frenteEsquerda();
  if(milisegundos >= 0) { 
    delay(milisegundos);
    parar();
  }
}

/*
 * Anda pra esquerda por x milisegundos e pára.
 */
void esquerda(int milisegundos) {
  frenteDireita();
  if(milisegundos >= 0) { 
    delay(milisegundos);
    parar();
  }
}

/************************
 * Controle dos Motores *
 ************************/
 
void frenteEsquerda() {
  int aux = map(analogRead(0),0, 1023, 0, 255);
  analogWrite(E_FRENTE, aux);
  analogWrite(E_TRAS, 0);
}

void frenteDireita() {
  analogWrite(D_FRENTE, 127);
  analogWrite(D_TRAS, 0);
}

void trasEsquerda() {
  int aux = map(analogRead(0),0, 1023, 0, 255);
  analogWrite(E_FRENTE, 0);
  analogWrite(E_TRAS, aux);
}

void trasDireita() {
  analogWrite(D_FRENTE, 0);
  analogWrite(D_TRAS, 127);
}

void parar() {
  analogWrite(E_FRENTE, 0);
  analogWrite(E_TRAS, 0);
  analogWrite(D_FRENTE, 0);
  analogWrite(D_TRAS, 0);
}
