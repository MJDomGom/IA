package aima.core.environment.labyrinth;
import aima.core.search.framework.problem.GoalTest;


public class LabyrinthGoalTest implements GoalTest {
	char[][] labyrinth = new LabyrinthBoard().readTXT("Labyrinth.txt");
	int[] coordG = searchG(labyrinth);
	int[] coordK = searchK(labyrinth);
	LabyrinthBoard goalG = new LabyrinthBoard(coordG[0],coordG[1],true,true);


	public boolean isGoalState(Object state) {
		LabyrinthBoard board = (LabyrinthBoard) state;
		return board.equals(goalG);
}

	public int[] searchG(char[][] labyrinth){
		int[] coords = new int[2];
		for (int i = 0; i < labyrinth.length; i++) {
			for (int j = 0; j < labyrinth[i].length; j++) {
				if(labyrinth[i][j]=='G'){
					coords[0] = i;
					coords[1] = j;
				}
			}
		}
		return coords;
	}

	public int[] searchK(char[][] labyrinth){
		int[] coords = new int[2];
		for (int i = 0; i < labyrinth.length; i++) {
			for (int j = 0; j < labyrinth[i].length; j++) {
				if(labyrinth[i][j]=='K'){
					coords[0] = i;
					coords[1] = j;
				}
			}
		}
		return coords;
	}

	public int[] getCoordG() {
		return coordG;
	}

	public int[] getCoordK() {
		return coordK;
	}
}