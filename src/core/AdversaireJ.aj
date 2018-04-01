package core;

import javafx.scene.paint.Color;

public aspect AdversaireJ {

    private Player blue = new Player("Mr. bleu", Color.BLUE);

    private Player red = new Player("Mr. rouge", Color.RED);

    private boolean player = false;

    Player around() : call(Player getCurrentPlayer()) {
        if (!player) {
            player = true;
            return blue;
        } else {
            player = false;
            return red;
        }
    }

}
