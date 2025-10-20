package bataille;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.SwingConstants;

/**
 * Programme proposant une interface graphique (Graphical User Interface) pour le jeu de bataille.
 * Utilise un répertoire "images" contenant  les faces des cartes.
 */
public class BattaileGUI {

    static final String PATH_TO_IMAGES = "images/";

    Bataille bataille;

    JFrame frameJeuDeBataille;
    JLabel commentaire;
    JLabel carteJoueurGaucheLabel;
    JLabel carteJoueurDroiteLabel;
    JButton btnJouer;
    JButton btnRemporter;

    BattaileGUI(String nomGauche, String nomDroite) {
        bataille = new Bataille(nomGauche, nomDroite);
        // A laisser ici, permet d'initialiser l'Interface
        // utilise nomGauche et nomDroite
        initFrame();
    }

    /**
     * affiche dans l'interface graphique une carte jouée par un joueur
     * 
     * @param joueur la place du joueur qui a joué la carte
     * @param carte la carte jouée par le joueur
     */
    void afficheCarteJoueur(PlaceJoueur joueur, Carte carte) {
        // A compléter
        String fileName;
        fileName = PATH_TO_IMAGES + carte.getNomFichierImage();
        switch (joueur) {
            case GAUCHE:
                carteJoueurGaucheLabel.setIcon(new ImageIcon(fileName));
                break;
            case DROITE:
                carteJoueurDroiteLabel.setIcon(new ImageIcon(fileName));
                break;
            default:
                break;
        }
    }

    /**
     * Action effectuée quand l'utilisateur clique sur le bouton jouer.
     * 
     * - une carte tirée au hasard est distribuée à chacun des joueurs, chacun des joueurs joue sa
     * carte.
     * 
     * - l'image de ces cartes dans l'interface graphique ainsi que leur nom.
     * 
     * Après cette action, le bouton Jouer est désactivé et le bouton Remporter est activé.
     */
    void jouer() {
        try {
            bataille.distribue();
            bataille.jouerUnTour();
            afficheCarteJoueur(PlaceJoueur.GAUCHE, bataille.carteGauche);
            afficheCarteJoueur(PlaceJoueur.DROITE, bataille.carteDroite);
            String comment = "" + bataille.joueurGauche.getNom() + " joue un(e) "
                    + bataille.carteGauche.getNom();
            comment += "   " + bataille.joueurDroite.getNom() + " joue un(e) "
                    + bataille.carteDroite.getNom();
            commentaire.setText(comment);
            btnRemporter.setEnabled(true);
            btnJouer.setEnabled(false);
        } catch (JoueurException e) {
            // ne devrait jamais arriver
            e.printStackTrace();
            System.exit(0);
        }
    }

    /**
     * Action associée au bouton Remporter qui permet de savoir quel joueur a remporté le pli.
     * 
     * Après cette action, le bouton jouer est activé et le bouton remporter est désactivé.
     */
    void remporter() {
        // A compléter
        String comment = "";
        Joueur remporte = bataille.gagnant();
        if (remporte == null) {
            comment = "Bataille ! on rejoue...";
        } else {
            comment = "C'est le joueur " + remporte.getNom() + " qui remporte le pli.";
            carteJoueurGaucheLabel.setIcon(null);
            carteJoueurDroiteLabel.setIcon(null);
        }
        commentaire.setText(comment);
        btnRemporter.setEnabled(false);
        btnJouer.setEnabled(true);
    }

