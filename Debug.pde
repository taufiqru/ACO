//notes//
ArrayList<String> algoStep = new ArrayList<String>();
ArrayList<String> listOfBestRoute = new ArrayList<String>();
ArrayList<String> listOflabel = new ArrayList<String>();

ArrayList<Track> bestRoutes = new ArrayList<Track>();
//Shape currBestRoute;
  
Float shortestPath = 99999.0;
String bestRoute = "";


void printAlgoStep(){
  for(String x:algoStep){
    println(x);
  }
}


void printTracks(Ant x){
  String jalur="";
   println("Jalur yang dilalui Semut-"+(Ants.size())+":");
  for(Track t:x.tabuTracks){
    jalur=jalur+t.label+"->";
  }
  println(jalur+"EXIT");
  
  println("Total jarak :"+x.totalDistance());
  if(x.totalDistance()<=shortestPath){
    if(x.totalDistance()==shortestPath){
       shortestPath = x.totalDistance();
       bestRoute = jalur+"EXIT";
       tambahBestRoute(bestRoute);
       addBestRoute(x.tabuTracks);
       printBestRoute();
    }else{
    listOfBestRoute.clear();
    bestRoutes.clear();
    shortestPath = x.totalDistance();
    bestRoute = jalur+"EXIT";
    tambahBestRoute(bestRoute);
    addBestRoute(x.tabuTracks);
    printBestRoute();
    }
  }
}

void printBestRoute(){
  String txt = "";
  String saveTxt="";
  for(String s:listOfBestRoute){
    txt = txt +s +"\n";
  }
  saveTxt = "Rute Terpendek : \n"+txt+"\nTotal Jarak : "+shortestPath;
  cf.bestTextarea.setText(saveTxt);
}

void addBestRoute(ArrayList<Track> tabuTracks){
  bestRoutes.addAll(new ArrayList<Track>(tabuTracks));
}

void viewBestRoute(){
}

int searchForDuplicate(String txt){
  for(String val:listOfBestRoute){
    if(val.equals(txt)){
      return -99;
    }
  }
  return 0;
}

void tambahBestRoute(String txt){
  if(searchForDuplicate(txt)==0){
    listOfBestRoute.add(txt);
  }
}
