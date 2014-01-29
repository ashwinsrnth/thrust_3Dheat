# include <thrust/fill.h>
# include <initialise_data.h>
# include <SimData.h>

void initialise_data(SimData& sim){
    
    sim.dx = sim.L_x/sim.N_x;
    sim.dy = sim.L_y/sim.N_y;
    sim.dz = sim.L_z/sim.N_z;
    
    // Fill host memory and then copy to device
    sim.temp_h.resize(sim.N_x*sim.N_y*sim.N_z);
    sim.temp_d.resize(sim.N_x*sim.N_y*sim.N_z);
    
    init_temp(thrust::raw_pointer_cast(sim.temp_h.data()),
                                       sim.N_x, sim.N_y, sim.N_z);

    // Copy to device
    sim.temp_d = sim.temp_h;
}

void init_temp(double *M, int N_x, int N_y, int N_z){

    int i, j, k;

    for (i=0; i<N_x; i++){
        for (j=0; j<N_y; j++){
            for (k=0; k<N_z; k++){

                int i3d = k*(N_x*N_y) + j*(N_x) + i;

                if (i == 0 || j == 0 || k == 0){
                    M[i3d] = 10.0;
                }

                else if (i == (N_x-1) || j == (N_y-1) || k == (N_z - 1)){
                    M[i3d] = 10.0;
                }

                else{
                    M[i3d] = 20.0;
                }
        }
    }
}
}
