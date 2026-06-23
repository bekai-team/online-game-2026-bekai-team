![Logo](/docs/marketing/branding/logo.png)

Welcome to **Maditron**, a gritty cyberpunk top-down RPG shooter featuring stunning retro pixel art. Experience high-octane combat, deep role-playing mechanics, and an immersive neon-drenched world driven by a powerful NestJS backend and a seamless Godot frontend engine.

---

## 🌌 Gameplay Features
* 🌍 Seamless immersion - explore the detailed game world without annoying loading screens thanks to a smooth spatial transition system between locations and the hub.
![Seamless immersion](/assets/1.png)
---
* 🤖 Live conversations with NPCs - get unique, meaningful and useful tips in real time thanks to the integration of modern artificial intelligence models (LLM), which makes every dialogue unique.
![Live conversations](/assets/2.png)
---
* 🎯 Clear progress control - keep your finger on the pulse of your adventures and instantly receive rewards using an intuitive dynamic task panel.
![Clear progress](/assets/3.png)
---
* 🛡 Secure access - your game achievements, inventory and personal data are reliably protected by the modern JWT server-side encryption standard.
![Secure access](/assets/4.png)
---
* ⚔️ Responsive combat control - enjoy dynamic skirmishes thanks to an optimized collision and hit registration system developed on native GDScript.
![Responsive combat](/assets/5.png)

---
## 🚀 Coming Soon (Development Roadmap)

We are actively expanding the borders of **Maditron**. The following features are currently in our backlog and slated for upcoming development phases:

### 📜 Advanced Quest & AI Systems
* **Dynamic AI Quests (Logic)** — Full integration of generative AI pipelines to drive deep, procedurally tailored quest lines that evolve based on world events.
* **Attributes Adaptability** — Real-time quest modification and dialogue branching tailored dynamically to your character’s unique attributes distribution.
* **AI Progress Tracker** — An advanced journal interface to monitor and review the state of AI-generated objectives, keeping your contract targets clear.

### 🌐 Corporate Net-Grid (Multiplayer)
* **WebSocket Integration** — Implementation of robust WebSocket connections to support low-latency local movement and network synchronization.
* **Proxy-Player Rendering** — Real-time rendering and tracking of remote runners navigating the same local sectors.
* **Smooth Interpolation** — Advanced dead-reckoning and interpolation algorithms for fluid, jitter-free movement of rival players across the grid.
* **Global Sub-Net Chat** — An integrated, real-time global text channel for runners to coordinate tactical strikes, trade data, or negotiate contracts.

### 🎮 UX & Feedback Enhancements
* **Tactical Interface Feedback** — Visually polished UI click responses, custom shaders, and responsive menu deployment to heighten interface immersion.
---
## 🛠 Setup Guide

### 1. Pre-requisites
For guaranteed and stable operation of the project, make sure that you have the following software versions installed:
* Game Engine: Godot Engine v4.2.2+ (for the client part)
* Backend Runtime: Node.js v20.0+
* Database: PostgreSQL v16+
* Package Manager: npm v11+

### 2. Database Setup
To deploy and populate the database with the necessary structure, go to the backend directory and run the following commands:

* Migrations: Automatic creation of tables and database structure:
npx prisma migrate dev
* Seed Data: Import demo data (base items, NPCs, starting locations). After executing this command, the database will be ready to work:
npm run seed

### 3. Environment Variables
All project configuration is done through environment variables. A template file .env.example is created in the root of the backend part of the project.

You need to create a .env file and copy the structure from .env.example there:

```env
# For connecting to the PostgreSQL database (change user and password to your own)

POSTGRES_HOST=127.0.0.1
POSTGRES_PORT=5432
POSTGRES_DB=maditron
POSTGRES_USER=postgres
POSTGRES_PASSWORD=123

WEB_SOCKETS_HOST=127.0.0.1
WEB_SOCKETS_PORT=80

OLLAMA_MODEL=gemma4

JWT_SECRET=your_secret
JWT_EXPIRE_IN=1h

REFRESH_JWT_SECRET=your_secret
REFRESH_JWT_EXPIRE_IN=60d

## 🛠️ Tech Stack

*   **Frontend Game Client:** [Godot Engine](https://godotengine.org/)
*   **Backend API Service:** [NestJS](https://nestjs.com/) (Node.js framework)
*   **Database / Realtime (Optional):** Define your database here (e.g., PostgreSQL, Redis, MongoDB)
```
---

