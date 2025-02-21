// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024 - 3DS - Antoine ELIAS
//
// For more information, see the COPYING file which you should have received
// along with this program.

function help(varargin)
    msg = sprintf("%s is obsolete. Please use %s.\n", "help", "doc")
    warning(msg)

    doc(varargin(:));
endfunction
