<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.affectemploie.dao.EmployeDAO, com.affectemploie.dao.LieuDAO, com.affectemploie.model.Employe, com.affectemploie.model.Lieu" %>
<%@ page import="com.affectemploie.dao.AffectationDAO, com.affectemploie.model.Affectation, java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="java.util.Collections,java.util.Comparator" %>
<%@ page import="java.util.Collections,java.util.Comparator" %>

<%
// D'abord récupérer les données
AffectationDAO affectationDAO = new AffectationDAO();
List<Affectation> affectations = affectationDAO.getAllAffectations();

EmployeDAO employeDAO = new EmployeDAO();
List<Employe> employes = employeDAO.getAllEmployes();

LieuDAO lieuDAO = new LieuDAO();
List<Lieu> lieux = lieuDAO.getAllLieux();

// Ensuite trier les données
// Trier les employés par code
Collections.sort(employes, new Comparator<Employe>() {
    public int compare(Employe e1, Employe e2) {
        try {
            // Essayer un tri numérique
            return Integer.compare(
                Integer.parseInt(e1.getCodeemp().trim()),
                Integer.parseInt(e2.getCodeemp().trim())
            );
        } catch (NumberFormatException e) {
            // Si échec, tri alphabétique
            return e1.getCodeemp().compareToIgnoreCase(e2.getCodeemp());
        }
    }
});

