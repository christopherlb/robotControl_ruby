# About
Implement the robot control toy problem, specifically in Ruby.


# How to use the app


```shell
bundle install
rspec
ruby app/main.rb
```

## Commands

You can type or pipe commands via stdin. Commands need to be separated with a newline. They are not case sensitive.

| Command | Action                                         |
|---------|------------------------------------------------|
| quit    | Exits the application                          |
| report  | Outputs the robot's <x,y,orientation>          |
| place   | Forcibly places the robot at <x,y,orientation> | 
| move    | Advance the robot one square, per orientation  |

# Development philosophy

- Iterative development, with a feature breadth first approach
- TDD as we go
- Emergent design
- KISS
- Assume the service will not grow significantly in complexity

# Task

## Instruction:
write code to solve the problem below as this was production code, putting as much effort and care as you would for production code, no less, no more.

We need instruction on how to run what you provide, but do not expect a docker image or anything related to infrastructure. For example:

require Ruby 3.0 or later

install dependencies with XXXX

run with “ruby my_code.rb”


# Problem:
The application is a simulation of a robot moving on a 6x6 square grid.

There are no obstructions on the grid.

The robot needs to be prevented from exceeding the limits of the grid, but is allowed to move freely on the grid otherwise.

Create a command-line application that reads in the following commands:

PLACE X, Y, O

MOVE

LEFT

RIGHT

REPORT



The PLACE X, Y, O will place the robot at position X, Y on the grid, with orientation O. Orientations are N, E, S, W (for North, East, South and West). Position (0,0) on the grid is the south west corner. First coordinate is along the East/West axis, the second coordinate is along the North/South axis.


MOVE will move the robot one step forward, in whichever direction it is currently facing



LEFT and RIGHT respectfully turn the robot 90° angle to the left or to the right.

REPORT announces the position and orientation of the robot (X, Y, O) in any format (such as standard out)



# Constraints
Commands are to be ignored until a valid PLACE command is issued

Any commands that would put the robot out of the defined grid is to be ignored, all other commands (including another PLACE) are to be obeyed



# Example
## One
PLACE 0,0,E
MOVE
REPORT
Output: 1,0,E

### Two

PLACE 0,0,N
MOVE
MOVE
RIGHT
MOVE
REPORT
Output: 1,2,E