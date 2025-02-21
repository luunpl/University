// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 8148 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/8148
//
// <-- Short Description -->
// fscanfMat did not read matrix file with tabulation as default separator.
//

ierr = execstr("r = fscanfMat(""SCI/modules/fileio/tests/nonreg_tests/bug_8148.txt"");", "errcatch");
if ierr <> 0 then pause,end
if size(r,'c') <> 3 then pause,end
if size(r,'r') <> 116 then pause,end
if r(1:3) <> [0 30 60] then pause,end
