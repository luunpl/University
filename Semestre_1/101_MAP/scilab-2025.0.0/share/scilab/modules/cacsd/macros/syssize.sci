// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA -
//
// Copyright (C) 2012 - 2016 - Scilab Enterprises
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

function [io,s] = syssize(sys)
    //Old stuff
    //  io=syssize(sys)
    //  [io,ns]=syssize(sys)
    //
    //   sys   : syslin list
    //   io    : io=[nout,nin]
    //                nout:  nb. outputs
    //                nin :  nb. inputs
    //   s    : nb states.

    arguments
        sys {mustBeA(sys, ["double", "lss", "r"])}
    end

    select type(sys)
    case 1 then
        msg = "%s: %s(Sl) is obsolete when Sl is a matrix of doubles.\n"
        msg = msprintf(msg, "syssize", "syssize");
        msg = [msg, msprintf(_("This feature will be permanently removed in Scilab %s"), "2026.0.0")]
        warning(msg) 
        io=size(sys)
        s=[]
    case 16 then
        sys1=sys(1)
        select sys1(1)
        case "lss" then
            io=size(sys("D")),
            [s,s]=size(sys("A"))
        case "r" then
            io=size(sys("den"))
            [lhs,rhs]=argn(0);
            if lhs==2 then  sys=tf2ss(sys);[s,s]=size(sys("A")),end
        end
    end
endfunction
