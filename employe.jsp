<%@ page import="com.affectemploie.dao.EmployeDAO, com.affectemploie.model.Employe, java.util.*" %>
<%@ page import="java.util.Collections,java.util.Comparator,java.util.ArrayList" %>

<%
    EmployeDAO employeDAO = new EmployeDAO();
    List<Employe> employes = employeDAO.getAllEmployes();
%>

<%!
    // Méthode pour mettre la première lettre en majuscule
    private String capitalize(String str) {
        if (str == null || str.isEmpty()) {
            return str;
        }
        return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
    }
%>

<%
    // Créer une copie modifiable de la liste
    List<Employe> employesTries = new ArrayList<>(employes);
    
    // Trier par code (numérique ou alphabétique)
    Collections.sort(employesTries, new Comparator<Employe>() {
        public int compare(Employe e1, Employe e2) {
            try {
                // Essayer un tri numérique
                int code1 = Integer.parseInt(e1.getCodeemp().trim());
                int code2 = Integer.parseInt(e2.getCodeemp().trim());
                return Integer.compare(code1, code2);
            } catch (NumberFormatException e) {
                // Si échec, tri alphabétique
                return e1.getCodeemp().compareToIgnoreCase(e2.getCodeemp());
            }
        }
    });
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
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        
        /* Modal */
        .modal .modal-dialog {
            max-width: 600px;
        }
        
        .modal .modal-header, .modal .modal-body, .modal .modal-footer {
            padding: 20px 30px;
        }
        
        .modal .modal-content {
            border-radius: 5px;
        }
        
        .modal .modal-footer {
            background: #ecf0f1;
            border-radius: 0 0 5px 5px;
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
        <li><a href="index.jsp"><i class="fas fa-home"></i> Tableau de Bord</a></li>
        <li><a href="employe.jsp" class="active"><i class="fas fa-users"></i> Employés</a></li>
        <li><a href="lieu.jsp"><i class="fas fa-map-marker-alt"></i> Lieux</a></li>
        <li><a href="affectation.jsp"><i class="fas fa-tasks"></i> Affectations</a></li>
        <li><a href="#"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
    </ul>
</nav>

<!-- Main Content -->
<div class="main-content">


    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 mb-0">Gestion des Employés</h1>
        <div class="text-muted">Bienvenue, Administrateur</div>
    </div>
    
    <!-- Employee Table -->
    <div class="table-wrapper">
        <div class="table-title">
            <div class="row">
                <div class="col-sm-6">
                    <h2>Liste des <b>Employés</b></h2>
                </div>
                <div class="col-sm-6">
                    <button class="btn btn-success float-right" data-toggle="modal" data-target="#addEmployeeModal">
                        <i class="fas fa-plus"></i> <span>Ajouter un employé</span>
                    </button>
                </div>
            </div>
        </div>
        
         <div class="search-box mb-3">
            <div class="input-group">
                <input type="text" id="searchInput" class="form-control" placeholder="Recherche...">
                <div class="input-group-append">
                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                </div>
            </div>
        </div>
        
        <table class="table table-striped table-hover">
		    <thead>
		        <tr>
		            <th>Code</th>
		            <th>Nom</th>
		            <th>Prénom</th>
		            <th>Poste</th>
		            <th>Actions</th>
		        </tr>
		    </thead>
		    <tbody>
		        <% for (Employe emp : employesTries) { %>
		            <tr>
		                <td><%= emp.getCodeemp() %></td>
		                <td><%= emp.getNom().toUpperCase() %></td>
		                <td><%= capitalize(emp.getPrenom()) %></td>
		                <td><%= capitalize(emp.getPoste()) %></td>
		                <td>
		                    <a href="#" class="edit btn btn-sm btn-primary" 
		                       data-code="<%= emp.getCodeemp() %>"
		                       data-nom="<%= emp.getNom() %>"
		                       data-prenom="<%= emp.getPrenom() %>"
		                       data-poste="<%= emp.getPoste() %>">
		                        <i class="fas fa-edit"></i> Modifier
		                    </a>
		                    <a href="#" class="delete btn btn-sm btn-danger ml-2"
		                       data-code="<%= emp.getCodeemp() %>">
		                        <i class="fas fa-trash"></i> Supprimer
		                    </a>
		                </td>
		            </tr>
		        <% } %>
		    </tbody>
		</table>
    </div>
</div>


<!-- Add Employee Modal -->
<div id="addEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="addEmployeeForm" action="ajouterEmployeServlet" method="post">

                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title">Nouvel Employé</h4>
                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Code</label>
                        <input type="text" name="codeemp" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Nom</label>
                        <input type="text" name="nom" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Prénom</label>
                        <input type="text" name="prenom" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Poste</label>
                        <input type="text" name="poste" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        <i class="fas fa-times"></i> Annuler
                    </button>
                    <button type="button" class="btn btn-success" id="confirmAddBtn">
					    <i class="fas fa-save"></i> Enregistrer
					</button>

                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning text-dark">
        <h5 class="modal-title">Confirmation</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fermer">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Voulez-vous vraiment ajouter cette information ?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Non</button>
        <button type="button" class="btn btn-primary" id="confirmSubmitBtn">Oui</button>
      </div>
    </div>
  </div>
</div>


<!-- Edit Employee Modal -->
<div id="editEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="editEmployeeForm" action="modifierEmployeServlet" method="post">
                <div class="modal-header bg-warning text-dark">
                    <h4 class="modal-title">Modifier Employé</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="originalCode" id="editOriginalCode">
                    
                    <div class="form-group">
                        <label>Code</label>
                        <input type="text" name="codeemp" id="editCode" class="form-control" required readonly>
                    </div>
                    <div class="form-group">
                        <label>Nom</label>
                        <input type="text" name="nom" id="editNom" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Prénom</label>
                        <input type="text" name="prenom" id="editPrenom" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Poste</label>
                        <input type="text" name="poste" id="editPoste" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        <i class="fas fa-times"></i> Annuler
                    </button>
                    <button type="submit" class="btn btn-warning text-white">
                        <i class="fas fa-edit"></i> Modifier
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Employee Modal -->
<div id="deleteEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="supprimerEmployeServlet" method="post">
                <div class="modal-header">
                    <h4 class="modal-title">Supprimer Employé</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Êtes-vous sûr de vouloir supprimer cet employé ?</p>
                    <div class="alert alert-info">
                        <strong>Code Employé:</strong> <span id="deleteCode"></span>
                    </div>
                    <p class="text-warning"><small>Cette action est irréversible.</small></p>
                    <input type="hidden" name="codeemp" id="deleteHiddenCode">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-danger">Supprimer</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function(){
        // Sidebar Toggle
        $('#sidebarToggle').click(function() {
            $('#sidebar').toggleClass('active');
        });

        // Recherche dans le tableau
        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("table tbody tr").each(function() {
                var found = false;
                $(this).find('td').each(function() {
                    if ($(this).text().toLowerCase().indexOf(value) > -1) {
                        found = true;
                        return false;
                    }
                });
                $(this).toggle(found);
            });
        });

        // Gestion de la modal d'édition
        $(document).on('click', '.edit', function() {
            var code = $(this).data('code');
            var nom = $(this).data('nom');
            var prenom = $(this).data('prenom');
            var poste = $(this).data('poste');
            
            $('#editOriginalCode').val(code);
            $('#editCode').val(code);
            $('#editNom').val(nom);
            $('#editPrenom').val(prenom);
            $('#editPoste').val(poste);
            
            $('#editEmployeeModal').modal('show');
        });
        
        $(document).ready(function() {
            // Intercepter la soumission du formulaire
            $('#editEmployeeForm').on('submit', function(e) {
                e.preventDefault(); // Empêcher l'envoi direct
                
                // Récupérer les valeurs
                const code = $('#editCode').val();
                const nom = $('#editNom').val();
                const prenom = $('#editPrenom').val();
                const poste = $('#editPoste').val();
                
                // Afficher une boîte de dialogue de confirmation
                Swal.fire({
                    title: 'Confirmer la modification',
                    html: `
                        <p>Voulez-vous vraiment modifier cet employé ?</p>
                        
                    `,
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#ffc107',
                    confirmButtonText: 'Oui, modifier',
                    cancelButtonText: 'Annuler'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Si confirmé, soumettre le formulaire
                        this.submit();
                    }
                });
            });
        });

        // Gestion de la modal de suppression
        $(document).on('click', '.delete', function() {
            var code = $(this).data('code');
            
            $('#deleteCode').text(code);
            $('#deleteHiddenCode').val(code);
            
            $('#deleteEmployeeModal').modal('show');
        });
    });
    
    document.getElementById('confirmAddBtn').addEventListener('click', function() {
        $('#confirmationModal').modal('show');
    });

    document.getElementById('confirmSubmitBtn').addEventListener('click', function() {
        document.getElementById('addEmployeeForm').submit();
    });
   
</script>
</body>
</html>