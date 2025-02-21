// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2019 - Samuel GOUGEON
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for bug 16227 -->
//
// <-- WINDOWS ONLY -->
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/16227
//
// <-- Short Description -->
// WSCI was not available among environment variables

assert_checkequal(getenv("WSCI"), WSCI)
assert_checktrue(dos("dir %WSCI%"))
