// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2014 - Scilab Enterprises - Paul Bignier
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
//
// <-- NO CHECK REF -->
//
// <-- Non-regression test for bug 13512 -->
//
// <-- GitLab URL -->
//https://gitlab.com/scilab/scilab/-/issues/13512
//
// <-- Short Description -->
// dae crashed if the evaluation function had wrong prototype

y0 = 0;
t0 = 0;
t  = 1;

// ==================================================================
// DASSL

// -------------------------------
// With initial yprime computation

// The evaluation function purposely lacks the output argument 'ires'
deff("ydot = f1(t, y, ydot)", "ydot = y.^2 - y*sin(t) + cos(t)")

refMsg = [msprintf(_("%s: Wrong number of output argument(s): %d expected.\n"), "f1", 2);
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_dassl", "dassl")];

assert_checkerror("y = dae(y0, t0, t, f1);", refMsg);

// The evaluation function purposely lacks the input argument 'ydot'
deff("[ydot,ires] = f2(t, y)", "ydot = y.^2 - y*sin(t) + cos(t)");

refMsg = [msprintf(_("Wrong number of input arguments.\n"));
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_dassl", "dassl")];
assert_checkerror("y = dae(y0, t0, t, f2);", refMsg);

// ----------------------------------
// Without initial yprime computation

// The evaluation function purposely lacks the output argument 'ires'
refMsg = [msprintf(_("%s: Wrong number of output argument(s): %d expected.\n"), "f1", 2);
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_dassl", "dassl")];
assert_checkerror("y = dae([y0; 0], t0, t, f1);", refMsg);

// The evaluation function purposely lacks the input argument 'ydot'
refMsg = [msprintf(_("Wrong number of input arguments.\n"));
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_dassl", "dassl")];
assert_checkerror("y = dae([y0; 0], t0, t, f2);", refMsg);


// ==================================================================
// DASRT

deff("r = g(t, y)", "r = ones(y)");

// -------------------------------
// With initial yprime computation

// The evaluation function purposely lacks the output argument 'ires'
refMsg = [msprintf(_("%s: Wrong number of output argument(s): %d expected.\n"), "f1", 2);
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_dasrt", "ddasrt")];
assert_checkerror("[y, r] = dae(""root"", y0, t0, t, f1, 1, g);", refMsg);

// The evaluation function purposely lacks the input argument 'ydot'
refMsg = [msprintf(_("Wrong number of input arguments.\n"));
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_dasrt", "ddasrt")];
assert_checkerror("[y, r] = dae(""root"", y0, t0, t, f2, 1, g);", refMsg);

// ----------------------------------
// Without initial yprime computation

// The evaluation function purposely lacks the output argument 'ires'
refMsg = [msprintf(_("%s: Wrong number of output argument(s): %d expected.\n"), "f1", 2);
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_dasrt", "ddasrt")];
assert_checkerror("[y, r] = dae(""root"", [y0; 0], t0, t, f1, 1, g);", refMsg);

// The evaluation function purposely lacks the input argument 'ydot'
refMsg = [msprintf(_("Wrong number of input arguments.\n"));
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_dasrt", "ddasrt")];
assert_checkerror("[y, r] = dae(""root"", [y0; 0], t0, t, f2, 1, g);", refMsg);


// ==================================================================
// DASKR

deff("r = g(t, y, yd)", "r = ones(y)");

// -------------------------------
// With initial yprime computation

// The evaluation function purposely lacks the output argument 'ires'
refMsg = [msprintf(_("%s: Wrong number of output argument(s): %d expected.\n"), "f1", 2);
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_daskr", "ddaskr")];
assert_checkerror("[y, r] = dae(""root2"", y0, t0, t, f1, 1, g);", refMsg);

// The evaluation function purposely lacks the input argument 'ydot'
refMsg = [msprintf(_("Wrong number of input arguments.\n"));
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_daskr", "ddaskr")];
assert_checkerror("[y, r] = dae(""root2"", y0, t0, t, f2, 1, g);", refMsg);

// ----------------------------------
// Without initial yprime computation

// The evaluation function purposely lacks the output argument 'ires'
refMsg = [msprintf(_("%s: Wrong size for output argument #%d: A matrix of size %d expected.\n"), "g", 1, 1);
msprintf(_("%ls: An error occurred in ''%ls'' subroutine.\n"), "%_daskr", "ddaskr")];
assert_checkerror("[y, r] = dae(""root2"", [y0; 0], t0, t, f1, 1, g);", refMsg);

// The evaluation function purposely lacks the input argument 'ydot'
assert_checkerror("[y, r] = dae(""root2"", [y0; 0], t0, t, f2, 1, g);", refMsg);
