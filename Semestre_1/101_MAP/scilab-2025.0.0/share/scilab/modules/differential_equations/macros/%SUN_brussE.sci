// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
//
// Copyright (C) 2022 - Stéphane Mottelet
//
// This file must be used under the terms of GPL License
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available atsol
// https://www.gnu.org/licenses/gpl-3.0.txt

function dydt = %SUN_brussE(t,y,a)
    u=y(1); v=y(2); w=y(3);
    dydt = [a-(w+1)*u+v*u*u; w*u-v*u*u;-w*u];
end
