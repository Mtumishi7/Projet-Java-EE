<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter Entreprise - Gestion des Stages & PFE</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen flex items-center justify-center p-4">
    <div class="max-w-xl w-full bg-white rounded-2xl shadow-sm border border-slate-200 p-8">
        <h2 class="text-2xl font-bold text-slate-900 mb-6">Ajouter une Entreprise Partenaire</h2>

        <form action="${pageContext.request.contextPath}/entreprises/nouvelle" method="post" class="space-y-6">
            <div>
                <label for="nom" class="block text-sm font-semibold text-slate-700 mb-2">Nom de l'entreprise</label>
                <input type="text" id="nom" name="nom" required class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Ex: EcoBank Burundi">
            </div>

            <div>
                <label for="adresse" class="block text-sm font-semibold text-slate-700 mb-2">Adresse</label>
                <input type="text" id="adresse" name="adresse" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Ex: Bujumbura, Boulevard Mwambutsa">
            </div>

            <div>
                <label for="emailContact" class="block text-sm font-semibold text-slate-700 mb-2">Email de contact</label>
                <input type="email" id="emailContact" name="emailContact" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="contact@entreprise.bi">
            </div>

            <div>
                <label for="telephone" class="block text-sm font-semibold text-slate-700 mb-2">Téléphone</label>
                <input type="tel" id="telephone" name="telephone" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="+257...">
            </div>

            <div class="flex items-center space-x-4 pt-4">
                <button type="submit" class="flex-1 py-3 px-6 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold rounded-xl shadow-sm transition">
                    Enregistrer l'entreprise
                </button>
                <a href="${pageContext.request.contextPath}/entreprises" class="py-3 px-6 bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold rounded-xl transition text-center">
                    Retour
                </a>
            </div>
        </form>
    </div>
</body>
</html>
