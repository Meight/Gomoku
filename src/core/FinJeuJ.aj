package core;

import core.model.Grid;
import core.model.Spot;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;
import java.util.ArrayList;
import java.util.List;

privileged public aspect FinJeuJ {

    private Boolean gameOver = false;
    private List<Spot> winningStonesAsp = new ArrayList<>(0);
    private GraphicsContext gc = null;

    public List<Spot> Grid.getWin(){
        return this.winningStones;
    }

    pointcut callDrawStone(GraphicsContext gc, Spot p) : call(void drawStone(GraphicsContext, Spot)) && args(gc, p);

    after(GraphicsContext gc, Spot p) : callDrawStone(gc, p) {
        this.gc = gc;
    }

    after(Grid grid) : call (void notifyGameOver(Player)) && target (grid) && within(Grid){
        winningStonesAsp = grid.getWin();
    }

    after(Player winner) : call(void notifyGameOver(Player)) && args(winner) {
        double spotSize = 20;
        this.gameOver = true;
        for (Spot stone : this.winningStonesAsp) {
            this.gc.setFill(Color.YELLOW);
            double x = spotSize + stone.x * spotSize; // center x
            double y = spotSize + stone.y * spotSize; // center y
            double r = spotSize / 2; // radius
            this.gc.fillOval(x - r, y - r, r * 2, r * 2);
        }
    }

    void around(int x, int y, Player player) : call(void placeStone(int, int, Player)) && args(x, y, player) {
        if(!gameOver) {
            proceed(x,y,player);
        }

    }

}
