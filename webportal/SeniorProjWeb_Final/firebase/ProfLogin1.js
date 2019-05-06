/*
    This file contains state change and login function for 
    website authentication.
*/
firebase.auth().onAuthStateChanged(function(user){
    if(user){
        window.location.href = "Profportal1.php";
        
    }else{
    
    }
});

function login(){
    var userEmail = document.getElementById("email_val").value;
    var userPass = document.getElementById("password_val").value;
    
    firebase.auth().signInWithEmailAndPassword(userEmail, userPass).catch(function(error){
        
        var errorCode = error.code;
        var errorMessage = error.message;

        window.alert("ErrorXU: " + errorMessage);
    });
}
