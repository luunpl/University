// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - Digiteo - Jean-Baptiste Silvy
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->
// <-- NO CHECK REF -->

// <-- Non-regression test for bug 4221 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/4221
//
// <-- Short Description -->
// graypolarplot uses to much memory.
//

rho=1:256;
theta=(1:360)./180.*%pi;
z=30+round(theta'*(1+rho.^2));
f=gcf();
f.color_map= hot(128);
clf();
graypolarplot(theta,rho,z);
close(winsid());

// It's just a 256x360 matrix, it should not complain about memory
