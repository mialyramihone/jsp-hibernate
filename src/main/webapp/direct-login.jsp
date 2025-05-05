<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Vérifier si une soumission a été faite
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Vérifier les identifiants directement dans la page
        if ("admin".equals(username) && "admin123".equals(password)) {
            // Créer une session
            session.setAttribute("username", username);
            
            // Rediriger vers la page d'accueil
            response.sendRedirect("index.jsp");
            return;
        } else {
            // Définir le drapeau d'erreur
            request.setAttribute("error", "1");
        }
    }
%>
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
body { 
    background: #f8f9fa; 
    font-family: 'Varela Round', sans-serif;
}
.login-container {
    max-width: 400px;
    margin: 100px auto;
    padding: 20px;
    background: white;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
.login-logo {
    text-align: center;
    margin-bottom: 20px;
}
.login-logo img {
    height: 80px;
}
</style>
</head>
<body>

<div class="login-container">
    <div class="login-logo">
        <img src="logo 3.png" alt="Logo">
    </div>
    <h2 class="text-center mb-4">Connexion</h2>

    <!-- Formulaire qui se soumet à la même page -->
    <form method="post" action="direct-login.jsp" id="loginForm">
        <div class="form-group">
            <label>Nom d'utilisateur</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Mot de passe</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Se connecter</button>
    </form>
</div>

<script>
$(document).ready(function() {
    <% if (request.getAttribute("error") != null || request.getParameter("error") != null) { %>
    Swal.fire({
        icon: 'error',
        title: 'Erreur',
        text: 'Identifiants incorrects',
        confirmButtonColor: '#3085d6'
    });
    <% } %>
});
</script>

</body>
</html>