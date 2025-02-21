// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2023 - 3DS - Antoine ELIAS
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- NO CHECK REF -->
// <-- CLI SHELL MODE -->

// mustBePositive
function foo(a)
    arguments
        a {mustBePositive}
    end
endfunction

foo(1);
assert_checkerror("foo(0)", [], 999);
assert_checkerror("foo(-1)", [], 999);
clear foo;

// mustBeNonpositive
function foo(a)
    arguments
        a {mustBeNonpositive}
    end
endfunction

foo(-1);
foo(0);
assert_checkerror("foo(1)", [], 999);
clear foo;

// mustBeNonnegative
function foo(a)
    arguments
        a {mustBeNonnegative}
    end
endfunction

foo(1);
foo(0);
assert_checkerror("foo(-1)", [], 999);
clear foo;

// mustBeNegative
function foo(a)
    arguments
        a {mustBeNegative}
    end
endfunction

foo(-1);
assert_checkerror("foo(0)", [], 999);
assert_checkerror("foo(1)", [], 999);
clear foo;

// mustBeFinite
function foo(a)
    arguments
        a {mustBeFinite}
    end
endfunction

foo(0);
assert_checkerror("foo(%nan)", [], 999);
assert_checkerror("foo(%inf)", [], 999);
clear foo;

// mustBeNonNan
function foo(a)
    arguments
        a {mustBeNonNan}
    end
endfunction

foo(0);
foo(%inf);
assert_checkerror("foo(%nan)", [], 999);
clear foo;

// mustBeNonzero
function foo(a)
    arguments
        a {mustBeNonzero}
    end
endfunction

foo(1);
foo(-1);
assert_checkerror("foo(0)", [], 999);
clear foo;

// mustBeNonsparse
function foo(a)
    arguments
        a {mustBeNonsparse}
    end
endfunction

foo(1);
assert_checkerror("foo(sparse(1))", [], 999);
clear foo;

// mustBeReal
function foo(a, b)
    arguments
        a {mustBeReal(a, b)}
        b = 0
    end
endfunction

foo(1);
foo(complex(1, 0));
foo(complex(1, %eps), %eps);
assert_checkerror("foo(%i)", [], 999);
assert_checkerror("foo(complex(0, 1))", [], 999);
clear foo;

// mustBeInteger
function foo(a)
    arguments
        a {mustBeInteger}
    end
endfunction

foo(1);
assert_checkerror("foo(1.1)", [], 999);
assert_checkerror("foo(%t)", [], 999);
clear foo;

// mustBeGreaterThan
function foo(a)
    arguments
        a {mustBeGreaterThan(a, 10)}
    end
endfunction

foo(11);
assert_checkerror("foo(10)", [], 999);
assert_checkerror("foo(9)", [], 999);
clear foo;

// mustBeLessThan
function foo(a)
    arguments
        a {mustBeLessThan(a, 10)}
    end
endfunction

foo(9);
assert_checkerror("foo(10)", [], 999);
assert_checkerror("foo(11)", [], 999);
clear foo;

// mustBeGreaterThanOrEqual
function foo(a)
    arguments
        a {mustBeGreaterThanOrEqual(a, 10)}
    end
endfunction

foo(10);
foo(11);
assert_checkerror("foo(9)", [], 999);
clear foo;

// mustBeLessThanOrEqual
function foo(a)
    arguments
        a {mustBeLessThanOrEqual(a, 10)}
    end
endfunction

foo(10);
foo(9);
assert_checkerror("foo(11)", [], 999);
clear foo;

// mustBeA
function foo(a)
    arguments
        a {mustBeA(a, "double")}
    end
endfunction

foo(10);
assert_checkerror("foo(%f)", [], 999);
clear foo;

// mustBeNumeric
function foo(a)
    arguments
        a {mustBeNumeric}
    end
endfunction

foo(10);
foo(int8(1));
assert_checkerror("foo(%t)", [], 999);
assert_checkerror("foo(%s)", [], 999);
clear foo;

// mustBeNumericOrLogical
function foo(a)
    arguments
        a {mustBeNumericOrLogical}
    end
endfunction

