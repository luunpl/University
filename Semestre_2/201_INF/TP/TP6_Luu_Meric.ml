(* 4.1 TP6 Flux de circulation *)
(*4.1.1 Statistiques sur les relevés*)
(*Q1*)
type flux = int;; 
type releve = Nil | Cons of flux * releve;;


(*Q2*)
(*Profil nbj_sans : releve -> int*)

(*Q3*)
let r1 = Cons(10, Cons(20, Cons(15, Cons(25, Nil))))
let r2 = Cons(0, Cons(2, Cons(15, Cons(25, Nil))))
let r3 = Cons(0, Cons(0, Cons(15, Cons(0, Cons(25, Cons(0, Cons(30, Nil)))))))
    
(*Q4*)
let rec nbj_sans (r : releve) : int = 
  match r with
  | Nil -> 0
  | Cons(pr, fin) -> (if pr = 0 then 1 else 0) + nbj_sans fin;;
      
(*Q7*)
(*
  let rec nbj_avec (x:flux) (r: releve) : int (* >= 0 *) =
    match x, r with
    | _, Nil -> 0
    | x, Cons(x,fin) -> 1 + nbj_avec x fin
    | x, Cons(pr,fin) -> (* on a donc ici x <> pr *) nbj_avec x fin;;
Line 18, characters 12-13:
Error: Variable x is bound several times in this matching
*)

(*Q8*)
let rec nbj_avec (x: flux) (r:releve) : int =
  match x, r with
  | _, Nil -> 0
  | f, Cons(y,fin) -> if f = y then 1 + nbj_avec f fin else nbj_avec f fin;; 

(*4.1.2 Assertions et tests unitaires*)
(*4.1.3 Appartenance*)
(*Q11, 12*)
let rec flux_app (x : int) (r : int list) : bool =
  match r with 
  |[] -> false
  |pr::fin -> x = pr || (flux_app x fin);;

(*Q13, 14*)
#trace flux_app;;
flux_app 3 [21;2;1;3];;

(*Q15*)
let app  a (s : 'a list) : bool = 
  match s with 
  |[] -> false
  |pr::fin -> a = pr || (flux_app a fin);;

(*4.1.4 Extrema des flux journaliers*)
(*Q16*)
type reveleNV = releve list;;(*\V sauf vide*)
                        
(*Q17*)
(*Profil : fluxmin : revele \ [] -> flux 
Sematiquement : fluxmin va donner le valeur flux le plus petit dans revele
De meme pour flux_max*)

(*Q18*)(*
  let fluxmin (r: revele) : flux = 
    match r with
    |[] -> 0
    |pr::fin -> let max = 0*)

(*Q19*) 

(*4.1.5 Flux observé au jour J*)
