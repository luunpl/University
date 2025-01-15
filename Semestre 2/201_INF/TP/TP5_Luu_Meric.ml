(*Factorielle*)
(*Q1*)
let rec fact (n:int) : int =
  if n = 0 then 1 else n * fact (n-1);;

(*Q2*)
fact 4;;

(*Q3*)
(*fact -1 ne termine jamais*)

(*Q4*) 
       
(*let fact2 (n:int) : int =
  if n = 0 then 1 else n * fact2 (n-1);;

Error: Unbound value fact2
Hint: Did you mean fact?
Hint: If this is a recursive definition,
you should add the 'rec' keyword on line 1*)

(*Q5*)
let rec fact3 (n:int) : int =
  match n with
  |0 -> 1
  |n -> n * fact3 (n-1);;
fact3 4;;


(*Somme d’entiers bâton*)
type baton = string (* dont les caractères sont uniquement des | *) ;;
type n = int;;

(*Q1*)
let addition_baton (b1:baton) (b2:baton) : baton =
  b1 ^ b2;;

(*Q3*)
let natVbaton1 (n : int) : string =
  String.make n '|';;

(*Q4*)
let rec natVbaton2 (n : int) : string =
  if n = 0 then "" else "|" ^ natVbaton2 (n-1);;
natVbaton2 10 ;;

let rec natVbaton (n : int) : baton =
  match n with
  | 0 -> "" 
  | _ -> "|" ^ natVbaton (n - 1) ;;
natVbaton 7;;

(*Q5*)
let batonVnat (baton : string) : int =
  String.length baton;; 
batonVnat "||||||" ;;

(*Q6*)
let mult (b1:baton) (b2 : baton) : baton =
  natVbaton ((batonVnat b1) * (batonVnat b2));;
mult "|||" "||";;
  
(*Quotient et reste de la division entière*)
(*Q1*)
type n = int;; (*N different a 0*)

(*Q2
(1) (quotient a b) = a mod b  si a > b
(2) (quotient a b) = 0 sinon*)

(*Q3*)
let quotient (a : int) (b : int) : int =
  a / b;;
quotient 17 5;;

(*Q4*)
let reste (a : int) (b : int) : int =
  a mod b;;
reste 17 5;;

(*Q5. Q6, Q7*)
let qr1 (a : int) (b : int) : int*int =
  (quotient a b, reste a b);;
qr1 17 5;;

(*Q8*)
let rec qr2 (a : int) (b : int) : int * int =
  if a < b then (0, a)  
  else let q, r = qr2 (a - b) b in (q + 1, r) ;;
qr2 17 5;;
