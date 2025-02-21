// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024 - 3DS - Antoine ELIAS
// For more information, see the COPYING file which you should have received
// along with this program.

function generated_files = xmltoinline(dirs,titles,directory_language,default_language)

    select nargin
    case 0 then
        generated_files = xmltoformat("inline");
    case 1 then
        generated_files = xmltoformat("inline",dirs);
    case 2 then
        generated_files = xmltoformat("inline",dirs,titles);
    case 3 then
        generated_files = xmltoformat("inline",dirs,titles,directory_language);
    case 4 then
        generated_files = xmltoformat("inline",dirs,titles,directory_language,default_language);
    else
        error(msprintf(gettext("%s: Wrong number of input argument(s): At most %d expected.\n"), "xmltoinline", 4));
    end
endfunction
