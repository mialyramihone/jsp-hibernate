<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>AffectEmploi</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link rel="icon" type="image/png" href="logo 2.png">
<style>
:root {
    /* --primary-color: #4361ee;
    --secondary-color: #3f37c9;
    --accent-color: #4895ef; */
    --light-color: #f8f9fa;
    --dark-color: #212529;
    --error-color: #ef233c;
    --success-color: #4cc9f0;
    
    --sidebar-width: 220px;
            --primary-color: #006691;
            --secondary-color: #0084b1;
            --accent-color: #00a8e8;
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0;
    padding: 20px;
}

.login-container {
    width: 100%;
    max-width: 450px;
    background: white;
    border-radius: 16px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    position: relative;
    z-index: 1;
}

.login-header {
    background: var(--primary-color);
    color: white;
    padding: 30px;
    text-align: center;
    position: relative;
}

.login-header::after {
    content: '';
    position: absolute;
    bottom: -20px;
    left: 0;
    right: 0;
    height: 40px;
    background: white;
    transform: skewY(-3deg);
    z-index: -1;
}

.logo {
    width: 80px;
    height: 80px;
    margin-bottom: 15px;
    border-radius: 50%;
    background: white;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.logo img {
    max-width: 70%;
    max-height: 70%;
}

.login-body {
    padding: 30px;
}

.form-control {
    height: 50px;
    border-radius: 8px;
    border: 1px solid #e0e0e0;
    padding-left: 45px;
    transition: all 0.3s;
}

.form-control:focus {
    border-color: var(--accent-color);
    box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
}

.input-group-text {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    z-index: 4;
    color: var(--primary-color);
    background: transparent;
    border: none;
}

.btn-login {
    background: var(--primary-color);
    border: none;
    height: 50px;
    border-radius: 8px;
    font-weight: 500;
    letter-spacing: 0.5px;
    transition: all 0.3s;
}

.btn-login:hover {
    background: var(--secondary-color);
    transform: translateY(-2px);
}

.forgot-password {
    color: var(--primary-color);
    text-decoration: none;
    font-size: 14px;
    transition: all 0.3s;
}

.forgot-password:hover {
    color: var(--secondary-color);
    text-decoration: underline;
}

.divider {
    display: flex;
    align-items: center;
    margin: 20px 0;
}

.divider::before, .divider::after {
    content: "";
    flex: 1;
    border-bottom: 1px solid #e0e0e0;
}

.divider-text {
    padding: 0 10px;
    color: #757575;
    font-size: 14px;
}

.social-login {
    display: flex;
    justify-content: center;
    gap: 15px;
}

.social-btn {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    transition: all 0.3s;
}

.social-btn:hover {
    transform: translateY(-3px);
}

.social-btn.google {
    background: #DB4437;
}

.social-btn.microsoft {
    background: #0078d4;
}

.social-btn.apple {
    background: #000000;
}

.footer-links {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 20px;
}

.footer-links a {
    color: #757575;
    font-size: 13px;
    text-decoration: none;
    transition: all 0.3s;
}

.footer-links a:hover {
    color: var(--primary-color);
}

.password-toggle {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #757575;
    z-index: 4;
}

.input-group {
    position: relative;
}

.input-group .form-control {
    padding-right: 45px;
}
</style>
</head>
<body>

<div class="login-container">
    <div class="login-header">
        <div class="logo">
            <img src="logo 1.png" alt="Logo">
        </div>
        <h2 class="mb-0">Bienvenue sur AffectEmploi</h2>
        <p class="mb-0">Connectez-vous pour accéder à votre espace</p>
    </div>
    
    <div class="login-body">
        <form method="post" action="direct-login.jsp" id="loginForm">
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Nom d'utilisateur" required>
                </div>
            </div>
            
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" name="password" id="password" class="form-control" placeholder="Mot de passe" required>
                    <span class="password-toggle" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>

            </div>
            
            <button type="submit" class="btn btn-primary btn-login w-100 mb-3">
                <i class="fas fa-sign-in-alt me-2"></i> Se connecter
            </button>
            
        </form>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
$(document).ready(function() {
    // Toggle password visibility
    $('#togglePassword').click(function() {
        const password = $('#password');
        const type = password.attr('type') === 'password' ? 'text' : 'password';
        password.attr('type', type);
        $(this).find('i').toggleClass('fa-eye fa-eye-slash');
    });
    
    <% if (request.getAttribute("error") != null || request.getParameter("error") != null) { %>
    Swal.fire({
        icon: 'error',
        title: 'Connexion échouée',
        text: '<%= request.getAttribute("error") != null ? request.getAttribute("error") : "Identifiants incorrects" %>',
        confirmButtonColor: '#4361ee',
        backdrop: `
            rgba(0,0,0,0.4)
            url("/images/nyan-cat.gif")
            left top
            no-repeat
        `
    });
    <% } %>
    
    // Animation on load
    $('.login-container').hide().fadeIn(500);
    $('.login-header').css('transform', 'translateY(-20px)');
    $('.login-header').animate({
        'transform': 'translateY(0)'
    }, 800);
});
</script>
</body>
</html>