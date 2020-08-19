// Ant Colony Optimization

int ACO(ArrayList<Integer> possibleTrack){
  ArrayList<Float> prob = new ArrayList<Float>(); //menampung nilai probabilitas tiap track
  ArrayList<Float> temp = new ArrayList<Float>(); //copy dari prob untuk roulette wheel
  Track curr;
  float T,n,total,p ;
  total = 0;
  
  
  for (int t : possibleTrack){
     curr = Tracks.get(t);
     T = curr.pheromone;
     n = 1/curr.distance;
     total = total+T*n;
  }
  
  for (int t : possibleTrack){
     curr = Tracks.get(t);
     T = curr.pheromone;
     n = 1/curr.distance;
     p = T*n/total;
     prob.add(p);
  }
  
  temp = prob; //copy prob ke temp
  Collections.sort(temp); //sorting value prob
  
  
  return 0;
}


//Roullete wheel