    /**
     * initialise la fenêtre graphique et les différents composants qu'elle contient.
     */
    void initFrame() {
        String nomGauche = bataille.joueurGauche.getNom();
        String nomDroite = bataille.joueurDroite.getNom();
        frameJeuDeBataille = new JFrame();
        frameJeuDeBataille.getContentPane().setMinimumSize(new Dimension(1000, 550));
        frameJeuDeBataille.getContentPane().setPreferredSize(new Dimension(1000, 550));
        frameJeuDeBataille.setTitle("Jeu de Bataille");
        frameJeuDeBataille.getContentPane().setBackground(new Color(0, 100, 0));
        frameJeuDeBataille.getContentPane()
                .setLayout(new BoxLayout(frameJeuDeBataille.getContentPane(), BoxLayout.Y_AXIS));
        JPanel joueursPanel = new JPanel();
        frameJeuDeBataille.getContentPane().add(joueursPanel);
        joueursPanel.setLayout(new BoxLayout(joueursPanel, BoxLayout.X_AXIS));
        JPanel joueur1Panel = new JPanel();
        joueur1Panel.setBackground(new Color(100, 149, 237));
        joueursPanel.add(joueur1Panel);
        joueur1Panel.setLayout(new BoxLayout(joueur1Panel, BoxLayout.Y_AXIS));
        JLabel labelJoueur1 = new JLabel(nomGauche);
        labelJoueur1.setHorizontalAlignment(SwingConstants.CENTER);
        joueur1Panel.add(labelJoueur1);
        JPanel joueur1CartesPanel = new JPanel();
        joueur1CartesPanel.setPreferredSize(new Dimension(500, 400));
        joueur1CartesPanel.setMinimumSize(new Dimension(500, 400));
        joueur1CartesPanel.setBackground(new Color(0, 100, 0));
        joueur1Panel.add(joueur1CartesPanel);
        joueur1CartesPanel.setLayout(new GridLayout(1, 0, 20, 0));
        JLabel tasJoueurGaucheLabel = new JLabel();
        tasJoueurGaucheLabel.setHorizontalAlignment(SwingConstants.CENTER);
        tasJoueurGaucheLabel.setPreferredSize(new Dimension(240, 360));
        tasJoueurGaucheLabel.setMaximumSize(new Dimension(240, 360));
        tasJoueurGaucheLabel.setMinimumSize(new Dimension(240, 360));
        tasJoueurGaucheLabel.setIcon(new ImageIcon(PATH_TO_IMAGES + "dos-de-carte.png"));
        joueur1CartesPanel.add(tasJoueurGaucheLabel);
        carteJoueurGaucheLabel = new JLabel();
        carteJoueurGaucheLabel.setHorizontalAlignment(SwingConstants.CENTER);
        carteJoueurGaucheLabel.setPreferredSize(new Dimension(240, 360));
        carteJoueurGaucheLabel.setMaximumSize(new Dimension(240, 360));
        carteJoueurGaucheLabel.setMinimumSize(new Dimension(240, 360));
        joueur1CartesPanel.add(carteJoueurGaucheLabel);
        JPanel joueur2Panel = new JPanel();
        joueur2Panel.setBackground(new Color(245, 222, 179));
        joueursPanel.add(joueur2Panel);
        joueur2Panel.setLayout(new BoxLayout(joueur2Panel, BoxLayout.Y_AXIS));
        JLabel labelJoueur2 = new JLabel(nomDroite);
        labelJoueur2.setHorizontalAlignment(SwingConstants.CENTER);
        joueur2Panel.add(labelJoueur2);
        JPanel joueur2CartesPanel = new JPanel();
        joueur2CartesPanel.setPreferredSize(new Dimension(500, 400));
        joueur2CartesPanel.setMinimumSize(new Dimension(500, 400));
        joueur2CartesPanel.setBackground(new Color(0, 100, 0));
        joueur2Panel.add(joueur2CartesPanel);
        joueur2CartesPanel.setLayout(new GridLayout(1, 0, 20, 0));
        carteJoueurDroiteLabel = new JLabel();
        carteJoueurDroiteLabel.setHorizontalAlignment(SwingConstants.CENTER);
        carteJoueurDroiteLabel.setPreferredSize(new Dimension(240, 360));
        carteJoueurDroiteLabel.setMaximumSize(new Dimension(240, 360));
        carteJoueurDroiteLabel.setMinimumSize(new Dimension(240, 360));
        joueur2CartesPanel.add(carteJoueurDroiteLabel);
        JLabel tasJoueurDroiteLabel = new JLabel();
        tasJoueurDroiteLabel.setHorizontalAlignment(SwingConstants.CENTER);
        tasJoueurDroiteLabel.setPreferredSize(new Dimension(240, 360));
        tasJoueurDroiteLabel.setMaximumSize(new Dimension(240, 360));
        tasJoueurDroiteLabel.setMinimumSize(new Dimension(240, 360));
        tasJoueurDroiteLabel.setIcon(new ImageIcon(PATH_TO_IMAGES + "dos-de-carte.png"));
        joueur2CartesPanel.add(tasJoueurDroiteLabel);
        JPanel commentairePanel = new JPanel();
        commentairePanel.setBackground(new Color(0, 100, 0));
        frameJeuDeBataille.getContentPane().add(commentairePanel);
        commentairePanel.setLayout(new BoxLayout(commentairePanel, BoxLayout.X_AXIS));
        commentaire = new JLabel("Commentaire");
        commentairePanel.add(commentaire);
        JPanel boutonsPanel = new JPanel();
        frameJeuDeBataille.getContentPane().add(boutonsPanel);
        boutonsPanel.setLayout(new BoxLayout(boutonsPanel, BoxLayout.X_AXIS));
        btnJouer = new JButton("Jouer");
        btnJouer.setEnabled(true);
        btnJouer.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                jouer();
            }
        });
        boutonsPanel.add(btnJouer);
        btnRemporter = new JButton("Remporter");
        btnRemporter.setEnabled(false);
        btnRemporter.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                remporter();
            }
        });
        boutonsPanel.add(btnRemporter);
        commentaire.setForeground(new Color(255, 255, 240));
        commentaire.setHorizontalAlignment(SwingConstants.CENTER);
        frameJeuDeBataille.setBounds(100, 100, 1054, 490);
        frameJeuDeBataille.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {

            public void run() {
                try {
                    BattaileGUI window = new BattaileGUI("Anna Tomie", "Guy de Michelin");
                    window.frameJeuDeBataille.setVisible(true);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

}
