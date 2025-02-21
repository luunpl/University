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

function dydt = %SUN_brussI(t,y,b,ep)
    w=y(3);
    dydt = [0; 0; (b-w)/ep];
end
