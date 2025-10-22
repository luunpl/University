/*
 * @author : Yvan Maillot (yvan.maillot@uha.fr)
 */
package edu.uha.miage;

/**
 * Une classe horaire pour gérer des horaires (heures, minutes, secondes).
 *
 * Les horaires appartiennent à l'un des deux formats 24h ou 12h
 *
 * Le format 24h signifie que les heures sont dans [0, 23] Le format 12h
 * signifie que les heures sont dans [0, 11]
 *
 * La responsabilité de cette classe est de garantir un horaire cohérent,
 *
 * c'est-à-dire
 *
 * 1. dont les secondes sont dans [0, 59]
 *
 * 2. dont les minutes sont dans [0, 59]
 *
 * 2. dont les heures sont dans [0, 11] au format 12h ou dans [0,23] au format
 * 24h
 *
 * @author yvan
 */
public class Horaire {

    /**
     * Construit un nouvel horaire à partir des arguments.
     *
     * @param h24 vrai => format 24h, faux => format 12h
     *
     * @param h les heures de cet horaire. Si h n'est pas dans l'intervalle
     * requis, il est considéré égal à 0.
     *
     * @param m les minutes de cet horaire. Si m n'est pas dans [0, 59], il est
     * considéré égal à 0.
     *
     * @param s les secondes de cet horaire. Si s n'est pas dans [0, 59], il est
     * considéré égal à 0.
     */

    public Horaire(boolean h24, int h, int m, int s) {
    // TODO 1.02. Écrire ce constructeur
    }

    /**
     * Construit un nouvel horaire à partir des arguments (les secondes sont
     * nulles).
     *
     * @param h24 vrai => format 24h, faux => format 12h
     *
     * @param h les heures de cet horaire. Si h n'est pas dans l'intervalle
     * requis, il est considéré égal à 0.
     *
     * @param m les minutes de cet horaire. Si m n'est pas dans [0, 59], il est
     * considéré égal à 0.
     */
    public Horaire(boolean h24, int h, int m) {
    // TODO 1.03. Écrire ce constructeur
    }

    /**
     * Construit un nouvel horaire à partir des arguments (les secondes et les
     * minutes sont nulles).
     *
     * @param h24 vrai => format 24h, faux => format 12h
     *
     * @param h les heures de cet horaire. Si h n'est pas dans l'intervalle
     * requis, il est considéré égal à 0.
     */
    public Horaire(boolean h24, int h) {
    // TODO 1.04. Écrire ce constructeur
    }

    /**
     * Construit l'horaire 00:00:00 au format 24h ou 12h.
     *
     * @param h24 vrai => format 24h, faux => format 12h
     */
    public Horaire(boolean h24) {
    // TODO 1.05. Écrire ce constructeur
    }

    /**
     * Construit un nouvel horaire au format 24h à partir des arguments.
     *
     * @param h les heures de cet horaire. Si h n'est pas dans l'intervalle
     * requis, il est considéré égal à 0.
     *
     * @param m les minutes de cet horaire. Si m n'est pas dans [0, 59], il est
     * considéré égal à 0.
     *
     * @param s les secondes de cet horaire. Si s n'est pas dans [0, 59], il est
     * considéré égal à 0.
     */
    public Horaire(int h, int m, int s) {
    // TODO 1.06. Écrire ce constructeur
    }

    /**
     * Construit un nouvel horaire au format 24h à partir des arguments (les
     * secondes sont nulles).
     *
     * @param h les heures de cet horaire. Si h n'est pas dans l'intervalle
     * requis, il est considéré égal à 0.
     *
     * @param m les minutes de cet horaire. Si m n'est pas dans [0, 59], il est
     * considéré égal à 0.
     */
    public Horaire(int h, int m) {
    // TODO 1.07. Écrire ce constructeur
    }

    /**
     * Construit un nouvel horaire au format 24h à partir des arguments (les
     * secondes et les minutes sont nulles).
     *
     * @param h les heures de cet horaire. Si h n'est pas dans l'intervalle
     * requis, il est considéré égal à 0.
     */
    public Horaire(int h) {
    // TODO 1.08. Écrire ce constructeur
    }

    /**
     * Construit l'horaire 00:00:00 au format 24h .
     */
    public Horaire() {
    // TODO 1.09. Écrire ce constructeur
    }

    /**
     * @return les heures de cet horaire
     */
    public int getHeures() {
        return 0;
    // TODO 1.10. Écrire ce getter
    }

    /**
     * @return les minutes de cet horaire
     */
    public int getMinutes() {
        return 0;
    // TODO 1.11. Écrire ce getter
    }

    /**
     * @return les secondes de cet horaire
     */
    public int getSecondes() {
        return 0;
    // TODO 1.12. Écrire ce getter
    }

    /**
     * @return vrai si format 24h, faux sinon.
     */
    public boolean isH24() {
        return false;
    // TODO 1.13. Écrire ce getter
    }

    /**
     * Met à jour les heures
     * @param heures les heures du nouvel horaire
     */
    public void setHeures(int heures) {
    // TODO 1.14. Écrire ce setter
    }

    /**
     * Met à jour les minutes
     * @param minutes les minutes du nouvel horaire
     */
    public void setMinutes(int minutes) {
    // TODO 1.15. Écrire ce setter
    }

    /**
     * Met à jour les secondes
     * @param secondes les secondes du nouvel horaire
     */
    public void setSecondes(int secondes) {
    // TODO 1.16. Écrire ce setter
    }

    /**
     * Met à jour le format 24h ou 12h
     *
     * @param h24 vrai => format 24h , faux sinon.
     */
    public void setH24(boolean h24) {
    // TODO 1.17. Écrire ce setter
    }

    /**
     * Retourne un horaire sous la forme d'une chaîne de caractères sous la
     * forme "hh:mm:ss" où hh, mm, ss sont les heures, les minutes et les
     * secondes sur deux chiffres.
     *
     * Par exemple "00:00:00", "02:33:59"
     *
     * Conseil : lire la javadoc de String.format() :
     * https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/lang/String.html#format(java.lang.String,java.lang.Object...)
     *
     * @return un horaire de la forme "hh:mm:ss"
     */
    @Override
    public String toString() {
        return null;
    // TODO 1.18. Écrire toString()
    }

    /**
     * Augmente cet horaire d'une heure.
     */
    public void uneHeureDePlus() {
    // TODO 1.19. Écrire uneHeureDePlus()
    }

    /**
     * Augmente cet horaire d'une minute.
     */
    public void uneMinuteDePlus() {
    // TODO 1.20. Écrire uneMinuteDePlus()
    }

    /**
     * Augmente cet horaire d'une seconde.
     */
    public void uneSecondeDePlus() {
    // TODO 1.21. Écrire uneSecondeDePlus()
    }
    // TODO 1.01. Déclarer les attributs utiles à votre classe.
    // 
}
