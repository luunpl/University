/*
 * Walnut Javascript page (contains all needed functions, included in structure, see template "top")
 *
 */

// Transform:
//     &lt; to <
//     &gt; to >
//     &amp; to &
function unescapeHTML(escapedHTML) {
    // From XSLT: unescapeHTML should produce the output string in the html code:
    // This is complicated because of all this espace ampersand and lt and gt thingies...
    //  return escapedHTML.replace(/]]><xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text><![CDATA[lt;/g,']]><xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text><![CDATA[').replace(/]]><xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text><![CDATA[gt;/g,']]><xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text><![CDATA[').replace(/]]><xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text><![CDATA[amp;/g,']]><xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text><![CDATA[');
    return escapedHTML.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&');
}

// Check if a file exist without using xsl/xml (pure javascript
function fileExists(url) {
    if (url) {
        var req = new XMLHttpRequest();
        req.open('GET', url, false);
        req.send("");
        return (req.status == 200);
    } else {
        return false;
    }
}

// show/hide sections
function showTd(tdName) {
    var allTd = document.getElementsByClassName(tdName);
    for (i = 0; i < allTd.length; i++) {
        if (allTd[i].style.visibility == "visible") {
            allTd[i].style.visibility = "hidden";
        }
        else {
            allTd[i].style.visibility = "visible";
        }
    }
}

function showHide(shID) {
    if (document.getElementById(shID)) {
        if (document.getElementById(shID + '-show').style.display != 'none') {
            document.getElementById(shID + '-show').style.display = 'none';
            document.getElementById(shID).style.display = 'block';
        }
        else {
            document.getElementById(shID + '-show').style.display = 'inline';
            document.getElementById(shID).style.display = 'none';
        }
    }
}


// Function for exercise2html-standalone questions
// Provides the correct answer to a MCQuestion.
function checkAnswer(nb)
{
    var answered;
//    correctionRemark(nb);
    highlightRightAnswer(nb);
    answered = personnalCorrection(nb);
    correctionRemark(nb, answered);
}

function personnalCorrection(nb)
{
    var question = document.getElementsByName(nb);

    var right = true;
    var partial = false;

    // check all the answers of check box and several possible good answers
    // (useless for a radiobutton... ... but then, there would be 2 functions...)
    var i;
    for (i = 0; i < question.length; i++)
    {
        var currentAnswer = question.item(i);
        var answered = currentAnswer.checked;
        var rightAnswer = currentAnswer.value;

        // if one of them is different, answer cannot be right...
        if (((answered === true) && (rightAnswer === "false")) ||
                ((answered === false) && (rightAnswer === "true")))
        {
            right = false;
        }
        // The answer is partially true if one right answer is correctly checked.
        else
        {
            if ((answered === true) && (rightAnswer === "true"))
            {
                partial = true;
            }
        }
    }


    var text = "";
    if (right)
    {
        text = text + "<div class='right'> Résultat: Votre réponse est juste.</div>";
    }
    else if (partial)
    {
        text = text + "<div class='partial'> Résultat: Votre réponse est partiellement juste. </div>"
    }
    else
    {
        text = text + "<div class='wrong'> Résultat: Votre réponse est fausse. </div>"
    }


    var whereToInsert = "correction-" + nb;

    document.getElementById(whereToInsert).innerHTML = text;

    return right;

}

function highlightRightAnswer(nb)
{
    var question = document.getElementsByName(nb);
    for (i = 0; i < question.length; i++)
    {
        var j = i+1;
        var currentAnswer = question.item(i);
        var divToChange = "" + nb + "-" + j;
        if (currentAnswer.value === "true")
        {
            document.getElementById(divToChange).className = 'right';
        }
        else
        {
            document.getElementById(divToChange).className = 'wrong';
        }
    }
}

function correctionRemark(nb, answered)
{
    var whatToSee = "remark-" + nb;
    if (answered === true)
    {
        document.getElementById(whatToSee).className = 'displayRight';
    }
    else
    {
        document.getElementById(whatToSee).className = 'displayWrong';
    }
}
