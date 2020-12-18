package aima.gui.demo.search;

import aima.core.agent.Action;
import aima.core.environment.labyrinth.LabyrinthBoard;
import aima.core.environment.labyrinth.LabyrinthFunctionFactory;
import aima.core.environment.labyrinth.LabyrinthGoalTest;
import aima.core.environment.labyrinth.LabyrinthManhattanHeuristic;
import aima.core.search.framework.SearchAgent;
import aima.core.search.framework.problem.Problem;
import aima.core.search.framework.qsearch.GraphSearch;
import aima.core.search.informed.AStarSearch;
import aima.core.search.informed.GreedyBestFirstSearch;
import aima.core.search.uninformed.BreadthFirstSearch;
import aima.core.search.uninformed.DepthFirstSearch;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

public class LabyrinthDemo {

    static LabyrinthBoard boardInicial = new LabyrinthBoard();
    public static int row;
    public static int colum;
    private static char[][] labyrinth = boardInicial.getState();

    public static void main(String[] args) {
        LabyrinthBreadthDemo();
        cleanLab();
        LabyrinthDepthGraphDemo();
        cleanLab();
        LabyrinthAStarDemo();
        cleanLab();
        LabyrinthGreedyDemo();
    }

    public static void cleanLab(){
        boardInicial = null;
        boardInicial = new LabyrinthBoard();
        labyrinth = boardInicial.getState();
        row = boardInicial.getRow();
        colum = boardInicial.getColum();
    }

    private static void LabyrinthBreadthDemo() {
        System.out.println("\nLabyrinth Demo breadth -->");
        try {
            Problem problem = new Problem(boardInicial, LabyrinthFunctionFactory.getActionsFunction(), LabyrinthFunctionFactory.getResultFunction(), new LabyrinthGoalTest());
            BreadthFirstSearch search = new BreadthFirstSearch();
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ArrayList<Action> actions = (ArrayList<Action>) agent.getActions();
            boardInicial = printPointLab(actions);
            printSolLabyrinth();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static void LabyrinthDepthGraphDemo() {
        System.out.println("\nLabyrinth Demo depth graph -->");
        try {
            Problem problem = new Problem(boardInicial, LabyrinthFunctionFactory.getActionsFunction(), LabyrinthFunctionFactory.getResultFunction(), new LabyrinthGoalTest());
            DepthFirstSearch search = new DepthFirstSearch(new GraphSearch());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ArrayList<Action> actions = (ArrayList<Action>) agent.getActions();
            boardInicial = printPointLab(actions);
            printSolLabyrinth();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static void LabyrinthAStarDemo() {
        System.out.println("\nLabyrinth A* -->");
        try {
            Problem problem = new Problem(boardInicial, LabyrinthFunctionFactory.getActionsFunction(), LabyrinthFunctionFactory.getResultFunction(), new LabyrinthGoalTest());
            AStarSearch search = new AStarSearch(new GraphSearch(),new LabyrinthManhattanHeuristic());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ArrayList<Action> actions = (ArrayList<Action>) agent.getActions();
            boardInicial = printPointLab(actions);
            printSolLabyrinth();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static void LabyrinthGreedyDemo() {
        System.out.println("\nLabyrinth Greedy Best First -->");
        try {
            Problem problem = new Problem(boardInicial, LabyrinthFunctionFactory.getActionsFunction(), LabyrinthFunctionFactory.getResultFunction(), new LabyrinthGoalTest());
            GreedyBestFirstSearch search = new GreedyBestFirstSearch(new GraphSearch(),new LabyrinthManhattanHeuristic());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ArrayList<Action> actions = (ArrayList<Action>) agent.getActions();
            boardInicial = printPointLab(actions);
            printSolLabyrinth();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static void printInstrumentation(Properties properties) {
        Iterator<Object> keys = properties.keySet().iterator();
        while (keys.hasNext()) {
            String key = (String) keys.next();
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }

    }

    private static void printActions(List<Action> actions) {
        for (int i = 0; i < actions.size(); i++) {
            String action = actions.get(i).toString();
            System.out.println(action);
        }
    }

    public static LabyrinthBoard printPointLab(List<Action> actions){
        for(int i =0; i<actions.size();i++){
            if(actions.get(i).toString().equals("Action[name==Up]")){
                labyrinth[boardInicial.getRow()-1][boardInicial.getColum()] = '.';
                boardInicial.setRow(boardInicial.getRow()-1);
            }else if(actions.get(i).toString().equals("Action[name==Down]")){
                labyrinth[boardInicial.getRow()+1][boardInicial.getColum()] = '.';
                boardInicial.setRow(boardInicial.getRow()+1);
            }else if(actions.get(i).toString().equals("Action[name==Left]")){
                labyrinth[boardInicial.getRow()][boardInicial.getColum()-1] = '.';
                boardInicial.setColum(boardInicial.getColum()-1);
            }else{
                labyrinth[boardInicial.getRow()][boardInicial.getColum()+1] = '.';
                boardInicial.setColum(boardInicial.getColum()+1);
            }
        }
        row = boardInicial.getRow();
        colum = boardInicial.getColum();

        return boardInicial;
    }

    public static void printSolLabyrinth(){
        System.out.println();

        for(int i = 0; i < labyrinth.length; i++)
        {
            for(int j = 0; j < labyrinth[i].length; j++)
            {
                System.out.printf("|%c|\t", labyrinth[i][j]);
            }
            System.out.println();
        }
    }
}