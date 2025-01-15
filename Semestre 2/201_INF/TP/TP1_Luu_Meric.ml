(* This is an OCaml editor.
   Enter your program here and send it to the toplevel using the "Eval code"
   button or [Ctrl-e]. *)

let max3 (a:int) (b:int) (c:int) : int = 
  if a >= b && a >=c  then a
  else if b >= a && b >= c then b
  else c ;;

max3 3 5 7