local Width = 10, Height = 7;
local CurGrid = []; CurGrid.resize(Width*Height);

function GetCell(Grid, X, Y) {
  if(X >= Width) X = 0;
  if(X < 0) X = Width-1;
  if(Y >= Height) Y = 0;
  if(Y < 0) Y = Height-1;
  return Grid[Y*Width+X];
}
function ShowGrid() {
  local CurX, CurY;
  for(CurY=0;CurY<Height;CurY++) {
    for(CurX=0;CurX<Width;CurX++)
      print(CurGrid[CurY*Width+CurX]?"@":".");
    print("\n");
  }
  print("\n");
}

function CalcGrid() {
  local OldGrid=clone CurGrid;
  local CurX, CurY;
  for(CurY=0;CurY<Height;CurY++) {
    for(CurX=0;CurX<Width;CurX++) {
      local Neighbors = 0;
      Neighbors += GetCell(OldGrid, CurX,   CurY-1);
      Neighbors += GetCell(OldGrid, CurX+1, CurY-1);
      Neighbors += GetCell(OldGrid, CurX+1, CurY);
      Neighbors += GetCell(OldGrid, CurX+1, CurY+1);
      Neighbors += GetCell(OldGrid, CurX,   CurY+1);
      Neighbors += GetCell(OldGrid, CurX-1, CurY+1);
      Neighbors += GetCell(OldGrid, CurX-1, CurY);
      Neighbors += GetCell(OldGrid, CurX-1, CurY-1);
      if(CurGrid[CurY*Width+CurX]) {
        if(Neighbors != 2 && Neighbors != 3)
          CurGrid[CurY*Width+CurX] = 0;
      } else {
        if(Neighbors == 3)
          CurGrid[CurY*Width+CurX] = 1;
      }
    }
  }
}

function InitGrid() {
  srand(time());
  local CurX, CurY;
  for(CurY=0;CurY<Height;CurY++)
    for(CurX=0;CurX<Width;CurX++)
      CurGrid[CurY*Width+CurX] = 0; //rand()&1;

  CurGrid[0*Width+1] = 1;
  CurGrid[1*Width+2] = 1;
  CurGrid[2*Width+2] = 1;
  CurGrid[2*Width+1] = 1;
  CurGrid[2*Width+0] = 1;
}

InitGrid();

local i;
for(i=0;i<12;i++) {
  ShowGrid();
  CalcGrid();
}
