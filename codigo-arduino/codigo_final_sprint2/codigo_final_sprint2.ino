int pinoSensor = 7;
const int LM35 = A5; // Define o pino que lera a saída do LM35
float temperatura; // Variável que armazenará a temperatura medida

void setup() {
  pinMode(pinoSensor, INPUT);
  Serial.begin(9600);
}
 
 

void loop() {
  if(digitalRead(pinoSensor) == LOW){
  Serial.print(1);
  }
  else {
  Serial.print(0);
  }
  
  Serial.print(';');
  temperatura = (float(analogRead(LM35))*5/(1023))/0.01;
  Serial.println(temperatura);
  delay(2000);
}