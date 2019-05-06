/*
    This file contains various funtions for the 
    website to function as intended.
*/

var courseList = []; //global couse list to be used in multiple functions

//stores course list on page load
function onLogin(userEmail){
    var db = firebase.database().ref();
    db.child("ProfessorClassList").orderByValue().equalTo(userEmail).once("value", function(snapshot){
        snapshot.forEach(function(data) {
            courseList.push(data.key);
        });
    });
}

//shows the list of courses after button click
function showList(){
    for(var i = 0; i < courseList.length; i++){
        var tree = document.createDocumentFragment();
        var li = document.createElement("li");
        var link = document.createElement("a");
        link.setAttribute("id", "link"+(i+1));
        link.setAttribute("href", "CourseTable.php?value_key="+courseList[i]);
        link.setAttribute("class", "buttonLink")
        link.appendChild(document.createTextNode(courseList[i]));

        tree.appendChild(link);
        li.appendChild(tree); 
        document.getElementById("courseList").appendChild(li);
    }
}