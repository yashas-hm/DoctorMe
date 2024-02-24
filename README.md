# 🩺 DoctorMe 📱

### Features 🚀

1) **User SignUp/SignIn**
2) **Doctor SignUp/SignIn**
3) **Find medical services near your location**
4) **Messaging with the service provider**

### Disclaimer 📝

This app serves as an MVP and not a full-fledged user-end app. I've integrated and built everything using local resources; however, a user-end app would typically utilize an online database instead of a localized one.

### Flow of the App 🌊

#### Login 🚪

Upon initial launch, the Login page prompts users to enter their user ID (email) and password. New users can sign up via the signup option.

Upon successful login, the screen redirects to either the Patients Accept Page or the Doctor Choice Page, depending on the user type. Doctors are directed to the Patient Accept Page, while patients are directed to the Doctor Choice Page.

| Login Page | Successful Login |
| :---: | :---: |
| <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(1).png" width="200" alt="Login Page"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(9).png" width="200" alt="Successful Login"/> |

#### Signup 📝

Clicking on the signup option from the login screen directs users to the signup page. Here, users can choose between patient and doctor signup. The page dynamically updates based on the selected option, allowing users to fill in the required information.

Email and password validation are performed using regular expressions.

| Signup Page - Patient | Signup Page - Doctor |
| :---: | :---: |
| <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(7).png" width="200" alt="Signup Page - Patient"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(8).png" width="200" alt="Signup Page - Doctor"/> |

#### Doctor Screen 👨‍⚕️

| Doctor Screen | Options | Doctor Details |
| :---: | :---: | :---: |
| <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(4).png" width="200" alt="Doctor Screen"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(5).png" width="200" alt="Options"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(6).png" width="200" alt="Doctor Details"/> |

#### Patient Screen 👩‍⚕️

| Patient Screen | Options | Patient Details |
| :---: | :---: | :---: |
| <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(10).png" width="200" alt="Patient Screen"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(11).png" width="200" alt="Options"/> | <img src="https://raw.githubusercontent.com/yashas-hm/DoctorMe/master/Screenshots/app%20(12).png" width="200" alt="Patient Details"/> |

### Limitations 🛑

- The "show by location" option is disabled as the app automatically fetches location data upon signup. However, the feature is fully functional.
- Messaging via SMS Provider is not operational due to the unavailability of free APIs. Instead, a button is implemented to open the SMS app with prefilled data for the user to send to the contact.

