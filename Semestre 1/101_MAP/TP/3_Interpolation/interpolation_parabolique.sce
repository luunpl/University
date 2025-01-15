//////////////////////////////////////////////////////////////////////////////
// 
// INTERPOLATION PARABOLIQUE
//
// 1) donnees : trois points (tt(1),yy(1)) , (tt(2),yy(2)) , (tt(3),yy(3)) 
//    avec tt(1) < tt(2) < tt(3)
//                                       
// 2) calculer les coefficients a, b et c
//    tel que la fonction y = f(t) = a t*t  + b t + c interpole les donnees
//    et definir la fonction f
//
// 3) puis tracer les donnees et la fonction
//
//////////////////////////////////////////////////////////////////////////////

    // ------------------ //
    // 1) les donnees B-1 //
    tt1 =  0; yy1 = 78;
    tt2 =  4; yy2 = 46;
    tt3 = 10; yy3 = 28;
    tt = [tt1 tt2 tt3];
    yy = [yy1 yy2 yy3];

    // ---------------------------------------------------------------- //
    // 2) determination de la fonction f(t) = a*t*t+b*t+c qui interpole //
    // les trois donnees (tt1,yy1), (tt2,yy2) et (tt3,yy3)              //
    
    // calcul des trois coefficients a, b et c tel que
    //  a*tt1^2 + b*tt1 +c = yy1
    //  a*tt2^2 + b*tt2 +c = yy2
    //  a*tt3^2 + b*tt3 +c = yy3
    
        // ------------------ //  
        // PARTIE A COMPLETER //
        // ------------------ //  
    
    // affichage dans la console des valeurs de a, b et c
    mprintf("a = %10.5f\n", a)
    mprintf("b = %10.5f\n", b)
    mprintf("c = %10.5f\n", c)
    
    //                                         2
    // definition de la fonction y = f(t) = a t + b t + c
    deff("y=f(t)","y = a*t.*t + b*t + c")
    

    // ------------------------------------------------------------------ //
    // 3) representation graphique dans une meme fenetre                  //
    // des donnees (tt,yy) sous forme de points rouges                    //
    // et de la fonction y = f(t) avec t tableau de 1000 valeurs          //
    // entre tt(1) et tt(3) sous forme d'une courbe noire                 //
    
        // ------------------ //  
        // PARTIE A COMPLETER //
        // ------------------ //  
    
