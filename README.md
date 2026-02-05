# pubhub
This recipe for publishers automates infrastructure, providing a unified codebase for web and mobile that is ready for production on day one. By handling the "boring but critical" configuration of cloud permissions, database schemas, and deployment pipelines it creates (aided by AI) a standardized environment functional, and shippable.

🏗️ What is being automated?
Instead of manually configuring dozens of services, the ignition scripts handle the heavy lifting:

Unified Environment: A single Flutter project configured for Web (WASM-ready), iOS, and Android.

Serverless Backend: Automatic deployment of GCP Functions V2 for logic like content caching and secure CRUD operations.

Automated Marketing: Pre-wired integration with Resend for newsletter subscriptions.

Standardized Compliance: Default configurations for SEO, screen-reader accessibility (Semantics), and 100% text selectability.

Deployment Pipeline: A "push-to-deploy" workflow targeting Netlify for the web and Firebase for the backend.

🤖 The AI-Augmented Workflow
This project is specifically designed to be handed off to an AI coding assistant (like Aider). Because the infrastructure is "clean" and standardized:

Context Awareness: The assistant starts with a full "map" of your GCP and Flutter architecture.

Frictionless Coding: You don't ask the AI to "set up a database"; you ask it to "add a new article category." The plumbing is already there.

Reliable Output: By enforcing 100% test coverage from the start, the recipe ensures that AI-generated features don't break existing functionality.

🏁 The "Day One" Success State
Once you run the bootstrap recipe, you will have:

A Live URL: A placeholder site secured with SSL and hosted on a global CDN.

An Admin Portal: A secure login where you can immediately begin adding, editing, and deleting content.

Newsletter Capture: A working form that sends subscriber data to your Resend dashboard.

Cross-Platform Parity: The exact same experience running in a web browser and a mobile emulator.

📂 Included in the Recipe
setup.sh / setup.ps1: The "Ignition" scripts for Mac and Windows.

.gitignore: Professional-grade exclusions for security and cleanliness.

docs/aider_instructions.md: The instruction manual for your AI assistant.

backend/functions/: Pre-written GCP V2 Node.js templates.
