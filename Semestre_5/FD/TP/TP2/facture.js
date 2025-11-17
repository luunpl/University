var AMIVAL = 3.15;
var AISVAL = 2.65;
var DIVAL = 10.0;

var totalFacture = 0.0;

function afficherFacture(prenom, nom, actes)
{
    totalFacture = 0.0;
    var text = "<html>\n";
    text +=
            "    <head>\n\
            <title>Facture</title>\n\
            <link rel='stylesheet' type='text/css' href='css/mystyle.css'/>\n\
         </head>\n\
         <body>\n";


    text += "Facture pour " + prenom + " " + nom + "<br/>";


    // Trouver l'adresse du patient
    var xmlDoc = loadXMLDoc("data/cabinetInfirmier.xml");
    var patients = xmlDoc.getElementsByTagName("patient");
    var i = 0;
    var found = false;

    while ((i < patients.length) && (!found)) {
        var patient = patients[i];
        var localNom = patient.getElementsByTagName("nom")[0].childNodes[0].nodeValue;
        var localPrenom = patient.getElementsByTagName("prénom")[0].childNodes[0].nodeValue;
        if ((nom === localNom) && (prenom === localPrenom)) {
            found = true;
        }
        else {
            i++;
        }
    }


    if (found) {
        text += "Adresse: ";
        // On récupère l'adresse du patient
        var adresse;
        // adresse = ... à compléter par une expression DOM
        text += adresseToText(adresse);
        text += "<br/>";

        var nSS = "0";
        // nss = récupérer le numéro de sécurité sociale grâce à une expression DOM

        text += "Numéro de sécurité sociale: " + nSS + "\n";
    }
    text += "<br/>";



    // Tableau récapitulatif des Actes et de leur tarif
    text += "<table border='1'  bgcolor='#CCCCCC'>";
    text += "<tr>";
    text += "<td> Type </td> <td> Clé </td> <td> Intitulé </td> <td> Coef </td> <td> Tarif </td>";
    text += "</tr>";

    var acteIds = actes.split(" ");
    for (var j = 0; j < acteIds.length; j++) {
        text += "<tr>";
        var acteId = acteIds[j];
        text += acteTable(acteId);
        text += "</tr>";
    }
    
     text += "<tr><td colspan='4'>Total</td><td>" + totalFacture + "</td></tr>\n";
     
     text +="</table>";
     
     
    text +=
            "    </body>\n\
    </html>\n";

    return text;
}

// Mise en forme d'un noeud adresse pour affichage en html
function adresseToText(adresse)
{
    var str = "A completer...";
    // Mise en forme de l'adresse du patient
    // A compléter

    return str;
}


function acteTable(acteId)
{
    var str = "";

    var xmlDoc = loadXMLDoc("data/actes.xml");
    var actes;
    // actes = récupérer les actes de xmlDoc

    // Clé de l'acte (3 lettres)
    var cle;
    // Coef de l'acte (nombre)
    var coef;
    // Type id pour pouvoir récupérer la chaîne de caractères du type 
    //  dans les sous-éléments de types
    var typeId;
    // Chaîne de caractère du type
    var type = "";
    // ...
    // Intitulé de l'acte
    var intitule;

    // Tarif = (lettre-clé)xcoefficient (utiliser les constantes 
    // var AMIVAL = 3.15; var AISVAL = 2.65; et var DIVAL = 10.0;)
    // (cf  http://www.infirmiers.com/votre-carriere/ide-liberale/la-cotation-des-actes-ou-comment-utiliser-la-nomenclature.html)      
    var tarif = 0.0;

    // Trouver l'acte qui correspond
    var i = 0;
    var found = false;
    
// A dé-commenter dès que actes aura le bon type...
//    while ((i < actes.length) && (!found)) {
        // A compléter (cf méthode plus haut)
//        i++;
//    }

    if (found) {
        // A compléter
//        cle = ;
//        coef = ;
//        typeId = ;
//        type = ;
//        intitule = ;
//        tarif = ;
    }

    // A modifier
    str += "<td>" + "???" + "</td>";
    str += "<td>" + "???" + "</td>";
    str += "<td>" + "???" + "</td>";
    str += "<td>" + "???" + "</td>";
    str += "<td>" + "???" + "</td>";
    totalFacture += tarif;

    return str;
}



// Fonction qui charge un document XML
function loadXMLDoc(docName)
{
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("GET", docName, false);
    xmlhttp.send();
    xmlDoc = xmlhttp.responseXML;

    return xmlDoc;
}
