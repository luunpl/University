// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2023 - Dassault Systemes - Bruno JOFRET
// Copyright (C) 2023 - 3DS - Antoine ELIAS
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- NO CHECK REF -->
// <-- CLI SHELL MODE -->

// test parsing && declaration
function checkAllCombination(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24)
    arguments
        // arguments checks
        v1
        v2 (1,:)
        v3 double
        v4 (1,:) double
        v5 {mustBePositive}
        v6 {mustBeMember(v6, "value")}
        v7 (1,:) {mustBePositive}
        v8 (1,:) {mustBeMember(v8, "value")}
        v9 double {mustBePositive}
        v10 double {mustBeMember(v10, "value")}
        v11 (1,:) double {mustBePositive}
        v12 (1,:) double {mustBeMember(v12, "value")}
        // with defaults values
        v13 = 42
        v14 (1,:) = 42
        v15 double = 42
        v16 (1,:) double = 42
        v17 {mustBePositive} = 42
        v18 {mustBeMember(v18, "value")} = 42
        v19 (1,:) {mustBePositive} = 42
        v20 (1,:) {mustBeMember(v20, "value")} = 42
        v21 double {mustBePositive} = 42
        v22 double {mustBeMember(v22, "value")} = 42
        v23 (1,:) double {mustBePositive} = 42
        v24 (1,:) double {mustBeMember(v24, "value")} = 42
        // comment line
    end
end

function checkbody(body)
    if assert_checkerror(strcat(body, ascii(10)), [], 999) == %f then
        error("error");
    end
endfunction

// non existing parameter
body = [...
"function test1()"
"    arguments"
"        x"
"    end"
"end"];

checkbody(body)

// wrong order
body = [...
"function test1(x, y)"
"    arguments"
"        y"
"        x"
"    end"
"end"];

checkbody(body)

// dims
body = [...
"function test1(x)"
"    arguments"
"        x (a, :)"
"    end"
"end"];

checkbody(body)

body = [...
"function test1(x)"
"    arguments"
"        x (%f, :)"
"    end"
"end"];

checkbody(body)

// type
body = [...
"function test1(x)"
"    arguments"
"        x float"
"    end"
"end"];

checkbody(body)

// default value
body = [...
"function test1(x, y)"
"    arguments"
"        x = 12"
"        y"
"    end"
"end"];

checkbody(body)

// validation functions
body = [...
"function test1(x)"
"    arguments"
"        x {mustBeSomething}"
"    end"
"end"];

checkbody(body)

body = [...
"function test1(x)"
"    arguments"
"        x {mustBeMember}"
"    end"
"end"];

checkbody(body)

body = [...
"function test1(x)"
"    arguments"
"        x {mustBeMember(x, 1, 2)}"
"    end"
"end"];

checkbody(body)

body = [...
"function test1(x)"
"    arguments"
"        x {mustBeInRange(x, 1)}"
"    end"
"end"];

checkbody(body)

body = [...
"function test1(x)"
"    arguments"
"        x {mustBeMember(x, rand())}"
"    end"
"end"];

checkbody(body)

body = [...
"function test1(x)"
"    arguments"
"        x {mustBeMember(x, [""s"", 1])}"
"    end"
"end"];

checkbody(body)

body = [...
"function test1(x)"
"    arguments"
"        x {mustBeMember(x, null())}"
"    end"
"end"];

checkbody(body)

body = [...
"function test1(x)"
"    arguments"
"    end"
"end"];

checkbody(body)

//variable present in argument
body = [...
"function test1(x)"
"    arguments"
"    end"
"end"];

checkbody(body)

//dims
function call_dims(varargin)
    res = varargin($);

    assert_checktrue(test_dims())
end

function res = test_dims(m, n, x)
    arguments
        m (1, 1)
        n (1, 1)
        x (m, n)
    end

    res = %t;
end

test_dims(1, 1, 1);
test_dims(1, 1, 1 + %i);
test_dims(1, 10, rand(1, 10));
test_dims(10, 1, rand(10, 1));
test_dims(10, 10, rand(10, 10));

//default value
function test_default1(x)
    arguments
        x = 42
    end

    assert_checkequal(x, 42);
end

test_default1();

function test_default2(x, y)
    arguments
        x
        y = x
    end

    assert_checkequal(x, y);
end

test_default2(42);

//validators
//mustBeA
function test_mustBeA(a, b, c, d, e, f, g, h, i, j, k)
    arguments
        a {mustBeA(a, "double")}
        b {mustBeA(b, "constant")}
        c {mustBeA(c, "bool")}
        d {mustBeA(d, "string")}
        e {mustBeA(e, "int")}
        f {mustBeA(f, "uint64")}
        g {mustBeA(g, "list")}
        h {mustBeA(h, "cell")}
        i {mustBeA(i, "struct")}
        j {mustBeA(j, "function")}
        k {mustBeA(k, "custom")}
    end
