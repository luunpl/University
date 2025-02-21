// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2008 - INRIA - Jean-Baptiste Silvy
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- INTERACTIVE TEST -->
// <-- TEST WITH GRAPHIC -->

// <-- Non-regression test for bug 2547 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/2547
//
// <-- Short Description -->
// export of very circle marks of very small size in postscript are not displayed

plot(1:10,'.')
e = gce().children;
e.mark_size_unit = "point";
e.mark_style = 0;
e.mark_size = 1;

fig = gcf();
xs2eps(fig.figure_id, TMPDIR+"/test.eps");
// check that the dots are present in the exported file.



