Welcome to Scilab 2025.0.0
==========================

This file details the changes between Scilab 2025.0.0 (this version), and the previous 2024.1.0 release.
For changelogs of earlier releases, please see [Scilab 2024.1.0][1].

Summary:

- New features
- Obsolete functions & features
- Removed functions & features
- Compilation & Packaging
- Known incompatibilities
- Fixed issues

Please report anything we could have missed, on [Discourse][2] or on [GitLab][3].

[1]: https://help.scilab.org/docs/2024.1.0/en_US/CHANGES.html
[2]: https://scilab.discourse.group/
[3]: https://gitlab.com/scilab/scilab/-/issues

New features
------------

For a high-level description of this release's main new features, please consult the "What's new" page of embedded documentation available by simply typing `doc` in the Scilab console.

### New functions

- `frank`: Computes Frank matrix.
- `getdeprecated`: Gets names of deprecated functions and replacement function names.
- `hilbm`: Computes Hilbert matrix.
- `invhilb`: Computes inverse of Hilbert matrix.
- `kmeans`: K-means clustering function.
- `magic`: Computes magic square matrix.
- `polyfit`: Fits a curve with a polynomial.
- `polyval`: Evaluates a polynomial for some given values.
- `vander`: Computes Vandermonde matrix.

### Features improvements

- `-e` and `-f` command-line options can now be used simultaneously  (and are run in the order they are given to Scilab).
- `x_dialog` and `x_mdialog` can now be used to enter hidden entries such as passwords.

### Language changes

- Lambda functions are now available in Scilab using a dedicated syntax `#(x) -> (x+1)`
- New simplified syntax to declare complex numbers: `1i` and `1j` (equivalent to `1*%i`).

### Web tools

- `timeout` optional parameter has been added to `http_*` functions.
- `http_upload` can be used to upload a remote file with a different name as local one.

### Graphics & GUI

- New property `"TooltipString"` added for `uimenu` handles.
- New properties `"cdata_bounds"` & `"color_range"` added for `Fac3d` handles.
- `"anti_aliasing"` property value is now `"8x"` by default for graphic figures (Anti-aliasing was deactivated by default in previous versions).
- `"fractional_font"` property value is now `"on"` by default for text handles (is was `"off"` by default in previous versions).
- Graphics functions now return the handles they created: `h = plot()`, `h = surf()`, ... This feature can be used to replace `h = gce()` in some cases.

A new way to manage rendering (raw text, LaTeX, MathML) of strings in graphics figures with:

- `"interpreter"` property added for `Text`, `Datatip`, `Label` and `Legend` handles,
- `"tics_interpreters"` property added for `Axis` handles,
- `"interpreters"` property added for `x_ticks`, `y_ticks` and `z_ticks` for `Axes` handles.

Some GUI (File Browser, Help Browser, ...) have been improved.

### Performances

- Some Scilab modules (`CACSD`, `Linear Algebra`, ...) have been updated to use the `arguments` block and enhance their performances.
- Threads management in Scilab kernel has been completely rewritten.

Obsolete functions or features
------------------------------

All these functions and features will be removed in Scilab 2026.0.0 (October 2025):

- `impl()`: Please use `dae()` instead.
- `princomp()`: Please use `pca()` instead.
- `testmatrix()`: Please use `magic()`, `invhilb()` or `frank()` instead.
- `captions()`: Please use `legend()` instead.
- `help()`: Please use `doc()` instead.

Removed Functions
-----------------

The following functions have been removed:

- `getURL`, obsolete since 2023.1.0, replaced by `http_get`.
- `sound`, obsolete since 2023.1.0, replaced by `playsnd`.
- `splitURL`, obsolete since 2023.1.0, replaced by `url_split`.

Compilation
-----------

If you are familiar with building Scilab from sources, these dependencies have been updated:

- Build with HDF5 1.14.4 is now supported (with support for older versions).
- Build with libXML2 2.12.7 is now supported (with support for older versions).
- Required version of MATIO updated to 1.5.27.
- Required version of OpenBLAS updated to 0.3.28 (Linux/macOS).
- All Java dependencies of Scilab have been updated to the latest version (Java 17).

Known incompatibilities
-----------------------

