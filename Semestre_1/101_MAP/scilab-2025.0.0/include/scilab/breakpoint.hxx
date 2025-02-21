/*
 *  Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
 *  Copyright (C) 2015 - Scilab Enterprises - Antoine ELIAS
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

#ifndef __BREAKPOINT_HXX__
#define __BREAKPOINT_HXX__

#include <string>
#include "macro.hxx"
#include "exp.hxx"

extern "C"
{
#include "parsecommand.h"
}

namespace debugger
{
struct Breakpoint
{
    Breakpoint() :  _pFunctionName(""),
                    _iMacroLine(0),
                    _pFileName(""),
                    _iFileLine(0),
                    _iFirstColumn(0),
                    _iHitCondition(0),
                    _iHitCount(0),
                    _condition(""),
                    _conditionError(""),
                    _conditionExp(NULL),
                    _enable(true) {}
    ~Breakpoint()
    {
        if (_conditionExp)
        {
            delete _conditionExp;
        }
    };

    void setFileName(const std::string& name)
    {
        _pFileName = name;
    }
    const std::string& getFileName() const
    {
        return _pFileName;
    }

    void setFunctionName(const std::string& functionName)
    {
        _pFunctionName = functionName;
    }
    const std::string& getFunctioName() const
    {
        return _pFunctionName;
    }

    void setMacroLine(int line)
    {
        _iMacroLine = line;
    }
    int getMacroLine() const
    {
        return _iMacroLine;
    }

    void setBeginLine(int column)
    {
        _iFirstColumn = column;
    }
    int getBeginLine() const
    {
        return _iFirstColumn;
    }

    void setFileLine(int line)
    {
        _iFileLine = line;
    }
    int getFileLine() const
    {
        return _iFileLine;
    }

    void setHitCondition(int hit)
    {
        _iHitCondition = hit;
    }
    bool hit()
    {
        return ++_iHitCount >= _iHitCondition;
    }
    void resetHitCount()
    {
        _iHitCount = 0;
    }

    bool hasMacro() const
    {
        return _pFunctionName.empty() == false && _iMacroLine >= 0;
    }

    bool hasFile() const
    {
        return _pFileName.empty() == false;
    }

    bool hasCondition() const
    {
        return _condition.empty() == false;
    }

    bool hasConditionError() const
    {
        return _conditionError.empty() == false;
    }

    void setEnable()
    {
        _enable = true;
    }
    void setDisable()
    {
        _enable = false;
    }
    bool isEnable() const
    {
        return _enable;
    }

    const std::string& getConditionError(void)
    {
        return _conditionError;
    }

    void setConditionError(const std::string& error)
    {
        _conditionError = error;
    }

    char* setCondition(const std::string& condition)
    {
        _condition = condition;
        char* error = parseCommand(condition.data(), (void**)(&_conditionExp));
        if(error)
        {
            _conditionError = error;
            return error;
        }
        _conditionExp->mute();
        return nullptr;
    }

    const std::string& getCondition() const
    {
        return _condition;
    }

    ast::Exp* getConditionExp()
    {
        return _conditionExp;
    }

private:
    std::string _pFunctionName;
    int _iMacroLine;
    int _iFirstColumn;
    std::string _pFileName;
    int _iFileLine;
    int _iHitCondition;
    int _iHitCount;
    std::string _condition;
    std::string _conditionError;
    ast::Exp* _conditionExp;
    bool _enable;
};

typedef std::vector<Breakpoint*> Breakpoints;

}

#endif /* !__BREAKPOINT_HXX__ */
