<html>
    <head>
        <style>
            @import url("ProfPortal.css");
                html {
                    background-color: #FFE571;                    
                    color: #0f469e;
                    font-family: "Trebuchet MS", Helvetica, sans-serif;
                }
        </style>
    </head>
    <script>
        function setEmail(){
            localStorage.setItem("email", document.getElementById('email_val').value);
        }
    </script>
    <body>
        <div class="topnav">
            <a>
                Please Login
            </a>
        </div>
        <div class="titleDiv">
            <img src="image.png"></img>
        </div>
        <div class="divCenterLogin" >
            <div>
                    <p>Username: <br/><input type="email" name="usr" id="email_val" size="42"><br/></p>
                    <p>Password: <br/><input type="password" name="pword" id="password_val" size="42"><br/></p>
                    <button onclick="login(); setEmail()" id="logButton" name="Login" class="resizedButton">Login</button>
                    <input type="hidden" name="id" id="id" value="">
            </div>
            
        </div>
        <div class="botLeft">
            <img class="imgSmall" src="Icon2x.png">
        </div>
        <div class="iosImg">
            <img class="imgSmall" src="iOS.png">
        </div>
        <div class="appImg">
            <img class="imgSmall" src="appstore.jpeg">
        </div>
        <div class="gitImg">
            <img class="imgSmall" src="git.png">
        </div>
        <div class="gitSite">
            <a href = "https://github.com/Austincw/Tap-For-Here" class="buttonLink">Check out our GitHub!</a>
        </div>
        <div class="botRight">
            <img class="imgSmall" src="Icon2x.png">
        </div>
    </body>

    <script src='https://www.gstatic.com/firebasejs/5.9.0/firebase-app.js'></script>
    <script src='https://cdn.firebase.com/js/client/2.2.1/firebase.js'></script>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
    <script src='https://www.gstatic.com/firebasejs/5.9.0/firebase-auth.js'></script>
    <script src='https://www.gstatic.com/firebasejs/5.9.0/firebase.js'></script>
    <script src="ProfPort1.js"></script>
    <script>
        var config = {
            apiKey: "AIzaSyA8aiK4T2JoJh4LIzxHATcTPP_Zhf4qAFc",
            authDomain: "tap-for-here-project.firebaseapp.com",
            databaseURL: "https://tap-for-here-project.firebaseio.com", 
            projectId: "tap-for-here-project",
            storageBucket: "gs://tap-for-here-project.appspot.com", //gs://tap-for-here-project.appspot.com.appspot.com???
            messagingSenderId: "229543974217",
        };
        firebase.initializeApp(config);

    </script> 
    <script src="ProfLogin1.js"></script>
    
</html>
