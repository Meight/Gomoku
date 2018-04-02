package core;

import javafx.scene.paint.Color;

public aspect AdversaireJ {

    private Player green_player = new Player("Green player", Color.GREEN);

    private Player blue_player = new Player("Blue Player", Color.BLUE);

    private boolean player = false;

    Player around() : call(Player getCurrentPlayer()) {
        if (!player) {
            player = true;
            return green_player;
        } else {
            player = false;
            return blue_player;
        }
    }

}
