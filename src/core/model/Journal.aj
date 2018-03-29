package core.model;

import core.Player;

public aspect Journal {

    pointcut NewPoint(int x, int y, Player player):
            call(public void Grid.placeStone(int x, int y, Player player));

    after(int x, int y, Player player): NewPoint(x,y,player){
        System.out.println("PLACING ASPECT");
    }

}
