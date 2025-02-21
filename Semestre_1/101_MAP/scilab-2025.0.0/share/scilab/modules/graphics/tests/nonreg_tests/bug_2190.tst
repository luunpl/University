// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2008 - INRIA - Jean-Baptiste Silvy
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->
// <-- ENGLISH IMPOSED -->

// <-- Non-regression test for bug 2190 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/2190
//
// <-- Short Description -->
// Scilab crashes when trying to plot2d huge amounts of data.
n = 20000000;
p = 1:n;
q = n:-1:1;
plot2d(p,q)

// scilab should display an error message, but not crash.
