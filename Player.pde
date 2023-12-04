class Player {
  PImage playerSprite;
  PVector Pos = new PVector(0, 0);

  Player(String spriteName) {
    playerSprite = loadImage(spriteName);
  }

  void Move(int direction, int newX, int newY) {
    if (newX < noOfCells && newX >= 0 && newY < noOfCells && newY >= 0) {
      if (checkWalls(direction, int(newX), int(newY))) {
        cells[int(player.Pos.x)][int(player.Pos.y)].containsPlayer = false;
        Pos = new PVector(newX, newY, 0);
        cells[int(player.Pos.x)][int(player.Pos.y)].containsPlayer = true;
      }
    }
  }

  void Display(int x, int y) {
    image(player.playerSprite, (x * cellSize) + (cellSize / 2.75), (y * cellSize) + (cellSize / 2.75));
  }

  boolean checkWalls(int direction, int pX, int pY) {
    int oppDirection = 0;
    if (direction < 2) oppDirection = direction + 2;
    if (direction > 1) oppDirection = direction - 2;
    if (cells[int(player.Pos.y)][int(player.Pos.x)].walls[direction] || cells[pY][pX].walls[oppDirection]) {
      return false;
    }
    return true;
  }
}
