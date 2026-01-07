<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");
header("Content-Type: application/json");


include 'db.php';

if (!isset($_GET['worker_id']) || empty($_GET['worker_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Worker ID is required.']);
    exit;
}

$worker_id = mysqli_real_escape_string($conn, $_GET['worker_id']);

$sql = "
    SELECT 
        w.worker_name AS worker_name,
        w.usd_per_day,
        COUNT(ws.worker_id) AS workshops_count,
        (w.usd_per_day * COUNT(ws.worker_id)) AS total_salary
    FROM workers w
    LEFT JOIN workshops ws ON w.worker_id = ws.worker_id
    WHERE w.worker_id = '$worker_id'
    GROUP BY w.worker_id, w.worker_name, w.usd_per_day
";


$result = mysqli_query($conn, $sql);

if (!$result) {
    echo json_encode(['status' => 'error', 'message' => 'SQL error: ' . mysqli_error($conn)]);
    exit;
}

if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    echo json_encode([
        'status' => 'success',
        'data' => [
            'worker_name' => $row['worker_name'],
            'usd_per_day' => $row['usd_per_day'],
            'workshops_count' => $row['workshops_count'],
            'total_salary' => $row['total_salary']
        ]
    ]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'No worker found with this ID.']);
}

?>
