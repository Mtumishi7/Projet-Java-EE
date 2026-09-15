<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Attestation Officielle - Gestion Stages & PFE</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @media print {
            body { background: white !important; print-color-adjust: exact; }
            .no-print { display: none !important; }
            .certificate-card { box-shadow: none !important; border: none !important; margin: 0 !important; width: 100% !important; max-width: none !important; }
        }
    </style>
</head>
<body class="bg-slate-100 min-h-screen py-10 px-4 flex flex-col items-center">
    
    <!-- Action Bar (No Print) -->
    <div class="no-print mb-6 flex gap-4">
        <button onclick="window.print()" class="bg-indigo-600 hover:bg-indigo-500 text-white font-semibold px-6 py-2.5 rounded-xl shadow transition flex items-center gap-2">
            🖨️ Télécharger / Imprimer en PDF
        </button>
        <a href="${pageContext.request.contextPath}/demandes" class="bg-slate-700 hover:bg-slate-600 text-white font-semibold px-6 py-2.5 rounded-xl shadow transition">
            ← Retour au Tableau de Bord
        </a>
    </div>

    <!-- Official Certificate Card -->
    <div class="certificate-card max-w-3xl w-full bg-white border-8 border-double border-indigo-900 rounded-2xl shadow-2xl p-12 text-slate-800 relative overflow-hidden">
        
        <!-- Header University -->
        <div class="text-center border-b-2 border-slate-200 pb-6 mb-8">
            <h2 class="text-sm font-bold uppercase tracking-widest text-indigo-800">République du Burundi</h2>
            <h3 class="text-xs uppercase tracking-wider text-slate-500 mb-2">Ministère de l'Enseignement Supérieur et de la Recherche Scientifique</h3>
            <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">UNIVERSITÉ POLYTECHNIQUE DE GITEGA</h1>
            <p class="text-xs text-slate-500 mt-1">Faculté des Sciences et Technologies — Département de Génie Logiciel</p>
        </div>

        <!-- Certificate Title -->
        <div class="text-center my-8">
            <h2 class="text-2xl font-black text-indigo-900 uppercase tracking-wide">Attestation de Validation de Sujet</h2>
            <div class="w-24 h-1 bg-indigo-600 mx-auto mt-2 rounded"></div>
        </div>

        <!-- Certificate Body -->
        <div class="text-justify text-base leading-relaxed space-y-6 text-slate-700">
            <p>
                Le soussigné, Coordinateur des Stages et Projets de Fin d'Études de l'Université Polytechnique de Gitega, certifie par la présente que l'étudiant(e) :
            </p>

            <div class="bg-slate-50 border border-slate-200 p-4 rounded-xl text-center font-bold text-slate-900 text-lg">
                <c:out value="${demande.etudiantEntity.utilisateur.prenom}"/> <c:out value="${demande.etudiantEntity.utilisateur.nom}"/> 
                <span class="block text-sm font-normal text-indigo-700 mt-1">Matricule : <c:out value="${demande.etudiantEntity.matricule}"/> — Filière : <c:out value="${demande.etudiantEntity.filiere}"/></span>
            </div>

            <p>
                A soumis et fait valider avec succès son sujet de <strong class="text-indigo-900"><c:out value="${demande.type}"/></strong> intitulé :
            </p>

            <div class="bg-indigo-50/50 border-l-4 border-indigo-600 p-4 italic text-indigo-950 font-semibold">
                « <c:out value="${demande.sujet}"/> »
            </div>

            <p>
                Au sein de l'entreprise partenaire <strong class="text-slate-900"><c:out value="${demande.entreprise.nom}"/></strong> située à <c:out value="${demande.entreprise.adresse}"/>.
            </p>

            <p class="text-sm text-slate-600 pt-2">
                Statut actuel du dossier dans le système académique : <strong class="text-emerald-700 uppercase"><c:out value="${demande.statut}"/></strong>.
            </p>
        </div>

        <!-- Footer Signatures -->
        <div class="mt-16 flex justify-between items-end pt-8 border-t-2 border-slate-200 text-sm">
            <div>
                <p class="text-slate-500">Fait à Gitega, le <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %></p>
            </div>
            <div class="text-center">
                <p class="font-bold text-slate-900">Le Coordinateur des Stages</p>
                <div class="h-16"></div> <!-- Space for signature -->
                <p class="text-xs text-slate-500">(Cachet et Signature)</p>
            </div>
        </div>

    </div>

</body>
</html>
