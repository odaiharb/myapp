<?php
$host = "fdb1033.awardspace.net";
$username = "4723357_workdb";
$password = "20BANGbang@";
$database = "4723357_workdb";

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
?>
