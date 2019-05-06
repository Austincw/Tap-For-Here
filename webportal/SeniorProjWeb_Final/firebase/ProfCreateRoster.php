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
        <?php 
            $email =  $_POST['id'];  
            
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
            function logout(){
                firebase.auth().signOut().then(function(){
                    
                }).catch(function(error){
                    window.alert("Error: " + error);
                });
            }

            function home(){
                window.location.href = "Profportal1.php";
            }


            var numStudents; //global student number for roster

            //creates textboxes to input student emails
            function numOfStud(){
                var i;
                numStudents = prompt("Please enter the number of students you wish to add", "0");
                for(i = 0; i < numStudents; i++){
                    var stuID = 'stud'+(i+1);
                    document.getElementById('textboxes').innerHTML += (i+1) + ": ";
                    document.getElementById('textboxes').innerHTML += '<input type="text" value="" id="'+stuID+'" /><br/>';
                    document.getElementById('textboxes').innerHTML += "<br/>";
                }
            }
            //packages form information into an array
            function store(){
                var i;
                var prof = "<?php echo $email."" ?>";
                var input = [];
                input[0] = prof;
                input[1] = document.getElementById('crsName').value;
                input[2] = document.getElementById('rmID').value;
                input[3] = document.getElementById('crsDay').value;
                input[4] = document.getElementById('startDay').value;
                input[5] = document.getElementById('endDay').value;
                input[6] = document.getElementById('startTime').value;
                input[7] = document.getElementById('endTime').value;

                for(i = 0; i < (numStudents); i++){
                    var p = "stud"+(i+1);
                    var stud = "";
                    stud = document.getElementById(p).value;
                    var studTrim = "";
                    studTrim = stud.substring(0, stud.indexOf("@"));
                    input[i+8] = studTrim;
                     
                }
                var getDaysArray = function(start, end) {
                    
                    for(var arr=[],dt=start; dt<=end; dt.setTime(dt.getTime()+86400000)){
                        arr.push(new Date(dt));
                    }
                    return arr;
                };
                //below returns the dates for a semester depending on the days of the week for a class
                var onlyDays = [];
                function getCertainDays(daysOfWeek, daysArr){
                    
                var count = 0;
                    if(dOW == "TR"){
                        for(var i = 0; i < daysArr.length; i++){
                            if(i%7 == 1 || i%7 == 3){
                                var date = daysArr[i].toISOString().slice(5, 10);
                                onlyDays[count] = date;
                                count++;
                            }
                        }
                    }
                    else if(dOW == "MWF"){
                        for(var i = 0; i < daysArr.length; i++){
                            if(i%7 == 0 || i%7 == 2 || i%7 == 4){
                                var date = daysArr[i].toISOString().slice(5, 10);
                                onlyDays[count] = date;
                                count++;
                            }
                        }
                    }
                    else if(dOW == "MW"){
                        for(var i = 0; i < daysArr.length; i++){
                            if(i%7 == 0 || i%7 == 2){
                                var date = daysArr[i].toISOString().slice(5, 10);
                                onlyDays[count] = date;
                                count++;
                            }
                        }
                    }
                    else if(dOW == "M"){
                        for(var i = 0; i < daysArr.length; i++){
                            if(i%7 == 0){
                                var date = daysArr[i].toISOString().slice(5, 10);
                                onlyDays[count] = date;
                                count++;
                            }
                        }
                    }
                    else if(dOW == "T"){
                        for(var i = 0; i < daysArr.length; i++){
                            if(i%7 == 1){
                                var date = daysArr[i].toISOString().slice(5, 10);
                                onlyDays[count] = date;
                                count++;
                            }
                        }
                    }
                    else if(dOW == "W"){
                        for(var i = 0; i < daysArr.length; i++){
                            if(i%7 == 2){
                                var date = daysArr[i].toISOString().slice(5, 10);
                                onlyDays[count] = date;
                                count++;
                            }
                        }
                    }
                    else if(dOW == "R"){
                        for(var i = 0; i < daysArr.length; i++){
                            if(i%7 == 3){
                                var date = daysArr[i].toISOString().slice(5, 10);
                                onlyDays[count] = date;
                                count++;
                            }
                        }
                    }
                    else if(dOW == "F"){
                        for(var i = 0; i < daysArr.length; i++){
                            if(i%7 == 4){
                                var date = daysArr[i].toISOString().slice(5, 10);
                                onlyDays[count] = date;
                                count++;
                            }
                        }
                    }
                }
                var startDay = input[4];
                var endDay = input[5];
                var daylist = getDaysArray(new Date(startDay),new Date(endDay));
                var dOW = input[3];
                getCertainDays(dOW, daylist);
                var x = ""+input.toString();
                document.getElementById("id").value = input;
                document.getElementById("date").value = onlyDays;
                document.getElementById("demo").innerHTML = x;
            }
        </script>  
        
    </head>
    <body onload= "numOfStud()">
        <div class="topnav">
            <a>
                <input onclick="home()" type="button" value="Home" class="resizedButton" id="home"/>
            </a>
            <a>
                <input onclick="logout()" type="button" value="Logout" class="resizedButton" id="signOut"/>
            </a>
        </div>
        <div class="titleDiv">
            <img src="image.png" ></img>
        </div>
        <br/><br/>
        <form name="roster" action= "database.php" method="GET">
            <div id="classInfo">
                <pre>Professor:          <?php echo $email."" ?><br/></pre>
                <pre>Course Name:    <input type='text' value='' id='crsName' pattern="[A-Za-z]+\s[0-9]+-[0-9]+"/> i.e. COMP 100-0001<br/></pre>
                <pre>Room ID:           <input type='text' value='' id='rmID' pattern="[A-Za-z]+\s[0-9]+"/> i.e. McNair 200<br/></pre>
                <pre>Course Day:       <input type='text' value='' id='crsDay' pattern="(M|T|W|R|F){1,5}"/> i.e. MWF, TR, MW, T<br/></pre>
                <pre>Start Date:        <input type='text' value='' id='startDay' pattern="20[0-9]{2}(-[0-9]{2}){2}"/> Format: YYYY-MM-DD, The start date must be a Monday<br/></pre>
                <pre>End Date:          <input type='text' value='' id='endDay' pattern="20[0-9]{2}(-[0-9]{2}){2}"/> Format: YYYY-MM-DD<br/></pre>
                <pre>Start Time:        <input type='text' value='' id='startTime' pattern="[0-9]{4}"/> Military time (9:00a is 0900 and 9:00p is 2100)<br/></pre>
                <pre>End Time:          <input type='text' value='' id='endTime' pattern="[0-9]{4}"/> Military time (3:00a is 0300 and 3:00p is 1500)<br/></pre>
                <p>Student Email: </p>
            </div>
            <div id="textboxes"></div>
            <div id="button" onclick="store()">
                <button type="submit" class="resizedButton">Submit</button>
                <input type="hidden" name="id" id="id" value="">
                <input type="hidden" name="date" id="date" value=""> <br/> <br/>
            </div>
        </form>
    </body>
</html>