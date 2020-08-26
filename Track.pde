ArrayList<Track> Tracks = new ArrayList<Track>();
ArrayList<Track> tabuTracks = new ArrayList<Track>();

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


int searchTrack(String label){
  int i = 0;
  for (Track t : Tracks){
    if(t.label==label){
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
      //search node (t.endX && t.endY) yang belum ada di tabu list 
      if(searchNodeTabu(t.endX,t.endY)==-1){
        listTrack.add(i);
      }
    }
    i++;
  }
  return listTrack;
}

void addTrack(Track x){
  if(searchTrack(x)==-1){
    if(!(x.startX==x.endX && x.startY==x.endY)){
      Tracks.add(x);
      Track reverseNewTrack = new Track(Character.toString(label),x.endX,x.endY,x.startX,x.startY,x.distance);
      Tracks.add(reverseNewTrack);
    }
  }
  label++;
}

class Track{
 float startX,startY,endX,endY,distance;
 float pheromone;
 String label;
 
 Track(String label,float sX,float sY, float eX, float eY, float distance){
   this.label = label;
   this.startX = sX;
   this.startY = sY;
   this.endX = eX;
   this.endY = eY;
   this.distance = distance;
   this.pheromone = 1;
 }
 
 void draw(){
  
  textSize(12);
  String txt;
  txt = label +"= "+distance+", ph = "+this.pheromone;
  text(txt,((endX+startX)/2)-5,((endY+startY)/2)-10); 
  stroke(0,0,0,50);
  strokeWeight(3);
  //fill(255,255,0);
  line(startX,startY,endX,endY);
 }
 
 void updateVal(){
   text("",((endX+startX)/2)-5,((endY+startY)/2)-10);
 }
 
}
