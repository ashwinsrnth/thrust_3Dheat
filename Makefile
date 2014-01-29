INC_DIR=src/include
SRC_DIR=src
OBJ_DIR=obj
BIN_DIR=bin

THRUST_DIR=home/ashwin/workspace/cuda/thrust
LIBS=/usr/local/lib/libyaml-cpp.a

CC=nvcc
CFLAGS=-I . -I $(INC_DIR) -I $(THRUST_DIR)

_OBJ=read_data.o initialise_data.o Thrust3DHeatSolver.o main.o
OBJ = $(patsubst %,$(OBJ_DIR)/%,$(_OBJ))

thrust_3Dheat: $(OBJ)
	$(CC) $^ -o $(BIN_DIR)/$@ $(LIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cu $(INC_DIR)/*.h
	$(CC) -c -o $@ $< $(CFLAGS)
