<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - Gestion des Stages & PFE</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800">
    <!-- Navbar -->
    <nav class="bg-indigo-900 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <div class="flex items-center space-x-3">
                    <span class="font-bold text-xl tracking-wide">🎓 Gestion Stages & PFE</span>
                </div>
                <div class="flex items-center space-x-4">
                    <button onclick="toggleDarkMode()" class="bg-indigo-800 hover:bg-indigo-700 text-white px-3 py-2 rounded-lg text-xs font-semibold transition" title="Basculer Mode Sombre">🌙 Thème</button>
                    <div class="text-sm bg-indigo-800/80 px-3 py-1.5 rounded-lg border border-indigo-700">
                        <span class="font-medium"><c:out value="${sessionScope.utilisateurConnecte.prenom}"/> <c:out value="${sessionScope.utilisateurConnecte.nom}"/></span>
                        <span class="ml-2 text-xs uppercase tracking-wider bg-indigo-600 px-2 py-0.5 rounded text-indigo-100"><c:out value="${sessionScope.utilisateurConnecte.role}"/></span>
                    </div>
                    <a href="${pageContext.request.contextPath}/deconnexion" class="bg-red-600 hover:bg-red-500 text-white px-4 py-2 rounded-lg text-sm font-medium transition shadow">Déconnexion</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Actions Header -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8 bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
            <div>
                <h1 class="text-2xl font-bold text-slate-900">Tableau de Bord Analytique</h1>
                <p class="text-slate-500 text-sm mt-1">Suivi, pilotage et workflow des propositions de stage et PFE.</p>
            </div>
            <div class="flex flex-wrap items-center gap-3">
                <c:if test="${sessionScope.utilisateurConnecte.role == 'ETUDIANT'}">
                    <a href="${pageContext.request.contextPath}/demandes/nouvelle" class="bg-indigo-600 hover:bg-indigo-500 text-white px-5 py-2.5 rounded-xl font-medium shadow-sm transition flex items-center gap-2">
                        <span>+ Nouvelle Proposition</span>
                    </a>
                </c:if>
                <c:if test="${sessionScope.utilisateurConnecte.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="bg-purple-600 hover:bg-purple-500 text-white px-5 py-2.5 rounded-xl font-medium shadow-sm transition">
                        🛠️ Gestion Utilisateurs
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/logs" class="bg-blue-600 hover:bg-blue-500 text-white px-5 py-2.5 rounded-xl font-medium shadow-sm transition">
                        📋 Journaux d'Activités
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/export-csv" class="bg-emerald-600 hover:bg-emerald-500 text-white px-5 py-2.5 rounded-xl font-medium shadow-sm transition">
                        📥 Exporter CSV
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/entreprises" class="bg-slate-800 hover:bg-slate-700 text-white px-5 py-2.5 rounded-xl font-medium shadow-sm transition">
                    Voir Entreprises
                </a>
            </div>
        </div>

        <!-- Search & Filter Bar -->
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 p-6 mb-8">
            <form action="${pageContext.request.contextPath}/demandes" method="get" class="grid grid-cols-1 sm:grid-cols-3 gap-4 items-end">
                <div>
                    <label class="block text-xs font-semibold text-slate-600 mb-1">Rechercher un sujet ou mot-clé</label>
                    <input type="text" name="search" value="${param.search}" placeholder="Ex: Blockchain, AWS..." class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-slate-600 mb-1">Filtrer par Statut</label>
                    <select name="statutFilter" class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-sm">
                        <option value="">-- Tous les statuts --</option>
                        <option value="BROUILLON" ${param.statutFilter == 'BROUILLON' ? 'selected' : ''}>BROUILLON</option>
                        <option value="SOUMISE" ${param.statutFilter == 'SOUMISE' ? 'selected' : ''}>SOUMISE</option>
                        <option value="VALIDEE" ${param.statutFilter == 'VALIDEE' ? 'selected' : ''}>VALIDEE</option>
                        <option value="REFUSEE" ${param.statutFilter == 'REFUSEE' ? 'selected' : ''}>REFUSEE</option>
                        <option value="EN_COURS" ${param.statutFilter == 'EN_COURS' ? 'selected' : ''}>EN_COURS</option>
                        <option value="RAPPORT_DEPOSE" ${param.statutFilter == 'RAPPORT_DEPOSE' ? 'selected' : ''}>RAPPORT_DEPOSE</option>
                        <option value="SOUTENANCE_PLANIFIEE" ${param.statutFilter == 'SOUTENANCE_PLANIFIEE' ? 'selected' : ''}>SOUTENANCE_PLANIFIEE</option>
                        <option value="EVALUEE" ${param.statutFilter == 'EVALUEE' ? 'selected' : ''}>EVALUEE</option>
                        <option value="ARCHIVEE" ${param.statutFilter == 'ARCHIVEE' ? 'selected' : ''}>ARCHIVEE</option>
                    </select>
                </div>
                <div class="flex gap-2">
                    <button type="submit" class="flex-1 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold py-2 px-4 rounded-xl text-sm transition shadow-sm">Filtrer</button>
                    <a href="${pageContext.request.contextPath}/demandes" class="bg-slate-200 hover:bg-slate-300 text-slate-700 py-2 px-3 rounded-xl text-sm transition text-center">Réinitialiser</a>
                </div>
            </form>
        </div>

        <!-- Demandes Table Card -->
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="px-6 py-5 border-b border-slate-100 flex justify-between items-center">
                <h3 class="font-bold text-lg text-slate-900">Liste des Sujets</h3>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-slate-50 text-slate-600 uppercase text-xs tracking-wider border-b border-slate-200">
                            <th class="py-4 px-6 font-semibold">ID</th>
                            <th class="py-4 px-6 font-semibold">Type</th>
                            <th class="py-4 px-6 font-semibold">Sujet</th>
                            <th class="py-4 px-6 font-semibold">Description</th>
                            <th class="py-4 px-6 font-semibold">Statut</th>
                            <th class="py-4 px-6 font-semibold text-right">Actions / Workflow</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 text-sm">
                        <c:forEach var="d" items="${demandes}">
                            <tr class="hover:bg-slate-50/80 transition">
                                <td class="py-4 px-6 font-medium text-slate-500">#<c:out value="${d.id}"/></td>
                                <td class="py-4 px-6">
                                    <span class="px-2.5 py-1 rounded-full text-xs font-semibold ${d.type == 'PFE' ? 'bg-purple-100 text-purple-700' : 'bg-blue-100 text-blue-700'}">
                                        <c:out value="${d.type}"/>
                                    </span>
                                </td>
                                 <td class="py-4 px-6">
                                     <div class="font-semibold text-slate-900"><c:out value="${d.sujet}"/></div>
                                     <c:if test="${not empty d.entreprise}">
                                         <div class="text-xs text-slate-600 font-medium mt-0.5">🏢 Entreprise : <span class="text-indigo-700 font-semibold"><c:out value="${d.entreprise.nom}"/></span></div>
                                     </c:if>
                                     <c:if test="${not empty d.technologies}">
                                         <div class="text-xs text-indigo-600 font-medium mt-1">🏷️ <c:out value="${d.technologies}"/></div>
                                     </c:if>
                                 </td>
                                <td class="py-4 px-6 text-slate-600 max-w-xs truncate"><c:out value="${d.description}"/></td>
                                 <td class="py-4 px-6">
                                     <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold 
                                         ${d.statut == 'BROUILLON' ? 'bg-slate-100 text-slate-700' : ''}
                                         ${d.statut == 'SOUMISE' ? 'bg-amber-100 text-amber-800' : ''}
                                         ${d.statut == 'VALIDEE' ? 'bg-emerald-100 text-emerald-800' : ''}
                                         ${d.statut == 'REFUSEE' ? 'bg-red-100 text-red-800' : ''}
                                         ${d.statut == 'EN_COURS' ? 'bg-blue-100 text-blue-800' : ''}
                                         ${d.statut == 'RAPPORT_DEPOSE' ? 'bg-indigo-100 text-indigo-800' : ''}
                                         ${d.statut == 'SOUTENANCE_PLANIFIEE' ? 'bg-orange-100 text-orange-800' : ''}
                                         ${d.statut == 'EVALUEE' ? 'bg-teal-100 text-teal-800' : ''}
                                         ${d.statut == 'ARCHIVEE' ? 'bg-gray-800 text-gray-100' : ''}">
                                         <c:out value="${d.statut}"/>
                                     </span>
                                     <c:if test="${d.statut == 'REFUSEE' && not empty d.motifRefus}">
                                         <p class="text-xs text-red-600 mt-1 font-medium max-w-xs">Motif : <c:out value="${d.motifRefus}"/></p>
                                     </c:if>
                                 </td>
                                 <td class="py-4 px-6 text-right space-x-2 whitespace-nowrap">
                                     <a href="${pageContext.request.contextPath}/demandes/commentaires?id=${d.id}" class="bg-slate-800 hover:bg-slate-700 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition inline-block">💬 Discussion</a>

                                     <c:if test="${d.statut == 'BROUILLON' && sessionScope.utilisateurConnecte.role == 'ETUDIANT'}">
                                        <form action="${pageContext.request.contextPath}/demandes/action" method="post" class="inline">
                                            <input type="hidden" name="id" value="${d.id}">
                                            <input type="hidden" name="actionType" value="SOUMETTRE">
                                            <button type="submit" class="bg-amber-500 hover:bg-amber-400 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Soumettre</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${(d.statut == 'SOUMISE' || d.statut == 'EN_ATTENTE_VALIDATION') && (sessionScope.utilisateurConnecte.role == 'ENSEIGNANT' || sessionScope.utilisateurConnecte.role == 'ADMIN')}">
                                        <form action="${pageContext.request.contextPath}/demandes/action" method="post" class="inline">
                                            <input type="hidden" name="id" value="${d.id}">
                                            <input type="hidden" name="actionType" value="VALIDER">
                                            <button type="submit" class="bg-emerald-600 hover:bg-emerald-500 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Valider</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/demandes/action" method="post" class="inline">
                                            <input type="hidden" name="id" value="${d.id}">
                                            <input type="hidden" name="actionType" value="REFUSER">
                                            <button type="submit" class="bg-red-600 hover:bg-red-500 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Refuser</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${d.statut == 'VALIDEE'}">
                                        <form action="${pageContext.request.contextPath}/demandes/action" method="post" class="inline">
                                            <input type="hidden" name="id" value="${d.id}">
                                            <input type="hidden" name="actionType" value="DEMARRER">
                                            <button type="submit" class="bg-blue-600 hover:bg-blue-500 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Démarrer</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${d.statut == 'EN_COURS'}">
                                        <form action="${pageContext.request.contextPath}/demandes/action" method="post" class="inline">
                                            <input type="hidden" name="id" value="${d.id}">
                                            <input type="hidden" name="actionType" value="DEPOSER">
                                            <button type="submit" class="bg-indigo-600 hover:bg-indigo-500 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Déposer Rapport</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${d.statut == 'RAPPORT_DEPOSE'}">
                                        <form action="${pageContext.request.contextPath}/demandes/action" method="post" class="inline">
                                            <input type="hidden" name="id" value="${d.id}">
                                            <input type="hidden" name="actionType" value="PLANIFIER">
                                            <button type="submit" class="bg-orange-500 hover:bg-orange-400 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Planifier</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${d.statut == 'SOUTENANCE_PLANIFIEE'}">
                                        <form action="${pageContext.request.contextPath}/demandes/action" method="post" class="inline">
                                            <input type="hidden" name="id" value="${d.id}">
                                            <input type="hidden" name="actionType" value="EVALUER">
                                            <button type="submit" class="bg-teal-600 hover:bg-teal-500 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Évaluer</button>
                                        </form>
                                    </c:if>

                                     <c:if test="${d.statut == 'EVALUEE'}">
                                         <form action="${pageContext.request.contextPath}/demandes/action" method="post" class="inline">
                                             <input type="hidden" name="id" value="${d.id}">
                                             <input type="hidden" name="actionType" value="ARCHIVER">
                                             <button type="submit" class="bg-slate-700 hover:bg-slate-600 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition">Archiver</button>
                                         </form>
                                     </c:if>

                                     <c:if test="${d.statut != 'BROUILLON' && d.statut != 'SOUMISE' && d.statut != 'REFUSEE' && d.statut != 'EN_ATTENTE_VALIDATION'}">
                                         <a href="${pageContext.request.contextPath}/demandes/attestation?id=${d.id}" target="_blank" class="bg-indigo-700 hover:bg-indigo-600 text-white px-3 py-1.5 rounded-lg text-xs font-semibold shadow transition inline-block">📄 Attestation</a>
                                     </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty demandes}">
                            <tr>
                                <td colspan="6" class="py-8 text-center text-slate-400 italic">Aucune demande enregistrée.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
    <script>
        function toggleDarkMode() {
            document.body.classList.toggle('bg-slate-900');
            document.body.classList.toggle('text-slate-100');
            const cards = document.querySelectorAll('.bg-white');
            cards.forEach(c => {
                c.classList.toggle('bg-slate-800');
                c.classList.toggle('text-slate-100');
                c.classList.toggle('border-slate-700');
            });
        }
    </script>
</body>
</html>
