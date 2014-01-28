# pragma once

# include <thrust/host_vector.h>
# include <thrust/device_vector.h>

class SimData{

public:
    thrust::host_vector<double>   temp_h;
    thrust::device_vector<double> temp_d;

    double   L_x, L_y, L_z,
             alpha, dt, dx, dy, dz;

    int     N_x, N_y, N_z,
            nsteps;
};

