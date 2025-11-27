<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Accounts</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { color: #3498db; text-align: center; margin-bottom: 30px; }
        .btn { padding: 10px 20px; background: #95a5a6; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; margin-bottom: 20px; }
        .btn:hover { background: #7f8c8d; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #3498db; color: white; }
        tr:hover { background: #f5f5f5; }
        .no-data { text-align: center; color: #7f8c8d; padding: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>View All Bank Accounts</h2>
        <a href="index.jsp" class="btn">Back to Home</a>
        
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_management", "root", "Subham@112");
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM accounts ORDER BY acc_number");
            
            if (!rs.isBeforeFirst()) {
                out.println("<div class='no-data'>No accounts found in the database.</div>");
            } else {
        %>
                <table>
                    <tr>
                        <th>Account Number</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Balance ($)</th>
                    </tr>
                    <%
                    while (rs.next()) {
                        String accNumber = rs.getString("acc_number");
                        String name = rs.getString("name");
                        int age = rs.getInt("age");
                        double balance = rs.getDouble("acc_balance");
                    %>
                    <tr>
                        <td><%= accNumber %></td>
                        <td><%= name %></td>
                        <td><%= age %></td>
                        <td>$<%= String.format("%.2f", balance) %></td>
                    </tr>
                    <%
                    }
                    %>
                </table>
        <%
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<div style='color: red; text-align: center; padding: 20px;'>Error: " + e.getMessage() + "</div>");
        }
        %>
    </div>
</body>
</html>