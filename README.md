# Visualize-Kruskal-2023
I created this project in 2023 for my high school data structure class to visualize the Kruskal algorithm, which finds the minimum spanning tree. I developed this visualizer to be user-friendly, with a focus on clarity in what is being displayed. Some features included: mouse position-dependent viewpoint, perspective projection, and a smooth UI, and more.

On the implementation level, the logic is not a direct implementation of Kruskal`s algorithm. To highlight detected cycles when adding edges, I used DFS instead of Union-Find for simplicity.

## How to Use
- Run `main.pde` in Processing.
- Generate nodes with a left-click.
- Delete nodes by clicking and holding on an existing node.
- Generate edges by selecting two nodes with a click.
- Press `m` to activate `Move Mode.`
  - In `Move Mode,` you can change the positions of nodes by dragging them.
  - Press `g` to deactivate `Move Mode.`
- Press `i` to initialize Kruskal.
  - During this process, edges are sorted by their length, and information windows appear.
- Press `u` to run one step of the Kruskal algorithm.

## Video Demo
[![Video Label](https://github.com/user-attachments/assets/f82f9579-b238-45dc-9412-872a23c877e5)](https://youtu.be/YBwCSuN6ejI)
