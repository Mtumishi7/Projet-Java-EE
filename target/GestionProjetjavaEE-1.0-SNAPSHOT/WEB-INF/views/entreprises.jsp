<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Entreprises Partenaires - Gestion des Stages & PFE</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800">
    <!-- Navbar -->
    <nav class="bg-indigo-900 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <span class="font-bold text-xl tracking-wide">🎓 Gestion Stages & PFE</span>
                <a href="${pageContext.request.contextPath}/demandes" class="bg-indigo-800 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition">Retour aux Demandes</a>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8 bg-white p-6 rounded-2xl shadow-sm border border-slate-200">
            <div>
                <h1 class="text-2xl font-bold text-slate-900">Entreprises Partenaires</h1>
                <p class="text-slate-500 text-sm mt-1">Répertoire officiel des structures d'accueil.</p>
            </div>
            <!-- Règle métier : Seul l'Admin peut ajouter une entreprise -->
            <c:if test="${sessionScope.utilisateurConnecte.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/entreprises/nouvelle" class="bg-indigo-600 hover:bg-indigo-500 text-white px-5 py-2.5 rounded-xl font-medium shadow-sm transition">
                    + Ajouter une Entreprise
                </a>
            </c:if>
        </div>

        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-slate-50 text-slate-600 uppercase text-xs tracking-wider border-b border-slate-200">
                            <th class="py-4 px-6 font-semibold">ID</th>
                            <th class="py-4 px-6 font-semibold">Nom</th>
                            <th class="py-4 px-6 font-semibold">Adresse</th>
                            <th class="py-4 px-6 font-semibold">Email Contact</th>
                            <th class="py-4 px-6 font-semibold">Téléphone</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 text-sm">
                        <c:forEach var="e" items="${entreprises}">
                            <tr class="hover:bg-slate-50/80 transition">
                                <td class="py-4 px-6 font-medium text-slate-500">#<c:out value="${e.id}"/></td>
                                <td class="py-4 px-6 font-semibold text-slate-900"><c:out value="${e.nom}"/></td>
                                <td class="py-4 px-6 text-slate-600"><c:out value="${e.adresse}"/></td>
                                <td class="py-4 px-6 text-slate-600"><c:out value="${e.emailContact}"/></td>
                                <td class="py-4 px-6 text-slate-600"><c:out value="${e.telephone}"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty entreprises}">
                            <tr>
                                <td colspan="5" class="py-8 text-center text-slate-400 italic">Aucune entreprise enregistrée.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>
