// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Sylvestre LEDRU
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
//
// <-- INTERACTIVE TEST -->
//
// <-- Non-regression test for bug 8830 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/8830
//
// <-- Short Description -->
// In call_scilab, TerminateScilab  did not clear the last error.

// Define Variables as decribed in the Makefile
// make bug_8830
// ./bug_8830

// "getLastErrorValue 0" must be displayed
