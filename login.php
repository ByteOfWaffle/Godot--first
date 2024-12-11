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

// Extract username and password from the input data
$username = $data['username'];
$password = $data['password'];

// Prepare a SQL statement to fetch the password for the given username
$stmt = $conn->prepare("SELECT password FROM userinfo WHERE username = ?");
$stmt->bind_param("s", $username); // Bind the username parameter to the SQL query
$stmt->execute(); // Execute the query
$result = $stmt->get_result(); // Retrieve the query results

// Check if any user was found with the provided username
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc(); // Fetch the row containing the password

    // Verify if the provided password matches the hashed password in the database
    if (password_verify($password, $row['password'])) {
        // Password matches, return a success response
        echo json_encode(["status" => "success", "message" => "Login successful"]);
    } else {
        // Password does not match, return an error response
        echo json_encode(["status" => "error", "message" => "Invalid password"]);
    }
} else {
    // No user found with the provided username, return an error response
    echo json_encode(["status" => "error", "message" => "User not found"]);
}

// Close the prepared statement and database connection
$stmt->close();
$conn->close();
?>
