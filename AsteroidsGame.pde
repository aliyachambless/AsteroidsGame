SpaceShip crashGreen;
ArrayList <Asteroid> firstRock = new ArrayList <Asteroid>();
ArrayList <Bullet> flyingBullets = new ArrayList <Bullet>();
Star[] nightSky = new Star[300];
Boolean fire = false;
int adj;
double hyp;
int calcDirection;
int rocks;
public void setup() 
{
  size(1000,800);
  crashGreen = new SpaceShip();
  rocks = 0;
  for(int i = 0; i < 6; i++){
    firstRock.add(new Asteroid());
  }
  for(int i = 0; i < 300; i++){
    nightSky[i] = new Star();
  }
}
public void draw() 
{
  background(0);
  for(int i = 0; i < 300; i++){
    nightSky[i].show();
    //nightSky[i].blink();
  }
  for(int i = 0; i < firstRock.size(); i++){
    firstRock.get(i).show();
    firstRock.get(i).move();
  }
  for(int i = 0; i < flyingBullets.size(); i++){
    flyingBullets.get(i).move();
    flyingBullets.get(i).show();
    if(flyingBullets.get(i).getX() > 1000 || flyingBullets.get(i).getX() < 0 || flyingBullets.get(i).getY() > 800 || flyingBullets.get(i).getY() < 0){
       flyingBullets.remove(i);
       System.out.println(flyingBullets.size());
    }
  }
  //System.out.println(flyingBullets.size());
  crashGreen.show();
  crashGreen.move();
  adj = mouseX - crashGreen.getX();
  hyp = Math.sqrt(Math.pow(mouseX - crashGreen.getX(),2)+Math.pow(crashGreen.getY() - mouseY,2));
  if(mouseY < crashGreen.getY())
    calcDirection = -1*(int)degrees((float)Math.acos(adj/hyp));
  else 
    calcDirection = (int)degrees((float)Math.acos(adj/hyp));
  crashGreen.setPointDirection(calcDirection);
  if(fire == true){
    stroke(0,98,255);
    line(crashGreen.getX() - cos((float)radians((float)crashGreen.getPointDirection()))*20, crashGreen.getY() - sin((float)radians((float)crashGreen.getPointDirection()))*20, crashGreen.getX() - cos((float)radians((float)crashGreen.getPointDirection()))*30, crashGreen.getY() - sin((float)radians((float)crashGreen.getPointDirection()))*30);
    line(crashGreen.getX() - cos((float)radians((float)crashGreen.getPointDirection()+20))*20, crashGreen.getY() - sin((float)radians((float)crashGreen.getPointDirection()+20))*20, crashGreen.getX() - cos((float)radians((float)crashGreen.getPointDirection()+20))*30, crashGreen.getY() - sin((float)radians((float)crashGreen.getPointDirection()+20))*30);
    line(crashGreen.getX() - cos((float)radians((float)crashGreen.getPointDirection()-20))*20, crashGreen.getY() - sin((float)radians((float)crashGreen.getPointDirection()-20))*20, crashGreen.getX() - cos((float)radians((float)crashGreen.getPointDirection()-20))*30, crashGreen.getY() - sin((float)radians((float)crashGreen.getPointDirection()-20))*30);
  }
  for(int i = 0; i < firstRock.size(); i++){
    if(dist(crashGreen.getX(), crashGreen.getY(), firstRock.get(i).getX(), firstRock.get(i).getY()) < 10*firstRock.get(i).getSize()){
      firstRock.remove(i);
    }
  }
  for(int x = 0; x < flyingBullets.size(); x++){
    for(int i = 0; i < firstRock.size(); i++){
      //if(flyingBullets.get(x).getX() <= firstRock.get(i).getX() + (10 * firstRock.get(i).getSize()) && flyingBullets.get(x).getX() >= firstRock.get(i).getX() - (10 * firstRock.get(i).getSize()) && flyingBullets.get(x).getY() >= firstRock.get(i).getX() - (10 * firstRock.get(i).getSize()) && flyingBullets.get(x).getY() >= firstRock.get(i).getX() - (10 * firstRock.get(i).getSize())){
        //System.out.println("rock x: "+ (firstRock.get(i).getX() + (10 * firstRock.get(i).getSize())) + ", bullet x: " + flyingBullets.get(x).getX());
      if(dist(flyingBullets.get(x).getX(), flyingBullets.get(x).getY(), firstRock.get(i).getX(), firstRock.get(i).getX()) < 10*firstRock.get(i).getSize()){
        flyingBullets.remove(x);
        if(firstRock.get(i).getSize() > 1){
          firstRock.get(i).split();
          System.out.println("hit");
        }
        else {
          firstRock.remove(i);
        }
      }
    }
  }
}
class SpaceShip extends Floater  
{   
    SpaceShip(){
      corners = 8;
      xCorners = new int[corners];
      yCorners = new int[corners];
      xCorners[0] = 13;
      xCorners[1] = 10;
      xCorners[2] = 0;
      xCorners[3] = -4;
      xCorners[4] = -15;
      xCorners[5] = -4;
      xCorners[6] = 0;
      xCorners[7] = 10;
      yCorners[0] = 0;
      yCorners[1] = 3;
      yCorners[2] = 6;
      yCorners[3] = 12;
      yCorners[4] = 0;
      yCorners[5] = -12;
      yCorners[6] = -6;
      yCorners[7] = -3;
      myColor = color(144,195,212);
      myCenterX = 500;
      myCenterY = 400;
      myDirectionX = 0;
      myDirectionY = 0;
      myPointDirection = 0;
    }
    public void setX(int x){myCenterX = x;}
    public void setY(int y){myCenterY = y;}
    public int getX(){return (int)myCenterX;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX(double x){myDirectionX = x;}   
    public double getDirectionX(){return myDirectionX;}   
    public void setDirectionY(double y){myDirectionY = y;} 
    public double getDirectionY(){return myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection = degrees;}  
    public double getPointDirection(){return myPointDirection;}

}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
public void keyPressed(){
  if(keyCode == 87){ // w = foreward
    crashGreen.accelerate(1);
    fill(255, 181, 71);
    fire = true;
  }
  // if(keyCode == 65){ // a = left
  //   crashGreen.rotate(-3);
  // }
  if(keyCode == 83){ // s = back
    crashGreen.accelerate(-1);
  }
  // if(keyCode == 68){ // d = right
  //   crashGreen.rotate(3);
  // }
  if(keyCode == 68){ // d = hyperspace
    crashGreen.setPointDirection((int)(Math.random()*360));
    crashGreen.setDirectionY(0);
    crashGreen.setDirectionX(0);
    crashGreen.setX((int)(Math.random()*1000));
    crashGreen.setY((int)(Math.random()*800));
  }
  if(keyCode == 32){
  }
}
public void keyReleased(){
  fire = false;
}
public class Star {
  private int xPos, yPos, bright;
  public Star(){
    xPos = (int)(Math.random()*1000);
    yPos = (int)(Math.random()*800);
    bright = (int)(Math.random()*255);
  }
  public void show(){
    fill(255,bright);
    noStroke();
    ellipse(xPos, yPos, 5,5);
  }
//   public void blink(){
//     int flicker = bright;
//     for(int i = bright; i >= bright-100 && i >= 0; i-=20){
//       fill(flicker,flicker,flicker);
//       noStroke();
//       ellipse(xPos, yPos, 5,5);
//       flicker -= i;
//     }
//   }
}
public void mousePressed(){
  flyingBullets.add(new Bullet());
  // for(int i = 0; i < firstRock.size(); i++){
  //   if(mouseX <= firstRock.get(i).getX() + (10 * firstRock.get(i).getSize()) && mouseX >= firstRock.get(i).getX() - (10 * firstRock.get(i).getSize()) && mouseY >= firstRock.get(i).getX() - (10 * firstRock.get(i).getSize()) && mouseY >= firstRock.get(i).getX() - (10 * firstRock.get(i).getSize())){
  //     System.out.println("clicked ASteroid");
  //     if(firstRock.get(i).getSize() > 1){
  //       firstRock.add(new Asteroid());
  //       firstRock.get(firstRock.size() - 1).setX(firstRock.get(i).getX());
  //       firstRock.get(firstRock.size() - 1).setY(firstRock.get(i).getY());
  //       firstRock.get(i).smaller();
  //       firstRock.get(firstRock.size() - 1).setSize(firstRock.get(i).getSize());
  //       firstRock.get(firstRock.size() - 1).setColor(color(255,0,0));
  //       firstRock.get(i).redo();
  //       firstRock.get(firstRock.size() - 1).redo();
  //     }
  //     else {
  //       firstRock.remove(i);
  //     }
  //   }
  // }
}
public class Asteroid extends Floater{
  private int rotSpeed, rockSize;
  public Asteroid(){
    rotSpeed = (int)(Math.random()*6)-3;
    corners = 9;
    rockSize = 3;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 8 * rockSize;
    xCorners[1] = 8 * rockSize;
    xCorners[2] = 0 * rockSize;
    xCorners[3] = -4 * rockSize;
    xCorners[4] = -11 * rockSize;
    xCorners[5] = -11 * rockSize;
    xCorners[6] = -6 * rockSize;
    xCorners[7] = 8 * rockSize;
    xCorners[8] = 10 * rockSize;
    yCorners[0] = 2 * rockSize;
    yCorners[1] = 10 * rockSize;
    yCorners[2] = 12 * rockSize;
    yCorners[3] = 7 * rockSize;
    yCorners[4] = 4 * rockSize;
    yCorners[5] = -5 * rockSize;
    yCorners[6] = -10 * rockSize;
    yCorners[7] = -7 * rockSize;
    yCorners[8] = -3 * rockSize;
    myColor = color(148, 171, 170);
    myCenterX = (int)(Math.random()*1000);
    myCenterY = (int)(Math.random()*800);
    myDirectionX = (int)(Math.random()*6)-3;
    myDirectionY = (int)(Math.random()*6)-3;
    myPointDirection = (int)(Math.random()*360);
  }
  public void setX(int x){myCenterX = x;}
  public void setY(int y){myCenterY = y;}
  public int getX(){return (int)myCenterX;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;} 
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}  
  public double getPointDirection(){return (int)myPointDirection;}
  public void setSize(int size){rockSize = size;}
  public int getSize(){return rockSize;}
  public void setColor(int mcolor){myColor = mcolor;}
  public void move(){
    rotate(rotSpeed);
    super.move();
  }
  public void smaller(){
    rockSize -= 1;
  }
  public void redo(){
    xCorners[0] = 8 * rockSize;
    xCorners[1] = 8 * rockSize;
    xCorners[2] = 0 * rockSize;
    xCorners[3] = -4 * rockSize;
    xCorners[4] = -11 * rockSize;
    xCorners[5] = -11 * rockSize;
    xCorners[6] = -6 * rockSize;
    xCorners[7] = 8 * rockSize;
    xCorners[8] = 10 * rockSize;
    yCorners[0] = 2 * rockSize;
    yCorners[1] = 10 * rockSize;
    yCorners[2] = 12 * rockSize;
    yCorners[3] = 7 * rockSize;
    yCorners[4] = 4 * rockSize;
    yCorners[5] = -5 * rockSize;
    yCorners[6] = -10 * rockSize;
    yCorners[7] = -7 * rockSize;
    yCorners[8] = -3 * rockSize;
    myDirectionX = (int)(Math.random()*6)-3;
    myDirectionY = (int)(Math.random()*6)-3;
    myPointDirection = (int)(Math.random()*360);
  }
  public void split(){
    firstRock.add(new Asteroid());
    int newIndex = firstRock.size() - 1;
    firstRock.get(newIndex).setX((int)myCenterX);
    firstRock.get(newIndex).setY((int)myCenterY);
    smaller();
    firstRock.get(newIndex).setSize(rockSize);
    firstRock.get(newIndex).setColor(color(255,0,0));
    redo();
    firstRock.get(newIndex).redo();
  }
}
public class Bullet{
  private float speed, xPos, yPos;
  private double direction;
  public Bullet(){
    speed = 5;
    direction = crashGreen.getPointDirection();
    xPos = crashGreen.getX();
    yPos = crashGreen.getY();
  }
  public float getX(){return xPos;}
  public float getY(){return yPos;}
  public void show(){
    fill(244, 50, 50);
    noStroke();
    ellipse(xPos, yPos, 5, 5);
  }
  public void move(){
    //System.out.println(speed*(sin(radians((float)direction))));
    xPos += speed*(cos(radians((float)direction)));
    yPos += speed*(sin(radians((float)direction)));
  }
}