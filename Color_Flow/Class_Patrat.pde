class Patrat{
  int cul;
  color culoare;
  int x,y;
  boolean detinut;
  boolean vizitat;
  Patrat(int x_,int y_){
     cul=(int)random(5);
     culoare=culori[cul];
     detinut=false;
     vizitat=false;
     x=x_;
     y=y_;
  }
  void afisare(){
    stroke(0);
    //noStroke();
    fill(culoare,20);
    rect(x,y,dim_p,dim_p);
  }
}
