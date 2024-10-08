GTKWAVE:= which gtkwave
TARGET := shift
CXX := g++
LD := $(CXX) 
C_FLAGS := -I/home/louis/systemc-3.0.0/include -O0 -g3 -Wall -c
LD_OPTIONS = -L/home/louis/systemc-3.0.0/lib-linux64 -o $(TARGET)
LIBS := -lsystemc
C_SOURCES = $(shell ls *.cc)
C_SOURCES += nand/nand.cc
C_SOURCES += not/notgate.cc
C_OBJS := $(patsubst %.cc, %.o, $(C_SOURCES))

%.o:%.cc
	@echo 'Building file: $(@F)'
	@echo '--------------------'
	@echo 'Invoking: GNU CPP Compiler'
	echo $(C_FLAGS)
	$(CXX) $(C_FLAGS) $< -o $@
	@echo 'Finished building: $(@F)'
	@echo ' '

all:$(TARGET) 

$(TARGET): $(C_OBJS)
	#echo $(C_SOURCES)
	#echo $(C_OBJS)
	@echo 'building binary $(@F)'
	$(LD) $(LD_OPTIONS) $(C_OBJS) $(LIBS)

prerequisites: 
ifneq ('$(GTKWAVE)', "/usr/bin/gtkwave")
	@echo $(GTKWAVE)
	@echo 'installing gtkwave, please be patient'
	sudo apt-get install -y gtkwave
endif

run:$(TARGET)
	./$(TARGET) 
	gtkwave -c 4 vcd_trace.vcd

clean:
	rm -f $(TARGET) *.o nand/*.o not/*.o vcd_trace.vcd
.PHONY: $(TARGET)
