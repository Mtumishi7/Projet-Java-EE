import re

with open("Rapport_Technique.md", "r", encoding="utf-8") as f:
    md = f.read()

# HTML styling conversion
html = md
html = re.sub(r'^# (.*?)$', r'<h1 class="text-4xl font-extrabold text-slate-900 tracking-tight mt-8 mb-4">\1</h1>', html, flags=re.M)
html = re.sub(r'^## (.*?)$', r'<h2 class="text-2xl font-bold text-indigo-700 mt-8 mb-4 pb-2 border-b border-indigo-100 flex items-center gap-2">\1</h2>', html, flags=re.M)
html = re.sub(r'^### (.*?)$', r'<h3 class="text-xl font-semibold text-slate-800 mt-6 mb-2">\1</h3>', html, flags=re.M)
html = re.sub(r'\*\*(.*?)\*\*', r'<strong class="font-bold text-slate-900">\1</strong>', html)
html = re.sub(r'^- (.*?)$', r'<li class="ml-6 list-disc text-slate-700 my-1.5">\1</li>', html, flags=re.M)

def replace_code_block(match):
    code = match.group(1)
    code = code.replace('<', '&lt;').replace('>', '&gt;')
    return f'''<div class="my-6 rounded-2xl overflow-hidden shadow-md border border-slate-800 bg-slate-950">
        <div class="bg-slate-900 px-4 py-2 border-b border-slate-800 flex items-center justify-between">
            <span class="text-xs font-mono text-indigo-400 font-semibold">Code Source Java EE</span>
            <div class="flex space-x-1.5">
                <div class="w-3 h-3 rounded-full bg-red-500"></div>
                <div class="w-3 h-3 rounded-full bg-amber-500"></div>
                <div class="w-3 h-3 rounded-full bg-emerald-500"></div>
            </div>
        </div>
        <pre class="p-5 text-slate-100 text-xs sm:text-sm font-mono overflow-x-auto leading-relaxed"><code>{code}</code></pre>
    </div>'''

html = re.sub(r'```java\n(.*?)```', replace_code_block, html, flags=re.S)
html = re.sub(r'```jsp\n(.*?)```', replace_code_block, html, flags=re.S)
html = re.sub(r'```\n(.*?)```', replace_code_block, html, flags=re.S)

paragraphs = []
for p in html.split('\n\n'):
    p = p.strip()
    if p:
        if not p.startswith('<h') and not p.startswith('<div') and not p.startswith('<li') and not p.startswith('---'):
            p = f'<p class="text-slate-700 my-4 leading-relaxed text-base">\n{p}\n</p>'
        paragraphs.append(p)

body_html = '\n'.join(paragraphs)

full_html = f"""<!DOCTYPE html>
<html lang="fr" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rapport Technique - Gestion Stages & PFE</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @media print {{
            body {{ print-color-adjust: exact; -webkit-print-color-adjust: exact; background: white !important; }}
            .shadow-xl, .shadow-md {{ box-shadow: none !important; }}
            .page-break {{ page-break-after: always; }}
        }}
    </style>
</head>
<body class="bg-gradient-to-br from-slate-100 via-indigo-50/30 to-slate-200 min-h-screen py-12 px-4 sm:px-6 lg:px-8 font-sans">
    <main class="max-w-4xl mx-auto bg-white/90 backdrop-blur-xl p-8 sm:p-14 rounded-3xl shadow-2xl border border-slate-200/80">
        
        <!-- Header Banner -->
        <div class="text-center pb-8 border-b border-slate-200 space-y-4">
            <div class="inline-flex items-center gap-2 bg-indigo-600 text-white text-xs font-bold px-4 py-1.5 rounded-full uppercase tracking-wider shadow-sm">
                🎓 Université Polytechnique de Gitega
            </div>
            <h1 class="text-3xl sm:text-5xl font-black text-slate-900 tracking-tight">
                Rapport Technique Projet Java EE
            </h1>
            <p class="text-slate-600 font-medium text-lg">
                Application Web Multi-Tiers de Gestion des Stages & PFE
            </p>
            
            <div class="flex flex-wrap justify-center items-center gap-3 pt-4">
                <div class="bg-indigo-50 border border-indigo-200 rounded-2xl px-5 py-3 text-left">
                    <div class="text-xs font-semibold text-indigo-600 uppercase tracking-wide">Auteurs</div>
                    <div class="text-slate-900 font-bold text-sm sm:text-base">IRABARUTA Olivier Jeremie & AYIKUNDE Juste Daxa</div>
                </div>
                <div class="bg-slate-50 border border-slate-200 rounded-2xl px-5 py-3 text-left">
                    <div class="text-xs font-semibold text-slate-500 uppercase tracking-wide">Filière / Promotion</div>
                    <div class="text-slate-900 font-bold text-sm sm:text-base">Génie Logiciel / BAC3 (2025-2026)</div>
                </div>
            </div>
        </div>

        <!-- Content Body -->
        <article class="mt-8">
            {body_html}
        </article>

        <!-- Footer -->
        <footer class="mt-16 pt-8 border-t border-slate-200 text-center text-xs text-slate-400 font-medium flex flex-col sm:flex-row justify-between items-center gap-2">
            <span>Département de Génie Logiciel — Université Polytechnique de Gitega</span>
            <span class="bg-slate-100 text-slate-600 px-3 py-1 rounded-full">Architecture Multi-Tiers Jakarta EE 10</span>
        </footer>
    </main>
</body>
</html>
"""

with open("Rapport_Technique.html", "w", encoding="utf-8") as f:
    f.write(full_html)

print("Modern HTML generated successfully as Rapport_Technique.html")
