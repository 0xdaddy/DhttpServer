<h1 align="center">💠 HTTPserver 💠</h1>
<h2 align="center">Very simple HTTPserver using D programming language 💠</h2>
<h4 align="center">⭐ Don't forget to leave a star! ⭐</h4>


## How it works ⚙️
* uses HTTP to communicate with browsers .
* It can identify the paths\\files sent by the browser, such as CSS , js ,etc..., and send them if they exist

## paths 📁
* `Routers/` contains the _HTTP.d file, which in turn contains the class that handles requests and responds to them.
* `templates/` contains the main files of the website\\host, index file, css files, etc.
* `Routers/reference` contains the file GETTER.d which contains a function that reads and returns the path given to it.
* `coustme/` contains files containing functions programmed specifically for specific purposes.
* `Win32/Debug` it will be useful when you use visual-d

## How to compile 🖥️
`Dhttpserver.d is the entry point || the main file`
<br>
`Make sure to put the templates/ folder next to the binary version of the program => output/bin/Dhttpserver.exe - output/bin/templates/`

* Windows
1. Download visual studio . 
2. Download visual-D ext http://rainers.github.io/visuald/visuald/StartPage.html .
3. Open DhttpServer.sln .
4. Build the project .
* Other OS
!NOT WORK IN other OS because the program is using winAPI FUNC


<h4 align="center">ℹ️ ~Check https://wiki.dlang.org/IDEs for more info~ ℹ️</h4>

