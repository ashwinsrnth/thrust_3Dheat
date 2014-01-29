# include <SimData.h>
# include <initialise_data.h>
# include <Thrust3DHeatSolver.h>
# include <read_data.h>
# include <sys/time.h>


int main(){

    SimData sim = read_data("../params.yml");
    
    initialise_data(sim);

    Thrust3DHeatSolver* solver = 
        new Thrust3DHeatSolver(sim);

    solver->initialise();

    struct timeval t1, t2;
    double elapsedtime;

    for(int i=0; i<sim.nsteps; i++){
        solver->take_step();

    gettimeofday(&t2, NULL);
    elapsedtime = (t2.tv_usec - t1.tv_usec);
    printf("Temperature update loop took: %f\n microseconds", elapsedtime);
    }

    solver->close();
    solver->write("../output.dat");
    
    return 0;
}