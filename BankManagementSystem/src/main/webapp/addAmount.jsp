<%@ page import="java.sql.*" %>
<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String accNumber = request.getParameter("acc_number");
        String amountStr = request.getParameter("amount");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement checkStmt = null;
        ResultSet rs = null;
        
        try {
            double amount = Double.parseDouble(amountStr);
            
            if (amount <= 0) {
                message = "Error: Amount must be greater than 0!";
            } else {
                // Direct database connection code
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/bank_management";
                    String username = "root";
                    String password = "Subham@112";
                    conn = DriverManager.getConnection(url, username, password);
                } catch (ClassNotFoundException e) {
                    throw new SQLException("Database driver not found");
                }
                
                String checkSql = "SELECT * FROM accounts WHERE acc_number = ?";
                checkStmt = conn.prepareStatement(checkSql);
                checkStmt.setString(1, accNumber);
                rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    String updateSql = "UPDATE accounts SET acc_balance = acc_balance + ? WHERE acc_number = ?";
                    pstmt = conn.prepareStatement(updateSql);
                    pstmt.setDouble(1, amount);
                    pstmt.setString(2, accNumber);
                    
                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        double newBalance = rs.getDouble("acc_balance") + amount;
                        message = "Success: $" + amount + " deposited to account " + accNumber + ". New balance: $" + newBalance;
                    }
                } else {
                    message = "Error: Account number " + accNumber + " not found!";
                }
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {}
        }
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Deposit Money</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            border: 1px solid rgba(255,255,255,0.2);
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .header h2 {
            color: #2c3e50;
            font-size: 2rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .header p {
            color: #7f8c8d;
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 600;
        }
        
        input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }
        
        .message {
            padding: 15px;
            margin: 20px 0;
            border-radius: 10px;
            text-align: center;
            font-weight: 600;
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .links {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        .links a {
            color: #667eea;
            text-decoration: none;
            margin: 0 10px;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .links a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon input {
            padding-left: 45px;
        }
        
        .input-icon::before {
            content: "💰";
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            z-index: 1;
        }
        
        .account-icon::before {
            content: "👤";
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>💰 Deposit Money</h2>
            <p>Add funds to customer account securely</p>
        </div>
        
        <% if(!message.isEmpty()) { %>
            <div class="message <%= message.contains("Success") ? "success" : "error" %>">
                <%= message %>
            </div>
        <% } %>
        
        <form method="post">
            <div class="form-group">
                <label for="acc_number">Account Number</label>
                <div class="input-icon account-icon">
                    <input type="text" id="acc_number" name="acc_number" required 
                           placeholder="Enter account number" maxlength="20">
                </div>
            </div>
            
            <div class="form-group">
                <label for="amount">Deposit Amount</label>
                <div class="input-icon">
                    <input type="number" id="amount" name="amount" step="0.01" min="0.01" required 
                           placeholder="Enter amount to deposit">
                </div>
            </div>
            
            <button type="submit" class="btn">Deposit Money</button>
        </form>
        
        <div class="links">
            <a href="index.jsp">🏠 Home</a> | 
            <a href="viewAccounts.jsp">👥 View Accounts</a> | 
            <a href="withdrawAmount.jsp">💸 Withdraw</a>
        </div>
    </div>
</body>
</html>