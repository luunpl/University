// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2017 - Samuel GOUGEON
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- ENGLISH IMPOSED -->
//
// <-- Non-regression test for bug 15239 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/15239
//
// <-- Short Description -->
// The console's properties .tag and .userdata were not displayed

c = get(0);
c.userdata = [1 2 ; 3 4];
c.tag = "myConsoleName";
c
