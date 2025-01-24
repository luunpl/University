(* This is an OCaml editor.
   Enter your program here and send it to the toplevel using the "Eval code"
   button or [Ctrl-e]. *)

(*Permutation ordonnée d’un couple d’entiers*)
(*Q1*)
let poCoupleE ((a,b):int*int) : int*int =
  if a < b then (a,b) else (b,a);;
poCoupleE(4,3);;

(*Q2 --> Q8
poCoupleE (33.3,14.5) ;;
Error: This expression has type float but an expression was expected of type int
    
2 < 3 ;;
2.0 < 3.0 ;; les 2 bools renvoient true
*)
let poCoupleR (a,b:float*float) : float*float =
  if a < b then (a,b) else (b,a);;

let poCouple (x,y: 'un_type*'un_type) : 'un_type*'un_type =
  if x <= y then x,y else y,x;;

(*Type Durée et opérations associées*)
(*Q1*)
type jour = int;;  (* {0,...,31} *)
type heure = int;; (* {0,...,23} *)
type de0a59 = int;;  (* {0,...,59} *)
type minute = int;;
type seconde = int;;
type duree = jour*heure*minute*seconde;;

(*Q1*)
(*Fonction div*)
let div (n:int) (d:int) : int * int =
  let q = n / d and r = n mod d in (q,r);;

let sec_en_duree (sec:seconde) : duree =
  let (jour, s1) = div sec 86400 in
  let (heure, s2) = div s1 3600 in 
  let (minute, s3) = div s2 60 in
  let (seconde, s4) = div s3 60 in
  (jour,heure,minute,seconde);;

sec_en_duree 11425125;;

(*Q2*)
let nb_total_sec ((j,h,m,s) : duree) : int =
  86400*j + 3600*h + 60*m + 60*s;;

nb_total_sec (12,23,4,6);;
(*Q3, Q4*)
let vec_en_duree (v1:int*int*int*int) : duree =
  v1;;

(*Q5*)
let duree_en_sec ((j,h,m,s) : duree) : int =
  86400*j + 3600*h + 60*m + 60*s;;

(*Q6*)
let som_duree (d1:duree) (d2:duree) : duree =
  sec_en_duree (duree_en_sec d1 + duree_en_sec d2);;

(*Q7*)
let eg_duree (d1:duree) (d2:duree) : bool =
  duree_en_sec d1 = duree_en_sec d2;;

(*Q8*)
let inf_duree (d1:duree) (d2:duree) : duree =
  if duree_en_sec d1 < duree_en_sec d2 then d1 else d2;;
