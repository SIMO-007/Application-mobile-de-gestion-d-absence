# flutter_app

Application de gestion d'absence en flutter avec un api php and une base de donnée mysql

Dependences:
xampp, php, flutter, dart 

before running the app:

1- go to the htdocs folder in the xampp directory

2- create a floder called "flutter"

3- inside it drag and drop the api folder

4- open the xampp control panel and start apache and mysql

5- go to phpmyadmin and create a new database called "flutter" (u can name it what u want but make sure to put that name as the value the dbconn variable in dbconn.php in the api folder)

6- in that databse u created in phpmyadmin, import the database_script.sql script to create the database automatically (u can add to the database ofc)

7- open the flutter project in ur IDE and change all occurences of my local ip address (192.168.11.103) and enter ur own.(if u use vscode press ctrl+shift+F so u can put what to replace and what to replace with for all the files at once)

8- configure whether if u want to run the project on a physical android phone or on an emulator then enter 'flutter run' in the terminal in the project directory

That should be it.

Here are some pics of the app :  



