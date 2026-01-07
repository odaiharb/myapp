<?php
header("Access-Control-Allow-Origin: *");
include 'db.php'; 

$worker_id = $_POST['worker_id'];
$worker_name = $_POST['worker_name'];
$usd_per_day = $_POST['usd_per_day'];

$sql = "INSERT INTO workers (worker_id, worker_name, usd_per_day) 
        VALUES ('$worker_id', '$worker_name', $usd_per_day)";

if (mysqli_query($conn, $sql)) {
    echo "Worker added successfully";
} else {
    echo "Error: " . mysqli_error($conn);
}

?>