## 📂 Project Structure

```
maditron/
├── api/                    # NestJS Backend Application
└── client/                 # Godot Engine Project Files
└── docker-compose/         # Docker-compose folder
```

---

## 🚀 Getting Started


Follow these instructions to get a local copy of the project up and running for development and testing.
Prerequisites

Make sure you have the following tools installed on your machine:

    Node.js (v18+ recommended)

    npm or yarn

    Godot Engine (v4.x recommended)

---

## 📦 Installation & Setup
1. Clone the Repository
Bash

git clone [https://github.com/your-username/maditron.git](https://github.com/your-username/maditron.git)
cd maditron

2. Start the Backend API

The backend handles player authentication, RPG stats, and game states. Navigate to the API directory, install your dependencies, and spin up the development server with hot-reload enabled.
Bash

2.1. Step into the API subdirectory
```cd ./api```

2.2. Install backend dependencies
```npm install```

2.3. Setup your environment variables (if applicable)
```cp .env.example .env```

2.4. Start the NestJS application in watch mode
```nest start --watch```

    Note: The API server should now be running locally (typically at http://localhost:3000).

3. Run the Godot Game Client

    Open the Godot Engine project manager.

    Click the Import button.

    Browse to your local project folder, navigate into the client/ folder (or wherever your project.godot file is located), and select it.

    Once the project loads inside the Godot Editor, press F5 (or click the Play icon in the top right corner) to launch and run the game client.

    Important: Before launching, check for project global scripts in Project -> Project Settings -> Globals. There must be `client/scripts/global.gd` and `client/scripts/session_manager.gd` listed. If not, add them manually for the project to launch. 
---

## Credits
- Contributors to the project are listed in the [CONTRIBUTORS](/CONTRIBUTORS.md) file.

### Assets used

- [Neo Zero Cyberpunk City Tileset](https://yaninyunus.itch.io/neo-zero-cyberpunk-city-tileset)
- Other asset packs for shotgun and rats from [itch.io](https://itch.io)

## Document links (Ukrainian)
- [Project Charter (Notion)](https://app.notion.com/p/Project-Charter-330c2e3d9baf80979098f1f967f5c777?source=copy_link)
- [Product Scope (MVP)](https://app.notion.com/p/Product-Scope-MVP-32bc2e3d9baf80418e95ef25cb7f9274?source=copy_link)
- [Business Requirements Document (Google Drive)](https://docs.google.com/document/d/1fl08Cg5Li6k1aPB050ymQmerGLByl_8h/edit?usp=sharing&ouid=115204124840595355451&rtpof=true&sd=true)
- [Architecture Details (Google Drive)](https://docs.google.com/document/d/1m4RBx5UEW2t9vtZF1zqhxAu-cML-Yauwsl2qYz9_RuU/edit?usp=sharing)
- [Explaining Note (Google Drive)](https://docs.google.com/document/d/1norvF9fWoI0dAMU3wZ72H5z1K56mExDnRvzvy9-Yer0/edit?usp=sharing)
- [Test Summary Report (Google Drive)](https://docs.google.com/document/d/1QyYDkwzUxSR0Rn31Y34HI3jWd9n-DgC2EAnht78ehek/edit?usp=sharing)
- [Requirements Traceability Matrix (Notion)](https://app.notion.com/p/Requirements-Traceability-Matrix-350c2e3d9baf80c2ab25c4a7fdb66525?source=copy_link)
- [Test Plan (XLSX)](/docs/test_plan.xlsx)

### Marketing
- [Elevator Pitch](/docs/marketing/copywriting/elevator_pitch.pdf)
- [Market Analysis](/docs/marketing/strategy/market_analysis.pdf)
- [Social Media Plan](/docs/marketing/strategy/social_media_plan.pdf)
- [Promotional Teaser Video](/docs/marketing/video/maditron_promo.mp4)