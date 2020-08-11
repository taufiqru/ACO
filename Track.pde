ArrayList<Track> Tracks = new ArrayList<Track>();

int searchTrack(Track x){
  int i = 0;
  for (Track t : Tracks){
    if(t.startX==x.startX && t.startY==x.startY && t.endX==x.endX && t.endY == x.endY){
     return i;
    }
    i++;
  }
  return -1;
}

ArrayList<Integer> searchTrack(Node x){
  ArrayList<Integer> listTrack = new ArrayList<Integer>();
  int i= 0 ;
  for(Track t:Tracks){
    if(t.startX==x.x && t.startY == x.y){
      listTrack.add(i);
    }
    i++;
  }
  return listTrack;
}

void addTrack(Track x){
  if(searchTrack(x)==-1){
    if(!(x.startX==x.endX && x.startY==x.endY)){
      Tracks.add(x);
    }
  }
  label++;
}

class Track{
 float startX,startY,endX,endY;
 String label;
 
 Track(String label,float sX,float sY, float eX, float eY){
   this.label = label;
   this.startX = sX;
   this.startY = sY;
   this.endX = eX;
   this.endY = eY;
 }
 
 void draw(){
  textSize(12);
  text(label,((endX+startX)/2)-5,((endY+startY)/2)-10); 
  stroke(0,0,0,50);
  strokeWeight(3);
  //fill(255,255,0);
  line(startX,startY,endX,endY);
 }
 
}
