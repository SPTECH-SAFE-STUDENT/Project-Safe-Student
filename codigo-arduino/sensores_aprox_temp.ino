int pinoSensor = 8; ​

const int LM35 = A0; ​

float temperatura; ​

​

void setup() {​

Serial.begin(9600); ​

pinMode(pinoSensor, INPUT);​

}​

​

void loop() {​

    if(digitalRead(pinoSensor) == LOW){​

  Serial.println("Ocupado!");​

  }​

  else {​

  Serial.println("Vazio");​

  }​

  delay(1000);​

​

temperatura = (float(analogRead(LM35))*5/(1023))/0.01 * 1.25;​

Serial.print("Temperatura: ");​

Serial.println(temperatura);​

delay(1000);​

}​
