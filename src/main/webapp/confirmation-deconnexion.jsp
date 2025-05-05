<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String username = (String) session.getAttribute("username");
    char userInitial = !username.isEmpty() ? Character.toUpperCase(username.charAt(0)) : '?';
%>
<!DOCTYPE html>
<html lang="fr">
<head>
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
            --warning-color: #f8961e;
            
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
            justify-content: center;
            align-items: center;
            margin: 0;
            padding: 20px;
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
        .confirmation-container {
            max-width: 500px;
            width: 100%;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.5s ease-out;
        }

        .confirmation-header {
            background: var(--primary-color);
            color: white;
            padding: 25px;
            text-align: center;
            position: relative;
        }

        .confirmation-header::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 0;
            right: 0;
            height: 40px;
            background: white;
            transform: skewY(-3deg);
            z-index: 1;
        }

        .confirmation-icon {
            font-size: 60px;
            color: var(--warning-color);
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }

        .confirmation-body {
            padding: 30px;
            position: relative;
            z-index: 2;
        }

        .confirmation-title {
            color: var(--dark-color);
            font-weight: 600;
            margin-bottom: 15px;
        }

        .confirmation-text {
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }

        .btn-confirm {
            background: var(--primary-color);
            border: none;
            border-radius: 8px;
            padding: 12px 25px;
            font-weight: 500;
            transition: all 0.3s;
            color: white;
        }

        .btn-confirm:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-cancel {
            background: white;
            border: 1px solid #ddd;
            color: var(--dark-color);
            border-radius: 8px;
            padding: 12px 25px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background: #f8f9fa;
            border-color: #ccc;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }

        .user-info {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--accent-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 20px;
        }

        .user-name {
            font-weight: 500;
            color: var(--dark-color);
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="confirmation-header">
        <div class="logo">
            <img src="logo 1.png" alt="Logo">
        </div>
        
            <h3>Déconnexion</h3>
        </div>
        
        <div class="confirmation-body text-center">
            
            
            <h4 class="confirmation-title">Êtes-vous sûr de vouloir vous déconnecter ?</h4>
            <p class="confirmation-text">Vous serez redirigé vers la page de connexion et devrez entrer à nouveau vos identifiants pour accéder à votre compte.</p>
            
            <div class="action-buttons">
                <a href="index.jsp" class="btn btn-cancel">
                    <i class="fas fa-arrow-left me-2"></i>Annuler
                </a>
                <a href="logout.jsp" class="btn btn-confirm">
                    <i class="fas fa-sign-out-alt me-2"></i>Se déconnecter
                </a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    $(document).ready(function() {

        $(".confirmation-container").hide().fadeIn(500);

        $('.btn-confirm').click(function(e) {
            e.preventDefault();
            const logoutUrl = $(this).attr('href');


            $('.confirmation-icon').html('<i class="fas fa-spinner fa-spin"></i>');
            $('.confirmation-title').text('Déconnexion en cours...');
            $('.confirmation-text').text('Veuillez patienter pendant que nous sécurisons votre session.');
            $('.action-buttons').fadeOut();


            setTimeout(function() {
                window.location.href = logoutUrl;
            }, 1500);
        });
    });
    </script>
</body>
</html>