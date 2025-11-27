<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Account</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { color: #27ae60; text-align: center; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #2c3e50; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; box-sizing: border-box; }
        .btn { padding: 12px 25px; background: #27ae60; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; margin-right: 10px; text-decoration: none; display: inline-block; }
        .btn:hover { background: #219a52; }
        .back { background: #95a5a6; }
        .back:hover { background: #7f8c8d; }
        .message { padding: 15px; margin: 20px 0; border-radius: 5px; text-align: center; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create New Bank Account</h2>
        
        <%
        String message = "";
        String messageType = "";
        
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String accNumber = request.getParameter("accNumber");
            String name = request.getParameter("name");
            String ageStr = request.getParameter("age");
            String balanceStr = request.getParameter("balance");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Subham@112");
                
                String sql = "INSERT INTO accounts (acc_number, name, age, acc_balance) VALUES (?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, accNumber);
                pstmt.setString(2, name);
                pstmt.setInt(3, Integer.parseInt(ageStr));
                pstmt.setDouble(4, Double.parseDouble(balanceStr));
                
                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    message = "✅ Account created successfully! Account Number: " + accNumber;
                    messageType = "success";
                }
                
                pstmt.close();
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
        
        <form method="post">
            <div class="form-group">
                <label>Account Number:</label>
                <input type="text" name="accNumber" required placeholder="Enter account number">
            </div>
            <div class="form-group">
                <label>Full Name:</label>
                <input type="text" name="name" required placeholder="Enter full name">
            </div>
            <div class="form-group">
                <label>Age:</label>
                <input type="number" name="age" required min="18" max="100" placeholder="Enter age">
            </div>
            <div class="form-group">
                <label>Initial Balance ($):</label>
                <input type="number" name="balance" step="0.01" required min="0" placeholder="Enter initial balance">
            </div>
            <button type="submit" class="btn">Create Account</button>
            <a href="index.jsp" class="btn back">Back to Home</a>
        </form>
    </div>
</body>
</html>