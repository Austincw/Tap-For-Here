<html>
    <head>
        <style>
            @import url("ProfPortal.css");
            @import url("table.css");
            @import url("util.css");
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

            $courseName = $_GET["value_key"]; //course name passed from previous page
            
            //date array for all dates for the semester for selected course name
            $dateData = $database->getReference('ClassAttendance/'.$courseName)->getChildKeys();
            sort($dateData);
        ?>
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
        <script>
            function home(){
                window.location.href = "Profportal1.php";
            }
            //sends needed variables back to this same page via html form
            function sendIt(){
                var coure = "";
                course = "<?php echo $courseName."" ?>";
                document.getElementById("courseName").value = course;
                document.getElementById("value_key").value = course;
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
        <div class="dropdown">
            <form> 
                <h3 class="padLeft" value="<?php echo $courseName."" ?>" id="course"><?php echo $courseName."" ?></h3>
                <p>
                    <label class="padLeft" >Select a Date</label>
                    <select class="padLeft" name="dateList" onchange="sendIt(); this.form.submit()">
                    <option value ="" disable selected>Dates</option>
                    <?php for($date = 0; $date < sizeOf($dateData); $date++){ ?>
                        <option value="<?php echo $dateData[$date]."" ?>"><?php echo $dateData[$date]."" ?></option>
                    <?php } ?>
                    </select>
                </p> <br/><br/>
                <input type="hidden" name="value_key" id="value_key">
                <input type="hidden" name="courseName" id="courseName">
                <input type="hidden" name="date" id="date" value="">
            </form>
            <?php
                //below creates the table that displays attendance for selected date
                if(isset($_GET["dateList"])){
                    $date = $_GET["dateList"]; 

                    $nameList = $database->getReference("ClassList/".$courseName."/roster")->getChildKeys();
                    sort($nameList);
                    $roster = $database->getReference('ClassAttendance/'.$courseName.'/'.$date)->getSnapshot()->getValue();
                    
                    $studIndex = 0;
                    foreach ($roster as $name => $value){
                        $attendance = json_encode($roster[$name]);
                        $table_attendance[$studIndex] = $attendance;
                        $studIndex++;
                    } 
                    ?>
                    <div class="limiter">
                        <div class="container-table100">
                            <div class="wrap-table100">
                                <div class="table100 ver1 m-b-110">
                                    <div class="table100-head">
                                        <table>
                                            <thead>
                                                <tr class="row100 head">
                                                    <th class="cell100 column1">Email</th>
                                                    <th class="cell100 column2"><?php echo $date."" ?></th>
                                                </tr> 
                                            </thead>
                                        </table>
                                    </div>    
                                    <div class="table100-body js-pscroll ps ps--active-y"> 
                                        <table>
                                            <tbody>
                                                <?php for($stud = 0; $stud < sizeOf($nameList); $stud++){ ?>
                                                    <tr class="row100 body"> 
                                                        <td class="cell100 column1"><?php echo $nameList[$stud]."" ?></td>
                                                        <td class="cell100 column2"><?php  if($table_attendance[$stud] == 'true'){
                                                                                                echo "<p>&#9989;</p>";
                                                                                           }
                                                                                           else{
                                                                                               echo "<p>&#10060;</p>";
                                                                                           }
                                                         ?> </td>
                                                    </tr>
                                                <?php } ?>
                                            </tbody>        
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>                
                    </div>
                <?php } ?>
            
        </div>
    </body>
    <script src="Proflogout.js"></script>
    
</html>