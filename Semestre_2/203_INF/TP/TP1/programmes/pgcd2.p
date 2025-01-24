program pgcd1 ;
var	a, b, x, y : integer ;
begin
	writeln('Ce programme calcule le pgcd de 2 nombres entiers') ;
	writeln('Tapez le premier au clavier, suivi de return') ;
	read(a) ;
	writeln('Tapez le deuxieme au clavier, suivi de return') ;
	read(b) ;
	x := a ;
	y := b ;
	while x <> y do
		if x > y then x := x - y
			 else y := y - x ;
	writeln('le pgcd de', a:3, ' et', b:3, ' est', x:3) ;
end.

