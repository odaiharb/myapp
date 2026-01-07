<?php
header("Access-Control-Allow-Origin: *");
include 'db.php'; // Include your database connection file

$address = $_POST['address1'];
$worker_id = $_POST['worker_id'];
$worker_name = $_POST['worker_name'];
$client_name = $_POST['client_name'];
$date = $_POST['date1'];
$type = $_POST['type1'];

$sql = "INSERT INTO workshops (address1, worker_id, worker_name, client_name, date1, type1) 
        VALUES ('$address', '$worker_id', '$worker_name', '$client_name', '$date', '$type')";


if (mysqli_query($conn, $sql)) {
    echo "Workshop saved successfully!";
} else {
    echo "Error: " . mysqli_error($conn);
}

?>
