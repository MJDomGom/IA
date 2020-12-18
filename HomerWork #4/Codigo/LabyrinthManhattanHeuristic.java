package aima.core.environment.labyrinth;

import aima.core.search.framework.Node;
import aima.core.search.framework.evalfunc.EvaluationFunction;
import aima.core.search.framework.evalfunc.HeuristicFunction;

public class LabyrinthManhattanHeuristic implements HeuristicFunction, EvaluationFunction {
    @Override
    public double h(Object state) {
        LabyrinthBoard labyrinth = (LabyrinthBoard) state;
        LabyrinthGoalTest goal = new LabyrinthGoalTest();
        if(labyrinth.isK()){
            return Math.abs(goal.getCoordG()[0] - labyrinth.getRow() + goal.getCoordG()[1] - labyrinth.getColum());
        }else{
            return Math.abs(goal.getCoordK()[0] - labyrinth.getRow() + goal.getCoordK()[1] - labyrinth.getColum());
        }
    }

    @Override
    public double f(Node n) {
        LabyrinthBoard labyrinth = (LabyrinthBoard) n.getState();
        LabyrinthGoalTest goal = new LabyrinthGoalTest();
        if(labyrinth.isK()){
            return Math.abs(goal.getCoordG()[0] - labyrinth.getRow() + goal.getCoordG()[1] - labyrinth.getColum());
        }else{
            return Math.abs(goal.getCoordK()[0] - labyrinth.getRow() + goal.getCoordK()[1] - labyrinth.getColum());
        }    }
}
