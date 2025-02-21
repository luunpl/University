// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024 - UTC - Stéphane MOTTELET
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

function varargout = captions(h,strings,location)
    arguments
        h {mustBeA(h, "handle")}
        strings string
        location string = "in_upper_right" 
    end
    if argn(1) > 1
        error(msprintf(_("%s: Wrong number of output argument(s): At most %d expected.\n"), "captions", 1));
    end
    if size(h,"*") <> size(strings,"*")
        error(msprintf(_("%s: Wrong size for input arguments #%d and #%d: Incompatible length.\n"), "captions", 1, 2));
    end
    warnobsolete("legend", "2026.0");
    
    if  argn(1)==1
        varargout(1) = %_legend(h($:-1:1),strings,location);
    else
        %_legend(h($:-1:1),strings,location);
    end
endfunction
