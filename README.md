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


## 🌐 How to set up database for accounts in XAMPP

If you already have your own web server you can just make a folder in your directory called DND, and insert the PHP files attached, and make a database called dnd_db and a table with 2 collums "username" and "password"

For XAMPP install it here: https://www.apachefriends.org/

⚠️Make sure to save XAMPP directly in the C: directory (NOT IN PROGRAM FILES)⚠️

Open XAMPP control panel as administrator from the file you downloaded ⚠️VERY IMPORTANT TO OPEN AS ADMIN, CAN BREAK IF YOU DON'T⚠️

Now start Apache and MySQL from the control panel.
In the "MySQL" row click on admin, and you'll be sent the the PHPmyadmin page. Here you can create and configure databases and tables.
Make a new database called: 