// Trier les affectations par code employé
Collections.sort(affectations, new Comparator<Affectation>() {
    public int compare(Affectation a1, Affectation a2) {
        try {
            return Integer.compare(
                Integer.parseInt(a1.getCodeemp().trim()),
                Integer.parseInt(a2.getCodeemp().trim())
            );
        } catch (NumberFormatException e) {
            return a1.getCodeemp().compareToIgnoreCase(a2.getCodeemp());
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
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        <li><a href="employe.jsp"><i class="fas fa-users"></i> Employés</a></li>
        <li><a href="lieu.jsp"><i class="fas fa-map-marker-alt"></i> Lieux</a></li>
        <li><a href="affectation.jsp" class="active"><i class="fas fa-tasks"></i> Affectations</a></li>
        <li><a href="#"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
    </ul>
</nav>

<!-- Main Content -->
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 mb-0">Gestion des Affectations</h1>
        <div class="text-muted">Bienvenue, Administrateur</div>
    </div>

    <div class="table-wrapper">
        <div class="table-title">
            <div class="row">
                <div class="col-sm-6">
                    <h2>Liste des <b>Affectations</b></h2>
                </div>
                <div class="col-sm-6">
                    <button class="btn btn-success float-right" data-toggle="modal" data-target="#addAffectationModal">
                        <i class="fas fa-plus"></i> <span>Nouvelle Affectation</span>
                    </button>
                </div>
            </div>
        </div>

        <div class="search-box mb-3">
            <div class="input-group">
                <input type="text" id="searchInput" class="form-control" placeholder="Rechercher une affectation...">
                <div class="input-group-append">
                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                </div>
            </div>
        </div>

        <table class="table table-striped table-hover">
    <thead>
        <tr>
            <th>Code Employé</th>
            <th>Code Lieu</th>
            <th>Date Affectation</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <% for (Affectation affectation : affectations) { 
            Employe employe = employeDAO.getEmployeByCode(affectation.getCodeemp());
            Lieu lieu = lieuDAO.getLieuByCode(affectation.getCodelieu());
        %>
        <tr>
            <td>
                <% if (employe != null) { %>
                    <div><strong><%= employe.getCodeemp() %></strong></div>
                    <div><%= employe.getNom() %> <%= employe.getPrenom() %></div>
                    <div class="text-muted"><%= employe.getPoste() %></div>
                <% } else { %>
                    <div class="text-danger">Employé introuvable</div>
                <% } %>
            </td>
            <td>
                <% if (lieu != null) { %>
                    <div><strong><%= lieu.getCodelieu() %></strong></div>
                    <div><%= lieu.getDesignation() %></div>
                    <div class="text-muted"><%= lieu.getProvince() %></div>
                <% } else { %>
                    <div class="text-danger">Lieu introuvable</div>
                <% } %>
            </td>
            <td><%= new SimpleDateFormat("dd/MM/yyyy").format(affectation.getDate()) %></td>
            <td>
                <a href="#" class="edit btn btn-sm btn-primary" 
                   data-codeemp="<%= affectation.getCodeemp() %>"
                   data-codelieu="<%= affectation.getCodelieu() %>"
                   data-date="<%= new SimpleDateFormat("yyyy-MM-dd").format(affectation.getDate()) %>">
                    <i class="fas fa-edit"></i> Modifier
                </a>
                <a href="#" class="delete btn btn-sm btn-danger ml-2"
                   data-codeemp="<%= affectation.getCodeemp() %>"
                   data-codelieu="<%= affectation.getCodelieu() %>">
                    <i class="fas fa-trash"></i> Supprimer
                </a>
            </td>
        </tr>
        <% } %>
    </tbody>
</table>
    </div>
</div>

<!-- Add Affectation Modal -->
<div id="addAffectationModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="ajouterAffectationServlet" method="post">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title">Nouvelle Affectation</h4>
                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
				        <label>Employé</label>
				        <select name="codeemp" class="form-control" required>
				            <option value="">Sélectionner un employé</option>
				            <% for (Employe emp : employes) { %>
				                <option value="<%= emp.getCodeemp() %>">
				                    <%= emp.getCodeemp() %> - <%= emp.getNom() %> <%= emp.getPrenom() %>
				                </option>
				            <% } %>
				        </select>
				    </div>
				    
				    <div class="form-group">
				        <label>Lieu</label>
				        <select name="codelieu" class="form-control" required>
				            <option value="">Sélectionner un lieu</option>
				            <% for (Lieu lieu : lieux) { %>
				                <option value="<%= lieu.getCodelieu() %>">
				                    <%= lieu.getCodelieu() %> - <%= lieu.getDesignation() %>
				                </option>
				            <% } %>
				        </select>
				    </div>
				    
				    <div class="form-group">
				        <label>Date Affectation</label>
				        <input type="date" name="date" class="form-control" required 
				               value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>">
				    </div>
    
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
	                        <i class="fas fa-times"></i> Annuler
	                    </button>
	                    <button type="submit" class="btn btn-success">
	                        <i class="fas fa-save"></i> Enregistrer
	                    </button>
	                </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Affectation Modal -->
<div id="editAffectationModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="editAffectationForm" action="modifierAffectationServlet" method="post">
                <div class="modal-header bg-warning text-dark">
                    <h4 class="modal-title">Modifier Affectation</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="originalCodeemp" id="editOriginalCodeemp">
                    <input type="hidden" name="originalCodelieu" id="editOriginalCodelieu">
                    
                    <div class="form-group">
                        <label>Employé</label>
                        <select name="codeemp" id="editCodeemp" class="form-control" required>
                            <% for (Employe emp : employes) { %>
                                <option value="<%= emp.getCodeemp() %>">
                                    <%= emp.getCodeemp() %> - <%= emp.getNom() %> <%= emp.getPrenom() %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Lieu</label>
                        <select name="codelieu" id="editCodelieu" class="form-control" required>
                            <% for (Lieu lieu : lieux) { %>
                                <option value="<%= lieu.getCodelieu() %>">
                                    <%= lieu.getCodelieu() %> - <%= lieu.getDesignation() %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Date Affectation</label>
                        <input type="date" name="date" id="editDate" class="form-control" required>
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

<!-- Delete Affectation Modal -->
<div id="deleteAffectationModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="supprimerAffectationServlet" method="post">
                <div class="modal-header">
                    <h4 class="modal-title">Supprimer Affectation</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Êtes-vous sûr de vouloir supprimer cette affectation ?</p>
                    <div class="alert alert-info">
                        <strong>Code Employé:</strong> <span id="deleteCodeemp"></span><br>
                        <strong>Code Lieu:</strong> <span id="deleteCodelieu"></span>
                    </div>
                    <p class="text-warning"><small>Cette action est irréversible.</small></p>
                    <input type="hidden" name="codeemp" id="deleteHiddenCodeemp">
                    <input type="hidden" name="codelieu" id="deleteHiddenCodelieu">
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
            $("table tbody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });

        // Gestion de la modal d'édition
        $(document).on('click', '.edit', function() {
            var codeemp = $(this).data('codeemp');
            var codelieu = $(this).data('codelieu');
            var date = $(this).data('date');
            
            console.log("Editing:", codeemp, codelieu, date); // Debug
            
            $('#editOriginalCodeemp').val(codeemp);
            $('#editOriginalCodelieu').val(codelieu);
            $('#editCodeemp').val(codeemp).trigger('change');
            $('#editCodelieu').val(codelieu).trigger('change');
            $('#editDate').val(date);
            
            $('#editAffectationModal').modal('show');
        });

        // Gestion de la modal de suppression
        $(document).on('click', '.delete', function() {
            var codeemp = $(this).data('codeemp');
            var codelieu = $(this).data('codelieu');
            
            console.log("Deleting:", codeemp, codelieu); // Debug
            
            $('#deleteCodeemp').text(codeemp);
            $('#deleteCodelieu').text(codelieu);
            $('#deleteHiddenCodeemp').val(codeemp);
            $('#deleteHiddenCodelieu').val(codelieu);
            
            $('#deleteAffectationModal').modal('show');
        });
    });
    
    $(document).ready(function(){
        // Recherche dans le tableau
        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("table tbody tr").each(function() {
                var found = false;
                $(this).find('td').each(function() {
                    if ($(this).text().toLowerCase().indexOf(value) > -1) {
                        found = true;
                        return false; // Sortie de la boucle si trouvé
                    }
                });
                $(this).toggle(found);
            });
        });
    });
    
    $(document).ready(function() {
        // Intercepter la soumission du formulaire
        $('#editAffectationForm').on('submit', function(e) {
            e.preventDefault(); // Empêcher l'envoi direct
            
            // Récupérer les valeurs
            const empCode = $('#editCodeemp option:selected').val();
	        const empText = $('#editCodeemp option:selected').text();
	        const lieuCode = $('#editCodelieu option:selected').val();
	        const lieuText = $('#editCodelieu option:selected').text();
	        const date = $('#editDate').val();
            
            // Afficher une boîte de dialogue de confirmation
            Swal.fire({
                title: 'Confirmer la modification',
                html: `
                    <p>Voulez-vous vraiment modifier cet affectation ?</p>
                    
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

    
</script>
</body>
</html>