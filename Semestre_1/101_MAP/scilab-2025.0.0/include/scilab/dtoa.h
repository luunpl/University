/*
*  Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
*  Copyright (C) 2018 - UTC - Stéphane MOTTELET
*
 *
 * This file is hereby licensed under the terms of the GNU GPL v2.0,
 * pursuant to article 5.3.4 of the CeCILL v.2.1.
 * This file was originally licensed under the terms of the CeCILL v2.1,
 * and continues to be available under such terms.
 * For more information, see the COPYING file which you should have received
 * along with this program.
*
*/

#ifndef __DTOA_H__
#define __DTOA_H__

#include "dynlib_ast.h"

EXTERN_AST char *dtoa(double d, int mode, int ndigits, int *decpt, int *sign, char **rve);
EXTERN_AST void freedtoa(char *s);

#endif // __DTOA_H__
