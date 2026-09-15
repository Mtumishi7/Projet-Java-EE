<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Demande - Gestion des Stages & PFE</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen flex items-center justify-center p-4">
    <div class="max-w-xl w-full bg-white rounded-2xl shadow-sm border border-slate-200 p-8">
        <h2 class="text-2xl font-bold text-slate-900 mb-6">Soumettre une proposition de Stage / PFE</h2>

        <form action="${pageContext.request.contextPath}/demandes/nouvelle" method="post" class="space-y-6">
            <div>
                <label for="type" class="block text-sm font-semibold text-slate-700 mb-2">Type de projet</label>
                <select id="type" name="type" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                    <option value="STAGE">Stage Académique</option>
                    <option value="PFE">Projet de Fin d'Études (PFE)</option>
                </select>
            </div>

            <div>
                <label for="entrepriseId" class="block text-sm font-semibold text-slate-700 mb-2">Entreprise d'accueil</label>
                <select id="entrepriseId" name="entrepriseId" required class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                    <option value="">-- Sélectionnez une entreprise --</option>
                    <c:forEach var="ent" items="${entreprises}">
                        <option value="${ent.id}"><c:out value="${ent.nom}"/> (<c:out value="${ent.ville}"/>)</option>
                    </c:forEach>
                </select>
                <p class="text-xs text-slate-500 mt-1">Vous ne trouvez pas votre entreprise ? <a href="${pageContext.request.contextPath}/entreprises" target="_blank" class="text-indigo-600 underline">Voir ou ajouter une entreprise</a></p>
            </div>

            <div>
                <label for="sujet" class="block text-sm font-semibold text-slate-700 mb-2">Intitulé du Sujet</label>
                <input type="text" id="sujet" name="sujet" required class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Ex: Plateforme IoT de gestion...">
            </div>

            <div>
                <label for="technologies" class="block text-sm font-semibold text-slate-700 mb-2">Technologies / Compétences clés</label>
                <input type="text" id="technologies" name="technologies" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Ex: Java EE, Angular, PostgreSQL, Docker">
            </div>

            <div>
                <label for="description" class="block text-sm font-semibold text-slate-700 mb-2">Description détaillée</label>
                <textarea id="description" name="description" required rows="4" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Décrivez les objectifs et technologies..."></textarea>
            </div>

            <div class="flex items-center space-x-4 pt-4">
                <button type="submit" class="flex-1 py-3 px-6 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold rounded-xl shadow-sm transition">
                    Enregistrer en Brouillon
                </button>
                <a href="${pageContext.request.contextPath}/demandes" class="py-3 px-6 bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold rounded-xl transition text-center">
                    Retour
                </a>
            </div>
        </form>
    </div>
</body>
</html>
