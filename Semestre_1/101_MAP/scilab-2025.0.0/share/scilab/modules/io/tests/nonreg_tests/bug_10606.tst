//<-- CLI SHELL MODE -->
// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - Charlotte Hecquet
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for bug 10606 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/10606
//
// <-- Short Description -->
//[rep,stat,stderr]=unix_g("diff /etc/passwd /etc/group")

//Shows only
// stderr  =
//     []
// stat  =
//    1.
// rep  =

if getos()=="Windows"
    [rep,stat,stderr]=unix_g("fc "+SCI+"/CHANGES.md "+SCI+"/COPYING");

else

    [rep,stat,stderr]=unix_g("diff "+SCI+"/CHANGES.md "+SCI+"/COPYING");

end

assert_checkfalse(rep == []);
