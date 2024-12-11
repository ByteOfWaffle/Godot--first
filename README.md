# 🥷 Stealth Platformer Game Project 🥷

## 📋 Overview
This is a platformer game with the following key features:

- 👻 Stealth (ability to hide)
- ⏱️ Timed levels to encourage competitivness in players.
- 💾 Saving game progress
- 🔄 Ability to transfer saves to and from a database

The game involves navigating through levels filled with obstacles and enemies, using stealth mechanics to avoid detection. 

## 💾 Saving and Save Transfer

The game will save the players progress after a level. The save data is first stored locally on the player's device.

Additionally, the saved game data can be transferred to and from a database. This enables them to continue their game on different devices, or to restore a previous save if needed.

The save transfer functionality is integrated with a backend database, allowing the game to securely store and retrieve player progress.

## 🔧 Technical Details

The game and database is built using the following technologies:

- 🖥️ Platform: Windows(game), Linux(database)
- 🎮 Engine: Godot
- 👨‍💻 Programming Language: GDscript
- 🗄️ Database: Probably some kinda SQL-based database, Still tryna figure it out.


# 🌐 How to Set Up a Database for Accounts in XAMPP

If you already have your own web server, simply create a folder in your directory called `DND`, insert the attached PHP files, and create a database named `dnd_db` with a table containing two columns: `username` and `password`.

For users setting up with XAMPP, follow these detailed steps:

## 1. Install XAMPP
- Download XAMPP from [this link](https://www.apachefriends.org/).
- **Important:** Save XAMPP directly in the `C:` directory. Avoid saving it in `Program Files` to prevent potential permission issues.

## 2. Open the XAMPP Control Panel
- Navigate to the file you downloaded and open the XAMPP control panel as an administrator.
  - ⚠️ **This step is crucial. Not opening as an administrator can cause errors.**

## 3. Start Services
- In the XAMPP control panel, start **Apache** and **MySQL** by clicking the "Start" buttons.

## 4. Access phpMyAdmin
- In the row labeled "MySQL," click on the **Admin** button. This will open the phpMyAdmin page in your browser.
- phpMyAdmin is used to create and configure your database.

## 5. Create the Database
1. In phpMyAdmin, create a new database named `dnd_db`.
2. Inside the `dnd_db` database, create a new table.
   - Name the table and add **two columns**:
     - `username`
     - `password`
3. Save the table configuration.

## 6. Configure XAMPP Files
1. Open the XAMPP installation directory and navigate to the `htdocs` folder. If you have done everything correctly it should lay here: `C:\xampp\htdocs`
2. Inside the `htdocs` folder, create a new folder named `dnd`.
3. Place the attached PHP files into the `dnd` folder.

Should end up looking like this:
![image](https://github.com/user-attachments/assets/0dd69e31-7c84-49e4-8961-30971c3338c3)

By following these steps, your database should be properly set up and connected to the game.
