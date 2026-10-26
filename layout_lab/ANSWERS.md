Name: Muhammad Ilyas
Roll Number: 04072313012

A1: 28
A2: 7
A3: 3
A4: 66

B1:
Stateless classes: LabApp, HomePage, SettingsCard, SummaryRow, Probe, Welcome, InfoPanel, ShareRow, InfoBox, and StampStack. These widgets do not keep changing internal state.

Stateful classes: Clock, Tile, and SwapBoard. Clock changes its seconds and build count, Tile changes its tap count, and SwapBoard changes the order of the tiles.

B2:
A Widget is rebuilt when setState causes the UI to rebuild. The Element is usually kept and reused at the same position in the widget tree, and the RenderObject is also usually kept unless the layout or rendering structure requires it to change.

The Probe showed that the Widget identity changed on rebuilds, while the Element identity stayed the same. It also showed that the BuildContext belonged to Probe and that a Scaffold existed above it in the tree.

B3:
In Step 7, the Row gave horizontal constraints to its children. The long Text widgets wanted more width than was available, which caused overflow. After wrapping the Text widgets in Expanded, the Row gave each child a limited share of the available width. Each Text then chose its size within those constraints and wrapped onto multiple lines. This demonstrates that constraints go down from parent to child, and sizes go up from child to parent.