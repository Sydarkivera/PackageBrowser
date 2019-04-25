<?php
//show error, debug only!
error_reporting(E_ALL);
ini_set('display_errors', 1);
$next_possible = 0;

function searchDir($base_dir="./",$p="",$f="",$allowed_depth=-1){
$contents=array();
global $next_possible;
$base_dir=trim($base_dir);
$p=trim($p);
$f=trim($f);

if($base_dir=="")$base_dir="./";
if(substr($base_dir,-1)!="/")$base_dir.="/";
$p=str_replace(array("../","./"),"",trim($p,"./"));
$p=$base_dir.$p;

if(!is_dir($p))$p=dirname($p);
if(substr($p,-1)!="/")$p.="/";

$filter=($f=="")?array():explode(",",strtolower($f));
$files=@scandir($p);
if(!$files)return array("contents"=>array(),"currentPath"=>$p);
$result = "";
$fileCount = count($files);

$start = isset($_GET["start"])?$_GET["start"]:0;
$end = isset($_GET["inc"])?$_GET["inc"]:10;
$end = $start+$end;
$end = min($fileCount, $end);
$search = isset($_GET["search"])?$_GET["search"]:"";

// 10.253

for ($i=$start; $i < $end && $i < $fileCount; $i++){

    $fName=$files[$i];
    $fPath=$p.$fName;

    $add=false;
    $fType="folder";

    if (!is_dir($fPath)){

        $ft=strtolower(substr($files[$i],strrpos($files[$i],".")+1));
        $fType=$ft;
        if ($f!=""){
            if (in_array($ft,$filter))$add=true;
        }else{
            $add=true;
        }
	if ($search != "") {
	    if (strpos($fName, $search) === false) {
        	$add = false;
	    }
	}
	if($add) {
	    if ($start > 0 ) {
                $add = false;
                $start --;
	    } else {
                $result .= "<div class='file'><a href='sip.php?SIP=".$fPath."/'>".$fName."</a></div>";
	    }
	}
    }
    //make sure expected entries exist.
    if (!$add) {
	$end++;
//	$i++;
    }

    if($fPath!="")$fPath=substr($fPath,strlen($base_dir));
}
if ($i < $fileCount) {
    $next_possible = 1;
}
return $result;
}
$p=isset($_GET["path"])?substr($_GET["path"], 4):"";
$f=isset($_GET["filter"])?$_GET["filter"]:"tar,folder";

$output = searchDir("/mnt/epp",$p,$f,-1);

$next_url = 'index.php?';
        $inc = '10';
        if (isset($_GET['inc'])) {
                $inc = $_GET['inc'];
        }
	$start = 0;
        if (isset($_GET['start'])) {
                $start = $_GET['start'];
        }
	$search = '';
        if (isset($_GET['search'])) {
                $search = $_GET['search'];
        }
        $next_url .= 'inc='.$inc.'&start='.($start+$inc).'&search='.$search;
        $prev_url = 'index.php?';
        $prev_url .= 'inc='.$inc.'&start='.($start-$inc).'&search='.$search;


?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Packet browser</title>
        <script src="js/sc.js"></script>
	<link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
    <h1><a href="/">Packet browser</a></h1>
    <img class="logga" src="img/logga.jpg"/>
    <h3>Välj det paket du vill granska</h3>
    <div class="search">
	<input type="text" placeholder="id" id="paketID" <?php
	if (isset($_GET["search"])) {
	    echo "value=\"".$_GET["search"]."\"";
	}
	?>/>
	<input type="button" value="search" onclick="filterID()"/>
    </div>
    <select onchange="displayElementsChanged(this)">
	<option value="10" <?php if (isset($_GET['inc']) && $_GET['inc'] == '10') {echo 'selected';} ?> > 10 </option>
	<option	value="50" <?php if (isset($_GET['inc']) && $_GET['inc'] == '50') {echo 'selected';} ?> > 50</option>
	<option	value="100" <?php if (isset($_GET['inc']) && $_GET['inc'] == '100') {echo 'selected';} ?> > 100</option>
    </select>
	<p><?php

	echo 'paket: '.$start.'-'.($start+$inc);

	 ?><p>
    <div class="files">
	<div class="filesHeader">Paket ID:</div>
    	<?php
            echo $output;
    	?>
    </div>
	<?php if ($start > 0) { ?>
	<a href="<?php echo $prev_url; ?>">prev</a>
	<?php }
	if ($next_possible == true) {?>
	<a href="<?php echo $next_url; ?>">next</a>
	<?php }?>
    </body>
</html>
