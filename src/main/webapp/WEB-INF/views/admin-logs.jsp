<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Journaux d'Activités - Administration</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800">
    <!-- Navbar -->
    <nav class="bg-indigo-900 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <span class="font-bold text-xl tracking-wide">📋 Journaux d'Activités & Audit Système</span>
                <div class="flex items-center space-x-3">
                    <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="bg-indigo-800 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition">Gérer Utilisateurs</a>
                    <a href="${pageContext.request.contextPath}/demandes" class="bg-slate-800 hover:bg-slate-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition">Retour aux Demandes</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-8">
        
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="px-6 py-5 border-b border-slate-100 flex justify-between items-center">
                <h3 class="font-bold text-lg text-slate-900">Historique global des actions (Audit Trail)</h3>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-slate-50 text-slate-600 uppercase text-xs tracking-wider border-b border-slate-200">
                            <th class="py-4 px-6 font-semibold">ID</th>
                            <th class="py-4 px-6 font-semibold">Date & Heure</th>
                            <th class="py-4 px-6 font-semibold">Utilisateur / Email</th>
                            <th class="py-4 px-6 font-semibold">Action</th>
                            <th class="py-4 px-6 font-semibold">Détails</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 text-sm">
                        <c:forEach var="log" items="${logs}">
                            <tr class="hover:bg-slate-50/80 transition">
                                <td class="py-4 px-6 font-medium text-slate-500">#<c:out value="${log.id}"/></td>
                                <td class="py-4 px-6 text-slate-600"><fmt:formatDate value="${log.dateAction}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                <td class="py-4 px-6 font-semibold text-indigo-900"><c:out value="${log.utilisateurEmail}"/></td>
                                <td class="py-4 px-6">
                                    <span class="px-2.5 py-1 rounded-full text-xs font-bold bg-indigo-100 text-indigo-800">
                                        <c:out value="${log.action}"/>
                                    </span>
                                </td>
                                <td class="py-4 px-6 text-slate-600"><c:out value="${log.details}"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty logs}">
                            <tr>
                                <td colspan="5" class="py-8 text-center text-slate-400 italic">Aucun journal d'activité enregistré.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>
