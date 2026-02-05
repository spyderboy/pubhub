#!/bin/bash

# Project: PubHub Unified Publisher Stack
# Script: setup.sh
# Version: 0.5.0
# Description: Automates Flutter, GCP V2, SEO Full-Stack, Analytics, and Aider Protocols.

# Colors for output
CYAN='\033[0;36m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

echo -e "${CYAN}🚀 Starting PubHub Ignition (Fully Reconciled)...${NC}"

# 1. Create Directory Structure
echo -e "${GRAY}📂 Creating directory structure...${NC}"
mkdir -p apps/flutter_app backend/functions/dist docs assets

# 2. Initialize Flutter (if not exists)
if [ ! -d "apps/flutter_app/web" ]; then
    echo -e "${GRAY}📦 Initializing Flutter Web app...${NC}"
    cd apps/flutter_app && flutter create . --platforms web,android,ios && cd ../..
fi

# 3. SEO Surgery: Template index.html (The Digital Jacket)
INDEX_PATH="apps/flutter_app/web/index.html"
if [ -f "$INDEX_PATH" ]; then
    echo -e "${GRAY}🧬 Injecting Full SEO Suite (OG, Twitter, Canonical) into index.html...${NC}"
    # This sed command injects the full set of 2026-standard meta tags
    sed -i '' 's|<title>.*</title>|<title>{{TITLE}}</title>\n    <link rel="canonical" href="{{CANONICAL_URL}}">\n    <meta name="description" content="{{DESC}}">\n    <meta property="og:type" content="article">\n    <meta property="og:title" content="{{TITLE}}">\n    <meta property="og:description" content="{{DESC}}">\n    <meta property="og:image" content="{{IMAGE_URL}}">\n    <meta name="twitter:card" content="summary_large_image">\n    <meta name="twitter:title" content="{{TITLE}}">\n    <meta name="twitter:description" content="{{DESC}}">\n    <meta name="twitter:image" content="{{IMAGE_URL}}">|' "$INDEX_PATH"
fi

# 4. Generate Files (Environment & Scaffolding)
echo -e "${GRAY}📄 Generating .env.example...${NC}"
cat <<EOF > .env.example
# --- FRONTEND (Flutter) ---
FLUTTER_APP_FIREBASE_API_KEY="your-api-key"
FLUTTER_APP_FIREBASE_PROJECT_ID="your-project-id"
GA_MEASUREMENT_ID="G-XXXXXXXXXX"

# --- BACKEND (GCP Functions) ---
# Set via: firebase functions:secrets:set RESEND_API_KEY
RESEND_API_KEY="re_12345"
GA_API_SECRET="your-ga4-secret"
EOF

echo -e "${GRAY}🔥 Setting up Firebase Baseline with SEO Routing...${NC}"
cat <<EOF > firebase.json
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
EOF

# 5. Generate SEO Middleware Logic
echo -e "${GRAY}🧩 Building SEO Middleware Microservice...${NC}"
cat <<EOF > backend/functions/seo_middleware.js
const admin = require("firebase-admin");
const fs = require("fs");
const path = require("path");

exports.handleSEO = async (req, res) => {
    const fullPath = req.path;
    const protocol = req.protocol;
    const host = req.get('host');
    const canonicalUrl = \`\${protocol}://\${host}\${fullPath}\`;

    let indexTemplate;
    try {
        indexTemplate = fs.readFileSync(path.join(__dirname, './dist/index.html'), 'utf-8');
    } catch (e) {
        return res.status(500).send("Build artifact index.html not found. Deploy Flutter app first.");
    }

    let meta = { title: "PubHub", desc: "Built with Unified Publisher Stack", image: "" };

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
EOF

# 6. Generate Aider Instructions (The AI Protocol)
echo -e "${GRAY}🤖 Writing AI Instruction Protocol...${NC}"
cat <<EOF > docs/aider_instructions.md
# Aider Instructions: Unified Publisher Stack

## 🔍 SEO & Metadata Protocol
1. **Frontend:** web/index.html uses {{TITLE}}, {{DESC}}, {{IMAGE_URL}}, {{CANONICAL_URL}} placeholders.
2. **Backend:** Update backend/functions/seo_middleware.js for all dynamic routes.
3. **Twitter:** Ensure IMAGE_URL is high-resolution for summary_large_image cards.

## 📊 Analytics Protocol
1. **Naming:** Use snake_case (e.g., article_engagement, newsletter_signup).
2. **Frontend:** Use firebase_analytics for UI tracking.
3. **Backend:** Use GA4 Measurement Protocol in GCP Functions for server-side events.

## 🛠️ Architecture
- Flutter (WASM) for Frontend.
- GCP V2 (Node.js) for Backend.
- Resend for Emails.
EOF

# 7. Security Rules & Git Hooks
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

if [ ! -d ".git" ]; then
    echo -e "${GRAY}🔧 Initializing Git repository...${NC}"
    git init
fi

echo -e "${GRAY}🪝 Installing Git Hooks (Quality Gates)...${NC}"
cat <<EOF > .git/hooks/pre-commit
#!/bin/sh
echo "Checking code quality before commit..."
if [ -d "apps/flutter_app/lib" ]; then
    cd apps/flutter_app
    flutter format --set-exit-if-changed . || { echo '❌ Flutter format failed'; exit 1; }
    flutter analyze || { echo '❌ Flutter analyze failed'; exit 1; }
    cd ../..
fi
echo "✅ Quality gates passed!"
EOF
chmod +x .git/hooks/pre-commit

# 8. Final Instructions
echo -e "\n${GREEN}✅ Ignition Complete!${NC}"
echo "---------------------------------------------------"
echo "Next Steps for Jose Antonio Licon:"
echo "1. Run 'cd apps/flutter_app' and get coding."
echo "2. Use Aider to expand your SEO Middleware Case logic."
echo "3. Update .env with your GA4 Measurement ID."
