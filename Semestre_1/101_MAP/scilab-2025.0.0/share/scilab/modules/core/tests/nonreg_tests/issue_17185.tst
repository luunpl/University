// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2024 - Dassault Systemes - Cedric DELAMARRE
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for issue 17185 -->
//
// Windows only: this test needs a GUI mode Scilab
// that cannot be launched yet on the Linux CI (Docker + SCI_JAVA_ENABLE_HEADLESS).
// the -nogui with WScilex return an error on windows only.
// <-- WINDOWS ONLY -->
// <-- NO CHECK REF -->
//
// <-- Short Description -->
// Scilab freeze at exit and -nogui ignored

// avoid warning popup at Scilab exit() (the issue is not reproductible using quit())
doc = xmlRead(SCIHOME + "/XConfiguration.xml");
pref = xmlXPath(doc, "//confirmation-dialogs/body/tools/tool");
savedState = pref(1).attributes.state;
xmlSetAttributes(pref(1).attributes, ["state", "unchecked"]);
xmlWrite(doc);

// check no freeze
scilabBin = """" + WSCI + "\bin\WScilex""";
err = unix(scilabBin + " -e ""plot2d();exit()"" --timeout 2m");
xmlSetAttributes(pref(1).attributes, ["state", savedState]);
xmlWrite(doc);
assert_checktrue(err == 0);

// check that -nogui return an error with WScilex
err = unix(scilabBin + "-cli -nogui ");
assert_checktrue(err <> 0);