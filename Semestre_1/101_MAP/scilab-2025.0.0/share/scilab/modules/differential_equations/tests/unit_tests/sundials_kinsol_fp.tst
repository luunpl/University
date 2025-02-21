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


// fixed point iteration

function out = f(x)
    out = x^2-2; 
end
function out = g(x)
    out = x/2+1/x; 
end

x = kinsol(g,1,method="fixedPoint");
x = kinsol(f,1,method="Picard",jacobian=2);





