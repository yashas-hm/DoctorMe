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
| <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(1).png" width="200" alt="APP SS1"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(2).png" width="200" alt="APP SS1"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(9).png" width="200" alt="APP SS1"/> |  

#### Signup

When new user signup page text is clicked from login screen then this page is presented. This page has an option to
choose between patient and doctor signup. When switch is on patient side then entries are displayed to fill up patient
information. When switch is on doctor side then entries are displayed to fill doctor information.

Signup page has email and password validation done using regular expression.

| Signup Page | Screenshot 1 |
| :---: | :---: |
| <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(7).png" width="200" alt="APP SS1"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(8).png" width="200" alt="APP SS1"/> | 

#### Doctor Screen

| Doctor Screen | Options | Doctor Details |
| :---: | :---: | :---: |
| <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(4).png" width="200" alt="APP SS1"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(5).png" width="200" alt="APP SS1"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(6).png" width="200" alt="APP SS1"/> |  

#### Patient Screen

| Patient Screen | Options | Patient Details |
| :---: | :---: | :---: |
| <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(10).png" width="200" alt="APP SS1"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(11).png" width="200" alt="APP SS1"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(12).png" width="200" alt="APP SS1"/> |  

#### Limitations

- I have disabled the show by location option as on signup the location is automatically taken by gps and dummy data
  doesn't have any location else the feature is working perfectly.
- Messaging using SMS Provider is not working as all online SMS APIs are paid, I couldn't find any open source free API
  to implement. For now, I have implemented a button when on pressed will open sms app with prefilled data to send to
  the contact. 