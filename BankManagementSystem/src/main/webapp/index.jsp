<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Global Trust Bank - Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: 
                linear-gradient(rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1)),
                url('images/images.jpg') center/cover no-repeat fixed;
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            color: white;
            margin-bottom: 60px;
            padding: 40px 20px;
        }
        
        .header h1 {
            font-size: 3.5rem;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            background: linear-gradient(45deg, #fff, #f0f8ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .header .tagline {
            font-size: 1.3rem;
            opacity: 0.9;
            margin-bottom: 10px;
            font-weight: 300;
        }
        
        .header .subtitle {
            font-size: 1rem;
            opacity: 0.7;
            font-weight: 300;
        }
        
        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 50px;
        }
        
        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 35px 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.2);
            text-align: center;
        }
        
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
            background: rgba(255, 255, 255, 1);
        }
        
        .card-icon {
            font-size: 3.5rem;
            margin-bottom: 20px;
            display: block;
        }
        
        .card h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.4rem;
            font-weight: 600;
        }
        
        .card p {
            color: #7f8c8d;
            margin-bottom: 25px;
            line-height: 1.6;
            font-size: 0.95rem;
        }
        
        .btn {
            display: inline-block;
            padding: 14px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            letter-spacing: 0.5px;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        .btn-primary { 
            background: linear-gradient(135deg, #28a745, #20c997); 
        }
        
        .btn-secondary { 
            background: linear-gradient(135deg, #6c757d, #868e96); 
        }
        
        .btn-success { 
            background: linear-gradient(135deg, #28a745, #20c997); 
        }
        
        .btn-danger { 
            background: linear-gradient(135deg, #dc3545, #e83e8c); 
        }
        
        .btn-warning { 
            background: linear-gradient(135deg, #ffc107, #fd7e14); 
        }
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 50px;
        }
        
        .feature-item {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            color: white;
            border: 1px solid rgba(255,255,255,0.2);
            transition: transform 0.3s ease;
        }
        
        .feature-item:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.2);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: block;
        }
        
        .feature-item h4 {
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .feature-item p {
            opacity: 0.9;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .footer {
            text-align: center;
            color: white;
            margin-top: 60px;
            padding: 30px;
            opacity: 0.8;
            font-size: 0.9rem;
        }
        
        .bank-logo {
            font-size: 4rem;
            margin-bottom: 20px;
            display: block;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.5rem;
            }
            
            .dashboard {
                grid-template-columns: 1fr;
            }
            
            .card {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header Section -->
        <div class="header">
            <div class="bank-logo">🏦</div>
            <h1>Global Trust Bank</h1>
            <div class="tagline">Professional Banking Management System</div>
            <div class="subtitle">Secure • Efficient • Reliable Banking Operations</div>
        </div>
        
        <!-- Main Dashboard -->
        <div class="dashboard">
            <!-- Account Management Card -->
            <div class="card">
                <div class="card-icon">👥</div>
                <h3>Account Management</h3>
                <p>Create new accounts, view existing accounts, and manage customer information with our comprehensive account management system.</p>
                <div style="display: grid; gap: 12px;">
                    <a href="createAccount.jsp" class="btn btn-success">Create New Account</a>
                    <a href="viewAccounts.jsp" class="btn btn-secondary">View All Accounts</a>
                </div>
            </div>
            
            <!-- Transactions Card -->
            <div class="card">
                <div class="card-icon">💳</div>
                <h3>Banking Transactions</h3>
                <p>Process deposits, withdrawals, and manage financial transactions securely with real-time balance updates and verification.</p>
                <div style="display: grid; gap: 12px;">
                    <a href="addAmount.jsp" class="btn btn-primary">💰 Deposit Funds</a>
                    <a href="withdrawAmount.jsp" class="btn btn-danger">💸 Withdraw Funds</a>
                </div>
            </div>
            
            <!-- Account Operations Card -->
            <div class="card">
                <div class="card-icon">⚙️</div>
                <h3>Account Operations</h3>
                <p>Update customer details, modify account information, or securely close accounts while maintaining complete audit trails.</p>
                <div style="display: grid; gap: 12px;">
                    <a href="updateAccount.jsp" class="btn btn-warning">✏️ Update Details</a>
                    <a href="deleteAccount.jsp" class="btn btn-danger">🗑️ Delete Account</a>
                </div>
            </div>
        </div>
        
        <!-- Features Section -->
        <div class="features">
            <div class="feature-item">
                <div class="feature-icon">🔒</div>
                <h4>Bank-Grade Security</h4>
                <p>Enterprise-level security protocols to protect all financial data and transactions.</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">⚡</div>
                <h4>Instant Processing</h4>
                <p>Real-time transaction processing with immediate balance updates and confirmations.</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">📊</div>
                <h4>Complete Audit</h4>
                <p>Full transaction history and audit trails for compliance and reporting purposes.</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">🌍</div>
                <h4>24/7 Availability</h4>
                <p>Round-the-clock access to banking operations and customer management.</p>
            </div>
        </div>
        
        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2024 Global Trust Bank. All Rights Reserved.</p>
            <p>Professional Banking Management System | v2.1</p>
        </div>
    </div>
</body>
</html>