<?php
header('Content-Type: text/plain');
require_once "openttd-admin.php";
// Variables
$timezone = 'Europe/Madrid';
$server = '127.0.0.1'; // Hostname or IP
$port = 3977; // Port
$password = "PASSWORD"; // Password
$type = "topography" // Screenshot type. Valid working values: minimap / topography / industry
//#######################################################
date_default_timezone_set($timezone); // Time

$openttdAdmin = new OttdAdmin($server,$port,$password);  // Hostname or IP, Port, Password
$openttdAdmin->connect();
$openttdAdmin->join();

$filename = $type . "_" . date("Y-m-d_H-i-s");

$openttdAdmin->console("screenshot $type $filename");

/*
- Create a screenshot of the game. Usage: 'screenshot [viewport | normal | big | giant | world | heightmap | minimap] [no_con] [size <width> <height>] [<filename>]'
- 'viewport' (default) makes a screenshot of the current viewport (including menus, windows, ..), 
- 'normal' makes a screenshot of the visible area, 
- 'big' makes a zoomed-in screenshot of the visible area, 
- 'giant' makes a screenshot of the whole map using the default zoom level, 
- 'world' makes a screenshot of the whole map using the current zoom level, 
- 'heightmap' makes a heightmap screenshot of the map that can be loaded in as heightmap, 
- 'minimap' makes a top-viewed minimap screenshot of the whole world which represents one tile by one pixel. 
- 'topography' makes a top-viewed topography screenshot of the whole world which represents one tile by one pixel. 
- 'industry' makes a top-viewed industries screenshot of the whole world which represents one tile by one pixel. 
- 'no_con' hides the console to create the screenshot (only useful in combination with 'viewport'). 
- 'size' sets the width and height of the viewport to make a screenshot of (only useful in combination with 'normal' or 'big').
*/
?>

