// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2018 - UTC - Stéphane MOTTELET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 15512 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/15512
//
// <-- Short Description -->
// after aborting a running script or macro (with abort or other), console print not working

mputl('abort',fullfile(TMPDIR,"tmp.sce"));
mode(2)
exec(fullfile(TMPDIR,"tmp.sce"),-1)
assert_checkequal(mode(),2)