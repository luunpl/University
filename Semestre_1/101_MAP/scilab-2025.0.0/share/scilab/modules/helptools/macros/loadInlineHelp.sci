// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024 - 3DS - Antoine ELIAS
// For more information, see the COPYING file which you should have received
// along with this program.

function loadInlineHelp(lang, page)
    arguments
        lang (1, 1) string = []
        page (1, 1) boolean = %f //by default load only links
    end

    global %inline_help;
    if %inline_help == [] || ...
            ~isfield(%inline_help, "scilab") || ...
            ~isfield(%inline_help.scilab, lang) || ...
            (page && ~isfield(%inline_help.scilab(lang), "pages")) then
        //load "lang" links
        filename = fullfile(SCI, "modules", "helptools", "inline", lang, "links.json");
        if isfile(filename) then
            %inline_help.scilab(lang).links = fromJSON(filename, "file");
            if page then
                filename = fullfile(SCI, "modules", "helptools", "inline", lang, "pages.json");
                if isfile(filename) then
                    data = fromJSON(filename, "file");
                    %inline_help.scilab(lang).pages = fromJSON(filename, "file");
                end
            end
        end
    end
end
