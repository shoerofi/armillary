# Air Seat Placement
This is a Ruby on Rails API program for Air Seat Placement.

API with an endpoint that helps seat audiences in a flight based on the following input and rules.

Rules for seating:

- Always seat passengers starting from the front row to back, starting from the left to the right
- Fill aisle seats first followed by window seats followed by center seats (any order in center seats)

Input:

- a 2D array that represents the rows and columns e.g: [[3,4], [4,5], [2,3], [3,4]]. This 2D array is just an example. The input to the program will be a dynamic 2D array.
- The number of passengers waiting in the queue.

Output:

- Idx(sitting group): the position of sitting group on a plane. represented by integer starting from 0(left side)..X(right side).
- Positions: this is a sitting position referenced by sitting group

Installation:

- Install the lates ruby 2.6.3
- run Bundle command
- run rails db:create db:migrate
- run rails server

Api-Doc and Testing:

- api-doc and testing: navigate to /api-docs
- details api documentation: /api-docs/v1/swagger.json
