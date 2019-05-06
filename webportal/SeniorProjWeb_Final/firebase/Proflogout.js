/*
    This file contains state change and
    logout functionality for the logout buttons.
*/
firebase.auth().onAuthStateChanged(function(user){
    if(user){
        
    }else{
        window.location = "ProfLogin1.php";
    }
});

function logout(){
    firebase.auth().signOut().then(function(){
        
    }).catch(function(error){
        window.alert("Error: " + error);
    });
}
