<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Account Details</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { color: #f39c12; text-align: center; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #2c3e50; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; box-sizing: border-box; }
        .btn { padding: 12px 25px; background: #f39c12; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; margin-right: 10px; }
        .btn:hover { background: #e67e22; }
        .back { background: #95a5a6; }
        .back:hover { background: #7f8c8d; }
        .message { padding: 15px; margin: 20px 0; border-radius: 5px; text-align: center; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        .account-info { background: #e8f4f8; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Account Details</h2>
        
        <%
        String message = "";
        String messageType = "";
        String currentName = "";
        String currentAge = "";
        String currentBalance = "";
        String accNumber = request.getParameter("acc_number");
        
        // If account number is provided via URL parameter, load the data
        if (accNumber != null && !accNumber.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Subham@112");
                
                String checkSql = "SELECT name, age, acc_balance FROM accounts WHERE acc_number = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                checkStmt.setString(1, accNumber);
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    currentName = rs.getString("name");
                    currentAge = String.valueOf(rs.getInt("age"));
                    currentBalance = String.format("%.2f", rs.getDouble("acc_balance"));
                } else {
                    message = "❌ Account not found!";
                    messageType = "error";
                }
                
                rs.close();
                checkStmt.close();
                conn.close();
            } catch (Exception e) {
                message = "❌ Error: " + e.getMessage();
                messageType = "error";
            }
        }
        
        // Handle form submission
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            accNumber = request.getParameter("accNumber");
            String newName = request.getParameter("name");
            String newAgeStr = request.getParameter("age");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Subham@112");
                
                // Update only name and age
                String updateSql = "UPDATE accounts SET name = ?, age = ? WHERE acc_number = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setString(1, newName);
                updateStmt.setInt(2, Integer.parseInt(newAgeStr));
                updateStmt.setString(3, accNumber);
                
                int rows = updateStmt.executeUpdate();
                if (rows > 0) {
                    message = "✅ Account details updated successfully!<br>Account: " + accNumber;
                    messageType = "success";
                    currentName = newName;
                    currentAge = newAgeStr;
                } else {
                    message = "❌ Account not found! Please check the account number.";
                    messageType = "error";
                }
                
                updateStmt.close();
                conn.close();
            } catch (Exception e) {
                message = "❌ Error: " + e.getMessage();
                messageType = "error";
            }
        }
        %>
        
        <% if (!message.isEmpty()) { %>
            <div class="message <%= messageType %>"><%= message %></div>
        <% } %>
        
        <% if (accNumber != null && !accNumber.isEmpty()) { %>
            <div class="account-info">
                <strong>Account Number:</strong> <%= accNumber %><br>
                <strong>Current Balance:</strong> $<%= currentBalance %>
            </div>
        <% } %>
        
        <form method="post">
            <div class="form-group">
                <label>Account Number:</label>
                <input type="text" name="accNumber" value="<%= accNumber != null ? accNumber : "" %>" required placeholder="Enter account number">
            </div>
            <div class="form-group">
                <label>Full Name:</label>
                <input type="text" name="name" value="<%= currentName %>" required placeholder="Enter customer name">
            </div>
            <div class="form-group">
                <label>Age:</label>
                <input type="number" name="age" value="<%= currentAge %>" required min="18" max="100" placeholder="Enter age">
            </div>
            <button type="submit" class="btn">Update Account</button>
            <a href="index.jsp" class="btn back">Back to Home</a>
        </form>
    </div>
</body>
</html>