import javax.swing.*;
import java.awt.*;
import java.awt.Container;
import java.awt.GridLayout;
import java.awt.Dimension;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

float yA=0, yAn=400, tempIng, tempDiv=300, tempDivPor; // yA = altura de calentamiento, Conta = contador de los numeros
float [] temp = new float[100]; //temperatura en escala
int btn=0,C1=0,C2=0,C3=0,Cn1=92,Cn2=124,Cn3=211,rata=17, ult=0, controlador=1; ///rata = numero del vector, C = color boton & Cn = color numeros
float cont=0.225; // descontador de temperatura
JTextField TF1; JFrame frame; JLabel L1; JButton B1;
Ventana ob = new Ventana();

boolean frm_active=false;

void setup(){
  size(700, 600);
  
  for(int i=rata;i<rata+30;i++){
  temp[i]=20;  
  }
         
}

void draw(){
  
   if (!frm_active) {
    frame.setVisible(true);
    frame.setSize(new Dimension(400,360));
    frm_active=true;
  }
  
  background(255, 255, 255); //color de fondo
  
  fill(92 ,124, 211);
  rect(150, 100, 200, 300); //recipiente con agua
  
  fill(232, 12, 12);
  rect(150, 400, 200, yA); //cambio de tempertatura
  
  fill(C1,C2,C3);
  ellipse(500,450,60,60);  // circulo de control
  
  textSize(10); //tamaño texto
  if(btn==1)
  text("ON",490,500);  //Texto Boton
  else
  text("OFF",490,500);  //Texto Boton
    
  textSize(25); //tamaño texto
  text("SIMULACION CALENTADOR DE AGUA ON/OFF",50,30);
  
  for(int i=17; i<47; i++){
  fill(Cn1,Cn2,Cn3);
  textSize(10);
  text(str(temp[i])+"   °C",355,yAn);
  yAn-=10;
  }
  yAn=400;
 
 
 // prender la energia aplicada
 
  if(btn==1){
   yA=yA-0.053*tempDivPor;  
   C1=232; C2=12; C3=12;
   Cn1=232; Cn2=12; Cn3=12;  
   
   //////////////tempArriba
   for(int i=rata; i<rata+10; i++){
   temp[i]+=cont;
   cont=cont/tempDivPor;
   }
   if(temp[rata]>=tempIng){
     temp[rata]=tempIng;
     rata++;   
   }
   
  if(rata==48)
  rata=47;
   cont=0.225;
 }else
 // apagar la energia aplicada
  if(btn==2){
   yA=yA+0.053*tempDivPor;  
   C1=0; C2=0; C3=0; 
   Cn1=92; Cn2=124; Cn3=211; 
   
   //////TempAbajo
   for(int i=rata+10; i>rata+ult; i--){
   temp[i]-=cont;
   cont=cont/tempDivPor;
   }
   
  if(rata==1){
  rata=1;
  ult=5;
  }else
  if(temp[rata+10]<=20){
    temp[rata+10]=20;
   rata--;
  }
   
   cont=0.225;

  }
  
  if(yA>=0)
    yA=0;    //control, tamaño del rectangulo rojo estado caliente
              // para que no se pase del tamaño del tanque
  if(yA<=-tempDiv){
     btn=2;                     //control, tamaño del rectangulo rojo estado caliente
     C1=0; C2=0; C3=0;         // para que no se pase del tamaño del tanque
     }
  else
  if(controlador==1){    ///controlador =ON/OF
  if(yA<=-tempDiv+5 && yA>=-tempDiv+4){
     C1=232; C2=12; C3=12;      // control de la consigna
     btn=1;
  }
  fill(232,12,12);
  ellipse(650,50,20,20);  
  }else{
  
  fill(255,255,255);
  ellipse(650,50,20,20); 
  }
}

void keyPressed()
{
  switch(key)
  {
    case '1':
      btn=1;    // prender la energia aplicada
      rata=17;
      break;
    case '2':
      btn=2;    // apagar la energia aplicada
      ult=0;
      break;
     case '9':
      controlador=1;
      break;
      case '0':
      controlador=0;
      break;  
  }
}

public class Ventana{
  
public Ventana(){
    
    frame=new JFrame("DATOS A INGRESAR DEL CALENTADOR");
    
    Container con=frame.getContentPane();
    con.setLayout(new FlowLayout()); 
    
    L1= new JLabel("Ingrese La temperatura: ");
    con.add(L1);
    TF1 = new JTextField(10);
    TF1.requestFocus(true);
    con.add(TF1);
    L1 = new JLabel(" °C");
    con.add(L1);
    B1 = new JButton("EMPEZAR");
    B1.addActionListener (new ActionListener()
       {
         public void actionPerformed (ActionEvent e)
         {
         tempIng = Float.parseFloat(TF1.getText());
         
         if(tempIng>20 && tempIng<100){
         btn=1;
         rata=17;
         if(tempIng>35){
         tempDivPor = 100/tempIng;
         tempDiv = 300/tempDivPor;
         }else{
         tempDivPor = 100/(tempIng-20);
         tempDiv = 300/tempDivPor;
         }
         TF1.setText("");
         B1.setEnabled(false);
         }else
         JOptionPane.showMessageDialog(null,"TEMPERATURA PEQUEÑA O GRANDE Rango[21 a 99]","!!!",JOptionPane.INFORMATION_MESSAGE);

         
         }
       });
    con.add(B1);
    
}
}
