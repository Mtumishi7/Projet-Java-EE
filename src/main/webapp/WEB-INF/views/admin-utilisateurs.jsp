<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Administration des Utilisateurs - Gestion Stages & PFE</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800">
    <!-- Navbar -->
    <nav class="bg-indigo-900 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <span class="font-bold text-xl tracking-wide">🛠️ Administration - Gestion des Utilisateurs (CRUD)</span>
                <div class="flex items-center space-x-3">
                    <a href="${pageContext.request.contextPath}/admin/logs" class="bg-blue-600 hover:bg-blue-500 text-white px-4 py-2 rounded-lg text-sm font-medium transition">📋 Journaux d'Activités</a>
                    <a href="${pageContext.request.contextPath}/admin/export-csv" class="bg-emerald-600 hover:bg-emerald-500 text-white px-4 py-2 rounded-lg text-sm font-medium transition">📥 Exporter CSV</a>
                    <a href="${pageContext.request.contextPath}/demandes" class="bg-indigo-800 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition">Retour aux Demandes</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-8">
        
        <!-- Form Add/Edit User Card -->
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 p-6" id="form-card">
            <h3 class="font-bold text-lg text-slate-900 mb-4" id="form-title">Créer un nouvel utilisateur</h3>
            <form action="${pageContext.request.contextPath}/admin/utilisateurs" method="post" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-6 gap-4 items-end">
                <input type="hidden" name="action" id="form-action" value="creer">
                <input type="hidden" name="id" id="userId">
                <div>
                    <label class="block text-xs font-semibold text-slate-600 mb-1">Prénom</label>
                    <input type="text" name="prenom" id="userPrenom" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-slate-600 mb-1">Nom</label>
                    <input type="text" name="nom" id="userNom" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-slate-600 mb-1">Email</label>
                    <input type="email" name="email" id="userEmail" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-slate-600 mb-1">Mot de passe <span id="pwd-hint" class="text-xs text-slate-400 font-normal"></span></label>
                    <input type="password" name="motDePasse" id="userPwd" class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-slate-600 mb-1">Rôle</label>
                    <select name="role" id="userRole" class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm">
                        <option value="ETUDIANT">ETUDIANT</option>
                        <option value="ENSEIGNANT">ENSEIGNANT</option>
                        <option value="ADMIN">ADMIN</option>
                    </select>
                </div>
                <div class="flex gap-2">
                    <button type="submit" id="submit-btn" class="flex-1 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold py-2 px-4 rounded-xl text-sm transition shadow-sm">Créer</button>
                    <button type="button" id="cancel-btn" onclick="resetForm()" class="hidden bg-slate-200 hover:bg-slate-300 text-slate-700 py-2 px-3 rounded-xl text-sm transition">Annuler</button>
                </div>
            </form>
        </div>

        <!-- Users Table Card -->
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="px-6 py-5 border-b border-slate-100 flex justify-between items-center">
                <h3 class="font-bold text-lg text-slate-900">Liste de tous les utilisateurs (CRUD)</h3>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-slate-50 text-slate-600 uppercase text-xs tracking-wider border-b border-slate-200">
                            <th class="py-4 px-6 font-semibold">ID</th>
                            <th class="py-4 px-6 font-semibold">Nom & Prénom</th>
                            <th class="py-4 px-6 font-semibold">Email</th>
                            <th class="py-4 px-6 font-semibold">Rôle</th>
                            <th class="py-4 px-6 font-semibold text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 text-sm">
                        <c:forEach var="u" items="${utilisateurs}">
                            <tr class="hover:bg-slate-50/80 transition">
                                <td class="py-4 px-6 font-medium text-slate-500">#<c:out value="${u.id}"/></td>
                                <td class="py-4 px-6 font-semibold text-slate-900"><c:out value="${u.prenom}"/> <c:out value="${u.nom}"/></td>
                                <td class="py-4 px-6 text-slate-600"><c:out value="${u.email}"/></td>
                                <td class="py-4 px-6">
                                    <span class="px-2.5 py-1 rounded-full text-xs font-bold 
                                        ${u.role == 'ADMIN' ? 'bg-purple-100 text-purple-800' : ''}
                                        ${u.role == 'ENSEIGNANT' ? 'bg-blue-100 text-blue-800' : ''}
                                        ${u.role == 'ETUDIANT' ? 'bg-emerald-100 text-emerald-800' : ''}">
                                        <c:out value="${u.role}"/>
                                    </span>
                                </td>
                                <td class="py-4 px-6 text-right space-x-2 whitespace-nowrap">
                                    <button type="button" onclick="editUser('${u.id}', '${u.prenom}', '${u.nom}', '${u.email}', '${u.role}')" class="bg-amber-500 hover:bg-amber-400 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Modifier</button>
                                    
                                    <c:if test="${u.id != sessionScope.utilisateurConnecte.id}">
                                        <form action="${pageContext.request.contextPath}/admin/utilisateurs" method="post" class="inline">
                                            <input type="hidden" name="action" value="supprimer">
                                            <input type="hidden" name="id" value="${u.id}">
                                            <button type="submit" onclick="return confirm('Voulez-vous vraiment supprimer cet utilisateur ?');" class="bg-red-600 hover:bg-red-500 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Supprimer</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        function editUser(id, prenom, nom, email, role) {
            document.getElementById('form-title').innerText = "Modifier l'utilisateur #" + id;
            document.getElementById('form-action').value = "modifier";
            document.getElementById('userId').value = id;
            document.getElementById('userPrenom').value = prenom;
            document.getElementById('userNom').value = nom;
            document.getElementById('userEmail').value = email;
            document.getElementById('userPwd').required = false;
            document.getElementById('pwd-hint').innerText = "(laisser vide pour garder l'actuel)";
            document.getElementById('userRole').value = role;
            document.getElementById('submit-btn').innerText = "Mettre à jour";
            document.getElementById('submit-btn').className = "flex-1 bg-amber-500 hover:bg-amber-400 text-white font-semibold py-2 px-4 rounded-xl text-sm transition shadow-sm";
            document.getElementById('cancel-btn').classList.remove('hidden');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function resetForm() {
            document.getElementById('form-title').innerText = "Créer un nouvel utilisateur";
            document.getElementById('form-action').value = "creer";
            document.getElementById('userId').value = "";
            document.getElementById('userPrenom').value = "";
            document.getElementById('userNom').value = "";
            document.getElementById('userEmail').value = "";
            document.getElementById('userPwd').required = true;
            document.getElementById('pwd-hint').innerText = "";
            document.getElementById('userRole').value = "ETUDIANT";
            document.getElementById('submit-btn').innerText = "Créer";
            document.getElementById('submit-btn').className = "flex-1 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold py-2 px-4 rounded-xl text-sm transition shadow-sm";
            document.getElementById('cancel-btn').classList.add('hidden');
        }
    </script>
</body>
</html>
