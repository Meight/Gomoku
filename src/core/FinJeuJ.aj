package core;

import core.model.Spot;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;

import java.util.ArrayList;
import java.util.List;

public aspect FinJeuJ {

    private Boolean gameOver = false;
    private List<Spot> winningStones = new ArrayList<>(0);
    private GraphicsContext gc = null;

    pointcut setWinningStonesPointcut(List<Spot> newValue) : set(List<Spot> Grid.winningStones) && args(newValue);

    pointcut callDrawStone(GraphicsContext gc, Spot p) : call(void drawStone(GraphicsContext, Spot)) && args(gc, p);

    after(GraphicsContext gc, Spot p) : callDrawStone(gc, p) {
        this.gc = gc;
    }

    after(List<Spot> newValue) : setWinningStonesPointcut(newValue) {
        this.winningStones = newValue;
    }

    after(Player winner) : call(void notifyGameOver(Player)) && args(winner) {
        double spotSize = 20;
        this.gameOver = true;
        for (Spot stone : this.winningStones) {
            this.gc.setFill(Color.YELLOW);
            double x = spotSize + stone.x * spotSize; // center x
            double y = spotSize + stone.y * spotSize; // center y
            double r = spotSize / 2; // radius
            this.gc.fillOval(x - r, y - r, r * 2, r * 2);
        }
    }

    void around(int x, int y, Player player) : call(void placeStone(int, int, Player)) && args(x, y, player) {
        if(gameOver) {
            System.out.println("FIN DU JEU");
        } else {
            proceed(x,y,player);
        }

    }

}
