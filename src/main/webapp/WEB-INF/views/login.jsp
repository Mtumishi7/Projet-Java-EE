<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Gestion des Stages & PFE</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-indigo-900 via-slate-900 to-gray-900 min-h-screen flex items-center justify-center p-4">
    <div class="max-w-md w-full bg-white/10 backdrop-blur-md rounded-2xl shadow-2xl p-8 border border-white/20">
        <div class="text-center mb-8">
            <h1 class="text-3xl font-extrabold text-white tracking-tight">Portail Stages & PFE</h1>
            <p class="text-indigo-200 text-sm mt-2">Université Polytechnique de Gitega</p>
        </div>

        <c:if test="${not empty erreur}">
            <div class="bg-red-500/20 border border-red-500 text-red-200 px-4 py-3 rounded-xl mb-6 text-sm text-center">
                <c:out value="${erreur}"/>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/connexion" method="post" class="space-y-6">
            <div>
                <label for="email" class="block text-sm font-medium text-indigo-100 mb-2">Adresse Email</label>
                <input type="email" id="email" name="email" required 
                       class="w-full px-4 py-3 bg-white/5 border border-white/20 rounded-xl text-white placeholder-indigo-300/50 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition">
            </div>
            <div>
                <label for="motDePasse" class="block text-sm font-medium text-indigo-100 mb-2">Mot de passe</label>
                <input type="password" id="motDePasse" name="motDePasse" required 
                       class="w-full px-4 py-3 bg-white/5 border border-white/20 rounded-xl text-white placeholder-indigo-300/50 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition">
            </div>
            <button type="submit" 
                    class="w-full py-3 px-4 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold rounded-xl shadow-lg hover:shadow-indigo-500/50 transition duration-200">
                Se connecter
            </button>
        </form>
    </div>
</body>
</html>
