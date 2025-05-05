<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ page import="com.affectemploie.dao.LieuDAO, com.affectemploie.model.Lieu, java.util.*" %>
<%
    LieuDAO lieuDAO = new LieuDAO();
    List<Lieu> lieux = lieuDAO.getAllLieux();
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
        
        table th, table td {
    width: 30px; 
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
        <li><a href="lieu.jsp" class="active"><i class="fas fa-map-marker-alt"></i> Lieux</a></li>
        <li><a href="affectation.jsp"><i class="fas fa-tasks"></i> Affectations</a></li>
       <li><a href="confirmation-deconnexion.jsp"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
    </ul>
</nav>

<!-- Main Content -->
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 mb-0">Gestion des Lieux</h1>
        <div class="text-muted">Bienvenue, Administrateur</div>
    </div>

    <div class="table-wrapper">
        <div class="table-title">
            <div class="row">
                <div class="col-sm-6">
                    <h2>Liste des <b>Lieux</b></h2>
                </div>
                <div class="col-sm-6">
                    <button class="btn btn-success float-right" data-toggle="modal" data-target="#addLieuModal">
                        <i class="fas fa-plus"></i> <span>Ajouter un lieu</span>
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
            <th>Designation</th>
            <th>Province</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            // Trier les lieux par code en ordre croissant
            Collections.sort(lieux, new Comparator<Lieu>() {
                public int compare(Lieu l1, Lieu l2) {
                    return l1.getCodelieu().compareTo(l2.getCodelieu());
                }
            });
            
            for (Lieu lieu : lieux) {
        %>
            <tr>
                <td><%= lieu.getCodelieu() %></td>
                <td><%= lieu.getDesignation() %></td>
                <td><%= lieu.getProvince().toUpperCase() %></td>
                <td>
                    <a href="#" class="edit btn btn-sm btn-primary" 
                       data-code="<%= lieu.getCodelieu() %>"
                       data-designation="<%= lieu.getDesignation() %>"
                       data-province="<%= lieu.getProvince() %>">
                        <i class="fas fa-edit"></i> Modifier
                    </a>
                    <a href="#" class="delete btn btn-sm btn-danger ml-2"
                       data-code="<%= lieu.getCodelieu() %>">
                        <i class="fas fa-trash"></i> Supprimer
                    </a>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>
    </div>
</div>

<!-- Add Lieu Modal -->
<div id="addLieuModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="addLieuForm"  action="ajouterLieuServlet" method="post">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title">Nouveau Lieu</h4>
                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Code</label>
                        <input type="text" name="codelieu" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Désignation</label>
                        <input type="text" name="designation" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Province</label>
                        <input type="text" name="province" class="form-control" required>
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


<!-- Edit Lieu Modal -->
<div id="editLieuModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="editLieuForm" action="modifierLieuServlet" method="post">
                <div class="modal-header bg-warning text-dark">
                    <h4 class="modal-title">Modifier Lieu</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="originalCode" id="editOriginalCode">
                    
                    <div class="form-group">
                        <label>Code</label>
                        <input type="text" name="codelieu" id="editCode" class="form-control" required readonly>
                    </div>
                    <div class="form-group">
                        <label>Désignation</label>
                        <input type="text" name="designation" id="editDesignation" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Province</label>
                        <input type="text" name="province" id="editProvince" class="form-control" required>
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

<!-- Delete Lieu Modal -->
<div id="deleteLieuModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="supprimerLieuServlet" method="post">
                <div class="modal-header">
                    <h4 class="modal-title">Supprimer Lieu</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Êtes-vous sûr de vouloir supprimer ce lieu ?</p>
                    <div class="alert alert-info">
                        <strong>Code:</strong> <span id="deleteCode"></span>
                    </div>
                    <p class="text-warning"><small>Cette action est irréversible.</small></p>
                    <input type="hidden" name="codelieu" id="deleteHiddenCode">
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
            var designation = $(this).data('designation');
            var province = $(this).data('province');
            
            $('#editOriginalCode').val(code);
            $('#editCode').val(code);
            $('#editDesignation').val(designation);
            $('#editProvince').val(province);
            
            $('#editLieuModal').modal('show');
        });
        
        $(document).ready(function() {
            // Intercepter la soumission du formulaire
            $('#editLieuForm').on('submit', function(e) {
                e.preventDefault(); // Empêcher l'envoi direct
                
                // Récupérer les valeurs
                const code = $('#editCode').val();
        		const designation = $('#editDesignation').val();
        		const province = $('#editProvince').val();
                
                // Afficher une boîte de dialogue de confirmation
                Swal.fire({
                    title: 'Confirmer la modification',
                    html: `
                        <p>Voulez-vous vraiment modifier ce lieu ?</p>
                        
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
            
            $('#deleteLieuModal').modal('show');
        });
    });
    
    document.getElementById('confirmAddBtn').addEventListener('click', function() {
        $('#confirmationModal').modal('show');
    });

    document.getElementById('confirmSubmitBtn').addEventListener('click', function() {
        document.getElementById('addLieuForm').submit();
    });
    
</script>
</body>
</html>