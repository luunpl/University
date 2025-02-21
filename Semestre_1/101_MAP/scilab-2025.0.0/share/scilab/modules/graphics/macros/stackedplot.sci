// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2022 - 3DS - Adeline CARNIS
// Copyright (C) 2022 - 3DS - Antoine ELIAS
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

function varargout = stackedplot(varargin)
    combineMatchingNames = %t;
    tss = list();
    linespec = [];
    varnames = [];
    inSameAxe = [];
    legendLabels = "";
    markArg = list();
    titleFigure = [];
    yLabels = [];

    colors = ["2773BF";"D15104";"E7B000";"7A2F90";"7CAC22";"61BFF0";"9B102D"];
    colors = hex2dec([part(colors, 1:2), part(colors, 3:4), part(colors, 5:6)]);

    function out = isLinespec(val)
        out = [];
        regexps = ["/(-[-\.]?|:)/", "/([rgbcmykw])/", "/([\+o\*\.xsd\^v><p])/"];

        for i = 1:size(val, "*")
            v = val(i);
            res = [];
            try
                for j = 1:size(regexps, "*")
                    [a, b, c, res($+1)] = regexp(v, regexps(j));
                    v = strsubst(v, res($), "");
                end
            catch
            end
            out(i) = v == "";
        end

        out = and(out);
    endfunction

    function res = getLinespec(val)
        res = [];
        regexps = ["/(-[-\.]?|:)/", "/([rgbcmykw])/", "/([\+o\*\.xsd\^v><p])/"];

        try
            for i = 1:size(regexps, "*")
                [a, b, c, res(1, $+1)] = regexp(val, regexps(i));
                val = strsubst(val, res($), "");
            end
        catch
            res = [];
        end
    endfunction

    function update_margins(f)
        k = size(f.children, "*");
        margins = f.children.margins;

        if k > 2 then
            axes_bounds = f.children.axes_bounds;           

            j = 0.2 / k;
            v = axes_bounds(1, 4) / 10;

            axes_bounds(2:$-1, 4) = axes_bounds(2:$-1, 4) - j;
            for i = k:-1:2
                axes_bounds(i-1, 2) = axes_bounds(i, 2) + axes_bounds(i, 4) + v;
            end
    
            margins(:, 3:4) = 0;
            margins(1, 4) = 0.25;
            margins(k, 3) = 0.25;
            f.children.axes_bounds = axes_bounds;
            
        elseif k == 2 then
            margins(:, 3:4) = [0.05 0.2;0.2 0.05];
        end

        f.children.margins = margins;
    endfunction

    if nargin == 0 then
        n = 100;
        t = seconds(1:n)';
        y1 = floor(10 * rand(n, 3)) + 10;
        ts1 = timeseries(t, y1(:, 1), y1(:, 2), y1(:, 3), "VariableNames", ["Time", "Var 1", "Var 2", "Var3"]);

        y2 = floor(10 * rand(n, 2)) + 20;
        ts2 = timeseries(t, y2(:, 1), y2(:, 2), "VariableNames", ["Time", "Var 1", "Var 2"]);
        f = stackedplot(ts1, ts2);
        if nargout
            varargout(1) = f;
        end
        return
    end

    //list of ts
    for i = 1:size(varargin)
        if typeof(varargin(i)) == "timeseries" then
            tss($+1) = varargin(i);
        else
            break;
        end
    end

    rhs = i;
    fname = "stackedplot";
    //process other parameters
    while rhs < =nargin
        select varargin(rhs)
        case "Title"
            titleFigure = varargin(rhs + 1);
            if type(titleFigure) <> 10 then
                error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), fname, rhs + 1));
            end
            rhs = rhs + 2;
        case "DisplayLabels"
            yLabels = varargin(rhs + 1);
            if type(yLabels) <> 10 then
                error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), fname, rhs + 1));
            end
            rhs = rhs + 2;
        case "CombineMatchingNames"
            combineMatchingNames = varargin(rhs + 1);
            if type(combineMatchingNames) <> 4 then
                error(msprintf(_("%s: Wrong type for input argument #%d: boolean expected.\n"), fname, rhs + 1));
            end
            rhs = rhs + 2;
        case "LegendLabels"
            legendLabels = varargin(rhs + 1);
            if type(legendLabels) <> 10 then
                error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), fname, rhs + 1));
            end
            if size(legendLabels, "*") <> size(tss) then
                error(msprintf(_("%s: Wrong size for input argument #%d: Must be the same size as the number of timeseries.\n"), fname, rhs + 1));
            end
            rhs = rhs + 2;
        else //probably a linespec
            arg = varargin(rhs);
            if type(arg) == 10 then
                err = %f;
                if isLinespec(arg) then
                    if size(arg,  "*") == 1 then
                        linespec(length(tss)) = "";
                        linespec(:) = arg;
                    else
                        if size(arg, "*") == length(tss) then
                            linespec = arg;
                        else
                            error(msprintf(_("%s: The number of Linespec must be equal to the number of timeseries in input.\n"), fname));
                        end
                    end
                elseif grep(arg, "mark") then
                        markArg($+1) = arg;
                        rhs = rhs + 1;
                        markArg($+1) = varargin(rhs)
                else
                    //varnames
                    varnames = varargin(rhs);
                    names = [];
                    for ts = tss
                        names = [names ts.Properties.VariableNames(2:$)];
                    end
                    
                    [a,b] = members(varnames, names);
                    if a == 0 then
                        err = %t;
                    end
                end
                if err then
                    error(msprintf(_("%s: Wrong value for input argument #%d: a valid LineSpec or VariableName expected.\n"), fname, rhs))
                end
            elseif type(arg) == 1 then
                //varnames
                for ts = tss
                    a = arg + 1;
                    a(a > size(ts.Properties.VariableNames, "*")) = [];
                    if a <> [] then
                        varnames = [varnames ts.Properties.VariableNames(a)];
                    end
                end
                [varnames, k] = unique(varnames);
                varnames = varnames(k);

            elseif typeof(arg) == "ce" then
                // c = {["Toto", "Titi"]', "Tutu"};
                varnames = arg;
                varN = [];
                for i = 1:size(arg, "*")
                    input = arg{i};
                    s = size(input, "*");
                    if iscolumn(input) then
                        input = input';
                    end
                    varN = [varN, input];
                    inSameAxe = [inSameAxe, i * ones(1, s)];
                end

                names = [];
                for ts = tss
                    names = [names ts.Properties.VariableNames(2:$)];
                end
                [a,b] = members(varN, names);
                if a == 0 then
                    error(msprintf(_("%s: Use only the VariableNames of timeseries.\n"), fname));
                end
            end
            rhs = rhs + 1;
        end
    end

    if typeof(varnames) == "ce" then
        combineMatchingNames = %t;
    end

    //check timeseries have the same timeline
    datatime = tss(1).vars(1).data;
    for i = 2:size(tss)
        if datatime <> tss(i).vars(1).data then
            error(msprintf(_("%s: timeseries must have the same timeline.\n"), fname));
        end
    end

    if typeof(tss(1).vars(1).data) == "duration" then
        x = tss(1).vars(1).data.duration;
        isDuration = %t;
    else //datetime
        x = tss(1).vars(1).data.date * 24*60*60 + tss(1).vars(1).data.time;
        isDuration = %f;
    end

    stacked = list();
    labels = [];
    xLabel = [];

    for i = 1:size(tss)
        ts = tss(i);
        xLabel($+1) = ts.props.variableNames(1);
        for j = 2:size(ts.vars, "*")
            if type(ts.vars(j).data) == 1 | typeof(ts.vars(j).data) == "datetime" | typeof(ts.vars(j).data) == "duration" then
                st = [];
                st.ts = i;
                st.var = j;
                st.ylabel = ts.props.variableNames(j);
                st.thickness = 2;
                st.type = typeof(ts.vars(j).data);
                st.line_style = 1;

                if combineMatchingNames then
                    if varnames <> [] then
                        if typeof(varnames) == "ce" then
                            for k = 1:size(varnames, "*")
                                vars = varnames{k};
                                idx = find(st.ylabel == vars);
                                if idx <> [] then
                                    if definedfields(stacked) == [] || and(definedfields(stacked) <> k) then 
                                        if size(tss) > 1 then
                                            st.line_style = idx;
                                        end
                                        stacked(k) = [];
                                        stacked(k)(idx + size(vars, "*")*(i-1)) = st;
                                    else
                                        if size(tss) > 1 then
                                            if i == 1 then
                                                st.line_style = idx;
                                            else
                                                st.line_style = stacked(k)(idx).line_style;
                                            end
                                        end
                                        stacked(k)(idx + size(vars, "*")*(i-1)) = st;
                                    end
                                end
                            end
                        else
                            // varnames is string or indices
                            idx = find(st.ylabel == varnames);
                            if idx <> [] then
                                if labels == [] | ~isfield(labels, st.ylabel) then
                                    stacked(idx) = st;
                                    labels(st.ylabel) = idx;
                                else
                                    stacked(labels(st.ylabel)) = [stacked(labels(st.ylabel)) st];
                                end
                            end
                        end
                    else
                        idx = find(st.ylabel == fieldnames(labels));
                        if idx <> [] then
                            stacked(labels(st.ylabel)) = [stacked(labels(st.ylabel)) st];
                        else
                            stacked($+1) = st;
                            labels(st.ylabel) = length(stacked);
                        end
                    end
                else
                    if varnames <> [] then
                        if inSameAxe <> [] then
                            m = max(inSameAxe);
                            idx = find(st.ylabel == varnames);
                            if idx <> [] then
                                if definedfields(stacked) == [] || and(definedfields(stacked) <> inSameAxe(idx) + (i - 1) * m) then 
                                    stacked($+1) = st;
                                else
                                    stacked(inSameAxe(idx) + (i - 1) * m) = [stacked(inSameAxe(idx) + (i - 1) * m) st];
                                end
                            end
                        else
                            if members(st.ylabel, varnames) <> 0 then
                                stacked($+1) = st;
                            end
                        end
                    else
                        stacked($+1) = st;
                    end
                    
                end
            end
        end
    end

    if yLabels <> [] then
        if inSameAxe <> [] then
            if size(yLabels, "*") <> size(unique(inSameAxe), "*") then
                error(msprintf(_("%s: DisplayLabels must be the same size as the number of variables.\n"), fname));
            end
        else
            names = []
            for t = stacked
                names = [names; list2vec(t.ylabel)];
            end
            names = unique(names);
            if size(yLabels, "*") <> size(names, "*") then
                error(msprintf(_("%s: DisplayLabels must be the same size as the number of variables.\n"), fname));
            end
        end
    end

    xLabel = unique(xLabel);
    if size(xLabel, "*") <> 1 then
        xLabel = "Time";
    end

    //open a new plot
    f = scf();
    f.immediate_drawing = "off";

    stackedsize = size(stacked);
    m = 0;
    for i = 1:stackedsize
        info = stacked(i);
        subplot(size(stacked), 1, i);

        for j = 1:size(info, "*")
            var = info(j);
            y = tss(var.ts).vars(var.var).data;

            if var.type == "duration" then
                fmt = y.format;
                y = y.duration;
            elseif var.type == "datetime" then
                fmt = y.format;
                y = y.date * 24*60*60 + y.time;
                if or(y < 0) then
                    y(y < 0) = %nan;
                end
            end

            if linespec <> [] then
                e = plot(x, y, linespec(var.ts), markArg(:));
            else
                e = plot(x, y, markArg(:));
            end

            e.thickness = var.thickness;

            if linespec == [] then
                s = size(colors, "r");
                if size(tss) > 1 then
                    c = modulo(var.ts-1, s) + 1;
                else
                    c = modulo(j - 1, s) + 1;
                end
                e.foreground = color(colors(c, 1), colors(c, 2), colors(c, 3));
                e.line_style = var.line_style;
            end
        end

        a = gca();
        if i <> stackedsize then
            a.axes_visible(1) = "off";
        end
        a.box = "off";
        a.tight_limits = "on";
        a.sub_ticks  = [0 4];

        yticks = a.y_ticks;
        loc = linspace(a.data_bounds(3), a.data_bounds(4), length(yticks(2))+1)'

        if var.type == "duration" then
            d = duration(0, 0, zeros(loc), "OutputFormat", fmt);
            d.duration = loc;
            labels = string(d);
        elseif var.type == "datetime" then //datatime
            d = datetime(zeros(loc), 1, 1, "OutputFormat", fmt);
            d.date = floor(loc / (24*60*60));
            labels = string(d);
        else
            labels = string(loc)
        end

        a.y_ticks = tlist(["ticks", "locations", "labels"], loc, labels);

        if yLabels <> [] then
            if combineMatchingNames then
                ytext = yLabels(i);
            else
                ytext = yLabels(info(1).var - 1);
            end
        else
            ytext = list2vec(info.ylabel);
        end
        [tmp, k] = unique(ytext);
        yy(k) = tmp;
        ylabel(yy)
        m = max(m, max(length(yy)))

        clear yy;

        if size(info, "*") > 1 | legendLabels <> "" then
            t = "";
            if size(ytext, "*") > 1 then
                if legendLabels <> "" then
                    t = legendLabels(list2vec(info.ts))' + " - ";
                end
                hl = legend(t + ytext)
            else
                t = list2vec(info.ylabel);
                hl = legend(t)
            end
            hl.line_width = 0.03;
            hl.font_size = 2
        end
    end
    //update_margins(f)


    a = f.children(1);
    a.x_label.text = xLabel;

    l = length(a.x_ticks.locations)
    if l < 10 then
        l = l + 1;
    end
    loc = round(linspace(a.data_bounds(1), a.data_bounds(2), l))'

    if isDuration then
        d = duration(0, 0, zeros(loc), "OutputFormat", datatime.format);
        d.duration = loc;
        labels = string(d);
    else
        d = datetime(zeros(loc), 1, 1, "OutputFormat", datatime.format);
        d.date = floor(loc / (24*60*60));
        d.time = modulo(loc, 24*60*60);
        labels = string(d);
    end
    a.x_ticks = tlist(["ticks", "locations", "labels"], loc, labels);

    if titleFigure <> [] then
        title(f.children($), titleFigure)
        f.children($).title.font_style = 8;
    end

    f.axes_size = f.axes_size + 1;
    f.axes_size = f.axes_size - 1;
    f.immediate_drawing = "on";

    // manage font_angle instead of the length of ylabel
    if m < 16 then
        for i = 1:size(f.children, "*")
            a = f.children(i)
            a.y_label.font_angle = 0;
        
            if m > 7 then
                c = 0.15:0.01:0.22;
                idx = find(m == 8:15);
                a.margins(1) = c(idx);
            end
        end
    end

    if nargout
        varargout(1) = f;
    end
    
endfunction


