# include <read_data.h>
# include <yaml-cpp/yaml.h>
# include <parser.h>

SimData read_data(const char* file_name){
    YAML::Node doc = YAML::LoadFile(file_name);
    SimData sim = doc.as<SimData>();
    return sim;
}