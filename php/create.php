<?php

if ( isset ( $GLOBALS["HTTP_RAW_POST_DATA"] )) {

	$im = imagecreatefromstring ($GLOBALS["HTTP_RAW_POST_DATA"]);
	
	header('Content-Type: image/jpeg');
	header("Content-Disposition: attachment; filename=".$_GET['name']);
	//imagepng($im,$_GET['name']);
	imagejpeg($im,$_GET['name'], 100);
	set_dpi($_GET['name'],200);
	
echo "yes";
	
} 
else 
{
	echo 'An error occured.';
}

/*
   @$jpg -- Path to a jpg file
   @$dpi -- DPI to use (1-255)
*/
function set_dpi($jpg, $dpi = 163)
{
 $fr = fopen($jpg, 'rb');
 $fw = fopen("$jpg.temp", 'wb');
 
 stream_set_write_buffer($fw, 0);
 
 fwrite($fw, fread($fr, 13) . chr(1) . chr(0) . chr($dpi) . chr(0) . chr($dpi));

 fseek($fr, 18);
 stream_copy_to_stream($fr, $fw);

 fclose($fr);
 fclose($fw);
 
 unlink($jpg);
 rename("$jpg.temp", $jpg);

}


echo "success";

?>