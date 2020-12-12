class Buton{
  int nr;
  int x;
  Buton(int x_,int nr_){
    x=x_;
    nr=nr_;
  }
  void afisare(){
     noStroke();
     if(deasupra()==true){
        fill(culori_light[nr]);
        rect(x,560,80,80);
     }
     else{
       fill(culori[nr]);
       rect(x,560,80,80);
     }
  }
  boolean deasupra(){
    if(mouseX>=x && mouseX<=(x+80) && mouseY>=560 && mouseY<=640)
       return true;
    return false;
  }
  boolean apasat(){
    if(mousePressed==true && deasupra()==true)
      return true;
    return false;
  }
}
