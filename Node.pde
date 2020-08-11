ArrayList<Node> Nodes = new ArrayList<Node>();

void addNode(Node x){
  if(searchNode(x.x,x.y)==-1){
    Nodes.add(x);
  }
}

int searchNode(float x, float y){
  int i = 0;
  for (Node n : Nodes) {
    if(n.x == x && n.y == y ){
      return i;
    }
    i++;
  }
  return -1;
}

class Node{
  String label;
  float x,y;
  int nodeSize=3;
  
  Node(String label,float x, float y){
    this.label = label;
    this.x = x;
    this.y = y;
  }
  
  void draw(){
      stroke(0);
      fill(255,0,0);
      //strokeWeight(12);
      ellipseMode(CENTER);
      ellipse(x,y,10,10);
  }
  
  
}
