import tracer.*;
import tracer.paths.*;
import static javax.swing.JOptionPane.*;
import java.util.*; 

//mouse locked to grid
Point quantizedMouse;

//grid
int cellSqrt = 25;
float rho = 1;

//tracks
Shape currTrack;
ArrayList<Shape> tracks = new ArrayList<Shape>();
Boolean select=false; 
Boolean selectExit = false;
Node selected;
char label = 'A';
char labelNode = '0';
Node oldExitNode;

void settings() {
  size(1200, 675);
}

void setup() {
  noCursor();  
  currTrack = new Shape();
  currTrack.setFill(false);
  quantizedMouse = new Point(quantize(mouseX, 0, cellSqrt), quantize(mouseY, 0, cellSqrt));
 // currTrack.addVertex(quantizedMouse);
}

void draw() {
  background(255);
  drawGrid(cellSqrt);
  drawDot(5, color(0), mouseX, mouseY);
  drawDot(10, color(0), quantizedMouse.x, quantizedMouse.y);
  
  currTrack.draw(g);
  for (Shape track : tracks) {
    track.draw(g); 
  }
  
  for (Node n : Nodes) {
    n.draw();
  }
  
  for (Track t : Tracks) {
    t.updateVal();
    t.draw();
  }
  
  for (Ant t : Ants) {
    if(t.finish){
     if(t.announce==false){
       println("semut-"+Ants.indexOf(t)+" selesai!");
       t.announce=true;
      }
    }else{
      t.step();
      t.draw(g);
    }
  }
 
}

void mouseMoved() {
  quantizedMouse.x = quantize(mouseX, 0, cellSqrt);
  quantizedMouse.y = quantize(mouseY, 0, cellSqrt);
}

void mousePressed() {
  if (mouseButton == RIGHT){
    select = false;
    Node x = new Node(labelNode++,quantizedMouse.x,quantizedMouse.y,"");
    addNode(x);
  }
  if(mouseButton == LEFT){
    if(!select){
      int search = searchNode(quantizedMouse.x,quantizedMouse.y);
      if(search==-1){
        println("bukan node!");
      }else{
        if(selectExit){
          if(oldExitNode!=null){
            oldExitNode.tipe = "";
          }
          Node x = Nodes.get(search); 
          x.tipe = "EXIT";
          oldExitNode = x;
          println("Node-"+x.label);
          selectExit=false;
        }else{
          Node x = Nodes.get(search); 
          selected = x;
          select = true;
          println("Node-"+search+" dipilih");
        }
      }
    }else{
      Node start = selected;
      Node end = new Node(labelNode++,quantizedMouse.x,quantizedMouse.y,"");
      addNode(end);
      float dist =  inputDistance();
      Track newTrack = new Track(Character.toString(label),start.x,start.y,end.x,end.y,dist);
      addTrack(newTrack);
      select = false;
    }
   }
}

void keyPressed(){
  if(key == CODED){
    }else{
      if(key == ' '){
        chooseTrack(Nodes.get(0));
      }
      if(key == 'x'){
        print("Pilih Exit Node : ");
        selectExit = true; 
        
        //chooseTrack(Nodes.get(0));
      }
    }
  
}

void chooseTrack(Node start){
    ArrayList<Integer> result = new ArrayList<Integer>();
    //Node start = Nodes.get(0);
    Point vtx = new Point(start.x,start.y); //node
    int i = currTrack.getVertexCount();
   // currTrack.removeVertex(i);
    currTrack.addVertex(i, vtx);
    tabuList.add(start);
    
    if(start.tipe != "EXIT"){
      result = searchTrack(start); // hasil -> list daftar track yang dapat dilalui
      // println(result.size()); 
   
      if(result.size()>0){
        //println(result.size());
        //int choose = int(random(0,result.size())); // pilih secara random
        int choose = algoACO(result); ///formula ACO menentukan track yang akan dilalui
        Track x = Tracks.get(result.get(choose)); //track yang dilalui sudah ditentukan
        tabuTracks.add(x);
        print(x.label);
        print("->");
        int chooseNode = searchNode(x.endX,x.endY);
        chooseTrack(Nodes.get(chooseNode)); //rekursif sampai ketemu node ujung
      }else{
        println("EXIT");
        Ant a = new Ant(currTrack,tabuList,tabuTracks);
        Ants.add(a);
        println("distance : "+a.totalDistance());
        updatePheromone(a.tabuTracks,a.totalDistance());//update feromon
        tracks.add(currTrack);
        currTrack = new Shape();
        currTrack.setFill(false);
        tabuList.clear();
        tabuTracks.clear();
      }
    }else{
      println("EXIT");
      Ant a = new Ant(currTrack,tabuList,tabuTracks);
      Ants.add(a);
      println("distance : "+a.totalDistance());
      updatePheromone(a.tabuTracks,a.totalDistance());//update feromon
      tracks.add(currTrack);
      currTrack = new Shape();
      currTrack.setFill(false);
      tabuList.clear();
      tabuTracks.clear();
    }
}

void drawDot(float strokeWeight, int c, float x, float y) {
  strokeWeight(strokeWeight);
  stroke(c);
  point(x, y);
}

void drawGrid(int cellSqrt) {
  strokeWeight(1);
  stroke(0, 25);

  int x = 0;
  while (x < width) {
    line(x, 0, x, height);
    x += cellSqrt;
  }

  int y = 0;
  while (y < height) {
    line(0, y, width, y);
    y += cellSqrt;
  }
}

static float quantize(float val, float min, float quantum) {
  val -= min;
  val /= quantum;
  val = round(val);
  return min + val * quantum;
}

float inputDistance(){
  String input;
  String string = "1";
  do {
      input = showInputDialog("Input Distance :");
      if(input!=null){
          if (input.matches("^[0-9]*$")) {
            string = input;
        } else {
           showMessageDialog(null,"Please enter a valid numbers");
        }
      }else{
        input = "1";
        string = input;
      }
      
  } while (!input.matches("^[0-9]*$"));
  return parseInt(string);
}
