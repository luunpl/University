program pgcd1 ;
var	a, b, x, y : integer ;
begin
	a := 27 ;
	b := 9 ;
	x := a ;
	y := b ;
	while x <> y do
		if x > y then x := x - y
			 else y := y - x ;
	writeln('le pgcd de', a:3, ' et', b:3, ' est', x:3) ;
end.

