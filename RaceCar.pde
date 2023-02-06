//Number of ai cars in the simulation
int       populationSize  = 100;    

// Time in frames that the simulation runs for
int       simulationTime  = 2000;

//Holds all the cars in the simulation
CarSystem carSystem       = new CarSystem(populationSize);

PImage track1;


void setup() {
    size(1920, 1080);
    track1 = loadImage("track1.png");
    textSize(25);
}

void draw() {
    clear();
    fill(255);
    rect(0, 50, 1000, 1000);
    image(track1, 0, 0); 

    carSystem.updateAndDisplay();
    simulationTime--;

    if (simulationTime == 0) {
        carSystem.newGeneration();
        simulationTime = 2000;
    }
    fill(0);
    text("Generation: " + carSystem.generation, 100, 100);
    text("Population Size: " + carSystem.CarControllerList.size(), 100, 200);
    text("Best Score: " + carSystem.bestScore, 100, 150);
    text("Best Score This Generation: " + carSystem.bestScoreThisGeneration, 100, 250);
    text("Fastest lap: " + carSystem.fastestTime, 100, 300);
    
    

}