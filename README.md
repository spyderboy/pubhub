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
* **Baseline Quality Gates:** Automated linting, formatting (Prettier/Dart Format), and `flutter analyze` via Git Hooks.
* **SEO Optimized For Web:** Pre-configured meta-tag handling for search engine visibility.
* **AI-Ready:** Structured specifically for **Aider** and local LLMs to accelerate development.

---

## 🚦 Quick-Start Workflow

### 1. Pre-Flight Checklist (The Hardware)
Ensure the core tools are installed on your workstation. Run `flutter doctor` to verify.

* **Node.js (v24+):** [Download Node.js](https://nodejs.org/)
* **Flutter SDK:** [Install Flutter](https://docs.flutter.dev/get-started/install)
* **AI Tools:** Install [Ollama](https://ollama.com) and [Aider](https://aider.chat).

#### 📱 Mobile Development Requirements
If you plan to publish to app stores, you must set up the native platform tools:

* **Android (Windows/Mac):** Install [Android Studio](https://developer.android.com/studio).
    * *Action:* After install, open the "SDK Manager" and ensure "Android SDK Command-line Tools" is checked.
* **iOS (Mac Only):** Install [Xcode](https://developer.apple.com/xcode/) from the Mac App Store.
    * *Action:* Run `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer` and `sudo xcodebuild -runFirstLaunch` in your terminal.

### 2. Ignition
Run the script for your OS to build the architecture, generate environment templates, and install Quality Gates.
* **Mac/Linux:** `chmod +x setup.sh && ./setup.sh`
* **Windows:** `.\setup.ps1`
    * *Note:* By default, Windows prevents scripts from running. If blocked, open **PowerShell as Administrator** and run:
      `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

### 3. Account "Handshake" & Environment
Link your local environment to your cloud providers:

1. **Prepare Keys:** Copy `.env.example` to `.env`.
2. **Populate `.env`:** * **Firebase Keys:** Found in Firebase Console > Project Settings.
    * **Netlify ID:** Found in Netlify Dashboard > Site Settings.
3. **Link Services:** Run `firebase login` and `netlify login`.
4. **Set Secrets:** Copy your API Key from [Resend](https://resend.com) and run:
   `firebase functions:secrets:set RESEND_API_KEY`

### 4. AI Handoff
1. Start your local model (e.g., `ollama serve`).
2. Launch Aider: `aider --msg-file docs/aider_instructions.md`
3. **Try this:** *"Aider, read my .env and initialize the Firebase config. Then build a Newsletter signup widget."*

---

## 🛡️ Security & Quality Gates

This stack follows the **Principle of Least Privilege** and enforces code standards automatically.



1. **Pre-Commit Hooks:** The setup script installs a Git hook. Every `git commit` automatically triggers `flutter format`, `flutter analyze`, and backend linting. If the code fails, the commit is blocked to ensure production quality.
2. **Firestore Rules:** Baseline rules are included in `firestore.rules`. By default, all data is locked; public data (articles) is read-only.
3. **GCP Service Accounts:** - **Do not** use the "Owner" role for your API keys.
   - **Action:** In the GCP Console, ensure the `App Engine default service account` only has the roles `Cloud Functions Developer` and `Secret Manager Secret Accessor`.
4. **Secrets:** Never commit API keys. Use `firebase functions:secrets:set` to keep keys out of the codebase.

---

## 🛠️ Troubleshooting

* **"Command Not Found" (Path Issues):** Restart your terminal or VS Code. On Windows, a full system restart may be required after the first installation to refresh the PATH.
* **Hook Failures:** If a commit is blocked, read the terminal output. It means the AI generated unformatted code or has linting errors. Fix them or run `git commit --no-verify` to bypass (not recommended).
* **Stuck Login:** If `firebase login` hangs in the browser, use `firebase login:ci` for a manual authentication code.

---

## 🌐 The Last Mile: Going Live

1. **Build for Web:** `flutter build web --wasm`
2. **Deploy:** `netlify deploy --prod --dir=apps/flutter_app/build/web`
3. **Domain Wiring:**
   - In Netlify: **Site Settings > Domain Management**.
   - In your Registrar: Update **Nameservers** to the four provided by Netlify.
   - Wait ~30 mins; SSL will provision automatically once DNS propagates.

---

## ⚖️ Legal & Compliance

Don't skip the legals. Templates for your **Privacy Policy**, **Terms of Service**, and **Copyright** are located in `/docs/legal_templates.md`.
**Action:** Ask Aider to generate these pages immediately to ensure you are compliant before collecting user emails.

## Extra Credit
Here are some commands to give Aider tailored for a Publisher workflow:

📰 Content & Editorial
Create an Article Listing:

"Aider, create a responsive 'News Feed' page that pulls articles from Firestore. Implement infinite scrolling and ensure each card has a 'Share' button that uses the native share sheet."

The Newsroom (Admin Dashboard):

"Build a 'Newsroom' dashboard accessible only to admins. It should allow me to draft articles in Markdown, upload images to Firebase Storage, and toggle a 'Featured' status."

Automated Newsletter Hook:

"Modify the 'Publish' button in the Newsroom so that when an article is saved, it also triggers the sendNewsletter GCP function via Resend to all subscribers."

📞 Engagement & Audience
Digital Tip Line (Secure):

"Create a 'Tip Line' page with a form for whistleblowers. Allow anonymous file uploads to a secure Firebase folder and notify the admin via a GCP function when a new tip is received."

Dynamic 'About Us':

"Create an 'About Us' page that pulls staff bios from a team collection in Firestore. Use the SEO renderer to make sure staff names are indexable by Google."

Live "Breaking News" Banner:

"Implement a global 'Breaking News' ticker at the top of the app. It should listen to a real-time Firestore document and only appear when the isActive flag is true."

💰 Growth & Monetization
Subscriber Paywall:

"Wrap the article body text in a logic gate. If the user is not logged in or doesn't have a subscriber flag in their profile, show a 'Join the Publication' call-to-action instead of the full content."

Ad Slot Integration:

"Create a reusable 'AdSlot' widget that I can drop between paragraphs in the article view. Ensure it complies with Flutter's accessibility semantics."

🛠️ Maintenance & SEO
SEO Audit:

"Check all existing pages and ensure they have unique Meta titles and descriptions being injected by our GCP function pattern."

Legal Compliance Check:

"Scan the 'Tip Line' and 'Newsletter' forms. Ensure they both link to our Privacy Policy and have the necessary GDPR consent checkboxes."
