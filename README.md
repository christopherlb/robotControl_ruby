# About
Implement the robot control toy problem, specifically in Ruby.


# How to use the app

Tested on Ruby 3.4.4, other versions may work, providing tests pass.

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
| left    | Rotate the robot 90* anticlockwise             |
| right   | Rotate the robot 90* clockwise                 |

# Development 

## Philosophy

- Iterative development, with a feature breadth first approach
- TDD as we go
- Emergent design
- KISS
- Assume the service will not grow significantly in complexity
- Make sensible choices for ambiguous functionality, providing it can be easily corrected if wrong 
(eg assume report does not quit, so we need an explicit quit command)

## Design

Nothing in the requirements prompted a complex multi-class structure, or hinted that this would be advantageous in the
near future. As such, the design revolves around a single `RobotApp` class that encapsules all game rules, IO validation
and state. The handling of commands is pulled out into separate methods to enable readability.

A thin IO wrapper `IoProxy` is used to separate the console, allowing for clean mocking (and to account that there is
the slight possibility of a near future swap of IO from STDIN etc hinted at in the requirement)s.

Accordingly testing is split into a lower level set of specs in `spec/robot_app_spec.rb`, which primarily focuses on 
the specific responsibilities of each command, and `spec/scenarios_spec.rb` which presents and asserts the output 
after command sequences, primarily looking at complexity.

## Future direction

Depending on what new requirements occur, consider:

- Commands as first class classes to allow many more commands
- Command pattern to allow undo-ability with a stack. We might want to rewrite PLACE using a sequence 
of move commands so it can be reversed.
- Allow more separators beyond \n or complex (json or xml) input formats
- Log invalid commands
- Separate game state and rules to better encapsulate fundamental restrictions from convenience 
(eg robot cannot go out of bounds vs move goes one square)
- Refactor tests to allow better discoverability

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

## Two

PLACE 0,0,N
MOVE
MOVE
RIGHT
MOVE
REPORT
Output: 1,2,E