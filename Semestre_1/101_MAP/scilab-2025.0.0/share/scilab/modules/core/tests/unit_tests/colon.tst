// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - INRIA - Michael Baudin
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->

// With start, stop integers
computed = 1:4;
expected = [1 2 3 4];
assert_checkequal(computed, expected);
// With start, step, stop integers
computed=1:2:5
expected = [1 3 5]
assert_checkequal(computed, expected);
// With start before stop
computed=size(1:0)
expected = [0 0]
assert_checkequal(computed, expected);
// With start before stop, whatever the step
computed=size(1:1:0)
expected = [0 0]
assert_checkequal(computed, expected);
// With start, step, stop reals
a=(1-0.9)*50
computed=(1:a)
expected = [1 2 3 4 5]
assert_checkalmostequal(computed, expected);
// With start, step, stop reals
step=(1-0.9)*20
computed=1:step:10
expected = [1 3 5 7 9]
assert_checkalmostequal(computed, expected);

// new or empty variable
clear x;x(:)=42;
assert_checkequal(x, 42);
x=[]; x(:)=42;
assert_checkequal(x, 42);

clear x; for i=1:3, x(i,:) = 1:2;, end
assert_checkequal(x, [1;1;1] * (1:2));

x=[];x(2,:)=1:2;
assert_checkequal(x, [0, 0; 1, 2]);
x=[];x(:,2)=1:2;
assert_checkequal(x, [0, 1; 0, 2]);
x=[];x(:)=1:2;
assert_checkequal(x, 1:2);
x=[];x(:)=(1:2)';
assert_checkequal(x, (1:2)');
