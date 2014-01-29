# include <thrust/device_vector.h>
# include <thrust/host_vector.h>
# include <thrust/iterator/counting_iterator.h>
# include <thrust/iterator/zip_iterator.h>
# include <thrust/tuple.h>
# include <thrust/for_each.h>

# include <Thrust3DHeatSolver.h>
# include <temperature_update_functor.h>
# include <printmatrix.h>


Thrust3DHeatSolver::Thrust3DHeatSolver(SimData& _sim):sim(_sim){};
void Thrust3DHeatSolver::initialise(){
    make_FD_stencil();
}





void Thrust3DHeatSolver::make_FD_stencil(){

    /*  Create a zip_iterator for 7-pt stencils
     * 
     *  Dereferencing a `zip_iterator` yields a `tuple`.
     *  Here we use nested `zip_iterator`s to
     *  iterate over `tuple`s that look like this:
     *
     *      <p(ijk), 
     *      <p(i-1,j,k), p(i+1,j,k)>,
     *      <p(i,j-1,k), p(i,j+1,k)>,
     *      <p(i,j,k-1), p(i,j,k+1)>,
     *      ix>
     *
     *  Where p(i,j,k) is the compute point.
     *  Also, note that ix is just the flattened index
     *
     *  `for_each` iterates over the stencils and the
     *  dereferencing and computation is done by the 
     *  `temperature update functor`.
     */


    // First point:
    thrust::device_vector<double>::iterator start = sim.temp_d.begin()+
                                                    sim.N_x*sim.N_y;
    thrust::counting_iterator<int> count(0);

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

void Thrust3DHeatSolver::take_step(){

    // Apply temperature update functor to each point
    // in grid:
    thrust::for_each(FD_stencil, 
                     FD_stencil+(sim.N_x*sim.N_y*(sim.N_z-2)-1), 
                     temperature_update_functor(sim.alpha, 
                     sim.dx, sim.dy, sim.dz, sim.dt,
                     sim.N_x, sim.N_y));
}


void Thrust3DHeatSolver::close(){
    // copy back to host:
    sim.temp_h = sim.temp_d;
}

void Thrust3DHeatSolver::write(char* fname){
    write_to_file(thrust::raw_pointer_cast(sim.temp_h.data()),
                  sim.N_x*sim.N_y*sim.N_z, 
                  fname);
}