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

function r = %SUN_sir(t,y,yp)
    r = [yp(1)+0.2*y(1)*y(2)
         yp(2)-0.2*y(1)*y(2)+0.05*y(2)  
          y(1)+y(2)+y(3)-1];
end
