# 🚀 The Unified Publisher Stack

**This recipe automates infrastructure, providing a unified codebase for web and mobile that is ready for production on day one.**

Most publishing projects stall out in the "plumbing" phase—configuring cloud permissions, setting up databases, and wiring deployment pipelines. This system eliminates that overhead. It builds a standardized, high-performance environment where your high-level intent—guided by AI—becomes functional, shippable software.

---

## 🔑 The Golden Keys: Required Accounts

Before running the ignition scripts, ensure you have active accounts with these providers. This project is designed to link these services into a single, automated ecosystem.

| Account | Role | Purpose |
| :--- | :--- | :--- |
| **Google Cloud (GCP)** | **The Engine** | Powers secure login (Auth), database (Firestore), and serverless logic (Functions V2). |
| **Netlify** | **The Storefront** | Hosts your website on a global CDN and manages your custom domain and SSL. |
| **Resend** | **The Post Office** | Handles professional delivery of newsletters and automated emails. |

> **Note:** These services offer generous free tiers. However, you will typically need a credit card on file for GCP and Netlify to verify your identity and enable "pay-as-you-go" scaling for when your publication grows.

---

## 🏗️ Core Features
* **Unified Frontend:** One Flutter codebase for Web (WASM-ready), Android, and iOS.
* **Selectable & Accessible:** 100% text selectability and built-in Semantics for accessibility compliance.
* **GCP V2 Backend:** Secure Node.js functions for content CRUD, caching, and newsletter integration.
* **SEO Optimized:** Pre-configured meta-tag handling for search engine visibility.
* **AI-Ready:** Structured specifically for **Aider** and local LLMs to accelerate development.

---

## 🚦 Quick-Start Workflow

### 1. Pre-Flight Checklist 
Ensure the core tools are installed on your workstation.

* **Node.js (v24+):** [Download Node.js](https://nodejs.org/)
* **Flutter SDK:** [Install Flutter](https://docs.flutter.dev/get-started/install)
* **AI Tools:** Install [Ollama](https://ollama.com) and [Aider](https://aider.chat) (`pip install aider-chat`).

#### 📱 Mobile Development Requirements
If you plan to publish to app stores, you must set up the native platform tools:

* **Android (Windows/Mac):** Install [Android Studio](https://developer.android.com/studio).
    * *Action:* After install, open the "SDK Manager" and ensure "Android SDK Command-line Tools" is checked.
* **iOS (Mac Only):** Install [Xcode](https://developer.apple.com/xcode/) from the Mac App Store.
    * *Action:* Run `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer` and `sudo xcodebuild -runFirstLaunch` in your terminal.

**Verification:** Run `flutter doctor` in your terminal. It will give you a green checkmark once these are configured correctly.

### 2. Ignition
Run the script for your OS to build the project architecture and install dependencies.
* **Mac/Linux:** `chmod +x setup.sh && ./setup.sh`
* **Windows:** `.\setup.ps1`
* By default, Windows prevents scripts from running for security. If you get a red error message when running `.\setup.ps1`, you need to grant permission.
1. Open **PowerShell** as **Administrator**.
2. Run this command:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

### 3. Account "Handshake"
Link your local environment to your cloud providers:
1. **Link Google:** Run `firebase login` to sync your account.
2. **Link Netlify:** Run `netlify login` to authorize your machine.
3. **Set Secrets:** Copy your API Key from [Resend](https://resend.com) and run:
   `firebase functions:secrets:set RESEND_API_KEY`

### 4. AI Handoff
1. Start your local model (e.g., `ollama serve`).
2. Launch Aider: `aider --msg-file docs/aider_instructions.md`
3. **Try this:** *"Aider, build the Admin Login page and the Newsletter signup widget."*

---

## 🛠️ Troubleshooting the "Handshake"

* **"Command Not Found" (Path Issues):** Restart your terminal or VS Code. On Windows, a full system restart may be required after the first installation to refresh the PATH.
* **Execution Policy (Windows):** If `setup.ps1` is blocked, open PowerShell as **Administrator** and run:
  `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
* **Permission Denied (Mac/Linux):** Ensure you ran `chmod +x setup.sh` before executing.
* **Stuck Login:** If `firebase login` hangs in the browser, use `firebase login:ci` for a manual authentication code.

---

## 🛡️ Security & Least-Privilege IAM

This stack follows the **Principle of Least Privilege**. 

1. **Firestore Rules:** By default, all data is locked. Public data (articles) is read-only.
2. **GCP Service Accounts:** Your Functions run under a dedicated service account. 
   - **Do not** use the "Owner" role for your API keys.
   - **Action:** In the GCP Console, ensure the `App Engine default service account` only has the roles `Cloud Functions Developer` and `Secret Manager Secret Accessor`.
3. **Secrets:** Never commit API keys. Use `firebase functions:secrets:set RESEND_API_KEY` to keep keys out of the codebase.

## 🌐 The Last Mile: Going Live

1. **Build for Web:** `flutter build web --wasm`
2. **Deploy:** `netlify deploy --prod --dir=build/web`
3. **Domain Wiring:**
   - In Netlify: **Site Settings > Domain Management**.
   - In your Registrar: Update **Nameservers** to the four provided by Netlify.
   - Wait ~30 mins; SSL will provision automatically once DNS propagates.

---

## ⚖️ Legal & Compliance

Don't skip the legals. Templates for your **Privacy Policy**, **Terms of Service**, and **Copyright** are located in `/docs/legal_templates.md`.
**Action:** Ask Aider to generate these pages immediately to ensure you are compliant before collecting user emails.

---

© 2026 Unified Publisher Stack | Designed for rapid, reproducible success.
