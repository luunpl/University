// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024- 3DS - Adeline CARNIS
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.


function [varargout] = dasrt(varargin)
    warnobsolete("dae", "2026.0.0");
    if nargout == 0 then
        nargout = 1;
    end
    c = "[" + strcat("varargout(" + string(1:nargout) + ")", ", ") + "] = %_dasrt(varargin(:))";
    execstr(c);
endfunction
