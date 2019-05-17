<?php

    include 'settings.php';
    // echo "Test";

    $tarName = $_GET['path'];
    $fileName = $_GET['file'];
//calcluate uuid
    $uuid = $tarName;
//remove tar part
    $pos = strpos($uuid, ".tar");
    $uuid = substr($uuid, 0, $pos);
//remove everything before uuid
    $pos = strrpos($uuid, "/");
    $uuid = substr($uuid, $pos+1);

    $command = "";
    // echo PACKAGE_TYPE;
    if (PACKAGE_TYPE == "SIP") {
        $command = "tarExtractor ".$tarName." \"".$uuid."/".$fileName."\"";
    } else { // $Package_type == "AIP"
        $command = "tarExtractor ".$tarName." \"".$uuid."/content/".$uuid.".tar/".$uuid."/".$fileName."\"";
    }
    // echo $command;
    $output = shell_exec($command);
    $size = strlen($output);

    $mimetype = $_GET['type'];
    if ($mimetype == "application/msword") {
      $mimetype = "text";
    }
    // echo $size;
    // echo 'Content-type: '. $_GET['type'];
    // echo 'Content-Disposition: inline; filename='.end(explode('/', $fileName));
    // echo $size;
    header("Pragma: public");
    header("Expires: 0");
    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
    header("Cache-Control: private", false); // required for certain browsers
    header('Content-type: '. $mimetype);
    header('Content-Disposition: inline; filename='.end(explode('/', $fileName)));
    header('Content-Transfer-Encoding: binary');
    header('Content-Length: '.$size);
    header('Accept-Ranges: bytes');
    echo $output;
    exit;
?>
