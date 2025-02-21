// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2014 - Scilab Enterprises - Charlotte HECQUET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 10336 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/10336
//
// <-- Short Description -->
// Default key of rand is changed from "uniform" to "normal"

x=rand(100,1);
assert_checkequal(rand("info"), "uniform");
cmd = "x=rand(100,0,""norm"")";
msg = msprintf("%s: Wrong value for input argument #%d: %s or %s expected.\n","rand",3,"''uniform''","''normal''");
assert_checkerror(cmd,msg);