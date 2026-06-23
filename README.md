---

## ✨ Features

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
* Database: PostgreSQL v15+
* Package Manager: npm v10+

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
# URL for connecting to the PostgreSQL database (change user and password to your own)
DB_URL="postgresql://user:password@localhost:5432/maditron_db"

# Secret key for generating player authorization tokens (minimum 32 characters)
JWT_SECRET="your_super_secret_jwt_key_here"

# Access key to the artificial intelligence API for generating NPC dialogues
LLM_API_KEY="sk-your-llm-api-key"