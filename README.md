# Maditron 🕹️⚡

Welcome to **Maditron**, a gritty cyberpunk top-down RPG shooter featuring stunning retro pixel art. Experience high-octane combat, deep role-playing mechanics, and an immersive neon-drenched world driven by a powerful NestJS backend and a seamless Godot frontend engine.

---

## 🌌 Gameplay Features

* 🌍 Seamless immersion - explore the detailed game world without annoying loading screens thanks to a smooth spatial transition system between locations and the hub.
* 🤖 Live conversations with NPCs - get unique, meaningful and useful tips in real time thanks to the integration of modern artificial intelligence models (LLM), which makes every dialogue unique.
* 🎯 Clear progress control - keep your finger on the pulse of your adventures and instantly receive rewards using an intuitive dynamic task panel.
* 🛡 Secure access - your game achievements, inventory and personal data are reliably protected by the modern JWT server-side encryption standard.
* ⚔️ Responsive combat control - enjoy dynamic skirmishes thanks to an optimized collision and hit registration system developed on native GDScript.

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

---

## 📂 Project Structure

```text
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

---