<html>
    <head>
        <style>
            @import url("ProfPortal.css");
            html {
                background-color: #FFE571;                    
                color: #0f469e;
                font-family: "Trebuchet MS", Helvetica, sans-serif;
            }
            pre{
                font-family: "Trebuchet MS", Helvetica, sans-serif;
            }
        </style>
        
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
        <script src="Proflogout.js"></script>

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
        
        $myArray = explode(',',  $_GET['id']); //array from form of roster creation 
        $dateArray = explode(',',  $_GET['date']); 
        $studArray = array(); //student roster array with false value
        $dateArr = array(); //semester class dates with student roster in each
       
        //creates student roster array with default value false and creates array used for class attendance
        if(sizeof($myArray) > 8){
            for($i = 8; $i < sizeof($myArray); $i++){
                $studArray[$myArray[$i]] = false;
            }
            for($j = 0; $j < sizeof($dateArray); $j++){
                $dateArr[$dateArray[$j]] = $studArray;
            }
        }
        //below are the main data entries for creating a new roster
        $classAttnd = [
                "$myArray[1]" => $dateArr  
        ];
        $database->getReference("ClassAttendance")->update($classAttnd);
        
        $classlistdata = [  
                "$myArray[1]" => [
                "Professor" => "$myArray[0]",
                    "roster" =>
                        $studArray 
                ]
        ];
        $database->getReference("ClassList")->update($classlistdata);
        
        $classdata = [
                "$myArray[1]" => [
                    "roomID" => "$myArray[2]",
                    "days" => "$myArray[3]",
                    "startDay" => "$myArray[4]",
                    "endDay" => "$myArray[5]",
                    "startTime" => "$myArray[6]",
                    "endTime" => "$myArray[7]",
                ]
        ];
        $database->getReference("ClassData")->update($classdata);
        
        $profClassList = [
                "$myArray[1]" => "$myArray[0]"
        ];
        $database->getReference("ProfessorClassList")->update($profClassList);
        ?>
        <script>
            function home(){
                window.location.href = "Profportal1.php";
            }
        </script>
    </head>
    <body>
        <div class="topnav">
            <a>
                <input onclick="home()" type="button" value="Home" class="resizedButton" id="home"/>
            </a>
            <a>
                <input onclick="logout()" type="button" value="Logout" class="resizedButton" id="signOut"/>
            </a>
        </div>
        <div class="titleDiv">
            <img src="image.png" >
        </div>
        <div class = "center">
            <h3 align="center">Course Roster has been created!</h3>
        </div>
        <div class="botLeft">
            <img class="imgSmall" src="Icon2x.png">
        </div>
        <div class="botRight">
            <img class="imgSmall" src="Icon2x.png">
        </div>
    </body>
</html>