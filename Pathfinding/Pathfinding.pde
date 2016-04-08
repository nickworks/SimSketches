boolean debug = false;
Level level;
Player player;
Pathfinder pathfinder;

void setup() {
  size(320, 320);
  TileHelper.app = this;
  level = new Level();
  player = new Player();
  pathfinder = new Pathfinder();
}
void draw() {
  // UPDATE:
  player.update();

  // DRAW:
  background(TileHelper.isHex ? 0 : 127);
  level.draw();
  player.draw();

  Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
  Tile tile = level.getTile(g);
  tile.hover = true;
  PVector m = tile.getCenter();
  fill(0, 0, 0);
  ellipse(m.x, m.y, 8, 8);


  // DRAW DEBUG INFO:
  fill(255, 255, 0);
  String s1 = (pathfinder.useManhattan) ? "(h) heuristic: manhattan" : "(h) heuristic: euclidian";
  String s2 = (level.useDiagonals) ? "(d) diagonals: yes" : "(d) diagonals: no";
  String s3 = (TileHelper.isHex) ? "(g) grid: hex" : "(g) grid: square";
  String s4 = (debug) ? "(`) debug: on" : "(`) debug: off";
  text(s1, 10, 15);
  text(s2, 10, 30);
  text(s3, 10, 45);
  text(s4, 10, 60);
}

void mousePressed() {
  player.setTargetPosition(TileHelper.pixelToGrid(new PVector(mouseX, mouseY)));
}
void keyPressed() {
  if (debug) println(keyCode);


  if (keyCode == 49) level.loadLevel(LevelDefs.LEVEL1);
  if (keyCode == 50) level.loadLevel(LevelDefs.LEVEL2);
  if (keyCode == 51) level.loadLevel(LevelDefs.LEVEL3);
  if (keyCode == 52) level.loadLevel(LevelDefs.LEVEL4);
  if (keyCode == 53) level.loadLevel(LevelDefs.LEVEL5);

  if (keyCode == 68) {
    level.toggleDiagonals();
    level.reloadLevel();
  }
  if (keyCode == 71) {
    TileHelper.isHex = !TileHelper.isHex;
    level.reloadLevel();
  }
  if (keyCode == 72) pathfinder.toggleHeuristic();
  if (keyCode == 192) debug = !debug;
}

