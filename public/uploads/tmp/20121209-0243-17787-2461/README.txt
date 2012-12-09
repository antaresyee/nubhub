ECE356 Lab 3: README
Andrew Shim
December 5, 2012

-----------------------------------------------------------
1. INSTRUCTIONS FOR RUNNING
-----------------------------------------------------------
Extract all executable code from Part1_executable.jar.
Contents should contain:
    - Dijkstra
    - Link
    - Main
    - Network
    - Path
    - Router

These names correspond to the actual java source code files.
Some of these classes contain inner classes and this should
be reflected in the contents of the .jar file.

Run following command in the directory with extracted files: "java Main"

Observe the output.


-----------------------------------------------------------
2. PROGRAM OUTPUT
-----------------------------------------------------------
Shortest path to A: [Path: O - A]; Cost: 2
Shortest path to B: [Path: O - A - B]; Cost: 4
Shortest path to C: [Path: O - C]; Cost: 4
Shortest path to D: [Path: O - A - B - D]; Cost: 8
Shortest path to E: [Path: O - A - B - E]; Cost: 7
Shortest path to F: [Path: O - A - F]; Cost: 14
Shortest path to T: [Path: O - A - B - D - T]; Cost: 13


-----------------------------------------------------------
3. RESOURCES
-----------------------------------------------------------
- Lecture slides: 4-network.ppt
- Memory from other CS courses: Remembered to use a priority queue
- Java documentation: To remember how to implement a Comparator


