class Cell {
  boolean isVisited, onStack, isCurrent, containsPlayer;
  int x, y;
  boolean[] walls;
  ArrayList<Cell> neighbour;

  Cell(int tempX, int tempY)
  {
    x = tempX;
    y = tempY;
    walls = new boolean[]{true, true, true, true};
  }
}
