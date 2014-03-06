/*******************************************************/
////////////////////////////////////////////////////////
/* ----- GOOGLE AdMob SETUP ------ */

#define k_ADMOB_UnitID @"GOOGLE-ADMOB-SIGN"

// Finish Admob setup
/*******************************************************/
////////////////////////////////////////////////////////






/*******************************************************/
////////////////////////////////////////////////////////

 /* ----- CHART BOOST SETUP ------ */
#define k_chartboost_appID @"4f21c409cd1cb2fb7000001b"
#define k_chartboost_appSignature @"92e2de2fd7070327bdeb54c15a5295309c6fcd2d"
// Finish chart boost setup
/*******************************************************/
////////////////////////////////////////////////////////





/*******************************************************/
////////////////////////////////////////////////////////
/* ------- Game Center Setup ------- */

#define k_leaderbord_ARCADE_Mode @"bugscrusher_arcade"
#define k_leaderbord_ZEN_Mode @"bugscrusher_zen"

// finish game center

/*******************************************************/
////////////////////////////////////////////////////////







/*******************************************************/
////////////////////////////////////////////////////////
/* choose what kind of ADS would like to show in the game */

/*
 k_DISABLE_AD
 k_iAD_ACTIVE
 k_CHARTBOOST_ACTIVE
 k_ADMOB_ACTIVE
*/

#define k_app_comes_with_this_Ad k_ADMOB_ACTIVE

//finish choosing.

/*******************************************************/
////////////////////////////////////////////////////////








/*******************************************************/
////////////////////////////////////////////////////////
/* ------- In-App Purchase ------- */
#define k_Remove_ADS_Product @"bugscrusher_remove_all_ads"

// finish In-App Purchase
/*******************************************************/
////////////////////////////////////////////////////////






/*******************************************************/
////////////////////////////////////////////////////////
/* ------------ SOCIAL AND EMAIL AREA ---------------- */


// %20 = it means space, you can't write like this : "Bug Crusher Game", you must write like this.
#define  k_EmailAddress  @"sdickson9740@me.com" // change it to your email address
#define  k_EmailSubject  @"KillaBug%20Game"


#define k_facebook_page_follow_profile_ID @"https://fb.com/your_profile_number" // It's because when the facebook app was installed, It'll open in the facebook application instead of browser.
#define k_facebook_page_follow_link @"https://fb.com/yourpage" // it's your page link

#define k_twitter_link @"https://www.twitter.com/awesomeapps7"

#define k_google_plus_link @"http://plus.google.com/link"


// Finish social and email area
////////////////////////////////////////////////////////
/*******************************************************/






////////////////////////////////////////////////////////
/*******************************************************/
/* ------------ SHOWING REATE US ---------------- */
// AFTER HOW MANY PLAYS WOULD YOU LIKE TO SHOW, REATE US!

#define k_MANY_AFTER_GAME_RATE 2

// always it's itunes links
#define k_OPEN_LINK_FOR_RATING @"itunes-link"

// FINISH SHOWING RATE US
////////////////////////////////////////////////////////
/*******************************************************/




////////////////////////////////////////////////////////
/*******************************************************/
/* ------------ SHOWING REATE US ---------------- */
// AFTER HOW MANY BUGS WOULD YOU LIKE TO SHOW OVER THE GAME.
// 0 means never
#define k_LOSE_AFTER_BUGS_PASSED 2

// FINISH SHOWING RATE US
////////////////////////////////////////////////////////
/*******************************************************/





/* Don't change these values ///  Don't change these values /// Don't change these values */
/* DEFINE VALUES */

#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define MAIN_WIDTH  self.view.frame.size.width
#define MAIN_HEIGHT self.view.frame.size.height

#define k_DISABLE_AD 0
#define k_iAD_ACTIVE 1
#define k_CHARTBOOST_ACTIVE 2
#define k_ADMOB_ACTIVE 3

#define K_cockroach 1
#define K_ant 2
#define K_ladybird 3
