package core.model;

import core.Player;

public aspect Journal {

    pointcut NewPoint():call(Grid.placeStone(..));

    after(int x, int y, Player player): NewPoint(x,y,player){
        
    }

}
