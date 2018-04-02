package core.model;

import core.Player;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public aspect Journal {

    after(int x, int y, Player player): call(public void Grid.placeStone(int,int,Player)) && args(x,y,player){
        String fileName = "journalDeJeu.txt";
        BufferedWriter bufferedWriter = null;
        try {
            bufferedWriter = new BufferedWriter( new FileWriter(fileName, true));
            bufferedWriter.write(player.getName()+" joue à la position ("+x+","+y+").");
            bufferedWriter.newLine();
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
