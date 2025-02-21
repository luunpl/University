// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2018 - UTC - Stéphane MOTTELET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 15024 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/15024
//
// <-- Short Description -->
// After A=10;  A{1}=2  corrupts A and silently fails

msg = sprintf(_("[error] Cell contents reference from a non-cell array object.\n")); 
assert_checkerror("A=10;A{1}=2", msg);
