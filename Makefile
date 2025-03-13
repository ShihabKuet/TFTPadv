# Compiler and flags
CC = g++
CFLAGS = -Wall -Wextra -std=c++17 -g
EXE_EXT = .exe
TARGET = build/tftp-server$(EXE_EXT)

# Directories
SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build

# Source and object files
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))

# Cross-platform mkdir command
ifeq ($(OS),Windows_NT)
    MKDIR = if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)
    RM = del /Q
else
    MKDIR = mkdir -p
    RM = rm -rf
endif

# Build rule
all: $(TARGET)

$(TARGET): $(OBJS)
	$(MKDIR)
	$(CC) $(CFLAGS) -o $@ $^

# Compile source files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(MKDIR)
	$(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# Clean build files
clean:
	$(RM) $(BUILD_DIR)

# Run the server
run: all
	$(TARGET)

# Debugging
debug: CFLAGS += -DDEBUG
debug: all

.PHONY: all clean run debug
