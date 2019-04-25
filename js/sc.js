function loadXMLDoc(filename) {
    if (window.ActiveXObject) {
        xhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } else {
        xhttp = new XMLHttpRequest();
    }
    xhttp.open("GET", filename, false);
    try {xhttp.responseType = "msxml-document"} catch(err) {} // Helping IE11
    xhttp.send("");
    return xhttp.responseXML;
}

function displayResult() {
    xml = loadXMLDoc("XML/SIP.xml");
    xsl = loadXMLDoc("XSLT/xslt.xsl");
    // console.log("xslt");
    // code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document") {
        ex = xml.transformNode(xsl);
        document.getElementById("example").innerHTML = ex;
    } else if (document.implementation && document.implementation.createDocument) {
        xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        resultDocument = xsltProcessor.transformToFragment(xml, document);
        console.log(resultDocument);
        document.getElementById("content").appendChild(resultDocument);
    }
}
function gup( name, url ) {
    if (!url) url = location.href;
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
    var regexS = "[\\?&]"+name+"=([^&#]*)";
    var regex = new RegExp( regexS );
    var results = regex.exec( url );
    return results == null ? null : results[1];
}

function openFile(e) {
    // console.log(e.getAttribute('id'));
    // var path = gup('SIP');
    // console.log(path);
    var idEl = document.getElementById("path").innerHTML;
    // console.log(idEl);
    // console.log(e.parentNode.nextSibling.innerHTML);
    //console.log("open.php?path="+idEl+"&file="+e.getAttribute('id')+"&type="+e.parentNode.nextSibling.innerHTML);
    document.location = "open.php?path="+idEl+"&file="+e.getAttribute('id')+"&type="+e.parentNode.nextSibling.innerHTML;
}

function filterID() {
    var filter = document.getElementById("paketID").value;
    var newLocation = location.search;
    if (filter != "") {
        var regex = new RegExp('search=[a-zA-Z0-9-]*');
        if (newLocation.search(regex) != -1) {
            newLocation = newLocation.replace(regex, 'search=' + filter);
        } else {
            newLocation = newLocation + '&search=' + filter;
        }
    } else {
	//remove attribute
        var regex = new RegExp('&search=[a-zA-Z0-9-]*');
        if (newLocation.search(regex) != -1) {
            newLocation = newLocation.replace(regex, '');
        }
    }
    location.search = newLocation;
}

function search() {
    var filename = document.getElementById("FileName").value;
    var mimeType = document.getElementById("mimeType").value;
    newLocation = location.search;
    if (filename != "") {
	var regex = new RegExp('fileSearch=[a-zA-Z0-9/.]*');
	if (newLocation.search(regex) != -1) {
	    newLocation = newLocation.replace(regex, 'fileSearch=' + filename);
	} else {
	    newLocation = newLocation + '&fileSearch=' + filename;
	}
    } else {
	//remove attribute
	var regex = new RegExp('&fileSearch=[a-zA-Z0-9/.]*');
        if (newLocation.search(regex) != -1) {
	    newLocation = newLocation.replace(regex, '');
        }
    }
    if (mimeType != "") {
	console.log("mimetype found");
        var regex = new RegExp('mimeSearch=[a-zA-Z0-9/]*');
        if (newLocation.search(regex) != -1) {
            newLocation	= newLocation.replace(regex, 'mimeSearch=' + mimeType);
        } else {
            newLocation = newLocation + '&mimeSearch=' + mimeType;
        }
    } else {
        //remove attribute
        var regex = new RegExp('&mimeSearch=[a-zA-Z0-9/.]*');
        if (newLocation.search(regex) != -1) {
            newLocation = newLocation.replace(regex, '');
        }
    }
//    console.log(newLocation);
    location.search = newLocation;
}

function displayElementsChanged(e) {
    var regex = new RegExp('inc=[0-9]*');
    if (location.search.search(regex)!= -1) {
        // console.log(location.search.replace(regex, 'world'));
        // console.log(location.search.replace(regex, 'inc='+e.options[e.selectedIndex].value));
        location.search = location.search.replace(regex, 'inc='+e.options[e.selectedIndex].value);
    } else {
        location.search = location.search + '&inc='+e.options[e.selectedIndex].value;
    }
}
