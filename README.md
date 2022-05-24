# DoctorMe

## Android Development Internship: Rhett Healthcare

Features

1) User SignUp/SignIn
2) Doctor SignUp/SignIn
3) Find medical services near your location
4) Messaging with the service provider

Disclaimer:<br>
<p>
This is an MVP app not a user end app, so I have integrated and built everything that uses 
local resources a user end app would have an online database instead of a localised database.</p>

## Flow of the app

#### Login

First time when the app runs the Login page opos up, it has entries to enter user id (email) and password. Below that is
the option for a new user to signup.

When correct id and password are entered, crosschecked by the database, then the screen is redirected to Patients Accept
Page or Doctor Choice Page depending on the user. If a doctor logs in then Patient Accept Page will open up, else if a
patient logs in, doctor choice page opens up.

| Login Page | Screenshot 1 | Login Success |
| :---: | :---: | :---: |
| <img src="" width="100" alt="APP SS1"/> | <img src="" width="100" alt="APP SS1"/> | <img src="" width="100" alt="APP SS1"/> |  

#### Signup

When new user signup page text is clicked from login screen then this page is presented. This page has an option to
choose between patient and doctor signup. When switch is on patient side then entries are displayed to fill up patient
information. When switch is on doctor side then entries are displayed to fill doctor information. 

Signup page has email and password validation done using regular expression.

| Signup Page | Screenshot 1 | Success |
| :---: | :---: | :---: |
| <img src="" width="100" alt="APP SS1"/> | <img src="" width="100" alt="APP SS1"/> | <img src="" width="100" alt="APP SS1"/> |  

#### Doctor Screen

| Doctor Screen | Options | Doctor Details |
| :---: | :---: | :---: |
| <img src="" width="100" alt="APP SS1"/> | <img src="" width="100" alt="APP SS1"/> | <img src="" width="100" alt="APP SS1"/> |  


#### Patient Screen

| Patient Screen | Options | Patient Details |
| :---: | :---: | :---: |
| <img src="" width="100" alt="APP SS1"/> | <img src="" width="100" alt="APP SS1"/> | <img src="" width="100" alt="APP SS1"/> |  
