# 🚀 The Unified Publisher Stack

**A professional-grade media engine that automates infrastructure, providing a unified codebase for web and mobile that is ready for production on day one.**

This system reduces the friction and overhead of publishing on web and mobile and builds a standardized, high-performance environment where your high-level intent—guided by AI—becomes a functional, shippable product.

---

## 💎 The Publisher’s Superpower: Why This System?

This project is built on the philosophy that technology should be a multiplier, not a hurdle. It is **FAST, STABLE, LOW-BARRIER**, and **PRACTICALLY FREE**.

* **Build at the Speed of Thought:** Because this system is **AI-Ready**, you describe features in plain English to your AI assistant (Aider). The system is "pre-wired" to understand your commands. You don't "vibe code" a prototype that breaks; you dictate professional and production ready features that go live immediately.
* **The Automated Safety Net:** Every time AI writes code for you, our **Quality Gates** (Digital Referees) automatically check it for errors. If the code is messy or broken, the system **refuses to let it through**. It’s like having a senior engineer looking over your shoulder 24/7.
* **Real-Time Intelligence** Knowledge is power. This system comes pre-configured with **Deep Analytics**.
- **See what’s working:** Track which articles are trending and where readers come from.
- **Privacy-First:** We use "Server-Side" tracking, meaning your site stays fast while respecting reader privacy.
* **Zero-Waste Cost Model:** We use **Serverless Technology**. If no one is using your site, your costs are near zero. You only pay for what you actually use. If you ever exceed the free tiers of these services, you have a "good problem"—it means you have the traffic and audience to sustain a massive business.

---

## 🧩 Future-Proof by Design: The Modular Advantage

Most websites are "Monoliths"—one big, heavy program where everything is tangled together. This project uses a **Serverless Microservice** architecture. Think of it as a collection of independent, specialized Lego bricks rather than one giant machine.



* **Platform Freedom:** Your content lives in an "API-first" environment. You aren't "married" to one platform. You can push your news to a website today, a mobile app tomorrow, or even a public data feed for other outlets later—without ever rebuilding your backend.
* **Set-It-and-Forget-It Stability:** Each feature (like a "Tip Line" or "Newsletter") runs as its own independent function. Once a function works, it stays working. You can update your entire website’s design without ever risking the stability of your core services.
* **Bite-Sized Innovation:** Adding a new feature is low-risk. You don't perform open-heart surgery on your website; you just plug in a new "bite-sized" service. This allows you to experiment with new ideas for pennies.

---

## 🔑 The Golden Keys: Required Accounts

Before running the ignition scripts, ensure you have active accounts with these providers.

| Account | Role | Purpose |
| :--- | :--- | :--- |
| **Google Cloud (GCP)** | **The Engine** | Powers secure login (Auth), database (Firestore), and serverless logic (Functions V2). |
| **Netlify** | **The Storefront** | Hosts your website on a global CDN and manages your custom domain and SSL. |
| **Resend** | **The Post Office** | Handles professional delivery of newsletters and automated emails. |

---

## 🚦 Quick-Start Workflow

### 1. Pre-Flight Checklist (The Hardware)
Ensure the core tools are installed. Run `flutter doctor` to verify.
* **Node.js (v24+):** [Download Node.js](https://nodejs.org/)
* **Flutter SDK:** [Install Flutter](https://docs.flutter.dev/get-started/install)
* **AI Tools:** Install [Ollama](https://ollama.com) and [Aider](https://aider.chat).

### 2. Ignition
Run the script for your OS to build the architecture, generate environment templates, and install Quality Gates.
* **Mac/Linux:** `chmod +x setup.sh && ./setup.sh`
* **Windows:** `.\setup.ps1`
    * *Note:* If blocked by security, run PowerShell as Admin and execute: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

### 3. Account "Handshake" & Environment
1.  **Prepare Keys:** Copy `.env.example` to `.env`. 
2.  **Populate `.env`:** Paste your Firebase Keys and Netlify Site ID into the file.
3.  **Link Services:** Run `firebase login` and `netlify login`.
4.  **Secure Secrets:** To keep your email keys safe and keep them out of your code, run:
    `firebase functions:secrets:set RESEND_API_KEY`

### 4. AI Handoff
Launch Aider: `aider --msg-file docs/aider_instructions.md`
**Try this:** *"Aider, read my .env and initialize the Firebase config. Then build a 'Breaking News' ticker for the top of the page."*

---

## 🛡️ Security & Quality Gates

This stack follows the **Principle of Least Privilege** and enforces code standards automatically.



1.  **Pre-Commit Hooks:** The setup script installs a Git hook. Every `git commit` triggers `flutter format`, `flutter analyze`, and backend linting. This prevents "bad code" from ever reaching your production site.
2.  **Firestore Rules:** Baseline rules are included. By default, your database is write-protected to prevent unauthorized access.
3.  **Secrets Management:** Sensitive keys are stored in Google Cloud Secret Manager, never in the plain-text code.

---

## 🌐 The Last Mile: Going Live

1.  **Build for Web:** `flutter build web --wasm`
2.  **Deploy:** `netlify deploy --prod --dir=apps/flutter_app/build/web`
3.  **Domain Wiring:** Point your registrar's Nameservers to the four provided by Netlify under **Domain Management**. SSL will provision automatically.

---

## ⚖️ Legal & Compliance

Don't skip the legals. Templates for your **Privacy Policy**, **Terms of Service**, and **Copyright** are in `/docs/legal_templates.md`.
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

Ad Slot Integration:

"Create a reusable 'AdSlot' widget that I can drop between paragraphs in the article view. Ensure it complies with Flutter's accessibility semantics."

🛠️ Maintenance & SEO
SEO Audit:

"Check all existing pages and ensure they have unique Meta titles and descriptions being injected by our GCP function pattern."

Legal Compliance Check:

"Scan the 'Tip Line' and 'Newsletter' forms. Ensure they both link to our Privacy Policy and have the necessary GDPR consent checkboxes."
