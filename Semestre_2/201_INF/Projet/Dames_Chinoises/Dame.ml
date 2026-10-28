(*Not my work*)
(*Credit : Khoi Anh Truong https://github.com/truongak*)
type dimension = int;; (*restreint aux entiers strictement positifs*)

type case = int * int * int;; (*restreint au triplet tels (i,j,k) tels que i+j+k=0*)
type vecteur = int * int * int;; (*restreint au triplet tels (i,j,k) tels que i+j+k=0*)

type couleur = Vert | Jaune | Rouge | Noir | Bleu | Marron (*Les couleurs des joueurs*)
               | Libre 
               | Code of string (*une chaine restreinte a 3 caracteres*);;


type case_coloree = case * couleur;;

type configuration = case_coloree list * couleur list * dimension;; (*sans case libre*)
          
type coup = Du of case * case | Sm of case list;;

exception Coordonnee_non_conforme
exception Case_non_alignee

let indice_valide (x:int) (dim:dimension) : bool =
  x >= -2*dim && x<= 2*dim;;

let est_case ((i,j,k):case):bool=
 (i+j+k=0);;

let rec associe (a:'a) (l:('a*'b) list) (defaut:'b):'b = 
    match l with
    |[] -> defaut
    |(el1,el2)::_ when el1=a -> el2
    |_::q -> associe a q defaut
;;

(*Q1*)
(*  i < -dim: correspond aux cases situées dans le camp Sud
    i > dim: correspond aux cases situées dans le camp nord
    j < -dim: correspond aux cases situées dans le camp sud-ouest
    (i, j, k) = (2dim, -dim, -dim): correspond à la case la plus au nord (la pointe du camp nord)
    (i, j, k) = (-dim - 1, 1, dim): correspond au coin en haut à gauche du camp nord.
    i >= -dim ^ j >= -dim ^ k >= -dim: correspond à l'hexagone central (le plateau privé des camps) 
*)

(*Q2*)
let est_dans_losagne (i,j,k:case) (dim:int):bool=
    if not (est_case (i,j,k)) then raise Coordonnee_non_conforme
    else (j>= (-dim) && j<= dim) && (k>=(-dim) && k<=dim)
;;

(*Q3*)
let est_dans_etoile (i,j,k:case) (dim:int): bool=
    if not (est_case (i,j,k)) then raise Coordonnee_non_conforme
    else (est_dans_losagne (i,j,k) dim) || (est_dans_losagne (k,i,j) dim) || (est_dans_losagne (j,k,i) dim)
;;

(*Q4*)
let rec tourner_case (m:int) (i,j,k:case):case=
    match m with
    |_ when not (est_case (i,j,k)) -> raise Coordonnee_non_conforme
    |0 -> i,j,k
    |_ when m > 0 -> tourner_case (m-1) (-k,-i,-j) (* tourne dans le sens direct si m est positif. *)
    |_ -> tourner_case (m+1) (-j,-k,-i) (* dans le sens horaire sinon *)
;; 

type vecteur = case

(*Q5*)
let translate (i,j,k:case) (x,y,z:vecteur):case=
    (i+x,j+y,k+z)
;;

(*Q6*)
let diff_case (i,j,k:case) (x,y,z:case): (* case *) vecteur =
    if not (est_case (i,j,k)) || not (est_case (x,y,z)) then raise Coordonnee_non_conforme
    else (i-x,j-y,k-z)
;;

(*Q7*)
let sont_cases_voisines (c1:case) (c2:case):bool=
    match diff_case c1 c2 with
    |_ when not (est_case c2) || not (est_case c1) -> raise Coordonnee_non_conforme
    | (0,1,-1)|(0,-1,1)|(1,0,-1)|(-1,0,1)|(1,-1,0)|(-1,1,0) -> true
    | _ -> false
;;

(*Q8*)
let calcul_pivot (i,j,k:case) (x,y,z:case):case option =
    if (i=x || j=y || k=z) && (est_case (i,j,k)) && (est_case (x,y,z)) 
    && (i+x) mod 2 = 0 && (j+y) mod 2 = 0 && (k+z) mod 2 = 0 
    then Some ((i+x)/2,(j+y)/2,(k+z)/2)
    else None;;

(*test pour calcul pivot*)
let casv1 = (-6,3,3);;
let casv1_ = (-4,1,3);;
let casv2 = (-4,1,3);;
let casv2_ = (-4,3,1);;
let casf1 = (-5,3,2);;
let casf1_ = (-4,3,1);;

assert ((calcul_pivot casf1 casf1_) = None);;
assert ((calcul_pivot casv1 casv1_) = Some(-5,2,3));;
assert ((calcul_pivot casv2 casv2_) = Some(-4,2,2));;

(*Q9*)
let rec vec_et_dist (c1:case) (c2:case) (*(i,j,k:case) (x,y,z:case): pareille *): case*int=
    match diff_case c1 c2 (*(i,j,k) (x,y,z)*) with
    |_ when not (est_case c2) || not (est_case c1) -> raise Coordonnee_non_conforme
    |0,0,0 -> (0,0,0),0
    |0,b,c -> ((0,b/abs(b),c/abs(b)),abs(b))
    |a,0,c -> ((a/abs(a),0,c/abs(a)),abs(c))
    |a,b,0 -> ((a/abs(b),b/abs(b),0),abs(b))
    |_ -> raise Case_non_alignee
;;

(*AFFICHAGE (fonctionne si les fonctions au dessus sont remplies)*)
(*transfo transforme des coordonnees cartesiennes (x,y) en coordonnees de case (i,j,k)*)
let transfo x y = (y, (x-y)/2,(-x-y)/2);;

let couleur2string (coul:couleur):string =
  match coul with
  | Libre -> " . "
  | Code s -> s  
  | Vert -> " V "
  | Jaune -> " J "
  | Rouge -> " R "
  | Noir -> " N "
  | Bleu -> " B "
  | Marron -> " M ";;

let rec affiche_ligne (n:int) (m:int) (config:configuration) : string =
  let (lcc,_,dim)=config in
    if m = (4 * dim) + 1 then " " (*fin de ligne*)
    else
      let c = transfo m n in
      if not ((n+m) mod 2 = 0) || not (est_dans_etoile c dim) then (*ceci est une inter-case (case inutile d'un damier) ou hors de l'etoile*)
        "   "^ affiche_ligne n (m + 1) config
      else (*ceci est une case ou bien en dehors du plateau*)
       (couleur2string (associe c lcc Libre)) ^ affiche_ligne n (m + 1) config;;


let affiche (config:configuration):unit =
  let (_,_,dim)=config in
    let rec affiche_aux n =
      if n = - 2 * dim - 1 then ()
      else
      begin
      print_endline (affiche_ligne n (-4*dim-1) config);
      print_endline "\n";
      affiche_aux (n - 1)
      end
    in
    affiche_aux (2*dim+1);;


let conf_1=([((0,0,0),Jaune)],[Jaune],2);;
affiche conf_1;;
let conf_reggae=([((0,-1,1),Vert);((0,0,0),Jaune);((0,1,-1),Rouge)],[Vert;Jaune;Rouge],1);;
affiche conf_reggae;;
let conf_vide=([],[],2);;
affiche conf_vide;;



(*Deuxieme partie*)
(*2.1*)
(*Q10*)

let tourner_liste (l:'a list): 'a list = 
  match l with
  | [] -> []
  | x::xs -> xs@[x]
;;

let rec der_liste (l:'a list): 'a = match l with
 | [a] -> a
 | x::xs -> der_liste(xs)
[@@ warning "-8"]
;;
(*restreint aux liste qui ne sont pas vides*)
assert((der_liste [Jaune;Vert;Rouge])=Rouge);; 
assert((tourner_liste [Vert;Jaune;Rouge]) = [Jaune; Rouge; Vert]);;

(*Q11*)
let rec remplir_segment (m:int) (i,j,k: case): case list =
  match m with
  | 1 -> [(i,j,k)]
  | _ -> [i,j,k]@remplir_segment (m-1) (i,j+1,k-1)
;;
(*restreint aux entiers naturels non nuls*)
(*Les tests*)
assert((remplir_segment 3 (-4,1,3)) = [(-4, 1, 3); (-4, 2, 2); (-4, 3, 1)]);;
assert((remplir_segment 1 (0,0,0)) = [0,0,0]);;

(*Q12*)
let rec remplir_triangle_bas (m:int) (i,j,k: case): case list =
  match m with
  | 1 -> [(i,j,k)]
  | _ -> (remplir_segment (m) (i,j,k))@(remplir_triangle_bas (m-1) (i-1,j+1,k))
;;
(*restreint aux entiers naturels*)
(*Les tests*)
assert((remplir_triangle_bas 3 (-4,1,3)) = [(-4, 1, 3); (-4, 2, 2); (-4, 3, 1); (-5, 2, 3); (-5, 3, 2); (-6, 3, 3)]);;

(*Q13*)
let rec remplir_triangle_haut (m:int) (i,j,k: case): case list =
  match m with
  | 1 -> [(i,j,k)]
  | _ -> (remplir_segment (m) (i,j,k))@(remplir_triangle_haut (m-1) (i+1,j,k-1))
;;
(*restreint aux entiers naturels*)
(*Les tests*)
assert((remplir_triangle_haut 3 (-3,4,-1)) = [(-3, 4, -1); (-3, 5, -2); (-3, 6, -3); (-2, 4, -2); (-2, 5, -3); (-1, 4, -3)]);;

(*Q14*)
let rec colorie (coul:couleur) (cl: case list): case_coloree list = 
  match cl with
  | [] -> []
  | x::xs -> (x,coul)::(colorie (coul) (xs)) (*checkkkk*)
;;
(*Les tests*)
assert((colorie (Jaune) ([(-3, 4, -1); (-3, 5, -2); (-3, 6, -3); (-2, 4, -2); (-2, 5, -3); (-1, 4, -3)])) = [((-3, 4, -1), Jaune); ((-3, 5, -2), Jaune); ((-3, 6, -3), Jaune);
((-2, 4, -2), Jaune); ((-2, 5, -3), Jaune); ((-1, 4, -3), Jaune)]);;

(*Q15*)
(* let rec tourner_cl (n:int) (cl: case_coloree list): case_coloree list =
  match cl with
  | [] -> []
  | (x,y)::xs -> ((tourner_case (n) x),y)::(tourner_cl n (xs)) (*need checkkkk*)
;; *)
(* let rec tourner_config (cl, coul, n :configuration): configuration = ((tourner_cl (6/List.length coul) cl), tourner_liste(coul),n);; Check it *)
(*Je sais pas comment tourner la liste de couleur, merci de le regarder et m'enseigner
   List.length could est le nombre de joueur*)

(*nouvelle method pour le faire et plus efficace*)
let rec tourner_config (cl, coul, dim :configuration): configuration = 
  match List.length(coul) with
    |1 -> let cl_tourne_1 = List.fold_left(fun acc x -> 
            let c,color = x in ((tourner_case 6 c),color)::acc) [] cl in (cl_tourne_1,tourner_liste coul,dim)
    |2 -> let cl_tourne_2 = List.fold_left(fun acc x -> 
            let c,color = x in ((tourner_case 3 c),color)::acc) [] cl in (cl_tourne_2,tourner_liste coul,dim)
    |3 -> let cl_tourne_3 = List.fold_left(fun acc x -> 
            let c,color = x in ((tourner_case 2 c),color)::acc) [] cl in (cl_tourne_3,tourner_liste coul,dim)
    |6 -> let cl_tourne_6 = List.fold_left(fun acc x -> 
            let c,color = x in ((tourner_case 1 c),color)::acc) [] cl in (cl_tourne_6,tourner_liste coul,dim)
  [@@warning "-8"]
  ;;



(*Q16*)
(* let rec tout_triangle (n:int) (j:couleur list) (m:dimension): case_coloree list =
  match j with
  | [] -> []
  | x::xs -> (tout_triangle (n) (xs) (m))@(tourner_cl (6-(n*(List.length j))) (colorie (x) (remplir_triangle_bas m (-m-1,1,m))))
;;
let rec remplir_init(j:couleur list) (m:dimension): configuration = ((tout_triangle (-(6/(List.length j))) j m), j, m);; Dont forget the minus "-" *)

(*nouvelle method, plus efficace*)
let rec remplir_init (cl: couleur list) (dim: dimension): configuration =
  List.fold_left
  (fun acc x -> let a,b,c = acc in let cl_list = (colorie x (remplir_triangle_bas dim (-dim-1,1,dim))) in tourner_config(cl_list@a,b,c)) ([],cl,dim) cl;;


(*A essayer apres avoir fait remplir_init*)
affiche (remplir_init [Code "Ali";Code "Bob";Code "Jim"] 3);;

(*Q17*)
let quelle_couleur (c:case) (conf:configuration): couleur = let x,y,z = conf in associe (c) (x) (Libre);;

(*Q18*)
let rec supprime_dans_cl (cl:case_coloree list) (c_sup:case): case_coloree list =
  match cl with
  | [] -> []
  | (x,y)::xs -> let a,b,c = x and a1,b1,c1 = c_sup in if a=a1 && b=b1 && c=c1 then (supprime_dans_cl (xs) c_sup) else (x,y)::(supprime_dans_cl (xs) c_sup)
;;

let rec supprime_dans_configuration (cl,c,m:configuration) (c_sup:case): configuration = ((supprime_dans_cl cl c_sup), c, m);;

(*Q19*)
(* let rec in_conf (c:case) (cl,co,dim:configuration): bool =
  match cl with
  | [] -> false
  | pr::fin -> let coord,coul = pr in if coord = c then true else in_conf c (fin,co,dim)
;; *)

(* failwith "Saut multiples non implementes" *)
let rec est_coup_valide (conf: configuration) (c:coup): bool =
  match c with
  | Du(a,b) -> let cl,co,dim = conf in if (sont_cases_voisines a b) && (quelle_couleur a conf) = (List.hd co) && (quelle_couleur b conf) = Libre && (est_dans_losagne b dim) then true else false
  | Sm(l) -> failwith "Saut multiples non implementes"(*(est_saut_multiple l conf)*);; 
  (*Pas de sauts multiples*)

(*Les tests*)
assert ((est_coup_valide (remplir_init [Code "Ali";Code "Bob";Code "Jim"] 3) (Du((-4,2,2),(-3,0,3)))) = false);;
assert ((est_coup_valide (remplir_init [Code "Ali";Code "Bob";Code "Jim"] 3) (Du((-4,1,3),(-3,0,3)))) = true);;

(*Q20*)
let rec appliquer_coup (conf: configuration) (c:coup): configuration = 
  match conf, c with
  | ([], co, dim), Du(_,_) -> [],co,dim
  | (pr::fin, co, dim), Du(c1,c2) -> let coord, coul = pr in let a,b,c = (appliquer_coup (fin,co,dim) c) in if coord = c1 then ((c2,coul)::a,co,dim) else (pr::a, co, dim)
  | (_,_,_),Sm _ -> failwith "Saut multiples non implementes";;
  (* | _, Sm(l) -> appliquer_coup (conf) (Du(List.hd l, der_liste l)) *)
(*Pas de sauts multiples*)

affiche((appliquer_coup (remplir_init [Code "Ali";Code "Bob";Code "Jim"] 3) (Du((-4,1,3),(-3,0,3)))));;

(*Q21*)
let rec mettre_a_jour_configuration (conf: configuration) (c: coup): configuration =
  match est_coup_valide conf c with
  | true -> appliquer_coup conf c
  | false -> failwith "Ce coup n'est pas valide, le joueur doit rejouer"
(*pas complete*)


(*Q22*)
let rec est_libre_seg (c1:case) (c2:case) (conf:configuration): bool =
  match vec_et_dist c1 c2 with
  |_,1 -> true
  |(a,b,c),x -> let i,j,k = c1 in if (quelle_couleur (i-a,j-b,k-c) conf) = Libre then (est_libre_seg (i-a,j-b,k-c) c2 conf) else false;;
(*On suppose que les deux cases sont alignes*)

(*Q23*)
let rec est_saut (c1: case) (c2: case) (conf: configuration): bool = 
  match calcul_pivot c1 c2 with
  |None -> false
  |Some(pivot) ->
  let (cl, co, dim) = conf in
  if (quelle_couleur c1 conf) = List.hd co && (quelle_couleur c2 conf) = Libre && (quelle_couleur pivot conf) <> Libre &&
    (est_libre_seg c1 pivot conf) && (est_libre_seg pivot c2 conf) then true else false;;
(*Dans l'enonce, cette fonction ne test que le deplacement de c1 a c2*)

(*test*)
assert (est_saut (-2,2,0) (0,0,0) ([((1, 3, -4), Code "Jim"); ((2, 2, -4), Code "Jim");
((3, 1, -4), Code "Jim"); ((2, 3, -5), Code "Jim");
((3, 2, -5), Code "Jim"); ((3, 3, -6), Code "Jim");
((3, -4, 1), Code "Bob"); ((-1, 1, 0), Code "Bob");
((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
((2, -5, 3), Code "Bob"); ((3, -6, 3), Code "Bob");
((-2, 2, 0), Code "Ali"); ((-4, 2, 2), Code "Ali");
((-4, 3, 1), Code "Ali"); ((-5, 2, 3), Code "Ali");
((-5, 3, 2), Code "Ali"); ((-6, 3, 3), Code "Ali")],
[Code "Ali"; Code "Bob"; Code "Jim"], 3) =  true);;

assert (est_saut (-2,2,0) (0,0,0) (remplir_init [Code "Ali"; Code "Bob"; Code "Jim"] 3) = false);;


(*Q24*)
let rec est_saut_multiple (cl: case list) (conf: configuration): bool =
  match cl with
  | [] -> true (*peut etre pas necessaire*)
  | pr1::[] -> true
  | pr1::pr2::fin -> if (est_saut pr1 pr2 conf) then est_saut_multiple (pr2::fin) (appliquer_coup conf (Du(pr1,pr2))) else false;;

(*test*)
assert(est_saut_multiple [(-2,2,0);(0,0,0);(2,0,-2)] ([((1, 3, -4), Code "Jim"); ((2, 2, -4), Code "Jim");
((3, 1, -4), Code "Jim"); ((2, 3, -5), Code "Jim");
((3, 2, -5), Code "Jim"); ((3, 3, -6), Code "Jim");
((3, -4, 1), Code "Bob"); ((-1, 1, 0), Code "Bob");
((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
((2, -5, 3), Code "Bob"); ((1, 0, -1), Code "Bob");
((-2, 2, 0), Code "Ali"); ((-4, 2, 2), Code "Ali");
((-4, 3, 1), Code "Ali"); ((-5, 2, 3), Code "Ali");
((-5, 3, 2), Code "Ali"); ((-6, 3, 3), Code "Ali")],
[Code "Ali"; Code "Bob"; Code "Jim"], 3) = true);;

(*Q25*)
let rec est_coup_valide (conf: configuration) (c:coup): bool =
  match c with
  | Du(a,b) -> let cl,co,dim = conf in if (sont_cases_voisines a b) && (quelle_couleur a conf) = (List.hd co) && (quelle_couleur b conf) = Libre && (est_dans_losagne b dim) then true else false
  | Sm(l) -> (est_saut_multiple l conf);;


let rec appliquer_coup (conf: configuration) (c:coup): configuration = 
  match conf, c with
  | ([], co, dim), Du(_,_) -> [],co,dim
  | (pr::fin, co, dim), Du(c1,c2) -> let coord, coul = pr in let a,b,c = (appliquer_coup (fin,co,dim) c) in if coord = c1 then ((c2,coul)::a,co,dim) else (pr::a, co, dim)
  | _, Sm(l) -> appliquer_coup (conf) (Du(List.hd l, der_liste l));;

let rec mettre_a_jour_configuration (conf: configuration) (c: coup): configuration =
  match est_coup_valide conf c with
  | true -> appliquer_coup conf c
  | false -> failwith "Ce coup n'est pas valide, le joueur doit rejouer";;
(*pas complete*)

affiche([((1, 3, -4), Code "Jim"); ((2, 2, -4), Code "Jim");
((3, 1, -4), Code "Jim"); ((2, 3, -5), Code "Jim");
((3, 2, -5), Code "Jim"); ((3, 3, -6), Code "Jim");
((3, -4, 1), Code "Bob"); ((-1, 1, 0), Code "Bob");
((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
((2, -5, 3), Code "Bob"); ((1, 0, -1), Code "Bob");
((-2, 2, 0), Code "Ali"); ((-4, 2, 2), Code "Ali");
((-4, 3, 1), Code "Ali"); ((-5, 2, 3), Code "Ali");
((-5, 3, 2), Code "Ali"); ((-6, 3, 3), Code "Ali")],
[Code "Ali"; Code "Bob"; Code "Jim"], 3);;

affiche (mettre_a_jour_configuration ([((1, 3, -4), Code "Jim"); ((2, 2, -4), Code "Jim");
((3, 1, -4), Code "Jim"); ((2, 3, -5), Code "Jim");
((3, 2, -5), Code "Jim"); ((3, 3, -6), Code "Jim");
((3, -4, 1), Code "Bob"); ((-1, 1, 0), Code "Bob");
((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
((2, -5, 3), Code "Bob"); ((1, 0, -1), Code "Bob");
((-2, 2, 0), Code "Ali"); ((-4, 2, 2), Code "Ali");
((-4, 3, 1), Code "Ali"); ((-5, 2, 3), Code "Ali");
((-5, 3, 2), Code "Ali"); ((-6, 3, 3), Code "Ali")],
[Code "Ali"; Code "Bob"; Code "Jim"], 3) (Sm([(-2,2,0);(0,0,0);(2,0,-2)])));;

(* affiche (mettre_a_jour_configuration ([((1, 3, -4), Code "Jim"); ((2, 2, -4), Code "Jim");
((3, 1, -4), Code "Jim"); ((2, 3, -5), Code "Jim");
((3, 2, -5), Code "Jim"); ((3, 3, -6), Code "Jim");
((3, -4, 1), Code "Bob"); ((0, 1, -1), Code "Bob");
((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
((2, -5, 3), Code "Bob"); ((1, 0, -1), Code "Bob");
((-2, 2, 0), Code "Ali"); ((-4, 2, 2), Code "Ali");
((-4, 3, 1), Code "Ali"); ((-5, 2, 3), Code "Ali");
((-5, 3, 2), Code "Ali"); ((-6, 3, 3), Code "Ali")],
[Code "Ali"; Code "Bob"; Code "Jim"], 3) (Sm([(-2,2,0);(-1,1,0);(1,1,-2)])));; *)

(*Q26*)
let score (conf: configuration): int = let cl, coul, dim = conf in List.fold_left (fun acc x -> let (a,b,c),y = x in if y = List.hd coul then acc + a else acc) 0 cl;;
let score_gagnant (dim: dimension) =  -(score (remplir_init [Code "Ali"] dim));;

(*Q27*)
let gagne (conf:configuration): bool = let cl,coul,dim = conf in score conf = score_gagnant dim;;

(*Q28*)

let partie (conf: configuration) (coup_l: coup list) = (List.fold_left (fun acc x -> (tourner_config(mettre_a_jour_configuration acc x))) conf coup_l);;


let est_partie (cl,coul,dim : configuration) (coup_l: coup list) =
   fst (List.fold_left (fun acc x -> let color,(case_gagne,coul_gagne,dim_gagne) = acc in
    if gagne (case_gagne,coul_gagne,dim_gagne) then (List.hd (coul_gagne), (case_gagne,coul_gagne,dim_gagne)) 
    else Libre,tourner_config (case_gagne,coul_gagne,dim_gagne)) (Libre,partie (cl,coul,dim) (coup_l)) coul);;

(*tester*)
assert (est_partie (remplir_init [Code "Ali";Code "Bob"] 1) 
[Du((-2,1,1),(-1,0,1)); 
Du((-2,1,1),(-1,0,1)); Du((-1,0,1),(0,0,0)); 
Du((-1,0,1),(0,-1,1)); Du((0,0,0),(1,0,-1)); 
Du((0,-1,1),(1,-1,0));Du((1,0,-1),(2,-1,-1)); Du((1,-1,0),(2,-1,-1))] = Code "Ali");;


(*Q29*)
let rec hd_liste l = match l with
    |[_] -> []
    |x::xs -> x::hd_liste xs
    [@@warning "-8"];;

let (>>) a b = match b with
  |Sm(x) -> Sm(x@[a])
  [@@warning "-8"]
;;

let tire a = match a with
  | Sm(x) -> x
  [@@warning "-8"];;


let rec der_hd x l2 = match l2 with
  |[] -> []
  |t::q -> if (der_liste(tire x)) = List.hd (tire t) then Sm((tire x)@(List.tl (tire t)))::(der_hd x q) else der_hd x q;;


let rec der_in_list l = match l with
  |[_] -> true
  |x::xs -> if x = der_liste(l) then false else der_in_list xs
[@@warning "-8"];;


let rec existe x l = match l with
  | [] -> false
  | t::q -> if t = x then true else existe x q;;

let rec diffe l = match l with
  |[] -> []
  |x::xs -> if existe x xs then diffe xs else x::(diffe xs);;

let rec liste_coup_valide l = match l with
  |[] -> []
  |x::xs -> if der_in_list(tire x) then x::(liste_coup_valide xs) else liste_coup_valide xs;;

let rec list_ligne conf c v = let cl,coul,dim = conf in
  match (translate c v) with
  |x when not(est_dans_losagne x dim) -> []
  |_ -> (translate c v)::(list_ligne conf (translate c v) v);;


let tout_ligne conf c = List.fold_left (fun acc x -> (list_ligne conf c x)@acc) [] [(1, -1, 0); (1, 0, -1); (0, 1, -1); (-1, 1, 0); (-1, 0, 1); (0, -1, 1)];;


let saut_ligne conf c = hd_liste(List.fold_left (fun acc x -> 
  if (est_saut_multiple [c;x] conf) then (x >> (der_liste acc))::acc else
    if (est_saut_multiple ((tire(List.hd(acc)))@[x]) conf) then (x >> (List.hd acc))::acc else
      acc) [Sm[c]] (tout_ligne conf c));;
      (*every possible saut on straight line*)

(*working*)

let rec tout_saut (conf: configuration) (c:case) (cl:coup list) (*only Sm*) = 
  match cl with 
  |[] -> []
  |_ -> let listes = diffe (List.fold_left (fun acc x -> 
  let saut_liste = (saut_ligne (mettre_a_jour_configuration conf x) (der_liste(tire(x)))) in (liste_coup_valide(der_hd x saut_liste))@acc) 
  [] (cl)) in diffe(listes@(tout_saut conf c listes)@(saut_ligne conf c));;

let coups_voisins (cl,coul,dim: configuration) (c:case): (case*coup) list =
  List.fold_left (fun acc x -> 
    if (est_case(translate c x)) && est_dans_losagne (translate c x) dim && (quelle_couleur (translate c x) (cl,coul,dim)) = Libre 
      then ((translate c x),Du(c,x))::acc else acc) [] [(0,1,-1);(0,-1,1);(1,0,-1);(-1,0,1);(1,-1,0);(-1,1,0)];;

let coup_sauts conf c = List.map (fun x -> der_liste(tire x),x) (tout_saut conf c (saut_ligne conf c));;

let coup_possibles conf c = (coup_sauts conf c)@(coups_voisins conf c);;


(*test pour la 29*)

let test = ([((3, -4, 1), Code "Bob"); ((2, -4, 2), Code "Bob");
  ((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
  ((2, -5, 3), Code "Bob"); ((3, -6, 3), Code "Bob");
  ((-6, 3, 3), Code "Ali"); ((-5, 3, 2), Code "Ali");
  ((-4, 3, 1), Code "Ali"); ((-3, 1, 2), Code "Ali");
  ((2, -3, 1), Code "Ali"); ((0, -2, 2), Code "Ali");
  ((3, 3, -6), Code "Ant"); ((3, 2, -5), Code "Ant");
  ((2, 3, -5), Code "Ant"); ((3, 1, -4), Code "Ant");
  ((2, 2, -4), Code "Ant"); ((1, 3, -4), Code "Ant")],
 [Code "Ali"; Code "Bob"; Code "Ant"], 3);;


let test3 = ([((3, -4, 1), Code "Bob"); ((1, -2, 1), Code "Bob");
  ((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
  ((2, -5, 3), Code "Bob"); ((3, -6, 3), Code "Bob");
  ((-5, 3, 2), Code "Ali"); ((-3, 1, 2), Code "Ali");
  ((0, -2, 2), Code "Ali"); ((2, -3, 1), Code "Ali");
  ((4, -3, -1), Code "Ali"); ((4, -2, -2), Code "Ali");
  ((3, 3, -6), Code "Ant"); ((3, 2, -5), Code "Ant");
  ((2, 3, -5), Code "Ant"); ((3, 1, -4), Code "Ant");
  ((2, 2, -4), Code "Ant"); ((1, 3, -4), Code "Ant")],
 [Code "Ali"; Code "Bob"; Code "Ant"], 3);;


let test2 = ([((3, -4, 1), Code "Bob"); ((2, -4, 2), Code "Bob");
  ((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
  ((2, -5, 3), Code "Bob"); ((3, -6, 3), Code "Bob");
  ((-5, 3, 2), Code "Ali"); ((-3, 1, 2), Code "Ali");
  ((0, -2, 2), Code "Ali"); ((2, -3, 1), Code "Ali");
  ((4, -3, -1), Code "Ali"); ((4, -2, -2), Code "Ali");
  ((3, 3, -6), Code "Ant"); ((3, 2, -5), Code "Ant");
  ((2, 3, -5), Code "Ant"); ((3, 1, -4), Code "Ant");
  ((2, 2, -4), Code "Ant"); ((1, 3, -4), Code "Ant")],
 [Code "Ali"; Code "Bob"; Code "Ant"], 3);;


let test1 = ([((3, -4, 1), Code "Bob"); ((2, -4, 2), Code "Bob");
  ((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
  ((2, -5, 3), Code "Bob"); ((3, -6, 3), Code "Bob");
  ((-6, 3, 3), Code "Ali"); ((0, -1, 1), Code "Ali");
  ((-2, 1, 1), Code "Ali"); ((0, 0, 0), Code "Ali");
  ((-2, 0, 2), Code "Ali"); ((-1, -1, 2), Code "Ali");
  ((3, 3, -6), Code "Ant"); ((3, 2, -5), Code "Ant");
  ((2, 3, -5), Code "Ant"); ((3, 1, -4), Code "Ant");
  ((2, 2, -4), Code "Ant"); ((1, 3, -4), Code "Ant")],
 [Code "Ali"; Code "Bob"; Code "Ant"], 3);;

let test4 = ([((3, -4, 1), Code "Bob"); ((2, -1, -1), Code "Bob");
  ((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
  ((2, -5, 3), Code "Bob"); ((3, -6, 3), Code "Bob");
  ((-5, 3, 2), Code "Ali"); ((-3, 1, 2), Code "Ali");
  ((0, -2, 2), Code "Ali"); ((2, -3, 1), Code "Ali");
  ((3, -2, -1), Code "Ali"); ((2, 0, -2), Code "Ali");
  ((3, 3, -6), Code "Ant"); ((3, 2, -5), Code "Ant");
  ((2, 3, -5), Code "Ant"); ((3, 1, -4), Code "Ant");
  ((2, 2, -4), Code "Ant"); ((1, 3, -4), Code "Ant")],
 [Code "Ali"; Code "Bob"; Code "Ant"], 3);;

let test5 = ([((3, -4, 1), Code "Bob"); ((2, -4, -2), Code "Bob");
  ((1, -4, 3), Code "Bob"); ((3, -5, 2), Code "Bob");
  ((2, -5, 3), Code "Bob"); ((3, -6, 3), Code "Bob");
  ((-4, 2, 2), Code "Ali"); ((-3, 1, 2), Code "Ali");
  ((-1, 0, 1), Code "Ali"); ((1, -1, 0), Code "Ali");
  ((6, -3, -3), Code "Ali"); ((3, -2, -1), Code "Ali");
  ((3, 3, -6), Code "Ant"); ((3, 2, -5), Code "Ant");
  ((2, 3, -5), Code "Ant"); ((3, 1, -4), Code "Ant");
  ((2, 2, -4), Code "Ant"); ((1, 3, -4), Code "Ant")],
 [Code "Ali"; Code "Bob"; Code "Ant"], 3);;

(*les test pour la 29*)

coup_possibles test5 (-4,2,2);;

coup_possibles test1 (-1,-1,2);;

coup_possibles test2 (-5,3,2);;

coup_possibles test3 (-5,3,2);;

coup_possibles test4 (-5,3,2);;

(*utiliser la fonction affiche pour voir le figure de ces tests 
puis utiliser le lien https://www-verimag.imag.fr/~bassetni/display.html pour voir les coordonnees
  Ca c'est le fin de la question 29, les fonctions suivants sont mon brouillon *)


















(***********************************************************)

(* let tout_saut conf c = List.fold_left (fun acc x -> 
  (liste_coup_valide(saut_ligne (mettre_a_jour_configuration conf x) (der_liste(tire(x)))))@acc) 
  (saut_ligne conf c) (saut_ligne conf c);; *)


  (*Secours*)
(* let saut_ligne conf c = let x,y,z = (List.fold_left (fun acc x -> let saut_mul, confi, c1 = acc in
  if (est_saut c1 x confi) then 
    ((x >> (List.hd saut_mul))::saut_mul,(mettre_a_jour_configuration confi (Sm[c1;x])),x) else acc) ([Sm[c]],conf,c) (tout_ligne conf c)) in x;;


let saut_ligne conf c = List.fold_left (fun acc x -> 
  if (est_saut_multiple ((tire(List.hd(acc)))@[x]) conf) then (x >> (List.hd acc))::acc else acc) [Sm[c]] (tout_ligne conf c);; *)

(* let saut_ligne conf c = hd_liste(List.fold_left (fun acc x -> 
  if (est_saut_multiple [c;x] conf) then (x >> (der_liste acc))::acc else acc) [Sm[c]] (tout_ligne conf c));; *)
  (*every saut nearest*)


(* let tout_saut (conf: configuration) (c:case)= List.fold_left (fun acc x -> 
  let saut_liste = (saut_ligne (mettre_a_jour_configuration conf x) (der_liste(tire(x)))) in (liste_coup_valide(der_hd x saut_liste))@acc) 
  (saut_ligne conf c) (saut_ligne conf c);;


let tout_saut2 conf c = List.fold_left (fun acc x -> 
  let saut_liste = (saut_ligne (mettre_a_jour_configuration conf x) (der_liste(tire(x)))) in (liste_coup_valide(der_hd x saut_liste))@acc) 
  (saut_ligne conf c) (tout_saut conf c);; *)
  (****************************************************************)






(*************************************)
(* let rec aligne conf c v = let cl,coul,dim = conf in
  match translate c v with
  | x when not(est_dans_losagne x dim) -> []
  | _ -> if (est_saut_multiple [c;(translate c v)] conf) then 
    Sm([c;translate c v])::(aligne (mettre_a_jour_configuration conf (Sm([c;translate c v]))) (translate c v) (1,-1,0)) else (aligne conf c (translate v v));; *)





(* test = remplir_init ([Code"Ali"; Code "Bob"; Code "Ant"]) 3;; *)



(* let coup_possibles (cl,coul,dim: configuration) (c:case): (case*coup) list =
  List.fold_left (fun acc x -> 
    if (est_case(translate c x)) && est_dans_losagne (translate c x) dim && (quelle_couleur (translate c x) (cl,coul,dim)) = Libre 
      then ((translate c x),Du(c,x))::acc else acc) [] [(0,1,-1);(0,-1,1);(1,0,-1);(-1,0,1);(1,-1,0);(-1,1,0)];; *)


(* let vides conf c = List.fold_left (fun acc x -> 
  if (est_case(translate c x)) && est_dans_losagne (translate c x) dim && (quelle_couleur (translate c x) (cl,coul,dim)) = Libre 
    then ((translate c x),Du(c,x))::acc else acc) True [(0,1,-1);(0,-1,1);(1,0,-1);(-1,0,1);(1,-1,0);(-1,1,0)];;

let rec coups_pos (conf:configuration) (c:case): (case*coup) list = 
  match case with
  | *)


(* let rec point (cl,coul,dim:configuration) (n:int) = match n with
  | 0 -> Libre
  | _ -> if score (cl,coul,dim) = score_gagnant dim then List.hd coul else point (tourner_config (cl,coul,dim)) (n-1);;

affiche(est_partie (remplir_init [Code "Ali";Code "Bob";Code "Jim"] 3) ([Du((-4,1,3),(-3,0,3));Du((-4,2,2),(-3,1,2))]));; *) 
(*les trucs ici sont rien*)



(* let lignes (cl,coul,dim) c v n = match n with
  | 0 -> true
  | _ -> if (quelle_couleur (translate c v) (cl,coul,dim)) = Libre then lignes (cl,coul,dim) (translate c v) (n-1) else 
    if  *)
(***************************************)