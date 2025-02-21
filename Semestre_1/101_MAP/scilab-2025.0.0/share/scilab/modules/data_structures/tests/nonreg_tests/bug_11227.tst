// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - Scilab Enterprises - Vincent COUVERT
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->

// <-- Non-regression test for bug 11227 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/11227
//
// <-- Short Description -->
// Scilab crashed when trying to use a structure with a non-existing field name containing "%"

// Existing field name
a = struct();
a("toto%")=2;
assert_checkequal(a("toto%"), 2);

clear a

// Non-existing field name
refMsg = msprintf(gettext("Field \""%ls\"" does not exist\n"),"toto");
a = struct();
assert_checkerror("a(""toto"")", refMsg);
