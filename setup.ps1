# setup.ps1 - Windows Bootstrapper
Write-Host "🛠️ Initializing Publisher Stack for Windows..." -ForegroundColor Cyan

# 1. Flutter Setup
if (Get-Command flutter -ErrorAction SilentlyContinue) {
    flutter create --platforms=web,android,ios apps/flutter_app
    Set-Location apps/flutter_app
    flutter pub add firebase_core firebase_auth cloud_firestore seo provider
    
    # Inject SelectionArea for 100% Selectable Text
    $mainFile = "lib/main.dart"
    if (Test-Path $mainFile) {
        (Get-Content $mainFile) -replace 'Widget build\(BuildContext context\) \{', 'Widget build(BuildContext context) { return SelectionArea(child: ' | Set-Content $mainFile
        Write-Host "✅ Flutter boilerplate updated with SelectionArea." -ForegroundColor Green
    }
} else {
    Write-Error "Flutter not found. Please ensure Flutter is in your PATH."
    exit
}

# 2. GCP Functions V2 Setup
Set-Location ../../
New-Item -ItemType Directory -Path "backend/functions" -Force | Out-Null
Set-Location "backend/functions"

if (Get-Command npm -ErrorAction SilentlyContinue) {
    npm init -y
    npm install firebase-functions@v2 firebase-admin resend
} else {
    Write-Error "NPM not found. Please install Node.js."
}

# 3. Create Aider Instructions
Set-Location ../../
New-Item -ItemType Directory -Path "docs" -Force | Out-Null
$instructions = @"
# Project Goals
- Framework: Flutter Web (WASM) & Mobile.
- Backend: GCP Functions V2.
- Requirements: 100% Accessibility, SEO, Selectable Text, Resend Integration.
- Test Coverage Target: 100%.
- Admin: Implementation of a secure /admin route for CRUD.
"@
$instructions | Out-File -FilePath "docs/aider_instructions.md" -Encoding utf8

Write-Host "🚀 Setup Complete!" -ForegroundColor Cyan
Write-Host "Next Step: Open this folder in VS Code and run 'aider --msg-file docs/aider_instructions.md'" -ForegroundColor Yellow
