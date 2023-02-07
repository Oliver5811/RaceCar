import java.util.*;  

class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser
  
  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();
  ArrayList<CarController> Dead = new ArrayList<CarController>();
  int populationSize = 0;
  int generation = 1;
  int bestScore = 0;
  int bestScoreThisGeneration = 0;
  int time = 0;
  int fastestTime = 0;

  CarSystem(int populationSize) {
    this.populationSize = populationSize;
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController();
      CarControllerList.add(controller);
    }
  }

  void updateAndDisplay() {
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {
      controller.update();
      if (controller.isDead) {
        Dead.add(controller);
      }
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController controller : CarControllerList) {
      controller.display();
      
      if (controller.sensorSystem.score > bestScoreThisGeneration){
        bestScoreThisGeneration = controller.sensorSystem.score;
      }
       //get time for fastest car
      time = controller.sensorSystem.lapTimeInFrames;
      if (fastestTime == 0){
        fastestTime = time;
      } else if (time < fastestTime && controller.sensorSystem.score > 2){
        fastestTime = time;
      }
    
    }
   
  
    CarControllerList.removeAll(Dead);
    Dead.clear();
  }

  void newGeneration(){

    // sort by score
    Collections.sort(CarControllerList, new Comparator<CarController>() {
      @Override
      public int compare(CarController o1, CarController o2) {
        return o1.sensorSystem.score - o2.sensorSystem.score;
      }
    });
    
    // reverse list
    Collections.reverse(CarControllerList);

    // filter out the ones with score 0
    for (int i=0; i<CarControllerList.size(); i++) {
      if (CarControllerList.get(i).sensorSystem.score == 0) {
        Dead.add(CarControllerList.get(i));
      }
    }
    CarControllerList.removeAll(Dead);

    // Get the best score
    if (CarControllerList.get(0).sensorSystem.score > bestScore){
      bestScore = CarControllerList.get(0).sensorSystem.score;
    }

    // Get the best 2's weights and biases
    float[] weights1 = CarControllerList.get(0).hjerne.weights;
    float[] weights2 = CarControllerList.get(1).hjerne.weights;
    float[] biases1 = CarControllerList.get(0).hjerne.biases;
    float[] biases2 = CarControllerList.get(1).hjerne.biases;

    // Clear the list
    CarControllerList.clear();
    for (int i=0; i<populationSize; i++) {
      CarController controller = new CarController();

        int mutationRate = (int)random(0, 100);
        if (mutationRate < 5){
          // Mutate the weights
          // Pick a random from 0 to 1
          int number = (int)random(0, 2);
          for (int j=0; j<controller.hjerne.weights.length; j++) {
            if (number == 0) {
              controller.hjerne.weights[j] = weights1[j];
            } else {
              controller.hjerne.weights[j] = weights2[j];
            }
            controller.hjerne.weights[j] += random(-0.1, 0.1);
          }

          // Mutate the biases
          for (int j=0; j<controller.hjerne.biases.length; j++) {
            if (number == 0) {
              controller.hjerne.biases[j] = biases1[j];
            } else {
              controller.hjerne.biases[j] = biases2[j];
            }
            controller.hjerne.biases[j] += random(-0.1, 0.1);
          }
        } else {
          // Copy the weights
          // Pick a random from 0 to 1
          int number = (int)random(0, 2);
          for (int j=0; j<controller.hjerne.weights.length; j++) {
            if (number == 0) {
              controller.hjerne.weights[j] = weights1[j];
            } else {
              controller.hjerne.weights[j] = weights2[j];
            }
          }

          // Copy the biases
          for (int j=0; j<controller.hjerne.biases.length; j++) {
            if (number == 0) {
              controller.hjerne.biases[j] = biases1[j];
            } else {
              controller.hjerne.biases[j] = biases2[j];
            }
          }
        }

      CarControllerList.add(controller);
    }
    generation++;

    bestScoreThisGeneration = 0;

  }
}
