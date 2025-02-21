// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2015 - Scilab Enterprises - Charlotte HECQUET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 14159 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/14159
//
// <-- Short Description -->
// Matplot crashes Scilab on boolean input

errmsg = msprintf(_("%s: Wrong type for input argument #%d: A real or integer expected.\n"), "Matplot", 1);
assert_checkerror("Matplot(%f)", errmsg);
