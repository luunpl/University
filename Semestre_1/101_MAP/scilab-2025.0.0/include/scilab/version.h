/*
 * Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) INRIA
 *
 * Copyright (C) 2012 - 2016 - Scilab Enterprises
 *
 * This file is hereby licensed under the terms of the GNU GPL v2.0,
 * pursuant to article 5.3.4 of the CeCILL v.2.1.
 * This file was originally licensed under the terms of the CeCILL v2.1,
 * and continues to be available under such terms.
 * For more information, see the COPYING file which you should have received
 * along with this program.
 *
 */
#ifndef SCI_VERSION_H
#define SCI_VERSION_H

#define SCI_VERSION_MAJOR 2025
#define SCI_VERSION_MINOR 0
#define SCI_VERSION_MAINTENANCE 0
#define SCI_VERSION_STRING "scilab-2025.0.0"
#define SCI_VERSION_WIDE_STRING L"scilab-2025.0.0"

/* hash key commit and commit date set to the first Scilab commit and will be updated by the Compilation Chain */
#define SCI_VERSION_REVISION "06c3e667aacc06fcb509a55bcb46ed9cf368fd42"
#define SCI_VERSION_TIMESTAMP 1729762778

/* for compatibility */
/* Deprecated */
#define SCI_VERSION SCI_VERSION_STRING
#define DEFAULT_SCI_VERSION_MESSAGE SCI_VERSION_WIDE_STRING

#endif
/*--------------------------------------------------------------------------*/

