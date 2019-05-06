# Tap For Here: NFC Attendance Taking
Tap for Here’s mission is to create a simple to use smartphone application for students to count themselves as attended for their classes while at the same time giving professors convenience and access to creating and viewing updated attendance records.

# Dependencies
**Currently the only devices we are supporting are iPhones 7 and newer, Android is planned to come later**<br>
`Firebase` <br>
`Composer` <br>
`XAMPP` is what we used but you are free to use whatever server you want <br>
`XCode`<br>

# Installation
In order to use both the iOS application and the website portal you will need to install the dependencies above first.  Once you have them installed you should be able to clone this repo onto your computer with <br>
`git clone https://github.com/Austincw/Tap-For-Here`
<br>
<br>
Now that you have the project on your computer you should be able to open the xcode workspace file in XCode just fine to then install to your iOS device(Make sure it is an iPhone 7 or newer)
<br>
<br>
For installing the webportal, first you will want to get the contents that are within the webportal folder.  This is where you want to have `composer` downloaded and installed on your computer in order to run the files within this folder.  The directory should be as follows: `webportal/SeniorProjWeb_Final/firebase`.  It is recommended to open the `SeniorProjWeb_Final/` directory in your IDE/Editor of choice to begin editing the html, php, and JS files.  **Everything inside of the `SeniorProjWeb_Final/firebase/` folder is needed in order to be firebase capable in php.**  Please make sure not to edit any files inside the vendor, secret, and .idea folders.
<br>
<br>
# User Manual
### iOS Application
Once you have the application on your phone usage is pretty straight forward.  
1. Fire make sure that your professor has created your course first before attepting to fully use the application.  
2. After they have, you must register on the application first with a little bit of information.  
3. Once you have registed, the `register` button will be replaced with `view classes`.  Now you will be able to view the courses that have the ability to use the application.  
4. When you are entering a classroom with the "Tap for Here" feature you will tap the icon on the home screen which will the prompt you to scan a tag.  When the tag gets scanned thats all there is to it!  You should be recorded down for attendance unless your professor hasn't created your course yet in the portal

### Professor Web Portal 

When you have the portal up and running on your server follow these instructions to add a new course.
1. First you will need to sign in with credentials that are given to you by us, you must request to be given access to the web portal.  This is to make sure everything is as secure as possible.  
2. Once you are given crendentials and sign in you will see two options to view current course list and create a new course.  Both are pretty self explanatory.  Under create a new course you will asked to fill out a form with the course you intend to add for your students to take advantage of this application.  
3. When you have created a course, these courses will appear when you press the `view course list` button.  This will show you a list of the courses you have created which also double as a link to that courses attendance record list.
4.  When you select a course from the current course list, you will have the option to select the date you want to see the attendance record for.  The names of the students and the and whether they have been recorded for attendance or not will display in the form of a table for easier viewing.
