// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2019 - UTC - Stéphane MOTTELET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 16152 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/16152
//
// <-- Short Description -->
//after s = spzeros(2,3), s([]) returns [] instead of sparse([])

s = sprand(5,5,0.5);
sEmpty = s([]);
assert_checkequal(sEmpty, sparse([]));

sb = s > 0;
sbEmpty = sb([]);
assert_checkequal(typeof(sbEmpty), "boolean sparse");
assert_checkequal(size(sbEmpty), [0,0]);


