
class Pathfinder {

  boolean useManhattan = false;
  boolean useDiagonals = false;
  ArrayList<Tile> open = new ArrayList<Tile>(); // collection of tiles we can use to solve the algorithm
  ArrayList<Tile> closed = new ArrayList<Tile>(); // collection of tiles that we've ruled out as NOT part of the solution

  Pathfinder() {
  }

  ArrayList<Tile> findPath(Tile start, Tile end) {
    open.clear(); // empty array
    closed.clear(); // empty array

    start.resetParent(); // starting tile's "parent" property should be null

    // STEP 1:
    connectStartToEnd(start, end);

    // STEP 2: BUILD PATH BACK TO BEGINNING
    ArrayList<Tile> path = new ArrayList<Tile>();
    Tile pathNode = end;
    while (pathNode != null) {
      path.add(pathNode);
      pathNode = pathNode.parent;
    }

    // STEP 3: REVERSE THE COLLECTION:
    ArrayList<Tile> rev = new ArrayList<Tile>();
    int maxIndex = path.size() - 1;
    for (int i = maxIndex; i >= 0; i--) {
      rev.add(path.get(i));
    }
    if (debug) outputPath(rev);
    return rev;
  }
  void outputPath(ArrayList<Tile> path) {
    println("BEST PATH:");
    int i = 0;
    for (Tile t : path) {
      print("\t" + i + ": " + t.X + ", " + t.Y);
      if(i == 0) print(" (current location)");
      println(); 
      i++;
    }
  }
  void connectStartToEnd(Tile start, Tile end) {

    open.add(start);

    while (open.size () > 0) {
      ////// GET THE NODE IN open WITH LOWEST F VALUE:
      float F = 9999;
      int index = -1;

      for (int i = 0; i < open.size (); i++) {
        Tile temp = open.get(i);
        if (temp.F < F) {
          F = temp.F;
          index = i;
        }
      }

      Tile current = open.remove(index);
      closed.add(current);

      if (current == end) {
        // path found!
        break;
      }
      // LOOP THROUGH ALL OF current's NEIGHBORS:
      for (int i = 0; i < current.neighbors.size (); i++) {
        Tile neighbor = current.neighbors.get(i);
        if (!tileInArray(closed, neighbor)) {
          if (!tileInArray(open, neighbor)) {
            open.add(neighbor);
            neighbor.setParent(current);
            neighbor.doHeuristic(end, useManhattan);
          } else {
            if (neighbor.G > current.G + neighbor.getTerrainCost()) {
              neighbor.setParent(current);
              neighbor.doHeuristic(end, useManhattan);
            } // end if
          } // end else
        } // end if
      } // end for
    } // end while
  } // end method

  boolean tileInArray(ArrayList<Tile> a, Tile t) {
    for (int i = 0; i < a.size (); i++) {
      if (a.get(i) == t) return true;
    }
    return false;
  }
  /*
  int indexOfTile(ArrayList<Tile> a, Tile t) {
   for (int i = 0; i < a.size (); i++) {
   if (a.get(i) == t) return i;
   }
   return -1;
   }*/
  void toggleHeuristic() {
    useManhattan = !useManhattan;
  }
}

