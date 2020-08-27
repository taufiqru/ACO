ControlFrame cf;
//boolean finish=false;


class ControlFrame extends PApplet{
  Robot robot;
  Textarea consoleTextarea;
  Textarea bestTextarea;
  int w,h;
  PApplet parent;
  ControlP5 cp5;
  Println console;
 
  
  public ControlFrame(PApplet _parent, int _w,int _h, String _name){
    super();
    parent = _parent;
    w = _w;
    h = _h;
    PApplet.runSketch(new String[]{this.getClass().getName()},this);
  }
  
  public void settings(){
    size(w,h);
  }
  public void setup(){
  //  try { 
  //  robot = new Robot();
  //} catch (AWTException e) {
  //  e.printStackTrace();
  //  exit();
  //}
   
    surface.setLocation(10,10);
    cp5 = new ControlP5(this);
    
    cp5.addTextlabel("Label_Parameter")
       .setText("Pengaturan Parameter :")
       .setPosition(10,10)
       .setColorValue(0xffffff00)
       .setFont(createFont("Arial Bold", 12));
    
    cp5.addSlider("Vaporization")
       .setRange(0.0,1.0)
       .setValue(1.0)
       .setPosition(15,42)
       .setSize(100,20)
       .setFont(createFont("Arial Bold", 10));
   
    cp5.addSlider("Alpha")
       .setRange(1,100)
       .setValue(1)
       .setPosition(15,72)
       .setSize(100,20)
       .setFont(createFont("Arial Bold", 10));
    
    cp5.addSlider("Beta")
       .setRange(1,100)
       .setValue(1)
       .setPosition(15,102)
       .setSize(100,20)
       .setFont(createFont("Arial Bold", 10));
       
    //cp5.addTextlabel("Label_Kontrol")
    //   .setText("Konfigurasi :")
    //   .setPosition(10,142)
    //   .setColorValue(0xffffff00)
    //   .setFont(createFont("Arial Bold", 12));
    
    //cp5.addTextlabel("Label_tambah")
    //   .setText("Tambah")
    //   .setPosition(10,172)
    //   .setColorValue(0xffffffff)
    //   .setFont(createFont("Arial Bold", 10));
       
    //cp5.addSlider("semut",10,500,65,172,100,15).setLabel("semut");
    
    //cp5.addButton("Mulai")
    // .setValue(0)
    // .setPosition(200,172)
    // .setSize(50,15)
    // ;
    
     cp5.addTextlabel("Label_Best")
       .setText("Jalur Terpendek :")
       .setPosition(10,590-22-150-10-22)
       .setColorValue(0xffffff00)
       .setFont(createFont("Arial Bold", 12));
       
     bestTextarea = cp5.addTextarea("best")
                   .setPosition(10, (590-22-150-10))
                   .setSize(280, 150)
                   .setFont(createFont("Arial", 10))
                   .setLineHeight(14)
                   .setColor(255)
                   .setColorBackground(0)
                   .setColorForeground(color(255, 100));
       
     cp5.addTextlabel("Label_Console")
     .setText("Console Log :")
     .setPosition(10,(590-22))
     .setColorValue(0xffffff00)
     .setFont(createFont("Arial Bold", 12));
       
      consoleTextarea = cp5.addTextarea("console")
                   .setPosition(10, 590)
                   .setSize(280, 200)
                   .setFont(createFont("Arial", 10))
                   .setLineHeight(14)
                   .setColor(255)
                   .setColorBackground(0)
                   .setColorForeground(color(255, 100));
      console = cp5.addConsole(consoleTextarea);//
  }
  
  void draw(){
    background(100);
  }
  
  void Alpha(int val){
   alpha = val;
  }
  
  void Beta(int val){
   beta = val;
  }
  
  void Vaporization(float val){
   rho = val;
  }
  
  void semut(int val){
   //println("tambah "+val+" semut");
  }
  
  void Mulai(int val){
   // if(Nodes.size()>0){
   //   for(int i=0;i<cp5.getController("semut").getValue();i++){
   //       robot.keyPress(KeyEvent.VK_SPACE);
   //        robot.delay(50);
   //        robot.keyRelease(KeyEvent.VK_SPACE);
   //   //     //delay((int)random(100,1000));
   //       }
   //        finish = true;
   //}
 }
 
// void keyPressed(){
//  if(key == CODED){
//    }else{
//      if(key == ' '){
//        algoStep.add("Step by step Semut-"+(Ants.size()+1)+":");
//        chooseTrack(Nodes.get(0));
//      }
//      if(key == 'x'){
//        print("Pilih Exit Node : ");
//        selectExit = true; 
//       }
//    }
  
//}
}
