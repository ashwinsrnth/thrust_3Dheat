# pragma once

# include <SimData.h>
# include <detail.h>
# include <tiled.h>

class Thrust3DHeatSolver
{
public:
    Thrust3DHeatSolver(SimData&);
    void initialise();
    void take_step();
    void close();
    bool finished();
    
    SimData& sim;

private:
    void make_FD_stencil();
    void temperature_update_functor();

    FDStencilIterator       FD_stencil;
};
