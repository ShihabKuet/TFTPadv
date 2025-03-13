# Compiler and flags
ifeq ($(OS),Windows_NT)
    # For Windows (using MinGW or Cygwin)
    CC = g++
    CFLAGS = -Wall -Wextra -std=c++17 -g
    EXE_EXT = .exe
    TARGET = build/tftp-server$(EXE_EXT)
else
    # For Linux/macOS
    CC = g++
    CFLAGS = -Wall -Wextra -std=c++17 -g
    EXE_EXT =
    TARGET = build/tftp-server
endif

# Directories
SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build

# Source and object files
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))

# Build rule
all: $(TARGET)

$(TARGET): $(OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $@ $^

# Compile source files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# Clean build files
clean:
	rm -rf $(BUILD_DIR)

# Run the server
run: all
	$(TARGET)

# Debugging
debug: CFLAGS += -DDEBUG
debug: all

.PHONY: all clean run debug