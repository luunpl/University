// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
//
// Copyright (C) 2022 - Stéphane Mottelet
//
// This file must be used under the terms of GPL License
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// https://www.gnu.org/licenses/gpl-3.0.txt

// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->

function out=res(t,y,yd)
    x=y(1:2);
    xd=yd(1:2);
    u=y(3:4);
    ud=yd(3:4);
    lambda=y(5);
    out=[xd-u
         ud+x*lambda+[0;1]
         x'*u];
endfunction

tspan = [7.4162987092054876];
y0=[1;0;0;0;0];
yd0=[0;0;0;-1;0];

[t,y]=ida(res,tspan,y0,yd0,t0=0,yIsAlgebraic=5,suppressAlg=%t);
