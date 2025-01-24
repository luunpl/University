(* This is an OCaml editor.
   Enter your program here and send it to the toplevel using the "Eval code"
   button or [Ctrl-e]. *)

(*2.7 TP3 Une date est-elle correcte ?*)
(*Q1*)
(*a*)
type jour = int (* restreint a {1...30} *);;
type mois = int (* restreint a {1..12} *);;
(*b*)
let estJourDansMois_2 (j : jour) (m : mois) :  bool =
  (m = 2 && j <= 28)  || ((m = 4  || m = 6 || m = 8|| m = 11) && j <= 30) || ((m = 1|| m=3 || m=5 || m=7 || m=8 || m=10 || m=12) && j <= 31);;

estJourDansMois_2 4 12;;
(*c*) 
assert ((estJourDansMois_2 28 1) = true);;
assert ((estJourDansMois_2 30 2) = false);;
assert ((estJourDansMois_2 2 13) = false);;
(*d*) 
(estJourDansMois_2 18 13), (estJourDansMois_2 0 4);;
(*bool * bool  = (false, true)*)

(*Q2*)
(*a*)
let estJourDansMois_3 (j :jour) (m : mois) : bool =
  match m with
  |1|3|5|7|8|10|12 -> j <= 31
  |2 -> j <= 28
  |_ -> j <= 30;;
(*b*)
assert ((estJourDansMois_2 18 13) = (estJourDansMois_3 18 13));;
(*Le resultat peut causer un erreur a cause de la derniere ligne de estJourDansMois_3, si on tape |4|6|9|11 au lieu de _, on recontre la caution de Ocaml
et je ne sais pas comment resoudre *)
assert ((estJourDansMois_2 0 4) = (estJourDansMois_3 0 4));;
assert ((estJourDansMois_2 28 1) = (estJourDansMois_3 28 1));;
(*le resultat est unit() qui signifie que les resultats sont identiques*);;

(*Q3*) 
(*a*)
type nouvelle_mois = Janvier | Fevrier | Mars | Avril | Mai | Juin | Juillet | Aout | Septembre | Octobre | Novembre | Decembre;;
let estJourDansMois_4 (j : jour) (m : nouvelle_mois) : bool = 
  match m with
  |Janvier | Mars | Mai | Juillet | Aout | Octobre | Decembre  -> j <= 31
  |Fevrier -> j <= 28
  |_ -> j <= 30;;

assert ((estJourDansMois_2 0 4) = (estJourDansMois_4 0 Avril));;
assert ((estJourDansMois_2 28 1) = (estJourDansMois_4 28 Janvier));; 
(*le resultat est unit() qui signifie que les resultats sont identiques*);;

(*2.8 TP3 Relations sur des intervalles d’entiers*)
(*Q1*)
(*C'est juste evaluer des expressions comme TP1 alors nous ne refaisons pas*)
(*Q2*)
not true && false;;
true || true && false;;
(*l'expression && est plus en priorite que ||*) 
(*Q3*)
10 mod 0 ;; 10 mod 5 ;;
let essaiEt1 (a:int) (b:int): bool =
  (b <> 0) && (a mod b = 0)
;;
essaiEt1 10 5 ;; essaiEt1 10 3 ;; essaiEt1 10 0 ;;
let monEt (x:bool) (y:bool): bool =
  x && y
;;
let essaiEt2 (a:int) (b:int): bool =
  monEt (b <> 0) (a mod b = 0)
;;
essaiEt2 10 0 ;;
(**)
(*2.8.1 n-uplets*)
(10,20,30);;
((10,20),30) ;; 
20,30.0 ;;
(*4,3 /. 2,0 ;;
4,3. /. 2,0 ;;
4,3. /. 2.,0 ;;
(4,0) /. (2,0) ;;*)

(*2.8.2 Points et intervalles*)
(*Q5 Q6 Q7*)
type intervalle = int * int (*bi,bs tel que bi <= bs*) ;;

let precede (x :int) (i : intervalle) : bool =
  let (bi, _) = i in x < bi;;

let interv_1 : intervalle = (-30, 50) and x1 : int = -40 in assert (precede x1 interv_1) ;;
(*le resultat est unit() qui est vrai*)
(*Q8*)
(*precede 3 4 5 ;; precede (3,4,5) ;; c'est un erreur de syntaxe car *)
precede 3 (4,5) ;;
(*renvoie true *)

(*2.8.3 Intervalles, couples d’intervalles*)
(*Q9 Q10*)
let chevauche (bi1, bs1 : intervalle) (bi2, bs2 : intervalle) : bool =
  (bs1 < bi2 && bi2 < bs1 && bs1 < bs2) || (bs2 < bi1 && bi1 < bs2 && bs1 < bs1) ;;

let coteAcote (bi1, bs1 : intervalle) (bi2, bs2 : intervalle) : bool =
  (bs1 + 1 = bi2) || (bs2 + 1 = bi1);;

(*Reutiliser les exemples vues dans cours*)
assert (chevauche(1,3) (4, 10) = false);;
assert(coteAcote (1,3) (4, 10) = true);;
(*les 2 cas sont vrais*)

(*TP3 Somme des chiffres d’un nombre*)
(*Q1*)
type nombre = int;;
type diviseur = int;;
let div (n : nombre) (d: diviseur) : int * int =
  let q = n / d and r = n mod d in (q,r);;
div 28 3;; 
(*- : int * int = (9, 1)*)
(*Q2*)
let sc (n : nombre) : int =
  let (a, b) = div n 10 in
  let (c, d) = div a 10 in 
  let (e, f) = div c 10 in
  let (g, h) = div e 10 in
  b + d + f + h;;
sc 2341;; 
(*- : int = 10*)