# pragma once
# include <SimData.h>

struct temperature_update_functor{



public:
    temperature_update_functor( double _alpha, double _dx, double _dy,   
                                double _dz, double _dt, int _N_x, int _N_y): 
                                alpha(_alpha), dx(_dx), dy(_dy), dz(_dz), dt(_dt), N_x(_N_x), N_y(_N_y){}

    template <typename Tuple>
    __host__ __device__
    void operator () (Tuple T){

        /* TODO: move this outside functor! */
        int     I, ix, iy;
        
        I = thrust::get<4>(T);
        ix= I%(N_x * N_y)%N_x;
        iy= I%(N_x * N_y)/N_x;

        if (((ix%(N_x-1))!=0) && ((ix%(N_x))!=0) &&
            ((iy%(N_y-1))!=0) && ((iy%(N_y))!=0)){

            thrust::get<0>(T) +=    (alpha*dt)*(

                (   thrust::get<0>(thrust::get<1>(T)) 
                -   2.0*thrust::get<0>(T)
                +   thrust::get<1>(thrust::get<1>(T)))/(dx*dx)
                +
                (   thrust::get<0>(thrust::get<2>(T))
                -   2.0*thrust::get<0>(T)
                +   thrust::get<1>(thrust::get<2>(T)))/(dy*dy)
                +
                (   thrust::get<0>(thrust::get<3>(T))
                -   2.0*thrust::get<0>(T)
                +   thrust::get<1>(thrust::get<3>(T)))/(dz*dz));
        }
    }

    private:
        double alpha, dt, dx, dy, dz;
        int N_x, N_y, N_z;
};  