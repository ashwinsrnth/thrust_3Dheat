# include <SimData.h>
# include <initialise_vectors.h>
# include <Thrust3DHeatSolver.h>
# include <read_data.h>

int main(){

    SimData sim = read_data("params.yml");
    
    initialise_vectors(sim);

    Thrust3DHeatSolver* solver = 
        new Thrust3DHeatSolver(sim);

    solver->initialise();
    
}