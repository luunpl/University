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
// <-- Non-regression test for bug 16122 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/16122
//
// <-- Short Description -->
// polynomials with different variables are concatenated without error

message = [ msprintf(gettext("Undefined operation for the given operands.\n"))
            msprintf(gettext("check or define function %s for overloading.\n"),"%p_c_p")];
assert_checkerror("[%s,%z]",message)