//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


import de.bezier.guido.*;
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 24;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void setup ()
{
    size(553, 420);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here 
    buttons = new MSButton[NUM_ROWS][NUM_COLS];

    for ( int r = 0; r < NUM_ROWS; r++)
    {
        for ( int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }

    for ( int i = 0; i < 60; i++)    
        setBombs();
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


public void setBombs()
{
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    
    if (!bombs.contains(buttons[row][col]))
    {
       bombs.add(buttons[row][col]);
    }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


public void draw ()
{
    background( 0 );

    if ( isWon() == true )
    {
        displayWinningMessage();
        noLoop();
    }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


public boolean isWon()
{
    //your code here
    return false;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


public void displayLosingMessage()
{
    //your code here
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


public void displayWinningMessage()
{
    buttons[9][3].setLabel("C");
    buttons[9][3].setLabel("O");
    buttons[9][3].setLabel("N");
    buttons[9][3].setLabel("G");
    buttons[9][3].setLabel("R");
    buttons[9][3].setLabel("A");
    buttons[9][3].setLabel("T");
    buttons[9][3].setLabel("U");
    buttons[9][3].setLabel("L");
    buttons[9][3].setLabel("A");
    buttons[9][3].setLabel("T");
    buttons[9][3].setLabel("I");
    buttons[9][3].setLabel("O");
    buttons[9][3].setLabel("N");
    buttons[9][3].setLabel("S");
    buttons[9][3].setLabel("!");
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


public class MSButton
{
    private int r, c, numRed, numGreen, numBlue;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    

    public MSButton ( int rr, int cc )
    {
        width = 560/NUM_COLS;
        height = 420/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        numRed = 0;
        numGreen = 0;
        numBlue = 0;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }


    public boolean isMarked()
    {
        return marked;
    }


    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    

    public void mousePressed () 
    {
        clicked = true;

        if (keyPressed == true)
        {
            if(marked == false)
                marked = true;

            else
            {
                clicked = false;
                marked = false;
            } 
        }

        else if (bombs.contains(this))
        {
            displayLosingMessage();
        }

        else if(!bombs.contains(this) && countBombs(r, c) > 0)
        {
            if (countBombs(r,c) == 1)
            {
                numRed = 0;
                numGreen = 0; 
                numBlue = 170;
            }
            if (countBombs(r,c) == 2)
            {
                numRed = 0;
                numGreen = 110; 
                numBlue = 0;
            }
            if (countBombs(r,c) == 3)
            {
                numRed = 170;
                numGreen = 0; 
                numBlue = 0;
            }
            if (countBombs(r,c) == 4)
            {
                numRed = 120;
                numGreen = 0; 
                numBlue = 255;
            }
            if (countBombs(r,c) == 5)
            {
                numRed = 0;
                numGreen = 120; 
                numBlue = 255;
            }
            if (countBombs(r,c) == 6)
            {
                numRed = 144;
                numGreen = 255; 
                numBlue = 0;
            }
            if (countBombs(r,c) == 7)
            {
                numRed = 255;
                numGreen = 50; 
                numBlue = 55;
            }

            this.setLabel("" + countBombs(r,c));
        }
        
        else
        {
            if(isValid(r-1, c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();

            if(isValid(r, c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();

            if(isValid(r, c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();

            if(isValid(r+1, c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();

            if(isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked())
                buttons[r-1][c-1].mousePressed();

            if(isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked())
                buttons[r+1][c-1].mousePressed();

            if(isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked())
                buttons[r-1][c+1].mousePressed();

            if(isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked())
                buttons[r+1][c+1].mousePressed();
        } 
    }


    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 120 );

        rect(x, y, width, height);
        fill(numRed, numGreen, numBlue);
        textSize(14);
        text(label,x+width/2,y+height/2);
    }


    public void setLabel(String newLabel)
    {
        label = newLabel;
    }

    public void setColor(int r, int g, int b)
    {
        numRed = r;
        numGreen = g;
        numBlue = b;
    }


    public boolean isValid(int r, int c)
    {
        if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
            return true;

        else
            return false;
    }


    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row, col+1) == true && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if (isValid(row, col-1) == true && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if (isValid(row+1, col) == true && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if (isValid(row-1, col) == true && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if (isValid(row+1, col+1) == true && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if (isValid(row+1, col-1) == true && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if (isValid(row-1, col+1) == true && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if (isValid(row-1, col-1) == true && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
           
        return numBombs;
    }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////