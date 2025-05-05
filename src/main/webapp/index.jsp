<%@ page import="java.util.Map, java.util.List, java.util.ArrayList" %>
<%@ page import="com.affectemploie.dao.EmployeDAO, com.affectemploie.dao.LieuDAO, com.affectemploie.dao.AffectationDAO" %>

<%
// Initialiser les DAO
EmployeDAO employeDAO = new EmployeDAO();
LieuDAO lieuDAO = new LieuDAO();
AffectationDAO affectationDAO = new AffectationDAO();

// Récupérer les comptages
int nombreEmployes = employeDAO.getNombreEmployes();
int nombreLieux = lieuDAO.getNombreLieux();
int nombreAffectations = affectationDAO.getNombreAffectations();

// Récupérer les dernières affectations
List<Map<String, String>> affectations = affectationDAO.getAffectationsDetails();
%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
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
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link rel="icon" type="image/png" href="logo 2.png">

    <style>
        :root {
            --sidebar-width: 220px;
            --primary-color: #006691;
            --secondary-color: #0084b1;
            --accent-color: #00a8e8;
        }
        
        body {
            color: #566787;
            background: #f5f5f5;
            font-family: 'Varela Round', sans-serif;
            font-size: 13px;
            margin-left: var(--sidebar-width);
            transition: all 0.3s;
        }
        
        /* Sidebar */
        nav {
            width: var(--sidebar-width);
            height: 100vh;
            background-color: var(--secondary-color);
            padding-top: 20px;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
        }
        
        nav img {
            display: block;
            margin: 0 auto 20px;
            height: 80px;
            transition: all 0.3s;
        }
        
        nav ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        
        nav ul li {
            text-align: left;
            margin: 5px 15px;
        }
        
        nav ul li a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            font-size: 15px;
            padding: 12px 15px;
            border-radius: 4px;
            transition: all 0.3s;
        }
        
        nav ul li a i {
            margin-right: 10px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }
        
        nav ul li a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }
        
        nav ul li a.active {
            background-color: white;
            color: var(--secondary-color);
            font-weight: bold;
        }
        
        /* Main Content */
        .main-content {
            padding: 20px;
            margin-left: 0;
            transition: all 0.3s;
        }
        
        /* Dashboard Cards */
        .card {
            border: none;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        
        .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            transform: translateY(-5px);
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            font-weight: bold;
            padding: 15px 20px;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .stat-card {
            text-align: center;
            padding: 20px;
        }
        
        .stat-card .value {
            font-size: 28px;
            font-weight: bold;
            color: var(--primary-color);
            margin: 10px 0;
        }
        
        .stat-card .label {
            font-size: 14px;
            color: #6c757d;
        }
        
        .stat-card .icon {
            font-size: 40px;
            color: var(--accent-color);
            margin-bottom: 10px;
        }
        
        /* Table */
        .table-wrapper {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
        }
        
        .table-title {
            padding: 15px 20px;
            background: var(--primary-color);
            color: #fff;
            border-radius: 5px 5px 0 0;
            margin: -20px -20px 15px -20px;
        }
        
        .table-title h2 {
            margin: 0;
            font-size: 20px;
        }
        
        .search-box {
            position: relative;
        }
        
        .search-box input {
            padding-right: 35px;
            border-radius: 20px;
            border: 1px solid #ddd;
        }
        
        .search-box .input-group-text {
            position: absolute;
            right: 0;
            top: 0;
            bottom: 0;
            background: transparent;
            border: none;
            z-index: 10;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            body {
                margin-left: 0;
            }
            
            nav {
                transform: translateX(-100%);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            nav.active {
                transform: translateX(0);
            }
        }
        
        /* Toggle Button */
        .sidebar-toggle {
            position: fixed;
            left: 10px;
            top: 10px;
            z-index: 1100;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: none;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        
        @media (max-width: 768px) {
            .sidebar-toggle {
                display: flex;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar Toggle Button -->
<button class="sidebar-toggle" id="sidebarToggle">
    <i class="fas fa-bars"></i>
</button>

<!-- Sidebar Navigation -->
<nav id="sidebar">
    <a href="index.jsp">
        <img src="logo 3.png" alt="Logo">
    </a>
    <ul>
        <li><a href="index.jsp" class="active"><i class="fas fa-home"></i> Tableau de Bord</a></li>
        <li><a href="employe.jsp"><i class="fas fa-users"></i> Employés</a></li>
        <li><a href="lieu.jsp"><i class="fas fa-map-marker-alt"></i> Lieux</a></li>
        <li><a href="affectation.jsp"><i class="fas fa-tasks"></i> Affectations</a></li>
		<li><a href="confirmation-deconnexion.jsp"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
    </ul>
</nav>

<!-- Main Content -->
<div class="main-content">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 mb-0">Tableau de Bord</h1>
        <div class="text-muted">Bienvenue, Administrateur</div>
    </div>
    
    <!-- Stats Cards -->
    <div class="row">
            <div class="col-md-4">
                <div class="card stat-card">
                    <div class="icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="value"><%= nombreEmployes %></div>
                    <div class="label">Employés</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stat-card">
                    <div class="icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="value"><%= nombreLieux %></div>
                    <div class="label">Lieux</div>
                </div>
            </div>
             <div class="col-md-4">
                <div class="card stat-card">
                    <div class="icon">
                        <i class="fas fa-tasks"></i>
                    </div>
                    <div class="value"><%= nombreAffectations %></div>
                    <div class="label">Affectations</div>
                </div>
            </div>
    </div>
    
    <!-- Recent Affectations Table dynamique -->
    <div class="card mt-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <div>
                <i class="fas fa-table mr-2"></i> Dernières affectations
            </div>
            <div class="search-box">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Rechercher..." id="searchInput">
                    <div class="input-group-append">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover" id="affectationsTable">
                        <thead class="thead-light">
                            <tr>
                                <th>Code employé</th>
                                <th>Nom</th>
                                <th>Prénoms</th>
                                <th>Poste</th>
                                <th>Code Lieu</th>
                                <th>Désignation</th>
                                <th>Province</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
								if (affectations != null && !affectations.isEmpty()) {
								    // Trier la liste par code employé (numérique ou alphabétique)
								    affectations.sort(new java.util.Comparator<Map<String, String>>() {
								        public int compare(Map<String, String> a1, Map<String, String> a2) {
								            try {
								                // Essayer un tri numérique
								                int code1 = Integer.parseInt(a1.get("code_employe"));
								                int code2 = Integer.parseInt(a2.get("code_employe"));
								                return Integer.compare(code1, code2);
								            } catch (NumberFormatException e) {
								                // Si échec, tri alphabétique
								                return a1.get("code_employe").compareTo(a2.get("code_employe"));
								            }
								        }
								    });
								    
								    for (Map<String, String> aff : affectations) {
								%>
                            <tr>
                                <td><%= aff.get("code_employe") %></td>
                                <td><%= aff.get("nom") %></td>
                                <td><%= aff.get("prenoms") %></td>
                                <td><%= aff.get("poste") %></td>
                                <td><%= aff.get("code_lieu") %></td>
                                <td><%= aff.get("designation") %></td>
                                <td><%= aff.get("province") %></td>
                                <td><%= aff.get("date") %></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="8" class="text-center">Aucune affectation disponible</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts JavaScript -->
    <script>
        // Recherche dynamique dans le tableau
        document.getElementById("searchInput").addEventListener("keyup", function () {
            const searchValue = this.value.toLowerCase();
            const rows = document.querySelectorAll("#affectationsTable tbody tr");

            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchValue) ? "" : "none";
            });
        });
        
        // Gestion du bouton sidebar toggle pour responsive
        document.getElementById("sidebarToggle").addEventListener("click", function() {
            document.getElementById("sidebar").classList.toggle("active");
        });
    </script>

</body>
</html>