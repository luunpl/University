// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2023 - Dassault Systemes - Cedric DELAMARRE
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->
// <-- LINUX ONLY -->
//
// <-- Short Description -->
// This test is used to execute other tests

// This test only work with a release due to include and libs path
if isdir("SCI/../../share") then
    cd(SCI + "/modules/call_scilab/tests/nonreg_tests")
    assert_checkequal(unix("make clean all"), 0);
    //assert_checkequal(unix("./bug_7601"), 255);
    assert_checkequal(unix("./bug_7602"), 0);
    assert_checkequal(unix("./bug_8115"), 0);
    assert_checkequal(unix("./bug_8830"), 0);
    assert_checkequal(unix("make clean"), 0);
end
