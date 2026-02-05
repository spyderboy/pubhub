#!/bin/bash
echo "🛠️ Initializing Publisher Stack..."

# 1. Flutter Setup
flutter create --platforms=web,android,ios apps/flutter_app
cd apps/flutter_app
flutter pub add firebase_core firebase_auth cloud_firestore seo provider
# Ensure 100% selectability boilerplate
sed -i '' 's/Widget build(BuildContext context) {/Widget build(BuildContext context) { return SelectionArea(child: /g' lib/main.dart

# 2. GCP Functions V2 Setup
cd ../../
mkdir -p backend/functions
cd backend/functions
npm init -y
npm install firebase-functions@v2 firebase-admin resend

# 3. Create Aider Instructions
cat <<EOF > ../../docs/aider_instructions.md
# Project Goals
- Framework: Flutter Web (WASM) & Mobile.
- Backend: GCP Functions V2.
- Requirements: 100% Accessibility, SEO, Selectable Text, Resend Integration.
- Test Coverage Target: 100%.
EOF

echo "✅ Setup Complete. Run 'aider --msg-file docs/aider_instructions.md'"
