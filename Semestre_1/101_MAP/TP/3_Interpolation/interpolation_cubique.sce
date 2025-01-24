//////////////////////////////////////////////////////////////////////////////
//
// INTERPOLATION CUBIQUE PAR INTERVALLE (PAR MORCEAUX)
//
// 
// 1) Donnees : N points (tt(k),yy(k)) avec 
//              tt(1) < tt(2) < ... < tt(k-1) < tt(k) < ... < tt(n)
//
// 2) calculer la fonction cubique par morceaux qui interpole les donnees
//
// 3) puis tracer les donnees et la fonction dans une meme fenetre

    // ------------------ //
    // 1) les donnees C-1 //
    tt = [1  3  5  8 10 13];
    yy = [2  3  7  8  3  1];
        
    // nombre de donnees
    N = length(tt);
    
    // -------------------------------------------------------------- //    
    // 2) calcul des N fonctions f_k avec 1 <= k <= N                 //
    // les 3 coefficients a_k, b_k et c_k definissant la fonction f_k //
    // sont stockees dans 3 vecteurs de taille N ainsi :              //
    // - un vecteur va contenant les differentes valeurs a_k          //
    //   a = [ a_1 a_2 ... a_N ]                                     //
    // - un vecteur vb contenant les differentes valeurs b_k          //
    //   b = [ b_1 b_2 ... b_N ]                                     //
    // - un vecteur vc contenant les differentes valeurs c_k          //
    //   c = [ c_1 c_2 ... c_N ]                                     //
    // et la fonction f_k est definie alors par l'expression          //
    //  f_k(t) = a(k) * t.*t + b(k) * t + c(k)                     //
    //                                                                //
    // -------------------------------------------------------------- //    
    
    // creation des vecteurs a, b et c avec N elements
    a = zeros(1,N);
    b = zeros(1,N);
    c = zeros(1,N);
    
    // determination des coefficients des N-2 fonctions f_k avec 2 <= k <= N-1
    for k=2:N-1
        // determination des 3 coefficients a(k),b(k),c(k) de la fonction 
        // f_k(t) = a(k) * t*t + b(k)*t +c(k) qui interpole
        // les 3 donnees (tt(k-1),yy(k-1)) , (tt(k),yy(k)) , (tt(k+1),yy(k+1))
        
            // ------------------ //  
            // PARTIE A COMPLETER //
            // ------------------ //  
    end
    
    // ajout des deux fonctions f_1 = f_2 et f_N = f_N-1
    //  pour chaque vecteur a, b et c, 
    //  copier le deuxieme element dans le premier element, 
    //  et copier l'avant-dernier element dans le dernier element
    a(1) = a(2);   b(1) = b(2);   c(1) = c(2);
    a(N) = a(N-1); b(N) = b(N-1); c(N) = c(N-1);
        
    
    // --------------------------------------------------------- //    
    // 3) representation graphique des donnees et de la fonction //
    // --------------------------------------------------------- //    

    // creation de la fenetre graphique
    fid = scf()
    
    // representation des donnees sous forme de points rouges de taille 8
    plot(tt,yy,'r.','markersize',8)
        
    // representation de la fonction intervalle par intervalle
    for k=1:N-1
        
        // [t1,t2] = [tt(k),tt(k+1)]
        t1 = tt(k);
        t2 = tt(k+1);
		
        // creer un tableau t de 1000 points dans l'intervalle [t1,t2]
        t = linspace(t1,t2,1000);
		
        // calcul des valeurs de la fonction f_k(t) --> vecteur f1
        
            // ------------------ //  
            // PARTIE A COMPLETER //
            // ------------------ //  

        // calcul des valeurs de la fonction f_k(t) --> vecteur f2
        
            // ------------------ //  
            // PARTIE A COMPLETER //
            // ------------------ //  


        // calcul des valeurs la fonction f(t) --> vecteur f
       
            // ------------------ //  
            // PARTIE A COMPLETER //
            // ------------------ //  


        // representation graphique de f dans l'intervalle [t1,t2] 
        plot(t,y,'k-','linewidth',2)
    end