foo(10);
foo(int8(1));
foo(%t);
assert_checkerror("foo(%s)", [], 999);
clear foo;

// mustBeNumericOrBoolean
function foo(a)
    arguments
        a {mustBeNumericOrBoolean}
    end
endfunction

foo(10);
foo(int8(1));
foo(%t);
assert_checkerror("foo(%s)", [], 999);
clear foo;

// mustBeNonempty
function foo(a)
    arguments
        a {mustBeNonempty}
    end
endfunction

foo(1);
assert_checkerror("foo([])", [], 999);
clear foo;

// mustBeScalarOrEmpty
function foo(a)
    arguments
        a {mustBeScalarOrEmpty}
    end
endfunction

foo(1);
foo([]);
assert_checkerror("foo([1 2])", [], 999);
clear foo;

// mustBeVector
function foo(a)
    arguments
        a {mustBeVector}
    end
endfunction

foo(1:2);
assert_checkerror("foo([])", [], 999);
assert_checkerror("foo([1 2; 3 4])", [], 999);
clear foo;

// mustBeMember
function foo(a)
    arguments
        a {mustBeMember(a, [1, 2])}
    end
endfunction

foo(1);
foo(2);
assert_checkerror("foo([])", [], 999);
assert_checkerror("foo(4)", [], 999);
clear foo;

// mustBeInRange
function foo(a)
    arguments
        a {mustBeInRange(a, 0, 10)}
    end
endfunction

foo(0);
foo(10);

assert_checkerror("foo(-1)", [], 999);
assert_checkerror("foo(11)", [], 999);
clear foo;

// mustBeFile
function foo(a)
    arguments
        a {mustBeFile}
    end
endfunction

foo("SCI/etc/scilab.start");

assert_checkerror("foo(""SCI/etc/balics.trats"");", [], 999);
clear foo;

// mustBeFolder
function foo(a)
    arguments
        a {mustBeFolder}
    end
endfunction

foo("SCI/etc");

assert_checkerror("foo(""SCI/cte"");", [], 999);
clear foo;

// mustBeNonzeroLengthText
function foo(a)
    arguments
        a {mustBeNonzeroLengthText}
    end
endfunction

foo("SCI/bin");

assert_checkerror("foo("""");", [], 999);
clear foo;

// mustBeValidVariableName
function foo(a)
    arguments
        a {mustBeValidVariableName}
    end
endfunction

foo("toto");

assert_checkerror("foo(""1toto"");", [], 999);
clear foo;

// mustBeEqualDims
function foo(a, b)
    arguments
        a {mustBeEqualDims(a, b)}
        b {mustBeEqualDims(b, a)}
    end
endfunction

foo(ones(1, 1), ones(1, 1));
foo(ones(1, 2), ones(1, 2));
foo(ones(2, 1), ones(2, 1));
foo(ones(2, 2), ones(2, 2));

assert_checkerror("foo(ones(1, 2), ones(2, 1));", [], 999);
assert_checkerror("foo(ones(2, 1), ones(1, 2));", [], 999);
clear foo;

// mustBeSameType
function foo(a, b)
    arguments
        a {mustBeSameType(a, b)}
        b {mustBeSameType(b, a)}
    end
endfunction

foo(1, 1);
foo(int8(1), int16(1));

assert_checkerror("foo(1, %t);", [], 999);
clear foo;

// mustBeEqualDimsOrScalar
function foo(a, b)
    arguments
        a {mustBeEqualDimsOrScalar(a, b)}
        b {mustBeEqualDimsOrScalar(b, a)}
    end
endfunction

foo(ones(1, 1), ones(1, 1));
foo(ones(1, 2), ones(1, 2));
foo(ones(1, 2), ones(1, 1));
foo(ones(2, 1), ones(2, 1));
foo(ones(2, 1), ones(1, 1));
foo(ones(2, 2), ones(2, 2));
foo(ones(2, 2), ones(1, 1));

assert_checkerror("foo(ones(1, 2), ones(2, 1));", [], 999);
assert_checkerror("foo(ones(2, 1), ones(1, 2));", [], 999);
clear foo;

