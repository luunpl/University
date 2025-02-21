// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2020 - UTC - Stéphane MOTTELET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 16350 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/16350
//
// <-- Short Description -->
// In if/while conditions, the empty sparse boolean is considered as TRUE.

a = sparse(1)<2;
a(1) = [];
b = 1;
if a, b = 2; end
assert_checkequal(b,1);
