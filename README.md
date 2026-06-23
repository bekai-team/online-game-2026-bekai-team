# Maditron 🕹️⚡

Welcome to **Maditron**, a gritty cyberpunk top-down RPG shooter featuring stunning retro pixel art. Experience high-octane combat, deep role-playing mechanics, and an immersive neon-drenched world driven by a powerful NestJS backend and a seamless Godot frontend engine.

---

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

## 🌌 Gameplay Features

    Cyberpunk Aesthetics: Dark, atmospheric synth-wave environment featuring vibrant neon lights and meticulously crafted pixel art.

    Top-Down Shooter Combat: Fast-paced gunplay, bullet-hell dodging, and tactical gun modifications.

    RPG Progression: Character stats customization, level-up trees, faction reputation, and grid-based cybernetic enhancements.