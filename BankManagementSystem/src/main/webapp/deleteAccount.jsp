<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Account</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { color: #e74c3c; text-align: center; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #2c3e50; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; box-sizing: border-box; }
        .btn { padding: 12px 25px; background: #e74c3c; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; margin-right: 10px; }
        .btn:hover { background: #c0392b; }
        .back { background: #95a5a6; }
        .back:hover { background: #7f8c8d; }
        .message { padding: 15px; margin: 20px 0; border-radius: 5px; text-align: center; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .warning { background: #fff3cd; color: #856404; border: 1px solid #ffeaa7; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Delete Bank Account</h2>
        
        <%
        String message = "";
        String messageType = "";
        String accountDetails = "";
        
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String accNumber = request.getParameter("accNumber");
            String confirm = request.getParameter("confirm");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Subham@112");
                
                if ("yes".equals(confirm)) {
                    // First get account details for confirmation message
                    String checkSql = "SELECT name, acc_balance FROM accounts WHERE acc_number = ?";
                    PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                    checkStmt.setString(1, accNumber);
                    ResultSet rs = checkStmt.executeQuery();
                    
                    if (rs.next()) {
                        String name = rs.getString("name");
                        double balance = rs.getDouble("acc_balance");
                        
                        // Delete the account
                        String deleteSql = "DELETE FROM accounts WHERE acc_number = ?";
                        PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
                        deleteStmt.setString(1, accNumber);
                        
                        int rows = deleteStmt.executeUpdate();
                        if (rows > 0) {
                            message = "✅ Account deleted successfully!<br>Account: " + accNumber + "<br>Name: " + name + "<br>Final Balance: $" + String.format("%.2f", balance);
                            messageType = "success";
                        }
                        deleteStmt.close();
                    } else {
                        message = "❌ Account not found!";
                        messageType = "error";
                    }
                    rs.close();
                    checkStmt.close();
                } else {
                    message = "⚠️ Deletion cancelled.";
                    messageType = "warning";
                }
                
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
                <label>Account Number to Delete:</label>
                <input type="text" name="accNumber" required placeholder="Enter account number">
            </div>
            <div class="form-group">
                <label>Confirm Deletion:</label>
                <select name="confirm" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;">
                    <option value="">-- Select --</option>
                    <option value="no">No, Cancel</option>
                    <option value="yes">Yes, Delete Permanently</option>
                </select>
            </div>
            <button type="submit" class="btn">Delete Account</button>
            <a href="index.jsp" class="btn back">Back to Home</a>
        </form>
        
        <div class="message warning">
            ⚠️ Warning: This action cannot be undone. All account data will be permanently deleted.
        </div>
    </div>
</body>
</html>