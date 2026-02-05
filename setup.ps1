# Project: PubHub Unified Publisher Stack
# Script: setup.ps1
# Version: 0.1.0
# Description: Automates Flutter, GCP V2, and Netlify environment setup with Quality Gates.

Write-Host "🚀 Starting PubHub Ignition (Windows Version)..." -ForegroundColor Cyan

# 1. Create Directory Structure
Write-Host "📂 Creating directory structure..." -ForegroundColor Gray
$dirs = @(
    "apps/flutter_app",
    "backend/functions",
    "docs",
    "assets"
)
foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }
}

# 2. Generate .env.example
Write-Host "📄 Generating .env.example..." -ForegroundColor Gray
$envExample = @"
# --- FRONTEND (Flutter) ---
FLUTTER_APP_FIREBASE_API_KEY="your-api-key"
FLUTTER_APP_FIREBASE_PROJECT_ID="your-project-id"

# --- BACKEND (GCP Functions) ---
# Set via: firebase functions:secrets:set RESEND_API_KEY
RESEND_API_KEY="re_12345"
"@
$envExample | Out-File -FilePath ".env.example" -Encoding ascii

# 3. Create Firebase Configuration Baseline
Write-Host "🔥 Setting up Firebase Baseline..." -ForegroundColor Gray
$firebaseJson = @"
{
  "functions": { "source": "backend/functions", "codebase": "default" },
  "firestore": { "rules": "firestore.rules", "indexes": "firestore.indexes.json" },
  "hosting": { "public": "apps/flutter_app/build/web", "rewrites": [{ "source": "**", "destination": "/index.html" }] }
}
"@
$firebaseJson | Out-File -FilePath "firebase.json" -Encoding ascii

# 4. Set up Baseline Security Rules (Least Privilege)
$rules = @"
rules_version = '2';
service cloud.firestore {
  match /databases/{
