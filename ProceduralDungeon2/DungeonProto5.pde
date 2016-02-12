
// create a "path" class
// be able to split apart the tree

Dungeon d;

void setup() {
  size(800, 600);
  generateDungeon();
  
}
void draw() {
  background(0);
  d.draw();
}
void generateDungeon(){
  d = new Dungeon();
}

void mousePressed(){
  generateDungeon();
}
