// Ant Colony Optimization

int algoACO(ArrayList<Integer> possibleTrack){
  /* didalam possible track ada index dari track yang mungkin di lewati semut*/
  ArrayList<Float> prob = new ArrayList<Float>(); //menampung nilai probabilitas tiap track
  
  Track curr;
  float T,n,total,p,roullete ;
  
  //
  String jarak="0";
  String Prob="0";
  String formula="";
  //
  
  total = 0;
  
  /* total distance*/
  for (int t : possibleTrack){
     curr = Tracks.get(t);
     T = (float)curr.pheromone;
     n = 1/curr.distance;
     total = total+T*n;
     jarak = jarak+"+"+T+"x"+"1/"+curr.distance;
     
  }
  
  /*probabilitas masing" track*/
  for (int t : possibleTrack){
     curr = Tracks.get(t);
     println(curr.label);
     T = (float)curr.pheromone;
     n = 1/curr.distance;
     p = T*n/total;
     prob.add(p);
     Prob = T+"x"+1+"/"+curr.distance;
     formula = "("+Prob+")/"+jarak+"="+p;
     println(formula);
  }
  
 
  
  roullete = RoulleteWheel(prob);
  int count = 0;
  for (float t:prob){
    if(t==roullete){
      return count;
    }
    count ++;
  }
  
  return -99;
}

//Roullete wheel
float RoulleteWheel(ArrayList<Float> prob){
  //
  String rolet="";
  //
  
  ArrayList<Float> temp = new ArrayList<Float>(); //copy dari prob untuk roulette wheel
  ArrayList<Float> cumSum = new ArrayList<Float>();
  float rand;
  
  temp = prob; //copy prob ke temp
  Comparator c = Collections.reverseOrder();
  Collections.sort(temp,c); //sorting value prob
  
  for(float f:temp){
    print(f+"|");
  }
  println("");
  
  int i=0;
  float cum = 1;
  rolet = rolet+cum+"|";
  
  cumSum.add(parseFloat(1));
  
  for(i=0;i<temp.size();i++){
    cum = cum-temp.get(i);
    rolet = rolet+cum+"|";
    cumSum.add(cum);
  }
  
  print(rolet);
  println("");
  
  rand = random(0.001,1);
  
  println("nilai random : "+rand);
  
  for(i=0;i<cumSum.size()-1;i++){
    if(rand<=cumSum.get(i) && rand>=cumSum.get(i+1)){
      return temp.get(i);
    }
  }
  
  return -99;
}

//update feromon
void updatePheromone(ArrayList<Track> tabuTracks,float totalDistance){
  Track temp;
  int idx=-99;
  for(Track t:tabuTracks){
   idx = searchTrack(t);
   temp=Tracks.get(idx);
   temp.pheromone = (1-rho)*temp.pheromone + 1/totalDistance + temp.pheromone;
   for(int x: searchTrack(t.label)){
     Tracks.get(x).pheromone = Math.round(temp.pheromone*100)/100.0d; //pembulatan jumlah feromone supaya digit tidak terlalu panjang
   }
   
  }
}
