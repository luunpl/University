// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024 - 3DS - Antoine ELIAS
// For more information, see the COPYING file which you should have received
// along with this program.

function loadToolboxInlineHelp(path, domain, lang)
    arguments
        path (1, 1) string
        domain (1, 1) string
        lang (1, 1) string = ""
    end

    if lang == "" then
        dirs = listfiles(fullfile(path, "inline"));
        for d = dirs'
            if isdir(fullfile(path, "inline", d)) then
                loadToolboxInlineHelp(path, domain, d);
            end
        end

        return;
    end

    global %inline_help;
    if %inline_help == [] || ...
            ~isfield(%inline_help, domain) || ...
            ~isfield(%inline_help(domain), lang) || ...
            (page && ~isfield(%inline_help(domain)(lang), "pages")) then
        //load "lang" links
        filename = fullfile(path, "inline", lang, "links.json");
        if isfile(filename) then
            %inline_help(domain)(lang).links = fromJSON(filename, "file");
            filename = fullfile(path, "inline", lang, "pages.json");
            if isfile(filename) then
                %inline_help(domain)(lang).pages = fromJSON(filename, "file");
            end
        end
    end
end
