int numRows = 24;
int numCols = 24;
Square[][] squares;

float squareSize = 27;
float spacing = squareSize / 2;

int totalDuration = 600;
int frameCounter = 0;

int loop = 1;

void setup() {
  size(1080, 1080, P2D);
  frameRate(60);
  smooth(8);
  
  squares = new Square[numRows][numCols];

  float borderOffset = 2.25 * squareSize;

  int[][] activationOrder = generateWaveOrder();

  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      int activationFrame = int(map(activationOrder[row][col], 0, numRows * numCols, 0, totalDuration));
      squares[row][col] = new Square(row * (squareSize + spacing) + borderOffset, col * (squareSize + spacing) + borderOffset, squareSize, activationFrame);
    }
  }
}

void draw() {
   background(5);

   for (Square[] rowSquares : squares) {
     for (Square square : rowSquares) {
       if (frameCounter >= square.activationFrame) {
         square.moving = true;
       }
       square.update();
       square.show(); 
     }
   }

   frameCounter++;
   
   if (loop > 1) {
     //saveFrame("frames/frame-####.png");
   }
   
   if (frameCounter >= totalDuration) {
     frameCounter = 0;
     loop++;
     
     if (loop == 3) {
       //print("Finished");
       //noLoop();
     }
   }
}

int[][] generateWaveOrder() {
  int[][] order = new int[numRows][numCols];

  int centerRow = numRows / 2;
  int centerCol = numCols / 2;

  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      float dx = abs(col - centerCol);
      float dy = abs(row - centerRow);

      float curveFactor = sin(dx * 0.2) * dy * 0.5; 

      if (row < centerRow && col < centerCol) {
        // Top left quadrant
        order[row][col] = int(dy * 10 + dx * 5 + curveFactor);
      } else if (row < centerRow && col >= centerCol) {
        // Bottom left quadrant
        order[row][col] = int(dy * 10 + (numCols - dx) * 5 - curveFactor);
      } else if (row >= centerRow && col < centerCol) {
        // Top right quadrant
        order[row][col] = int((numRows - dy) * 10 + dx * 5 - curveFactor);
      } else {
        // Bottom right quadrant
        order[row][col] = int((numRows - dy) * 10 + (numCols - dx) * 5 + curveFactor);
      }
    }
  }

  return order;
}
