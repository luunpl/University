// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// Copyright (C) DIGITEO - 2011 - Allan CORNET
// Copyright (C) 2012 - 2016 - Scilab Enterprises
// Copyright (C) 2019 - Samuel GOUGEON
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

function [f, e] = log2(x)
    // x may be positive, negative, or complex
    arguments
        x {mustBeA(x, "double")}
    end

    if nargout == 1 then
        f = log(x) / log(2)
    else
        if ~isreal(x,0)
            msg = gettext("%s: Wrong value for input argument #%d: Real numbers expected.\n")
            error(msprintf(msg, "log2", 1))
        else
            x = real(x)
        end
        [f, e] = frexp(x)
    end
endfunction
