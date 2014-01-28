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
    void write(char* fname);
    SimData& sim;

private:
    void make_FD_stencil();    
    FDStencilIterator       FD_stencil;
};
