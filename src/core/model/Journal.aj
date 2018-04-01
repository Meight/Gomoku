package core.model;

import core.Player;

public aspect Journal {

    after(int x, int y, Player player): call(public void Grid.placeStone(int,int,Player)) && args(x,y,player){
        System.out.println("X : " + x);
        System.out.println("Y : " + y);
        System.out.println("Player : " + player.getName());
    }

}