end

st = struct("field", 1);
custom = mlist(["custom", "field"], 1);
test_mustBeA(42, 2+4*%i, %t, "scilab", int64(42), uint64(12), list(1, 2, 3), {"toto", %t, [1 2 3]}, st, cos, custom)

//transtypage
//* -> string
function test_string(x, ref)
    arguments
        x string
        ref
    end

    assert_checkequal(x, ref);
end

vref = [0 1 2;3 4 5];
test_string(vref, string(vref))
test_string(vref + vref*%i, string(vref + vref*%i))
test_string(int8(vref), string(vref))
test_string(uint8(vref), string(vref))
test_string(int16(vref), string(vref))
test_string(uint16(vref), string(vref))
test_string(int32(vref), string(vref))
test_string(uint32(vref), string(vref))
test_string(int64(vref), string(vref))
test_string(uint64(vref), string(vref))
test_string(modulo(vref, 2) == 1, ["F" "T" "F";"T" "F" "T"])
test_string(["F" "T" "F";"T" "F" "T"], ["F" "T" "F";"T" "F" "T"])


//* -> double
function test_double(x, ref)
    arguments
        x double
        ref
    end

    assert_checkequal(x, ref);
end

vref = [0 1 2;3 4 5];
test_double(vref, vref)
test_double(vref + vref*%i, vref + vref*%i)
test_double(int8(vref), vref)
test_double(uint8(vref), vref)
test_double(int16(vref), vref)
test_double(uint16(vref), vref)
test_double(int32(vref), vref)
test_double(uint32(vref), vref)
test_double(int64(vref), vref)
test_double(uint64(vref), vref)
test_double(modulo(vref, 2) == 1, modulo(vref, 2))
test_double(string(vref), vref)
//test_double(string(vref + vref*%i), vref + vref*%i) //not managed

//* -> int
function test_int(x, ref)
    arguments
        x int
        ref
    end

    assert_checkequal(x, ref);
end

vref = [0 1 2;3 4 5];
test_int(vref, int32(vref))
test_int(int8(vref), int32(vref))
test_int(uint8(vref), int32(vref))
test_int(int16(vref), int32(vref))
test_int(uint16(vref), int32(vref))
test_int(int32(vref), int32(vref))
test_int(uint32(vref), int32(vref))
test_int(int64(vref), int32(vref))
test_int(uint64(vref), int32(vref))
test_int(string(vref), int32(vref))

function test_uint(x, ref)
    arguments
        x uint
        ref
    end

    assert_checkequal(x, ref);
end

vref = [0 1 2;3 4 5];
test_uint(vref, uint32(vref))
test_uint(int8(vref), uint32(vref))
test_uint(uint8(vref), uint32(vref))
test_uint(int16(vref), uint32(vref))
test_uint(uint16(vref), uint32(vref))
test_uint(int32(vref), uint32(vref))
test_uint(uint32(vref), uint32(vref))
test_uint(int64(vref), uint32(vref))
test_uint(uint64(vref), uint32(vref))
test_uint(string(vref), uint32(vref))

//* -> bool
function test_bool(x, ref)
    arguments
        x bool
        ref
    end

    assert_checkequal(x, ref);
end

vref = [0 1 0;1 0 1];
test_bool(vref, vref == 1)
test_bool(int8(vref), vref == 1)
test_bool(uint8(vref), vref == 1)
test_bool(int16(vref), vref == 1)
test_bool(uint16(vref), vref == 1)
test_bool(int32(vref), vref == 1)
test_bool(uint32(vref), vref == 1)
test_bool(int64(vref), vref == 1)
test_bool(uint64(vref), vref == 1)
test_bool(vref == 1, vref == 1)
test_bool(string(vref == 1), vref == 1)

//varargin
function r = test_varargin(a, varargin)
    arguments
        a
        varargin
    end

    r = nargin;
endfunction

assert_checkequal(test_varargin(1), 1);
assert_checkequal(test_varargin(1, 2), 2);
assert_checkequal(test_varargin(1, 2, 3), 3);

code = [
    "function test_varargin(a, b, varargin)"
    "    arguments"
    "        a"
    "        b"
    "    end"
    "endfunction"
];

checkbody(code);

code = [
    "function test_varargin(a, b, varargin)"
    "    arguments"
    "        a"
    "        b"
    "        varargin (3)"
    "    end"
    "endfunction"
];

checkbody(code);

//overload of size function
function test_size(a)
    arguments
        a (1, :)
    end
endfunction

test_size(1/%s);
test_size(table(1));
test_size(table([1, 2]));

function test_size(a)
    arguments
        a (3)
    end
endfunction

test_size(list(1, 2 ,3))

