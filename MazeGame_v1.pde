//player variables
Player player;

//maze variables
Cell[][] cells;
Cell currentCell;
ArrayList<Cell> cellsVisited = new ArrayList<Cell>();
int cellSize;
int noOfCells = 25;

void setup() {
  size(900, 900);
  smooth(4);
  strokeCap(ROUND);
  
  player = new Player("Player.png");

  //setting up the variables used for the maze generation
  cellSize = max(width/noOfCells, height/noOfCells);
  cells = new Cell[noOfCells][noOfCells];
  setupCells();
  setupNeighbours();
  currentCell = cells[0][0];
  cells[0][0].containsPlayer = true;
  cellsVisited.add(currentCell);

  mazeGen();
}

//sets up the base cell values for the maze
void setupCells() {
  for (int i = 0; i < noOfCells; i++) {
    for (int j = 0; j < noOfCells; j++) {
      cells[i][j] = new Cell(i, j);
    }
  }
}

//sets up the base neighbours for each cell
void setupNeighbours() {
  for (int i = 0; i < noOfCells; i++) {
    for (int j = 0; j < noOfCells; j++) {
      cells[i][j].neighbour = new ArrayList<Cell>();
      if (i>0) {
        cells[i][j].neighbour.add(cells[i-1][j]);
      }
      if (i<noOfCells-1) {
        cells[i][j].neighbour.add(cells[i+1][j]);
      }
      if (j>0) {
        cells[i][j].neighbour.add(cells[i][j-1]);
      }
      if (j<noOfCells-1) {
        cells[i][j].neighbour.add(cells[i][j+1]);
      }
    }
  }
}

//Generates a maze using randomised backtracking
void mazeGen() {
  while (cellsVisited.size() != 0) {
    if (cellsVisited.size() < noOfCells * noOfCells)
    {
      if (sidesCheck()) {
      Cell nextCell = choseNextCell();
      cellsVisited.add(currentCell);
      currentCell.onStack = true;

      if (nextCell.x - currentCell.x == 1) {
        currentCell.walls[1] = false;
        nextCell.walls[3] = false;
      } else if (nextCell.x - currentCell.x == -1) {
        currentCell.walls[3] = false;
        nextCell.walls[1] = false;
      } else if (nextCell.y - currentCell.y == 1) {
        currentCell.walls[2] = false;
        nextCell.walls[0] = false;
      } else {
        currentCell.walls[0] = false;
        nextCell.walls[2] = false;
      }
      currentCell.isCurrent = false;
      currentCell = nextCell;
      currentCell.isCurrent = true;
      currentCell.isVisited = true;
    } else if (cellsVisited.size()>0) {
      currentCell.isCurrent = false;
      currentCell = cellsVisited.remove(cellsVisited.size()-1);
      currentCell.onStack = false;
      currentCell.isCurrent = true;
    }
    }
  }
}

boolean sidesCheck() {
  for (int i = 0; i < currentCell.neighbour.size(); i++) {
    Cell tempCell = currentCell.neighbour.get(i);
    if (!tempCell.isVisited) return true;
  }
  return false;
}

Cell choseNextCell() {
  ArrayList<Cell> unvisitedCells = new ArrayList<Cell>();
  for (int i = 0; i < currentCell.neighbour.size(); i++) {
    Cell tempCell = currentCell.neighbour.get(i);
    if (tempCell.isVisited == false) unvisitedCells.add(tempCell);
  }
  return unvisitedCells.get(floor(random(unvisitedCells.size())));
}

void draw() {
  displayMaze();
}

//displays the maze using the cell scale
void displayMaze() {
  background(255);
  for (int i = 0; i < noOfCells; i++) {
    for (int j = 0; j < noOfCells; j++) {
      stroke(0);
      strokeWeight(1.5);
      if (cells[i][j].walls[0]) line(j*cellSize, i*cellSize, j*cellSize, (i+1)* cellSize);
      if (cells[i][j].walls[1]) line(j*cellSize, (i+1)*cellSize, (j+1)*cellSize, (i+1)*cellSize);
      if (cells[i][j].walls[2]) line((j+1)*cellSize, (i+1)*cellSize, (j+1)*cellSize, i*cellSize);
      if (cells[i][j].walls[3]) line((j+1)*cellSize, i*cellSize, j*cellSize, i*cellSize);
      if (cells[i][j].containsPlayer) player.Display(i, j);
    }
  }
}
//player movement
void keyReleased() {
  int pX, pY;
  int direction = 0;
  pX = int(player.Pos.x);
  pY = int(player.Pos.y);
  if (key == 'a' || key == 'A'){ pX -= 1;
  direction = 0;}
  if (key == 's' || key == 'S'){ pY += 1;
  direction = 1;}
  if (key == 'd' || key == 'D'){ pX += 1;
  direction = 2;}
  if (key == 'w' || key == 'W'){ pY -= 1;
  direction = 3;}
  player.Move(direction, pX, pY);
}
