//<-- CLI SHELL MODE -->
// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - S/E - Sylvestre LEDRU
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->

a=$**2;
assert_checkequal(a, $**2); // Was doing a segfault in Scilab 6 as some point
a=[1,2,3;4,5,6];
assert_checkequal(a($),6);

b = [1 2 3;4 5 6;7 8 9];
assert_checkequal(b(1,$),3);

assert_checkequal(b($,2),8);
assert_checkequal(b($,$),9);

// Add a row at the end of the matrix b
b($+1,:) = [1 1 1];
b_ref = [1 2 3;4 5 6;7 8 9;1 1 1];
assert_checkequal(b, b_ref);

// new or empty variable
clear x;x(1:2)=42;
assert_checkequal(x, [42; 42]);
x=[]; x(1:2)=42;
assert_checkequal(x, [42; 42]);
clear x;x($+1:$+2)=42;
assert_checkequal(x, [42; 42]);
x=[]; x($+1:$+2)=42;
assert_checkequal(x, [42; 42]);

clear x; x(1:0)=42
assert_checkequal(x, []);
x=[]; x(1:0)=42
assert_checkequal(x, []);
clear x; x(1:$)=42
assert_checkequal(x, []);
x=[]; x(1:$)=42
assert_checkequal(x, []);