- `lyap` function no longer accepts non-square matrices as input.
- `pca`: the order of the first three output arguments has been modified. The old `[lambda, comprinc, scores] = pca(x)` syntax has been replaced by `[comprinc, scores, lambda] = pca(x)`. See the history part of [pca documentation](https://help.scilab.org/pca) for more information.
- `show_pca(lambda, facpr, N)`: Following the `pca` function improvements, `lambda` is now a p-by-1 vector. The ratio of the corresponding eigenvalue over the sum of eigenvalues now is computed in the `show_pca` function.
- `isvector` function and `mustBeVector` helper now return `%T` for scalars (instead of `%F` in previous versions) to be coherent with `isrow` and `iscolumn`.
- Undocumented syntax `legend(h1,h2,h3,....,strings)` is no more supported.
- When a "Legend" entity is created, its `"links"` property is now a vector with the same order as the legend strings.
- When setting the `x_ticks`, `y_ticks` and `z_ticks`, the new `"interpreters"` property must be managed.
- `fec` no more creates a `Compound` object.
- `h = plot(x1, y1, x2, y2)` now returns handles in `h` as in arguments i.e. `[h1, h2]`.

Packaging & Supported Operating Systems
---------------------------------------

- 32-bit platforms are not supported (no binary versions released).

- Native macOS M1/arm64 build is provided (at least 2 x faster than Intel build using Rosetta emulation).

- Scilab embedded JVM is Java 17 without a memory usage limit. Java heap size limit can still be set in Preferences (General / Java Heap Memory).

- To run or compile Scilab, you might need:
  - Windows (amd64):
    - Windows 11 (Desktop)
    - Windows 10 (Desktop)
    - Windows 8 (Desktop)
  - macOS:
    - Intel-based Mac running macOS 10.13+ (run) and 11+ (compile)
    - M1-based Mac running macOS 11+ (run, compile). 
  - Linux (amd64):
    - debian:11, 12
    - ubuntu:20.04, 22.04, 23.10, 24.04
    - fedora:39, 40

Issue Fixes
-----------

- [#9630](https://gitlab.com/scilab/scilab/-/issues/9630): The toolbar of the documentation browser did not behave as other toolbars.
- [#13121](https://gitlab.com/scilab/scilab/-/issues/13121): Solving ODEs could make Scilab crash under macOS.
- [#13764](https://gitlab.com/scilab/scilab/-/issues/13764): `TooltipString` property was missing for `uimenu` handles.
- [#14265](https://gitlab.com/scilab/scilab/-/issues/14265): `gcf().resize = "off"` (and other similar recursive settings) displayed a useless output.
- [#14891](https://gitlab.com/scilab/scilab/-/issues/14891): `set_io` was not documented.
- [#14934](https://gitlab.com/scilab/scilab/-/issues/14934): Deleting a datatip with `delete(dtHandle)` created a ghost "????" component.
- [#14938](https://gitlab.com/scilab/scilab/-/issues/14938): After datatips were reforged, `SCI/modules/graphics/macros/datatips/` contained useless functions.
- [#15405](https://gitlab.com/scilab/scilab/-/issues/15405): Accessing H5::CompType in a HDF5 file made Scilab crash.
- [#15732](https://gitlab.com/scilab/scilab/-/issues/15732): In a `try` block, `continue` was ignored.
- [#15946](https://gitlab.com/scilab/scilab/-/issues/15946): `./configure` did not detect JARs symbolic links.
- [#16136](https://gitlab.com/scilab/scilab/-/issues/16136): `sound()` was a duplicate of `playsnd()` and has been removed.
- [#16897](https://gitlab.com/scilab/scilab/-/issues/16897): Scilab did not build against Lucene 9.4.0.
- [#16928](https://gitlab.com/scilab/scilab/-/issues/16928): Manually created ticks are not saved.
- [#17071](https://gitlab.com/scilab/scilab/-/issues/17071): Math rendering worked only if the whole text was notated as LaTeX.
- [#17177](https://gitlab.com/scilab/scilab/-/issues/17177): Some blocks had blank icons with users palettes in Xcos.
- [#17187](https://gitlab.com/scilab/scilab/-/issues/17187): Behavior of `bar()` was inconsistent.
- [#17210](https://gitlab.com/scilab/scilab/-/issues/17210): Routine "datatipManagerMode.sci" did not work and generated errors.
- [#17216](https://gitlab.com/scilab/scilab/-/issues/17216): `findobj(propertyName, propertyValue, ...)` statement did not work as explained in documentation.
- [#17230](https://gitlab.com/scilab/scilab/-/issues/17230): Scilab did not build against HDF5 >= 1.10.
- [#17251](https://gitlab.com/scilab/scilab/-/issues/17251): First example in XML Objects help page was broken.
- [#17252](https://gitlab.com/scilab/scilab/-/issues/17252): `uiimport()` code export failed when using a non-alphanumeric in variable used as time.
- [#17253](https://gitlab.com/scilab/scilab/-/issues/17253): `uiimport()` failed with TAB as delimiter when having some spaces variable names.
- [#17254](https://gitlab.com/scilab/scilab/-/issues/17254): `uiimport()` failed to import files with multiple header lines.
- [#17257](https://gitlab.com/scilab/scilab/-/issues/17257): Properties of `Grayplot` and `Champ` entities could no more be displayed in the Scilab console.
- [#17259](https://gitlab.com/scilab/scilab/-/issues/17259): Valgrind reported a memleak on `string([1 2])`.
- [#17260](https://gitlab.com/scilab/scilab/-/issues/17260): `uiimport()` failed to import a .txt file but succeeded with the same file renamed in .csv.
- [#17262](https://gitlab.com/scilab/scilab/-/issues/17262): Scilab did not build against libxml2 >= 2.12.7.
- [#17264](https://gitlab.com/scilab/scilab/-/issues/17264): `datetime()` help page had two history sections.
- [#17267](https://gitlab.com/scilab/scilab/-/issues/17267): Scrollbar was not available for some documentation pages.
- [#17268](https://gitlab.com/scilab/scilab/-/issues/17268): Display was wrong for `zpk` or `state-space` variables.
- [#17269](https://gitlab.com/scilab/scilab/-/issues/17269): Arguments block does not allow to check dimension over input dimensions.
- [#17272](https://gitlab.com/scilab/scilab/-/issues/17272): `datetime("1999-06","InputFormat","yyyy-MM")` produced an error.
- [#17274](https://gitlab.com/scilab/scilab/-/issues/17274): `toJSON()` created "\/" strings instead of "/".
- [#17275](https://gitlab.com/scilab/scilab/-/issues/17275): `legend()` made Scilab crash when an empty value was used as the first input argument and `5` as the second one.
- [#17277](https://gitlab.com/scilab/scilab/-/issues/17277): Setting `mxstep` in ODEOPTIONS does work with ODE type `rkf` and it was not documented.
- [#17279](https://gitlab.com/scilab/scilab/-/issues/17279): Extraction of an unknown field from a struct (or library) created inside a function made Scilab crash.
- [#17280](https://gitlab.com/scilab/scilab/-/issues/17280): `cvode()` could make Scilab crash under Windows because of uncaught exception.
- [#17283](https://gitlab.com/scilab/scilab/-/issues/17283): Outline display was slow for big matrices in `struct`, `tlist`, etc...
- [#17285](https://gitlab.com/scilab/scilab/-/issues/17285): `leastsq()` could make Scilab crash in case of error under macOS/arm64.
- [#17287](https://gitlab.com/scilab/scilab/-/issues/17287): SUNDIALS ODE solvers failed to extend complex ODEs.
- [#17288](https://gitlab.com/scilab/scilab/-/issues/17288): `graypolarplot()` failed when called with 4 or 5 input arguments.
- [#17289](https://gitlab.com/scilab/scilab/-/issues/17289): Some fields of user-type objects were not displayed.
- [#17292](https://gitlab.com/scilab/scilab/-/issues/17292): `size()` did not return any output for vectors of `datetime`.
- [#17293](https://gitlab.com/scilab/scilab/-/issues/17293): `datetime` type was not managed in `datenum()` and `datevec()`.
- [#17294](https://gitlab.com/scilab/scilab/-/issues/17294): `dae("root2",...)` did not work as documented.
- [#17298](https://gitlab.com/scilab/scilab/-/issues/17298): Documentation of `synchronize()` now explains how to use lists of timeseries as input arguments.
- [#17300](https://gitlab.com/scilab/scilab/-/issues/17300): `captions()` input/output order was inconsistent. This function has been set as obsolete.
- [#17307](https://gitlab.com/scilab/scilab/-/issues/17307): Ghost `Datatip` object was found by `get()` after deletion of parent figure.
- [#17311](https://gitlab.com/scilab/scilab/-/issues/17311): Scilab crashed when running n-pendulum demonstration.
- [#17312](https://gitlab.com/scilab/scilab/-/issues/17312): `compress()` could not compress a single file without a container.
- [#17315](https://gitlab.com/scilab/scilab/-/issues/17315): `addmenu()` documentation example could not be executed.
