// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2018 - UTC - Stéphane MOTTELET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for bug 15762 -->
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/15762
//
// <-- Short Description -->
// error() refuses multiline error messages (regression)

string = ["line 1";"line 2"];
assert_checkerror('error(string)',string)
assert_checkerror('error(999,string)',string)
assert_checkerror('error(string,999)',string)
