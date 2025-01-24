//////////////////////////////////////////////////////////////////////////////
// 
// INTERPOLATION LINEAIRE PAR INTERVALLE (PAR MORCEAUX)
//
// 
// 1) se donner N points (tt(k),yy(k)) 
//    avec tt(1) < tt(2) < ... < tt(k-1) < tt(k)
//
// 2) creer une fenetre graphique, et tracer les donnees (tt(k),yy(k))
//
// 3) pour chaque intervalle [tt(k),tt(k+1)], 1 <= k <= N-1
//     determiner la fonction f(t) = a t + b qui interpole les deux
//     points (tt(k),yy(k)),(tt(k+1),yy(k+1))
//     calculer et tracer la fonction f pour des valeurs t dans
//     l'intervalle [tt(k),tt(k+1)]
//////////////////////////////////////////////////////////////////////////////

    // ------------------ //
    // 1) les donnees A-1 //
    tt = [ 0  2  4  6  8 10];
    yy = [84 52 36 28 24 22];
    
    // nombre de donnees
    N = length(tt); 
    
    // ------------------------------------------------------ //
    // 2) creation d'une fenetre graphique et                 //
    // affichage des donnees (tt,yy) sous forme de ronds rouges //

        // ------------------ //
        // PARTIE A COMPLETER //
        // ------------------ //
    
    // ------------------------------------------------------ //
    // 3) pour chaque intervalle [tt(k),tt(k+1)], 1 <= k <= N-1 //
    for k = 1:N-1

        // determiner les coefficients a et b a partir de
        // tt(k), yy(k), tt(k+1), yy(k+1) tels que :
        //   a tt(k)   + b = yy(k)
        //   a tt(k+1) + b = yy(k+1)

            // ------------------ //
            // PARTIE A COMPLETER //
            // ------------------ //
        
        // creation d'un tableau t de 1000 valeurs entre tt(k) et tt(k+1)

            // ------------------ //
            // PARTIE A COMPLETER //
            // ------------------ //
        
        // calcul des valeurs y = f(t) = a*t+b

            // ------------------ //
            // PARTIE A COMPLETER //
            // ------------------ //
        
        // trace graphique de (t,y) sur forme d'une courbe continue noire

            // ------------------ //
            // PARTIE A COMPLETER //
            // ------------------ //
    
    end
