// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA - F. Delebecque
// Copyright (C) 2012 - 2016 - Scilab Enterprises
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

function Aclosed=h_cl(P,r,K)
    //[Aclosed]=h_cl(P,r,K)
    //Given the standard plant P (with r=size(P22)) and the controller
    //K (computed e.g. by h_inf) this macro returns the closed loop
    //matrix Aclosed whose poles allows to checks the internal stability
    //of the closed loop system.
    //Aclosed is the A matrix of [I -P22;-K I]^-1;
    //!

    if and(typeof(P)<>["rational","state-space"]) then
        error(msprintf(gettext("%s: Wrong type for input argument #%d: Linear state space or a transfer function expected.\n"),"h_cl",1))
    end

    
    [LHS,RHS]=argn(0);
    if RHS==2 then //h_cl(P,K)
        K=r;
        [P, K] = %h_cl1(P, K)
        [A,B2,C2,D22]=abcd(P);
    elseif RHS==3 then //h_cl(P,r,K)
        [P, K] = %h_cl2(P, r, K)
        r=int(r);
        [A,B1,B2,C1,C2,D11,D12,D21,D22]=smga(P,r);
    end    

    [Ac,Bc,Cc,Dc]=abcd(K);
    [n,pp]=size(B2);[ndc1,ndc2]=size(Dc);[nd1,nd2]=size(D22);
    [m,q]=size(Bc);
    Bw=[B2, zeros(n,ndc2); zeros(m,pp), Bc];
    [n1,m2]=size(Cc);
    [n2,m1]=size(C2);
    Cw=[zeros(ndc1,m1), Cc;  C2, zeros(n2,m2)];
    Aclosed=[A, zeros(n,m); zeros(m,n), Ac] +...
      Bw*inv([eye(ndc1,ndc1),-Dc;-D22,eye(nd1,nd1)])*Cw;
endfunction

function [P, K] = %h_cl1(P, K)
    arguments
        P {mustBeA(P, ["r", "lss"])}
        K {mustBeA(K, ["r", "lss"])}
    end

    if typeof(P) == "rational" then
        P = tf2ss(P);
    end

    if typeof(K) == "rational" then
        K = tf2ss(K);
    end

endfunction

function [P, K] = %h_cl2(P, r, K)
    arguments
        P {mustBeA(P, ["r", "lss"])}
        r {mustBeA(r, "double"), mustBeReal, mustBeVector, mustBePositive}
        K {mustBeA(K, ["r", "lss"])}
    end

    if typeof(P) == "rational" then
        P = tf2ss(P);
    end

    if typeof(K) == "rational" then
        K = tf2ss(K);
    end

    if size(r, "*") <> 2 then
        error(msprintf(gettext("%s: Wrong size for input argument #%d: A vector of size %d expected.\n"), "h_cl", 2, 2));
    end

endfunction
