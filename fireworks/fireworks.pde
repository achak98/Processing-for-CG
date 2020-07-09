//fireworks - born of insomnia
Firework[] fs = new Firework[10];
Star[] s = new Star[20];
PImage img;
boolean once;
void setup(){
  size(1280,720);
  textMode(CENTER);
  smooth();
  for (int i = 0; i < fs.length; i++){
    fs[i] = new Firework();
  }
  img = loadImage("bg.png");
}
void draw(){
  image(img, 0, 0,width,height);
  noStroke();
  fill(0, 13, 25,20);
  rect(0,0,width,height);
  
  for (int i = 0; i < fs.length; i++){
    fs[i].draw();
  }
  
  for(int j=0;j<10;j++){
    pushMatrix();
  once = false;
  for (int i = 0; i < fs.length; i++){
    if((fs[i].hidden)&&(!once)){
      fs[i].launch();
      once = true;
    }
  }smooth();specular(255,255,255);shininess(50);popMatrix();
  }
}


class Star{
} 
class Firework{
  float x, y, oldX,oldY, ySpeed, targetX, targetY, explodeTimer, flareWeight, flareAngle;
  int flareAmount, duration;
  boolean launched,exploded,hidden;
  color flare;
  Firework(){
    launched = false;
    exploded = false;
    hidden = true;
  }
  void draw(){
    if((launched)&&(!exploded)&&(!hidden)){
      launchMaths();
      strokeWeight(2);
      stroke(255);
      line(x,y,oldX,oldY);
    }
    if((!launched)&&(exploded)&&(!hidden)){
      explodeMaths();
      noStroke();
      strokeWeight(flareWeight);
      stroke(flare);
      for(int i = 0; i < flareAmount + 1; i++){
          pushMatrix();
          translate(x,y);
          point(sin(radians(i*flareAngle))*explodeTimer,cos(radians(i*flareAngle))*explodeTimer);
          popMatrix();
       }
    }
    if((!launched)&&(!exploded)&&(hidden)){
      //do nothing
    }
  }
  void launch(){
    float xi=random(0,width),yi=random(0,height);
    x = oldX = xi + ((random(5)*10) - 25);
    y = oldY = height;
    targetX = xi;
    targetY = yi;
    ySpeed = random(3) + 2;
    flare = color(random(3)*50 + 105,random(3)*50 + 105,random(3)*50 + 105);
    flareAmount = ceil(random(30)) + 20;
    flareWeight = ceil(random(3));
    duration = ceil(random(4))*20 + 30;
    flareAngle = 360/flareAmount;
    launched = true;
    exploded = false;
    hidden = false;
  }
  void launchMaths(){
    oldX = x;
    oldY = y;
    if(dist(x,y,targetX,targetY) > 6){
      x += (targetX - x)/2;
      y += -ySpeed;
    }else{
      explode();
    }
  }
  void explode(){
    explodeTimer = 0;
    launched = false;
    exploded = true;
    hidden = false;
  }
  void explodeMaths(){
    if(explodeTimer < duration){
      explodeTimer+= 0.4;
    }else{
      hide();
    }
  }
  void hide(){
    launched = false;
    exploded = false;
    hidden = true;
  }
  
}
