var numStudents; 


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
    var input = [];
    input[0] = document.getElementById('email').value;
    input[1] = document.getElementById('crsName').value;
    input[2] = document.getElementById('rmID').value;
    input[3] = document.getElementById('crsDay').value;
    input[4] = document.getElementById('crsTime').value;

    roster = {}
    for(i = 0; i < (numStudents); i++){
        var p = "stud"+(i+1);
        var e = "email"+(i+1);
        input[i+5] = document.getElementById(p).value;
        roster[e] = input[i+5];
    }
    

    firebase.database().ref('Professors/'+input[0]+'/'+input[1]+'/').set({
        roomID: input[2],
        crsDay: input[3],
        crsTime: input[4],
        roster
    });
    var x = ""+input.toString();
    document.getElementById("demo").innerHTML = x;
}
//login page authentication check function
function validateForm() {
    var un = document.loginform.usr.value;
    var pw = document.loginform.pword.value;
    //place holder authentication
    var username = "NCAT";
    var password = "abcd1234";
    if ((un == username) && (pw == password)) {
        return true;
    }
    else {
        alert ("Login was unsuccessful, please check your username and password");
        return false;
    }
    // firebase.auth().signInWithEmailAndPassword(un, pw).catch(function(error) {
    //     // Handle Errors here.
    //     var errorCode = error.code;
    //     var errorMessage = error.message;
    //     // ...
    //   });
}

// Initialize Firebase
// TODO: Replace with your project's customized code snippet

// var database = firebase.database();
/*function onload() {
    firebase.initializeApp(config);
    var database = firebase.database();
};*/