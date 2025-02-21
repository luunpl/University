// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2021 - UTC - Stéphane MOTTELET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 11600 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/11600
//
// <-- Short Description -->
// rand("foo") runs silently without returning an error

cmd = "rand(""foo"")";
msg = msprintf(_("%s: Wrong value for input argument #%d: ''%s'', ''%s'', ''%s'' or ''%s'' expected.\n"), "rand", 1,"info","seed","uniform","normal");
assert_checkerror(cmd,msg)

cmd = "rand(2,2,""foo"")";
msg = msprintf(_("%s: Wrong value for input argument #%d: ''%s'' or ''%s'' expected.\n"), "rand", 3, "uniform","normal");
assert_checkerror(cmd,msg)

cmd = "rand(2,""foo"")";
msg = msprintf(_("%s: Wrong value for input argument #%d: ''%s'' or ''%s'' expected.\n"), "rand", 2, "uniform","normal");
assert_checkerror(cmd,msg)
