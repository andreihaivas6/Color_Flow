Patrat[][] patrat= new Patrat[50][50];
Buton[] buton=new Buton[10];
PImage reset_buton;
PFont font;
color[] culori={#FF0303,#3C03FF,#0CE509,#FFB803,#A012C1,#FFF41F};
color[] culori_light={#E0666A,#8B77DE,#60F55B,#F5CA65,#C67CDB};
int i,j;
int x,y,x1;
int dim_mat=12,dim_p=400/dim_mat;
int mutari,patrate=0;
int u_buton;
boolean cerc;
void setup(){
  mutari=17;
  
  size(600,700);
  font=createFont("Times New Roman",64,true);
  textFont(font,36);
  reset_buton=loadImage("but.png");
  y=100;
  for(i=1;i<=dim_mat;i++){
    x=100;
    for(j=1;j<=dim_mat;j++){
      patrat[i][j]=new Patrat(x,y);
      x=x+dim_p;
    }
    y=y+dim_p;
  }
  init();
  Afisare_m();
  
  x1=50;
  for(i=0;i<5;i++){
    buton[i]=new Buton(x1,i);
    x1=x1+105;
  }
  Afisare_b();
  cerc=true;
}
void draw(){
  cursor_();
  fundal();    
  for(i=0;i<5;i++)
    if(buton[i].apasat()==true && u_buton!=i){
      u_buton=i;
      mutari--;
      umplere();
      cerc=false;
    }
  Afisare_m();
  Afisare_b();
  finall();
}
void init(){
  while(patrat[1][1].cul== patrat[1][2].cul || patrat[1][1].cul==patrat[2][1].cul)
    patrat[1][1].cul=(int)random(5);
  u_buton=patrat[1][1].cul;
  patrat[1][1].culoare=culori[patrat[1][1].cul];
  patrat[1][1].detinut=true;
  patrate=1;
}
void fundal(){
  fill(#D3D1D1);
  noStroke();
  rect(0,0,width,100);
  rect(0,500,width,300);
  rect(0,100,100,400);
  rect(500,100,100,400);
  fill(0);
  text("Mutari:"+mutari,50,60);
  image(reset_buton,550,0,50,50);
}
void Afisare_m(){
  for(i=1;i<=dim_mat;i++)
    for(j=1;j<=dim_mat;j++)
       patrat[i][j].afisare();
  if(cerc==true){
    noStroke();
    fill(0);
    ellipse(100+dim_p/2,100+dim_p/2,dim_p/4,dim_p/4);
  }
}
void Afisare_b(){
  stroke(0);
  fill(#B2B2B2);
  rect(30,540,540,120);
  for(i=0;i<5;i++)
    buton[i].afisare();
}
void cursor_(){
  boolean pe_buton=false;
  for(i=0;i<5;i++)
    if(buton[i].deasupra()==true)
      pe_buton=true;
  if(pe_buton==true)
    cursor(HAND);
  else
    cursor(ARROW);
}
void finall(){
  if(mutari==0){
    fundal();
    Afisare_b();
    cursor(ARROW);
    fill(0);
    text("GAME OVER",300,60);
    for(int a=1;a<=dim_mat;a++)
      for(int b=1;b<=dim_mat;b++){
        stroke(0);
        fill(patrat[a][b].culoare);
        rect(patrat[a][b].x,patrat[a][b].y,dim_p,dim_p);
      } 
    noLoop();
  }
  if(patrate==dim_mat*dim_mat){
    fundal();
    Afisare_b();
    cursor(ARROW);   
    fill(0);
    text("Ai castigat!",300,60);
    for(int a=1;a<=dim_mat;a++)
      for(int b=1;b<=dim_mat;b++){
        stroke(0);
        fill(patrat[a][b].culoare);
        rect(patrat[a][b].x,patrat[a][b].y,dim_p,dim_p);
      }   
    noLoop();
  }
}
void umplere(){
  int k,l;
  boolean gasit;
  do{
    gasit=false;
    for(k=1;k<=dim_mat;k++)
      for(l=1;l<=dim_mat;l++)
        if(patrat[k][l].detinut==true){
          patrat[k][l].cul=i;
          patrat[k][l].culoare=culori[i];
          int ii[]={-1,0,1,0}, ij[]={0,1,0,-1};
          for(j=0;j<=3;j++)
          if(k+ii[j]>=1 && k+ii[j]<=dim_mat && l+ij[j]>=1 && l+ij[j]<=dim_mat)
            if(patrat[k+ii[j]][l+ij[j]].detinut==false && patrat[k+ii[j]][l+ij[j]].cul==i){
              patrate++;
              patrat[k+ii[j]][l+ij[j]].detinut=true;
              gasit=true;
            }
        }
  }while(gasit==true);
}
void mousePressed(){
  if(mouseY<=50 && mouseX>=550)
    setup();
}
/*
void curatare(){
  int k,l;
  for(k=1;k<=dim_mat;k++)
    for(l=1;l<=dim_mat;l++)
      patrat[k][l].vizitat=false;

}
void schimba_culoare(){
  int k,l;
  for(k=1;k<=dim_mat;k++)
    for(l=1;l<=dim_mat;l++)
       if(patrat[k][l].detinut==true){
         patrat[k][l].cul=i;
         patrat[k][l].culoare=culori[i];
       }
}
void umplere(int k,int l){
  if(patrat[k][l].vizitat==false){
    patrat[k][l].vizitat=true;
      if(patrat[k][l].detinut==false && patrat[k][l].cul==i){
        patrat[k][l].detinut=true;
        patrate++;
      }
      if(patrat[k][l].cul==i){
        int[] ii={-1,0,1,0};
        int[] ij={0,1,0,-1};
        for(j=0;j<=3;j++)
          if(k+ii[j]>=1 && k+ii[j]<=dim_mat && l+ij[j]>=1 && l+ij[j]<=dim_mat)
            umplere(k+ii[j],l+ij[j]);
      }
    }
}
*/
