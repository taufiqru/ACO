import tracer.*;
import tracer.paths.*;

//mouse locked to grid
Point quantizedMouse;

//grid
int cellSqrt = 25;

//tracks
Shape currTrack;
ArrayList<Shape> tracks = new ArrayList<Shape>();
Boolean select=false; 
Node selected;
char label = 'A';

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
    Node x = new Node("New",quantizedMouse.x,quantizedMouse.y);
    addNode(x);
  }
  if(mouseButton == LEFT){
    if(!select){
      int search = searchNode(quantizedMouse.x,quantizedMouse.y);
      if(search==-1){
        println("bukan node!");
      }else{
        Node x = Nodes.get(search); 
        selected = x;
        select = true;
        println("Node-"+search+" dipilih");
      }
    }else{
      Node start = selected;
      Node end = new Node("New",quantizedMouse.x,quantizedMouse.y);
      addNode(end);
      Track p = new Track(Character.toString(label),start.x,start.y,end.x,end.y); 
      addTrack(p);
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
    }
  
}

void chooseTrack(Node start){
    ArrayList<Integer> result = new ArrayList<Integer>();
    //Node start = Nodes.get(0);
    Point vtx = new Point(start.x,start.y);
    int i = currTrack.getVertexCount();
   // currTrack.removeVertex(i);
    currTrack.addVertex(i, vtx);
    
    result = searchTrack(start); 
   // println(result.size()); 
   
    if(result.size()>0){
      //println(result.size());
      int choose = int(random(0,result.size()));
      Track x = Tracks.get(result.get(choose));
      print(x.label);
      print("->");
      int chooseNode = searchNode(x.endX,x.endY);
      chooseTrack(Nodes.get(chooseNode)); //rekursif sampai ketemu node ujung
    }else{
      println("EXIT");
      Ants.add(new Ant(currTrack));
      tracks.add(currTrack);
      //println(tracks);
      currTrack = new Shape();
      currTrack.setFill(false);
    }
    
    
}

void drawDot(float strokeWeight, int c, float x, float y) {
  strokeWeight(strokeWeight);
  stroke(c);
  point(x, y);
}

void drawGrid(int cellSqrt) {
  strokeWeight(1);
  stroke(0, 100);

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