# Project: PubHub Unified Publisher Stack
# Script: setup.ps1
# Version: 0.5.0
# Description: Automates Flutter, GCP V2, SEO Full-Stack, Analytics, and Aider Protocols for Windows.

Write-Host "🚀 Starting PubHub Ignition v0.5.0 (Fully Reconciled Windows)..." -ForegroundColor Cyan

# 1. Create Directory Structure
Write-Host "📂 Creating directory structure..." -ForegroundColor Gray
$dirs = @(
    "apps/flutter_app",
    "backend/functions/dist",
    "docs",
    "assets"
)
foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }
}

# 2. Initialize Flutter (if not exists)
if (!(Test-Path "apps/flutter_app/web")) {
    Write-Host "📦 Initializing Flutter Web app..." -ForegroundColor Gray
    Set-Location "apps/flutter_app"
    flutter create . --platforms web,android,ios
    Set-Location "../../"
}

# 3. SEO Surgery: Template index.html (The Digital Jacket)
$indexPath = "apps/flutter_app/web/index.html"
if (Test-Path $indexPath) {
    Write-Host "🧬 Performing Full SEO Surgery on index.html..." -ForegroundColor Gray
    $content = Get-Content $indexPath -Raw
    
    # Placeholder block for 2026 Social Standards
    $seoMeta = @"
<title>{{TITLE}}</title>
    <link rel="canonical" href="{{CANONICAL_URL}}">
    <meta name="description" content="{{DESC}}">
    <meta property="og:type" content="article">
    <meta property="og:title" content="{{TITLE}}">
    <meta property="og:description" content="{{DESC}}">
    <meta property="og:image" content="{{IMAGE_URL}}">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="{{TITLE}}">
    <meta name="twitter:description" content="{{DESC}}">
    <meta name="twitter:image" content="{{IMAGE_URL}}">
"@
    # Replace static title with dynamic SEO block
    $content = $content -replace '<title>.*</title>', $seoMeta
    Set-Content -Path $indexPath -Value $content -Encoding UTF8
}

# 4. Generate Files (Environment & Scaffolding)
Write-Host "📄 Generating .env.example..." -ForegroundColor Gray
$envExample = @"
# --- FRONTEND (Flutter) ---
FLUTTER_APP_FIREBASE_API_KEY="your-api-key"
FLUTTER_APP_FIREBASE_PROJECT_ID="your-project-id"
GA_MEASUREMENT_ID="G-XXXXXXXXXX"

# --- BACKEND (GCP Functions) ---
# Set via: firebase functions:secrets:set RESEND_API_KEY
RESEND_API_KEY="re_12345"
GA_API_SECRET="your-ga4-secret"
"@
$envExample | Out-File -FilePath ".env.example" -Encoding ascii

Write-Host "🔥 Setting up Firebase Baseline with SEO Routing..." -ForegroundColor Gray
$firebaseJson = @"
{
  "functions": { "source": "backend/functions", "codebase": "default" },
  "firestore": { "rules": "firestore.rules", "indexes": "firestore.indexes.json" },
  "hosting": { 
    "public": "apps/flutter_app/build/web", 
    "rewrites": [
      { "source": "/posts/**", "function": "seoMiddleware" },
      { "source": "**", "destination": "/index.html" }
    ] 
  }
}
"@
$firebaseJson | Out-File -FilePath "firebase.json" -Encoding ascii

# 5. Generate SEO Middleware Logic
Write-Host "🧩 Building SEO Middleware Microservice..." -ForegroundColor Gray
$middlewareContent = @"
const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

exports.handleSEO = async (req, res) => {
    const fullPath = req.path;
    const protocol = req.protocol;
    const host = req.get('host');
    const canonicalUrl = \`\${protocol}://\${host}\${fullPath}\`;

    let indexTemplate;
    try {
        indexTemplate = fs.readFileSync(path.join(__dirname, './dist/index.html'), 'utf-8');
    } catch (e) {
        return res.status(500).send('Build artifact index.html not found. Deploy Flutter app first.');
    }

    let meta = { title: 'PubHub', desc: 'Built with Unified Publisher Stack', image: '' };

    if (fullPath.startsWith('/posts/')) {
        const id = fullPath.split('/').pop();
        const doc = await admin.firestore().collection('articles').doc(id).get();
        if (doc.exists) {
            const data = doc.data();
            meta.title = data.title || meta.title;
            meta.desc = data.summary || meta.desc;
            meta.image = data.coverImage || meta.image;
        }
    }

    const hydratedHtml = indexTemplate
        .replace(/{{TITLE}}/g, meta.title)
        .replace(/{{DESC}}/g, meta.desc)
        .replace(/{{IMAGE_URL}}/g, meta.image)
        .replace(/{{CANONICAL_URL}}/g, canonicalUrl);

    res.status(200).send(hydratedHtml);
};
"@
$middlewareContent | Out-File -FilePath "backend/functions/seo_middleware.js" -Encoding UTF8

# 6. Generate Aider Instructions
Write-Host "🤖 Writing AI Instruction Protocol..." -ForegroundColor Gray
$aiderDocs = @"
# Aider Instructions: Unified Publisher Stack

## 🔍 SEO & Metadata Protocol
1. **Frontend:** web/index.html uses {{TITLE}}, {{DESC}}, {{IMAGE_URL}}, {{CANONICAL_URL}} placeholders.
2. **Backend:** Update backend/functions/seo_middleware.js for all dynamic routes.
3. **Twitter:** Ensure IMAGE_URL is high-res for summary_large_image cards.

## 📊 Analytics Protocol
1. **Naming:** Use snake_case (e.g., article_engagement, newsletter_signup).
2. **Implementation:** Use firebase_analytics for UI; GA4 Measurement Protocol for Backend events.

## 🛠️ Architecture
- Flutter (WASM) for Frontend.
- GCP V2 (Node.js) for Backend.
- Resend for Emails.
"@
$aiderDocs | Out-File -FilePath "docs/aider_instructions.md" -Encoding UTF8

# 7. Security Rules & Git Hooks
Write-Host "🛡️ Setting up security rules..." -ForegroundColor Gray
$rules = @"
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} { allow read: if true; allow write: if request.auth != null; }
  }
}
"@
$rules | Out-File -FilePath "firestore.rules" -Encoding ascii
"[]" | Out-File -FilePath "firestore.indexes.json" -Encoding ascii

if (!(Test-Path ".git")) {
    Write-Host "🔧 Initializing Git..." -ForegroundColor Gray
    git init
}

$hookContent = @"
#!/bin/sh
echo "Checking code quality..."
if [ -d "apps/flutter_app/lib" ]; then
    cd apps/flutter_app
    flutter format --set-exit-if-changed . || { echo '❌ Format failed'; exit 1; }
    flutter analyze || { echo '❌ Analyze failed'; exit 1; }
    cd ../..
fi
echo "✅ Quality gates passed!"
"@
$hookContent | Out-File -FilePath ".git/hooks/pre-commit" -Encoding ascii

Write-Host "`n✅ Ignition Complete!" -ForegroundColor Green
Write-Host "---------------------------------------------------"
Write-Host "Next Steps for Jose Antonio Licon:"
Write-Host "1. Run 'cd apps/flutter_app' and get coding."
Write-Host "2. Use Aider to expand your SEO Middleware Case logic."
Write-Host "3. Update .env with your GA4 Measurement ID."
