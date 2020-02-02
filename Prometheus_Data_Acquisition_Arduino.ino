
const int LC = A0;
const int PT = A2;
//const float lcOffset = ;
//const float lcSlope = ;

void setup() {
  Serial.begin(9600);
  
  delay(500);
}

void loop() {
  
   float lcVoltage = analogRead(LC) * (5.0 / 1023.0);
   //float force = lcSlope * (lcVoltage - lcOffset);
   float ptVoltage = analogRead(PT) * (5.0/1023.0);
   float psi = 570.03 * ptVoltage - 509.77;
   Serial.print(lcVoltage); Serial.print(",");
   Serial.print(psi);
   Serial.println();
   
   delay(1);
}
