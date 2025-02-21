// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 3DS - 2023 - Antoine ELIAS
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

//=============================================================================
function ifortCompiler = findmsifortcompiler()
    ifortCompiler = "unknown"; // unknown
    if getos() == "Windows" then
        if getenv("IFORT_COMPILER23", "") <> "" then
            ifortCompiler = "Intel oneAPI HPC 2023";
        elseif getenv("IFORT_COMPILER22", "") <> "" then
            ifortCompiler = "Intel oneAPI HPC 2022";
        end
    else // NOT Windows
        ifortCompiler = "unknown"; // unknown
    end
endfunction
//=============================================================================


