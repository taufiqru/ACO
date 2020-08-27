//notes//
ArrayList<String> algoStep = new ArrayList<String>();

void printAlgoStep(){
  for(String x:algoStep){
    println(x);
  }
}

void printTracks(Ant x){
  float totDistance=0;
  String jalur="";
  
  println("Jalur yang dilalui Semut-"+(Ants.size())+":");
  for(Track t:x.tabuTracks){
    jalur=jalur+t.label+"->";
    totDistance = totDistance + t.distance;
  }
  println(jalur+"EXIT");
  println("Total jarak :"+x.totalDistance());
}
