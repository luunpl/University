// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
//
// Copyright (C) 2021 - Stéphane Mottelet
//
// This file must be used under the terms of GPL License
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available atsol
// https://www.gnu.org/licenses/gpl-3.0.txt

function vdot=%SUN_vdp1(t, v)
    mu = 1;
    vdot = [v(2); mu*(1-v(1)^2)*v(2)-v(1)]
end
