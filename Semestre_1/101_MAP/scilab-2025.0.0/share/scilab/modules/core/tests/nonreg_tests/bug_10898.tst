// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024 - 3DS - Cedric Delamarre
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for bug 10898 -->
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/10898
//
// <-- Short Description -->
// Introduce new tests for pipes

if getos() == "Windows" then
    sciCli = WSCI + "\bin\Scilex";
    sciAdvCli = WSCI + "\bin\WScilex-cli";
else
    sciCli = strsplit(SCI, "share/scilab")(1) + "/bin/scilab-cli";
    sciAdvCli = strsplit(SCI, "share/scilab")(1) + "/bin/scilab-adv-cli";
end

[resp, ierr, msgerr] = unix_g("echo %pi | "+sciCli+" -nb");
assert_checkequal(ierr, 0);
resp(find(resp=="")) = [];
[expected, ierr, msgerr] = unix_g(sciCli+" -nb -quit -e %pi");
assert_checkequal(ierr, 0);
expected(find(expected=="")) = [];
assert_checkequal(resp, expected);

[resp, ierr, msgerr] = unix_g("echo %pi | "+sciAdvCli+" -nb");
assert_checkequal(ierr, 0);
resp(find(resp=="")) = [];
[expected, ierr, msgerr] = unix_g(sciAdvCli+" -nb -quit -e %pi");
assert_checkequal(ierr, 0);
expected(find(expected=="")) = [];
assert_checkequal(resp, expected);

