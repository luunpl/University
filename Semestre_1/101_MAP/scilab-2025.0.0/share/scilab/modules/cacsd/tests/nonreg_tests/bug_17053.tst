// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2023 - Dassault Systèmes - Clément DAVID
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->

// <-- Non-regression test for bug 17053 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/17053
//
// <-- Short Description -->
// 
// 

v = ones(1,20);
[d,n,e] = arl2(v, poly(1,'z','c'),1);
ldiv(n,d,100);
[d,n,e] = arl2(v,d,3);
ldiv(n,d,100);
[d,n,e] = arl2(v,d,8);
ldiv(n,d,100);
