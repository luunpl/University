// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2006-2008 - INRIA - Jean-Baptiste SILVY <jean-baptiste.silvy@inria.fr>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->
// <-- NO CHECK REF -->

// <-- Non-regression test for bug 1587 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/1587
//
// <-- Short Description -->
//    Changing the colormap with the graphic editor of a not selected figure do not
//    modify the colormap as expected. The colormap of the figure which should be
//    modified is not the entered one. The selected figure colormap is also changed
//    with the entered colormap. Moreover, Scilab often crash some time after this bug
//    occures.

// test the modification on a figure which is not current
f1 = gcf() ;
plot3d ;

f2 = scf() ;
hc = jet(21) ;
f2.color_map = hc ;
plot3d ;

// change the colormap of the first window
jc = jet(45) ;
f.color_map = jc ;

// check that the colormaps are well copied
if abs( max( f.color_map - jc ) ) > 1e-8 then pause,end
if abs( max(f2.color_map)-max(hc) ) > 1e-8 then pause,end
close(winsid());