// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2018 - Samuel GOUGEON
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->
// <-- INTERACTIVE TEST -->

// <-- Non-regression test for bug 15418 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/15418
//
// <-- Short Description -->
// With colordef("black") and colordef("none"), titles and axes labels were
//  invisible or almost invisible.

colordef("none")
close(winsid())
scf(1);
param3d(), xtitle("General title","X title","Y title", "Z title")
scf(2);
plot(), xtitle("General title","X title","Y title")
// Check that titles are well visible in white

colordef("black")
close(winsid())
scf(1);
param3d(), xtitle("General title","X title","Y title", "Z title")
scf(2);
plot(), xtitle("General title","X title","Y title")
// Check that titles are well visible in white

colordef("white")
close(winsid())
scf(1);
param3d(), xtitle("General title","X title","Y title", "Z title")
scf(2);
plot(), xtitle("General title","X title","Y title")
// Check that titles are well visible in black on grey (unchanged)

colordef("default")
close(winsid())
scf(1);
param3d(), xtitle("General title","X title","Y title", "Z title")
scf(2);
plot(), xtitle("General title","X title","Y title")
// Check that titles are well visible in black on white (unchanged)
