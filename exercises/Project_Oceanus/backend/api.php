<?php
// Developer: Jai Verma
// Description: API endpoint for Fleet CRUD operations

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");

require 'db.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    // Fetch all ships
    $stmt = $pdo->query("SELECT * FROM ships ORDER BY created_at DESC");
    $ships = $stmt->fetchAll();
    echo json_encode($ships);
} 
elseif ($method === 'POST') {
    // Add a new ship
    $data = json_decode(file_get_contents("php://input"), true);
    
    if (isset($data['ship_name']) && isset($data['ship_class'])) {
        $stmt = $pdo->prepare("INSERT INTO ships (ship_name, ship_class, operational_status) VALUES (?, ?, ?)");
        $stmt->execute([$data['ship_name'], $data['ship_class'], 'Docked']);
        
        echo json_encode(["message" => "Ship successfully added to fleet."]);
    } else {
        http_response_code(400);
        echo json_encode(["error" => "Invalid ship data."]);
    }
}
?>