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
        <?php

            require_once './vendor/autoload.php';

            use Kreait\Firebase;
            use Kreait\Firebase\Factory;
            use Kreait\Firebase\ServiceAccount;


            $serviceAccount = ServiceAccount::fromJsonFile(__DIR__.'/secret/tap-for-here-project-713992ad1a9e.json');

            $firebase = (new Factory)
                ->withServiceAccount($serviceAccount)
                ->create();

            $database = $firebase->getDatabase();
        ?>
        <script src='https://www.gstatic.com/firebasejs/5.9.0/firebase-app.js'></script>
        <script src='https://cdn.firebase.com/js/client/2.2.1/firebase.js'></script>
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
        <script src='https://www.gstatic.com/firebasejs/5.9.0/firebase-auth.js'></script>
        <script src='https://www.gstatic.com/firebasejs/5.9.0/firebase.js'></script>
           
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
        <script src="ProfPort1.js"></script>
        <script src="Proflogout.js"></script>
        <script>

            var email = "";

            //onload function, trims email down to username only
            function start(){
                email = localStorage.getItem("email");
                var prof = email.substring(0, email.indexOf("@"));
                onLogin(prof); 
                var formE = document.getElementById('id').value = prof;
            }
        </script>  
       
        

    </head>
    <body onload="start()">

        <div class="topnav">
            <a>
            <form action="ProfCreateRoster.php" method="POST">
                <input type="submit" value="Create Roster" class="resizedButton"/>
                <input type="hidden" name="id" id="id" value="">
            </form>
        </a>
        <a>
            <input onclick="logout()" type="button" value="Logout" class="resizedButton" id="signOut"/>
        </a>
        </div>
        <div class="titleDiv">
            <img src="image.png">
        </div>
        <div id="button" class="divCenter">
            <br/> <br/>
            <input onclick="showList()" type="button" value="Show Course List" class="resizedButton" id="crsLst" align="center"/>
            <h3>Course List</h3>
            <div id="courseList" class="crslst">
                <ul id="course" align="center"> 
                </ul>
            </div>
        </div>
    </body>
    
</html>