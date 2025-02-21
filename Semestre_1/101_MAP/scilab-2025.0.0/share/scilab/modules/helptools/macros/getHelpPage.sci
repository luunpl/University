function page = getHelpPage(key, lang)
    arguments
        key (1, 1) string
        lang (1, 1) string = getlanguage()
    end

    [page, name] = getPage(key, "scilab", lang);
    if page == [] then
        //look in toolbox
        global %inline_help;
        tbx = fieldnames(%inline_help);
        tbx(tbx == "scilab") = [];
        for t = tbx'
            [page, name] = getPage(key, t, lang);
            if page <> [] then
                ret = page;
            end
        end

        printf(_("%s: Requested help page ""%s"" does not exist.\n"), "help", key);
        return;
    end
end

function [page, name] = getPage(key, domain, lang)
    page = [];
    name = key;
    loadInlineHelp(lang)
    global %inline_help;

    if ~isfield(%inline_help(domain), lang) then
        if lang <> "en_US" then
            page = getPage(key, domain, "en_US");
            if page == [] then
                //try in toolbox help page
                disp("tbx");
            end
            return;
        end
    end

    l = %inline_help(domain)(lang).links;
    if ~isfield(l, key) then
        //try with some permutations for short key (factorial)
        if length(key) <= 8  then
            ret = perms(strsplit(key)');
            ret = strcat(ret, "", "c");
            ret = find(members(fieldnames(%inline_help(domain)(lang).links), ret));
            if ret <> [] then
                [page, name] = getPage(fieldnames(%inline_help(domain)(lang).links)(ret(1)), domain, lang);
                return;
            end
        end

        if lang <> "en_US" then
            page = getPage(key, domain, "en_US");
        end
        return;
    end

    link = l(key);
    if ~isfield(%inline_help(domain)(lang), "pages") then
        loadInlineHelp(lang, %t);
    end

    page = %inline_help(domain)(lang).pages(link);
end
