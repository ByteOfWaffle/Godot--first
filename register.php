<?php
// Set headers to allow cross-origin requests and specify JSON response format
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Establish connection to the MySQL database
$conn = new mysqli("localhost", "root", "", "dnd_db");

// Check for connection errors and return an error response if the connection fails
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed"]));
}

// Retrieve JSON input data sent to the script
$data = json_decode(file_get_contents('php://input'), true);

// Extract username and hash the provided password
$username = $data['username'];
$password = password_hash($data['password'], PASSWORD_DEFAULT);

// Check if the username already exists in the database
$check = $conn->prepare("SELECT username FROM userinfo WHERE username = ?");
$check->bind_param("s", $username); // Bind the username to the SQL query
$check->execute(); // Execute the query
$result = $check->get_result(); // Retrieve the query results

// If the username exists, return an error response
if ($result->num_rows > 0) {
    echo json_encode(["status" => "error", "message" => "Username already exists"]);
} else {
    // If the username does not exist, insert the new user into the database
    $stmt = $conn->prepare("INSERT INTO userinfo (username, password) VALUES (?, ?)");
    $stmt->bind_param("ss", $username, $password); // Bind the username and hashed password to the SQL query

    // Check if the insertion was successful and return an appropriate response
    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Account created successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Registration failed"]);
    }

    // Close the prepared statement
    $stmt->close();
}

// Close the database connection
$conn->close();
?>