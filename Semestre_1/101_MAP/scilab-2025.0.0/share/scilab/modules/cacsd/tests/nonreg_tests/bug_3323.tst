// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - INRIA - Serge Steer
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 3323 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/3323
//
// <-- Short Description -->
//   In ss2tf.sci, it is claimed that one may enter the second argument, rmax, as "b".
z=poly(0,'z');
h=[1,1/z;1/(z^2+1),z/(z^2-2)];
if norm(coeff((clean(ss2tf(tf2ss(h),'b'))-h).num),1) >100*%eps then pause,end
