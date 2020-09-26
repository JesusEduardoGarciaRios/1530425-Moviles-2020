//DECLARACION DE VARIABLES
PImage imgs[];/*Variable para cargar las dos imagenes(blanco.png para el espacio en blanco 
              y (drac.jpg) para el rompecabezas)*/
PImage IMG[];//Variable para guardar cada una de las piezas de la imagen drac.jpg

//Espacios estaticos del rompecabezas
int [][] posiciones = {
  {0,0}, {105,0}, {210,0},
  {0,105}, {105,105}, {210,105},
  {0,210}, {105,210}, {210,210}
};

//Vector tipo boleano de 9 espacios inicializados en falso
boolean mover[] = {false,false,false,false,false,false,false,false,false}; 

int id_espacio; //indice del bloque de espacio

import java.util.ArrayList;
import java.util.Collections;

ArrayList<Integer> perm;

//Devuelve el indice de la pieza del rompecabezas de acuerdo a las coordenadas del cursor(donde se esta haciendo click)
int id_img_click(int x, int y){
  if(x>0 && x<105 && y>0 && y<105)
    return 0;  //se retorna el indice de la imagen 0 (numero 1)
    
  if(x>105 && x<210 && y>0 && y<105)
    return 1;  //se retorna el indice de la imagen 1 (numero 2)
  
  else if(x>210 && x<315 && y>0 && y<105)
    return 2;  //se retorna el indice de la imagen 2 (numero 3)
  
  else if(x>0 && x<105 && y>105 && y<210)
    return 3;  //se retorna el indice de la imagen 3 (numero 4)
    
  else if(x>105 && x<210 && y>105 && y<210)
    return 4;  //se retorna el indice de la imagen 4 (numero 5)
  
  else if(x>210 && x<315 && y>105 && y<210)
    return 5;  //se retorna el indice de la imagen 5 (numero 6)
    
  else if(x>0 && x<105 && y>210 && y<315)
    return 6;  //se retorna el indice de la imagen 6 (numero 7)
    
  else if(x>105 && x<210 && y>210 && y<315)
    return 7;  //se retorna el indice de la imagen 7 (numero 8)
  
  else if(x>210 && x<315 && y>210 && y<315)
    return 8;  //se retorna el indice de la imagen 9 (espacio en blanco)
    
  return -1;   
  
}

//Identificar que piezas se pueden mover de acuerdo a la posición del espacio
void get_movimientos(int id){
  
  for (int i = 0; i < 9; i++)
    mover[i] = false;
                    
  switch(id){
    case 0:mover[1]=true; mover[3]=true;
      break;
    case 1:mover[0]=true; mover[2]=true; mover[4]=true;
      break;
    case 2:mover[1]=true; mover[5]=true;
      break;
    case 3:mover[0]=true; mover[4]=true; mover[6]=true;
      break;
    case 4:mover[1]=true; mover[3]=true; mover[5]=true; mover[7]=true;
      break;
    case 5:mover[2]=true; mover[4]=true; mover[8]=true;
      break;
    case 6:mover[3]=true; mover[7]=true;
      break;
    case 7:mover[6]=true; mover[4]=true; mover[8]=true;
      break;  
    case 8:mover[5]=true; mover[7]=true;
      break; 
    default:break;
  }
}
//Devuelve el indice de donde se encuentra el espacio en blanco, de acuerdo a la lista desordenada
int get_id_espacio(){
  for (int i = 0; i < 9; i++){
    if(perm.get(i) == 8)
      return i;
  }
  return 0;
} 

//CONFIGURACION DE VARIABLES Y PARAMETROS
void setup(){
  //Tamaño de la ventana
  size(315,315);
  
  //Se define imgs como vector de tamaño 2 para cargar ambas imagenes 
  imgs = new PImage[2];
  imgs[0] = loadImage("drac.jpg");
  imgs[1] = loadImage("blanco.png");
  
  /*Se define IMG como vector de tamaño 9 para almacenar las partes de drac.jpg*/
  IMG = new PImage[9];
  IMG[0] = imgs[0].get(0,0,100,100);
  IMG[1] = imgs[0].get(100,0,100,100);
  IMG[2] = imgs[0].get(200,0,100,100);
  IMG[3] = imgs[0].get(0,100,100,100);
  IMG[4] = imgs[0].get(100,100,100,100);
  IMG[5] = imgs[0].get(200,100,100,100);
  IMG[6] = imgs[0].get(0,200,100,100);
  IMG[7] = imgs[0].get(100,200,100,100);
  //Al ultimo vector se le almacena la parte que iría en blanco(blanco.png)
  IMG[8] = imgs[1].get(0,0,100,100);
  
  //perm es una lista que almacena los numeros del 0 a 8
  perm = new ArrayList<Integer>();
  for (int i = 0; i < 9; i++)
    perm.add(i);
  Collections.shuffle(perm);//Desordena la lista
  
  //Muestra en consola la lista desordenada
  println();
  for (int i = 0; i < 9; i++)
    print(perm.get(i)+",");
}

//MUESTRA EN PANTALLA LA EJECUCION
void draw(){
  //Se imprimen las imagenes de acuerdo al orden de la lista perm
  /*fila 1*/
  image(IMG[perm.get(0)], posiciones[0][0], posiciones[0][1]);
  image(IMG[perm.get(1)], posiciones[1][0], posiciones[1][1]);
  image(IMG[perm.get(2)], posiciones[2][0], posiciones[2][1]);
  /*fila 2*/
  image(IMG[perm.get(3)], posiciones[3][0], posiciones[3][1]);
  image(IMG[perm.get(4)], posiciones[4][0], posiciones[4][1]);
  image(IMG[perm.get(5)], posiciones[5][0], posiciones[5][1]);
  /*fila 3*/
  image(IMG[perm.get(6)], posiciones[6][0], posiciones[6][1]);
  image(IMG[perm.get(7)], posiciones[7][0], posiciones[7][1]);
  image(IMG[perm.get(8)], posiciones[8][0], posiciones[8][1]);
}

//Indica si la pieza que se presiona se movera o no, y hacia donde
void mover_pieza(int id_pieza){
  if(mover[id_pieza] == true){
    int aux = perm.get(get_id_espacio());
    perm.set( get_id_espacio(), perm.get(id_pieza) );
    perm.set( id_pieza, aux );
  }
  get_movimientos( get_id_espacio() );
}

//FUNCIONES PARA CLICK DEL MOUSE
void mousePressed(){
  get_movimientos(get_id_espacio());//Identificar que piezas se pueden mover de acuerdo a la posición del espacio
  int id_pieza = id_img_click(mouseX, mouseY);//Identificar en que pieza se hace click
  println("Pieza: "+id_pieza);//Muestra en consola el indice de la posicion de la pieza
  mover_pieza(id_pieza);
}
 
  
