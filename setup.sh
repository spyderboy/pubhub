#!/bin/bash

# Project: PubHub Unified Publisher Stack
# Script: setup.sh
# Version: 0.1.0
# Description: Automates Flutter, GCP V2, and Netlify environment setup with Quality Gates.

# Colors for output
CYAN='\033[0;36m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

echo -e "${CYAN}🚀 Starting PubHub Ignition (Unix Version)...${NC}"

# 1. Create Directory Structure
echo -e "${GRAY}📂 Creating directory structure...${NC}"
mkdir -p apps/flutter_app backend/functions docs assets

# 2. Generate .env.example
echo -e "${GRAY}📄 Generating .env.example...${NC}"
cat <<EOF > .env.example
# --- FRONTEND (Flutter) ---
FLUTTER_APP_FIREBASE_API_KEY="your-api-key"
FLUTTER_APP_FIREBASE_PROJECT_ID="your-project-id"

# --- BACKEND (GCP Functions) ---
# Set via: firebase functions:secrets:set RESEND_API_KEY
RESEND_API_KEY="re_12345"
EOF

# 3. Create Firebase Configuration Baseline
echo -e "${GRAY}🔥 Setting up Firebase Baseline...${NC}"
cat <<EOF > firebase.json
{
  "functions": { "source": "backend/functions", "codebase": "default" },
  "firestore": { "rules": "firestore.rules", "indexes": "firestore.indexes.json" },
  "hosting": { "public": "apps/flutter_app/build/web", "rewrites": [{ "source": "**", "destination": "/index.html" }] }
}
EOF

# 4. Set up Baseline Security Rules (Least Privilege)
echo -e "${GRAY}🛡️ Setting up security rules...${NC}"
cat <<EOF > firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} { allow read: if true; allow write: if request.auth != null; }
  }
}
EOF
echo "[]" > firestore.indexes.json

# 5. Initialize Git and Quality Gates (The Hooks)
if [ ! -d ".git" ]; then
    echo -e "${GRAY}🔧 Initializing Git repository...${NC}"
    git init
fi

echo -e "${GRAY}🪝 Installing Git Hooks (Quality Gates)...${NC}"
cat <<EOF > .git/hooks/pre-commit
#!/bin/sh
# Baseline Quality Gate
echo "Checking code quality before commit..."

# Flutter Check
if [ -d "apps/flutter_app/lib" ]; then
    cd apps/flutter_app
    flutter format --set-exit-if-changed . || { echo '❌ Flutter format failed'; exit 1; }
    flutter analyze || { echo '❌ Flutter analyze failed'; exit 1; }
    cd ../..
fi

# Backend Check
if [ -d "backend/functions/node_modules" ]; then
    cd backend/functions
    npm run lint || { echo '❌ Backend lint failed'; exit 1; }
    cd ../..
fi

echo "✅ Quality gates passed!"
EOF

# Ensure the hook is executable
chmod +x .git/hooks/pre-commit

# 6. Final Instructions
echo -e "\n${GREEN}✅ Ignition Complete!${NC}"
echo "---------------------------------------------------"
echo "Next Steps for Jose Antonio Licon:"
echo "1. Run 'cd apps/flutter_app
