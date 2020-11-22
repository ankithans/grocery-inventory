# grocery-inventory

## 🔗 Links
- [Grocery-inventory apk](https://github.com/ankithans/help-me/)
- [Backend API](https://grocery-invent.herokuapp.com/)
- [API documentation](https://documenter.getpostman.com/view/11391372/TVetcSDt)
- [Video Explanation](https://vimeo.com/)

## 📊 Flow Diagram
<img src="https://github.com/ankithans/grocery-inventory/blob/main/abc.png">

## ❓ Problem Statement
> When we go to the market we are often confused that if the item is needed or not. Sometimes we buy items that were already there in the home. To solve that particular problem we have created an application that queries in your home grocery invetory database and tell that if the item is their in the house or not and if available how much quantity is available. Then user can buy it accordingly.

## 🤔 Challenges we faced
- searching item in the database based on the tags given by google vision api
- using google cloud as it was the first time we used it in any project

## 💡 features
- simple and fast google authentication
- user can search items in their home(inventory) by clicking a picture
- user can set remaining amount of item
- make shopping list (comming soon)


## 💻 samples:

<img src="" width="250"> &nbsp;&nbsp;&nbsp;&nbsp; <img src="" width="250" style="float:right"> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; <img src="" width="250">

<img src="" width="250"> &nbsp;&nbsp;&nbsp;&nbsp; <img src="" width="250" style="float:right"> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; <img src="" width="250">

<img src="" width="250"> &nbsp;&nbsp;&nbsp;&nbsp; <img src="" width="250" style="float:right"> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; <img src="" width="250">

## 👣 steps to run the project
- clone the repo in your local machine
- do ```yarn``` in root directory
- do ```flutter pub get``` in ```client``` folder
- add firebase to your flutter project and google-service-account.json in your root directory
- add MONGO_URI, JWT_SECRET in your .env
- do ```yarn dev``` in the root directory and your backend is up and running
- do ```flutter run``` in ```client``` and your app will start with no issues

## Tech Stacks & dependencies
##### 🤖 Backend
- node with typescript
- mongodb
- google vision
- google cloud storage
- Heroku

##### 🌟 Frontend
- Flutter for cross-platform application  
- [dio](https://pub.dev/packages/dio)
- [firebase](https://pub.dev/packages/firebase)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [path](https://pub.dev/packages/path)
- [image_picker](https://pub.dev/packages/image_picker)
- [provider](https://pub.dev/packages/provider)
- [google_sign_in](https://pub.dev/packages/google_sign_in)

## made with 💕 by: 
- [Ankit Hans](https://github.com/ankithans)
- [Sagnik Biswas](https://github.com/sbiswas2209)
