<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Discussion & Commentaires - Sujet #${demande.id}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800">
    <!-- Navbar -->
    <nav class="bg-indigo-900 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <span class="font-bold text-xl tracking-wide">💬 Fil de Discussion du Sujet</span>
                <a href="${pageContext.request.contextPath}/demandes" class="bg-indigo-800 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition">Retour aux Demandes</a>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-6">
        
        <!-- Subject Card -->
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 p-6">
            <div class="flex justify-between items-start mb-2">
                <h2 class="text-xl font-bold text-slate-900"><c:out value="${demande.sujet}"/></h2>
                <span class="px-3 py-1 rounded-full text-xs font-bold bg-indigo-100 text-indigo-800"><c:out value="${demande.type}"/></span>
            </div>
            <p class="text-slate-600 text-sm"><c:out value="${demande.description}"/></p>
        </div>

        <!-- Comments Thread -->
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 p-6 space-y-6">
            <h3 class="font-bold text-lg text-slate-900 border-b border-slate-100 pb-4">Échanges et Remarques</h3>

            <div class="space-y-4">
                <c:forEach var="c" items="${commentaires}">
                    <div class="p-4 rounded-xl border ${c.auteurEmail == sessionScope.utilisateurConnecte.email ? 'bg-indigo-50/50 border-indigo-100 ml-6' : 'bg-slate-50 border-slate-200 mr-6'}">
                        <div class="flex justify-between items-center mb-1">
                            <span class="font-bold text-xs text-indigo-900"><c:out value="${c.auteurEmail}"/></span>
                            <span class="text-xs text-slate-400"><fmt:formatDate value="${c.dateCreation}" pattern="dd/MM/yyyy HH:mm"/></span>
                        </div>
                        <p class="text-sm text-slate-700 mt-1"><c:out value="${c.message}"/></p>
                    </div>
                </c:forEach>
                <c:if test="${empty commentaires}">
                    <p class="text-center text-slate-400 italic py-6">Aucun commentaire pour le moment. Commencez la discussion ci-dessous.</p>
                </c:if>
            </div>

            <!-- Add Comment Form -->
            <form action="${pageContext.request.contextPath}/demandes/commentaires" method="post" class="mt-6 pt-4 border-t border-slate-100 space-y-4">
                <input type="hidden" name="demandeId" value="${demande.id}">
                <div>
                    <label class="block text-xs font-semibold text-slate-600 mb-2">Ajouter un commentaire / feedback</label>
                    <textarea name="message" required rows="3" class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Écrivez votre message ici..."></textarea>
                </div>
                <div class="flex justify-end">
                    <button type="submit" class="bg-indigo-600 hover:bg-indigo-500 text-white font-semibold py-2.5 px-6 rounded-xl text-sm transition shadow-sm">Envoyer le message</button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>
