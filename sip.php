<?php

include 'settings.php';

$date_format = "h:i:s";

//var for storing uuid globaly
$uuid = "";
//Function for obtaining the mets.xml file inside the innermost .tar
function getMetsFile($path)
{
    global $uuid, $date_format;
    $path = substr($path, 0, strlen($path)-1);

    $result = "<p style='display: none' id='path'>".$path."</p>";

    //get uuid from path. goto folder $path/<uuid>/content/<uuid>.tar/<uuid>/mets.xml and read the file
    $uuid = $path;
    //remove tar part
    $pos = strpos($uuid, ".tar");
    $uuid = substr($uuid, 0, $pos);
    //remove everything before uuid
    $pos = strrpos($uuid, "/");
    $uuid = substr($uuid, $pos+1);

    //from a.out by axenu
    $output = [];
    $command = "";

    // start by testing if the package contains an inner mets.xml file
    $command = "tarExtractor " . $path . " " . $uuid . "/content/".$uuid.".tar/".$uuid."/mets.xml";
    // echo $command;
    exec($command, $output);

    if (count($output) <= 0) {
        // return false;
        // instead of just returning, try to find an outer tar file.
        $command = "tarExtractor " . $path . " " . $uuid . "/mets.xml";
        exec($command, $output);
        if (count($output) <= 0) {
          return false;
        }
    }
    // echo "after tar extractor: ".date($date_format)."</br>";
    //load mets.xml
    $xml = new DOMDocument;
    $xml->loadXML(implode($output));
    $xsl = new DOMDocument;
    $xsl->load('XSLT/mets.xsl');
    $proc = new XSLTProcessor;
    $start = isset($_GET["disp"])?intval($_GET['disp']):0;
    $inc = isset($_GET["inc"])?intval($_GET['inc']):10;
    $fileSearch = isset($_GET["fileSearch"])?$_GET["fileSearch"]:'';
    $mimeSearch = isset($_GET["mimeSearch"])?$_GET["mimeSearch"]:'';
    $min = $start-$inc;
    $proc->setParameter('', 'disp', $start);
    $proc->setParameter('', 'max', $inc+$start);
    $proc->setParameter('', 'min', $min);
    $proc->setParameter('', 'limit', $inc);
    $proc->setParameter('', 'fileSearch', $fileSearch);
    $proc->setParameter('', 'mimeSearch', $mimeSearch);
    $folder = isset($_GET['folder'])?'&folder':'';
    $incS = '&inc='.$inc;
    $proc->setParameter('', 'url', 'sip.php?SIP='.$_GET['SIP'].$folder.$incS);
    $proc->importStyleSheet($xsl);
    $result .= $proc->transformToXML($xml);
    // echo "after XSLT mets: ".date($date_format)."</br>";
    //load premis.xml
    $output = [];
    $command = "";
    if (PACKAGE_TYPE == "SIP") {
        $command = "tarExtractor " . $path . " " . $uuid . "/ipevents.xml";
    } else { // $Package_type == "AIP"
        $command = "tarExtractor " . $path . " " . $uuid . "/content/".$uuid.".tar/".$uuid."/ipevents.xml";
    }
    exec($command, $output);
    $xml = new DOMDocument;
    $xml->loadXML(implode($output));
    $xsl = new DOMDocument;
    $xsl->load('XSLT/premis.xsl');
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);
    $result .= $proc->transformToXML($xml);
    // echo "after XSLT premis: ".date($date_format)."</br>";
    return $result;
}

$xml = new DOMDocument;
$path = $_GET['SIP'];
$result = "Not a valid SIP.";
if (!isset($_GET['folder'])) {
    $res = getMetsFile($path);
    if ($res != false) {
        $result = $res;
    }
}

 ?>
<!DOCTYPE html>
<html>
    <head>
	<meta charset="utf-8">
        <title><?php echo $uuid; ?></title>
        <script src="js/sc.js"></script>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
	<img class="logga" src="img/logga.jpg"/>
	<?php
       echo $result;
    ?>
    </body>
</html>
