package aima.core.environment.labyrinth;

import aima.core.agent.Action;
import aima.core.search.framework.problem.ActionsFunction;
import aima.core.search.framework.problem.ResultFunction;

import java.util.LinkedHashSet;
import java.util.Set;

public class LabyrinthFunctionFactory {

    private static ActionsFunction _actionsFunction = null;
    private static ResultFunction _resultFunction = null;

    public static ActionsFunction getActionsFunction() {
        if (null == _actionsFunction) {
            _actionsFunction = new LabActionsFunction();
        }
        return _actionsFunction;
    }

    public static ResultFunction getResultFunction() {
        if (null == _resultFunction) {
            _resultFunction = new LabResultFunction();
        }
        return _resultFunction;
    }

    private static class LabActionsFunction implements ActionsFunction {
        public Set<Action> actions(Object state) {
            LabyrinthBoard board = (LabyrinthBoard) state;

            Set<Action> actions = new LinkedHashSet<Action>();

            if (board.canMove(LabyrinthBoard.LEFT)) {
                actions.add(LabyrinthBoard.LEFT);
            }
            if (board.canMove(LabyrinthBoard.RIGHT)) {
                actions.add(LabyrinthBoard.RIGHT);
            }
            if (board.canMove(LabyrinthBoard.UP)) {
                actions.add(LabyrinthBoard.UP);
            }
            if (board.canMove(LabyrinthBoard.DOWN)) {
                actions.add(LabyrinthBoard.DOWN);
            }
            return actions;
        }
    }

    private static class LabResultFunction implements ResultFunction {
        public Object result(Object s, Action a) {
            LabyrinthBoard board = (LabyrinthBoard) s;
            if (LabyrinthBoard.RIGHT.equals(a)
                    && board.canMove(LabyrinthBoard.RIGHT)) {
                LabyrinthBoard newBoard = new LabyrinthBoard(board);
                newBoard.moveRight();
                return newBoard;
            } else if (LabyrinthBoard.LEFT.equals(a)
                    && board.canMove(LabyrinthBoard.LEFT)) {
                LabyrinthBoard newBoard = new LabyrinthBoard(board);
                newBoard.moveLeft();
                return newBoard;
            } else if (LabyrinthBoard.UP.equals(a)
                    && board.canMove(LabyrinthBoard.UP)) {
                LabyrinthBoard newBoard = new LabyrinthBoard(board);
                newBoard.moveUp();
                return newBoard;
            } else if (LabyrinthBoard.DOWN.equals(a)
                    && board.canMove(LabyrinthBoard.DOWN)) {
                LabyrinthBoard newBoard = new LabyrinthBoard(board);
                newBoard.moveDown();
                return newBoard;
            }
            // The Action is not understood or is a NoOp
            // the result will be the current state.
            return s;
        }
    }
}