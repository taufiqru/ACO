  ArrayList<Ant> Ants = new ArrayList<Ant>();


class Ant {
  ArrayList<Node> tabuList = new ArrayList<Node>();
  Path track;
  Point pt;
  float u, du, length1D;
  float w = 5;
  boolean finish =false;
  boolean announce = false;
  
  Ant(Path track,ArrayList<Node> tabuList) {
    this.track = track;   
    this.u = 0;
    this.du = 1 / track.getLength();
    this.length1D = 25 / track.getLength();
    this.pt = new Point(0, 0);  
    this.tabuList = tabuList;
   
  }
  
  void step() {
    u = Path.remainder(u + du, 1);
    //println(u);
    if(u>=0.99){
      finish=true;
    }
  }
  
  void draw(PGraphics g) {
      float v = u;
      track.trace(pt, v);
      stroke(0);
      fill(255,0,0);
      strokeWeight(12);
      ellipseMode(CENTER);
      pushMatrix();
      translate(pt.x, pt.y);
      rotate(atan2(0,0));
      ellipse(0,0,3,3);
      popMatrix();
      //v = Path.remainder(v - 1.25*length1D, 1);
      //println(v);
  }
}
