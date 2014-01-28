# include <SimData.h>
# include <initialise_data.h>
# include <Thrust3DHeatSolver.h>
# include <read_data.h>

int main(){

    SimData sim = read_data("params.yml");
    
    initialise_data(sim);

    Thrust3DHeatSolver* solver = 
        new Thrust3DHeatSolver(sim);

    solver->initialise();

    for(int i=0; i<sim.nsteps; i++){
        solver->take_step();
    }

    solver->close();
    solver->write("output.dat");
    
    return 0;
}