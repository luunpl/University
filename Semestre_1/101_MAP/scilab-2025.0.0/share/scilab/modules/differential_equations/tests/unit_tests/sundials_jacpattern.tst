// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
//
// Copyright (C) 2022 - UTC - Stéphane Mottelet
//
// This file must be used under the terms of GPL License
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// https://www.gnu.org/licenses/gpl-3.0.txt

// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->

function dydt = vdp(t,y,mu)
    dydt = [y(2,:)
            mu*(1-y(1,:).*y(1,:)).*y(2,:)-y(1,:)];
end

function out=vdpJac(t,y,mu)
    out = [0 1
          -2*mu*y(1)*y(2)-1 mu*(1-y(1)*y(1))];
end

mu = 1;
y0 = [2;1];

tspan = 0:0.1:10;

sp = sparse([0 1;1 1]);
[t,y,info0] = cvode(list(vdp,mu), tspan, y0, method="BDF");
[t,y,info1] = cvode(list(vdp,mu), tspan, y0, jacobian=vdpJac);
[t,y,info2] = cvode(list(vdp,mu), tspan, y0, jacPattern=sp);

function out=fun(t,f)
    out = LAP*f - f.*f.*f + f + 2;
endfunction

function out=jac(t,f)
    d = -3*f.*f+1;
    out = LAP+diag(sparse(d));
endfunction

// define square domain [-1,1] x [-1,1]
n = 50;
x=linspace(-1,1,n);
y=x;
[X,Y]=meshgrid(x,x);

// build finite differences operators
dx=x(2)-x(1);
d1x=sparse(ones(n-1,1));
d0x=sparse(ones(n,1));
lap = (diag(d1x,-1)+diag(d1x,1)-2*diag(d0x))/dx/dx;
// use Kronecker product to build matrix of d/dx^2 and d/dy^2
LAP = lap .*. speye(n,n) + speye(n,n) .*. lap;

f0 = ones(n*n,1);

[t,y0,info0]=cvode(fun,tspan,f0,method="BDF");
[t,y1,info1]=cvode(fun,tspan,f0,jacBand=[n n]);
[t,y2,info2]=cvode(fun,tspan,f0,jacPattern=LAP);
[t,y3,info3]=cvode(fun,tspan,f0,jacobian=jac);

assert_checkalmostequal(y0,y1,1e-7);
assert_checkalmostequal(y0,y2,1e-7);
assert_checkalmostequal(y0,y3,1e-7);
assert_checkalmostequal(y1,y2,1e-7);
assert_checkalmostequal(y1,y3,1e-7);
assert_checkalmostequal(y2,y3,1e-7);

assert_checkequal(info1.stats.nRhsEvalsFD,303);
assert_checkequal(info2.stats.nRhsEvalsFD,15);
assert_checkequal(info3.stats.nRhsEvalsFD,0);

assert_checktrue(info0.stats.eTime/info1.stats.eTime > 10);
assert_checktrue(info0.stats.eTime/info2.stats.eTime > 30);
assert_checktrue(info0.stats.eTime/info3.stats.eTime > 30);

OPT.method="DIRK_5";
OPT.rtol=1e-12;
OPT.atol=1e-9;
[t,y0,info0]=arkode(fun,tspan,f0,options=OPT);
[t,y1,info1]=arkode(fun,tspan,f0,jacBand=[n n],options=OPT);
[t,y2,info2]=arkode(fun,tspan,f0,jacPattern=LAP,options=OPT);
[t,y3,info3]=arkode(fun,tspan,f0,jacobian=jac,options=OPT);

assert_checkalmostequal(y0,y1,1e-7);
assert_checkalmostequal(y0,y2,1e-7);
assert_checkalmostequal(y0,y3,1e-7);
assert_checkalmostequal(y1,y2,1e-7);
assert_checkalmostequal(y1,y3,1e-7);
assert_checkalmostequal(y2,y3,1e-7);

assert_checkequal(info1.stats.nRhsEvalsFD,909);
assert_checkequal(info2.stats.nRhsEvalsFD,45);
assert_checkequal(info3.stats.nRhsEvalsFD,0);

assert_checktrue(info0.stats.eTime/info1.stats.eTime > 5);
assert_checktrue(info0.stats.eTime/info2.stats.eTime > 5);
assert_checktrue(info0.stats.eTime/info3.stats.eTime > 5);
