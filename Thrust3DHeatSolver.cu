# include <thrust/device_vector.h>
# include <thrust/host_vector.h>
# include <thrust/iterator/counting_iterator.h>
# include <thrust/iterator/zip_iterator.h>
# include <thrust/tuple.h>

# include <Thrust3DHeatSolver.h>

Thrust3DHeatSolver::Thrust3DHeatSolver(SimData& _sim):sim(_sim){};
void Thrust3DHeatSolver::initialise(){
    make_FD_stencil();
}

void Thrust3DHeatSolver::make_FD_stencil(){

    thrust::device_vector<double>::iterator start = sim.temp_d.begin()+
                                                    sim.N_x*sim.N_y;
    thrust::counting_iterator<int> count;
    FD_stencil =    thrust::make_zip_iterator(
                    thrust::make_tuple(
                        start,
                        thrust::make_zip_iterator(thrust::make_tuple(
                        start-1, 
                        start+1)),
                        thrust::make_zip_iterator(thrust::make_tuple(
                        start-sim.N_y, 
                        start+sim.N_y)),
                        thrust::make_zip_iterator(thrust::make_tuple(
                        start-sim.N_y*sim.N_x, 
                        start+sim.N_x*sim.N_y)),
                        count));
}
