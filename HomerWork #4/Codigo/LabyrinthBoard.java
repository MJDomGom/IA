package aima.core.environment.labyrinth;

import aima.core.agent.Action;
import aima.core.agent.impl.DynamicAction;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Arrays;
import java.util.Objects;
import java.util.Scanner;

public class LabyrinthBoard {

    public static Action LEFT = new DynamicAction("Left");
    public static Action RIGHT = new DynamicAction("Right");
    public static Action UP = new DynamicAction("Up");
    public static Action DOWN = new DynamicAction("Down");
    private char[][] state;
    private int row;
    private int colum;
    private boolean G = false;
    private boolean K = false;
    private static String FILENAME = "Labyrinth.txt";


    public LabyrinthBoard() {
        state = readTXT(FILENAME);
        for(int i = 0; i<state.length;i++){
            for(int j = 0; j< state[i].length;j++){
                if(state[i][j] == 'S'){
                    this.row = i;
                    this.colum = j;
                }
            }
        }
    }

    public LabyrinthBoard(int x, int y,boolean g,boolean k) {
        this.state = readTXT(FILENAME);
        this.row = x;
        this.colum = y;
        this.G = g;
        this.K = k;
    }

    public LabyrinthBoard(boolean g,boolean k) {
        this.G = g;
        this.K = k;
    }

    public LabyrinthBoard(LabyrinthBoard copyBoard) {
        this(copyBoard.getRow(), copyBoard.getColum(), copyBoard.isG(), copyBoard.isK());
    }

    public int getColum() {
        return colum;
    }

    public void setColum(int colum) {
        this.colum = colum;
    }

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public char[][] getState() {
        return state;
    }

    public void setState(char[][] state) {
        this.state = state;
    }

    public boolean isG() {
        return G;
    }

    public void setG(boolean g) {
        G = g;
    }

    public boolean isK() {
        return K;
    }

    public void setK(boolean k) {
        K = k;
    }

    public void moveRight() {
        this.colum++;
        if(!isK()){
            if(state[getRow()][getColum()]=='K'){
                this.K = true;
            }
        }
        if(isK() && state[getRow()][getColum()] == 'G'){
            this.G = true;
        }
    }

    public void moveLeft() {

        this.colum--;
        if(!isK()){
            if(state[getRow()][getColum()]=='K'){
                this.K = true;
            }
        }
        if(isK() && state[getRow()][getColum()] == 'G'){
            this.G = true;
        }
    }

    public void moveDown() {

        this.row++;
        if(!isK()){
            if(state[getRow()][getColum()]=='K'){
                this.K = true;
            }
        }
        if(isK() && state[getRow()][getColum()] == 'G'){
            this.G = true;
        }
    }

    public void moveUp() {

        this.row--;
        if(!isK()){
            if(state[getRow()][getColum()]=='K'){
                this.K = true;
            }
        }

        if(isK() && state[getRow()][getColum()] == 'G'){
                this.G = true;
        }
    }

    public boolean canMove(Action where) {
        boolean retVal = true;
        if (where.equals(LEFT)) {
            retVal = ((getColum()!=0) && (state[getRow()][getColum()-1]!='%'));
        } else if (where.equals(RIGHT)) {
            retVal = ((getColum()!= state.length-1) && (state[getRow()][getColum()+1] != '%'));
        } else if (where.equals(UP)) {
            retVal = ((getRow()!= 0) && (state[getRow()-1][getColum()] != '%'));
        } else if (where.equals(DOWN)) {
            retVal = ((getRow()!= state.length-1) && (state[getRow()+1][getColum()] != '%'));
        }
        return retVal;
    }


    public static char[][] readTXT(String file){
        int wid;
        String line = null;
        char[][] row = null;

        try{
            String path = System.getProperty("user.dir");
            FileReader fileReader = new FileReader(path + "\\src\\main\\java\\aima\\core\\environment\\labyrinth\\"+ file);
            BufferedReader buffer = new BufferedReader(fileReader);
            Scanner scan = new Scanner(buffer);

            if(scan.hasNextLine()){
                line = scan.nextLine();
                wid = line.length();
                row = new char[wid][wid];

                for(int i =0; i<wid;i++){
                    row[0][i] = line.charAt(i);
                }

                while(scan.hasNextLine()){
                    for(int i = 1; i<wid;i++){
                        line = scan.nextLine();
                        for(int j = 0; j<wid;j++){
                            row[i][j] = line.charAt(j);
                        }
                    }
                }
                scan.close();
            }
        }catch (FileNotFoundException ex){
            System.err.println("No se puede abrir el archivo: "+file);
        }
        return row;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        LabyrinthBoard that = (LabyrinthBoard) o;
        return row == that.row &&
                colum == that.colum &&
                G == that.G &&
                K == that.K;
    }

    @Override
    public int hashCode() {
        return Objects.hash(row, colum, G, K);
    }

    @Override
    public String toString() {
        return "LabyrinthBoard{" +
                "row=" + row +
                ", colum=" + colum +
                ", G=" + G +
                ", K=" + K +
                '}';
    }
}