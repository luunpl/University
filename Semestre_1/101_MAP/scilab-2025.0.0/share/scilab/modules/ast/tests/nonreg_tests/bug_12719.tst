// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2020 - UTC - Stéphane MOTTELET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 12719 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/12719
//
// <-- Short Description -->
//A(%s) gives the same result as A($)

A = [1 2;3 4];
assert_checkerror("A(%s)",msprintf(_("Invalid index.\n")))
