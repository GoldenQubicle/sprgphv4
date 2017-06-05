class GUI extends PApplet {
  PApplet parent;
  ControlP5 cp5;
  Textarea testMessage;

  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(512, 512);
  } 

  public void setup() {
    cp5 = new ControlP5(this);
    testMessage = cp5.addTextarea("message").setPosition(256, 256).setSize(200, 20).setText("ello ello");

    
  }
  
  public void draw(){
   background(100); 
  }
}