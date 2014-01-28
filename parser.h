# pragma once

# include <yaml-cpp/yaml.h>

namespace YAML
{
    template<>
    struct convert<SimData>{
        static Node encode(const SimData& sim){
            Node node;
            node["alpha"]   = sim.alpha;
            node["dt"]      = sim.dt;
            node["nsteps"]  = sim.nsteps;
            node["L_x"]     = sim.L_x;
            node["L_y"]     = sim.L_y;
            node["L_z"]     = sim.L_z;
            node["N_x"]     = sim.N_x;
            node["N_y"]     = sim.N_y;
            node["N_z"]     = sim.N_z;
            return node;
        }

        static bool decode(const Node& node, SimData& sim){
            sim.alpha     = node["nu"].as<double>();
            sim.dt        = node["dt"].as<double>();
            sim.nsteps    = node["nsteps"].as<double>();
            sim.L_x       = node["L_x"].as<double>();
            sim.L_y       = node["L_y"].as<double>();
            sim.L_z       = node["L_z"].as<double>();
            sim.N_x       = node["N_x"].as<int>();
            sim.N_y       = node["N_y"].as<int>();
            sim.N_z       = node["N_z"].as<int>();
           return true;
        }
    };
}
