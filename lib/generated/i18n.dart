import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class S implements WidgetsLocalizations {
  const S();

  static S? current;

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  static S? of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Naveli";

  String get plEnterEmail => "Please enter E-mail";

  String get plEnterEmailOrMobile => "Please enter E-mail Or Mobile";

  String get plEnterValidEmail => "Please enter valid email address";

  String get noInternet => "No internet";

  String get doYouKnow => "Do you know?";

  String get update => "Update";

  String get here => "Here";

  String get letKnowYou => "Let's know you better!";

  String get enterYourName => "Enter your name";

  String get plSelectYourGender => "Please select your gender";

  String get plEnterName => "Please enter name";

  String get nutrition => "Nutrition";

  String get download => "Download PDF";

  String get reports => "Graphs & Reports";

  String get askYourQuestion => "Ask your Question";

  String get queOfDay => "Question of the Day";

  String get plWriteQue => "Please write your Question";

  String get plSelectYourMedicine => "Please select your medicines";

  String get plSelectTs => "Please accept terms of service";

  String get plSelectPrivacy => "Please accept privacy policy";

  String get ailments => "Ailments";

  String get plSelectYourRelation => "Please select your relationship status";

  String get plEnterMobile => "Please enter mobile no.";

  String get plSelectSleepTime => "Please select your sleep time";

  String get plWakeUpSleepTime => "Please select your wake up time";

  String get plFeelAnswer => "Please feel all questions answers";

  String get plSelectMedicine => "Please select medicine";

  String get plSelectAilment => "Please select ailment";

  String get plAddComment => "Please add comment";

  String get plEnterHamAapkeKon => "Please enter hum aapke hain kaun";

  String get plEnterAge => "Please enter age";

  String get selectOption => "Select an option below";

  String get like => "Like";

  String get dislike => "Dislike";

  String get plEnterHeight => "Please enter height";

  String get plSelectWeight => "Please select weight";

  String get plSelectPreviousPeriodDate => "Please your previous periods date";

  String get userDataSyncFailed => "User data sync failed";

  String get plSelectYourBday => "Please select your birth date";

  String get plEnterValidOtp => "Please enter valid OTP";

  String get mythVsFacts => "Myth vs facts";

  String get logYourSymptoms => "Log your symptoms";

  String get womenInNews => "NeoW in News";

  String get oops => "Network Error";

  String get allAboutPeriods => "All about periods";

  String get plEnter10DigitsMobile => "Please enter 10 Digits mobile no.";

  String get plSelectUserType => "Please select user type";

  String get plEnterPassword => "Please enter password";

  String get sleep => "Sleep";

  String get pco => "PCO";

  String get pms => "PMS";

  String get share => "Share";

  String get comment => "Comment ";

  String get welcomeForum => "Welcome to NeoW’s Forum";

  String get water => "Water";

  String get follow => "Follow";

  String get settings => "Settings";

  String get profile => "Profile";

  String get welcomeToOurForum => "Welcome to Our Forum";

  String get kg => "Kg";

  String get hamAapkeKon => "Hum Aapke hain Kaun!";

  String get naveliUniqueId => "Naveli’s Unique ID";

  String get gender => "Gender";

  String get secretDiary => "Secret Diary";

  String get healthMix => "Health Mix";

  String get reminder => "Reminder";

  String get hisutism => "Hirsutism";

  String get dataNotFound => "data not found";

  String get contactNoNotAvailable => "Contact number not available.";

  String get locationService => 'Location service';

  String get waterReminder => 'Water Intake';

  String get logYourWeight => 'Log Your Weight';

  String get logYourSleepHour => 'Log Your Sleep hour';

  String get width => 'Width';

  String get areYouSure => 'Are you sure?';

  String get thisActionPermanentlyDelete =>
      'This action will permanently delete this album';

  String get min => 'Min';

  String get height => 'Height';

  String get track => 'Track';

  String get age => 'Age';

  String get locationPermission => 'Location permission';

  String get plEnableLocationService =>
      'Please enable location service to get current location.';

  String get plAllowLocationPermission =>
      'Please allow location permission to get current location.';

  String get enableService => 'Enable service';

  String get allowPermission => 'Allow permission';

  String get done => 'Done';

  String get online => "You are online now";

  String get periodsInformation => "Periods Information";

  String get superWomen => "Super Women";

  String get offline => "You are offline now";

  String get login => "Login";

  String get medication => "Medication";

  String get signUp => "SignUp";

  String get alreadyHave => "Already have an account? LogIn";

  String get dontHave => "Don't have an account? SignUp";

  String get forgotPassword => "Forgot password";

  String get wesupport =>
      "We support all forms of gender expression. However, we need this to calculate your body metrics";

  String get yourgender => "Whats your gender vibe? fam?";

  String get relationshipStatus => "Relationship Status";

  String get yourJourney => "Your journey in candles?";

  String get selectDate => "Select Date";

  String get name => "Name";

  String get other => "Other";

  String get enterOtherGender => "Enter other gender";

  String get female => "Female";

  String get selectAny => "Select any one in below ";

  String get whoAreYou => "Who are you ?";

  String get neowMe => "Neow";

  String get buddy => "Buddy";

  String get cycleEnthu => "Cycle Enthusiast";

  String get emailOrPhone => "E-mail or Phone No.";

  String get password => "Password";

  String get welcomeToNewYou => "Welcome to New You!";

  String get welcome =>
      "We'll ask you a few questions to help personalize your experience. ";

  String get yoQuickSurvey => "Yo, Quick survey time- Help us level up";

  String get myDailyInsights => "My daily insights - Today";

  String get yourFabulousName => "Your Fabulous name, please";

  String get neowmeName => "Neowme, Naam to";

  String get sunaHoga => "suna hi hoga";

  String get email => "Email";

  String get phone => "Phone No.";

  String get submit => "Submit";

  String get willAsk =>
      "We'll ask you a few questions to help personalize your experience.";

  String get resendOtp => "Resend OTP";

  String get requestOtp => "Request for new OTP in";

  String get seconds => "seconds";

  String get enterYourOtp => "Enter Your OTP";

  String get beforeWeGet => "Before we get started";

  String get yatriGanDhyanDe => "Yatrigan Kripya Dhyaan dein";

  String get pleaseAsk =>
      "Please ask your parent or guardian to help you set up your NeoW account.";

  String get asYouAre =>
      "As you're younger than 16 years old. we're legally required to ask a parent or guardian for:";

  String get theirPermission => "Their permission for you to use the NeoW app.";

  String get theirHelp => "Their help to set up your privacy settings";

  String get accept => "Accept";

  String get next => "Next";

  String get sleepNow => "Sleep Now";

  String get apply => "Apply";

  String get quiz => "Quiz";

  String get knowYourBody => "Know your body";

  String get myDashboard => "My Dashboard";

  String get weight => "Weight";

  String get calculateBmi => "Calculate BMI";

  String get bmiScore => "BMI Score";

  String get normal => "Normal";

  String get bmi => "BMI";

  String get decline => "Decline";

  String get removeAccess => "Remove access";

  String get bmiCalculator => "BMI Calculator";

  String get youAndClue => "You and Clue";

  String get wePromise =>
      "We promise to keep your data safe, secure and private. Please take a moment to get to know our policies.";

  String get iAgree => "I agree to NeoW's  ";

  String get termsOfServices => "Terms Of Service.";

  String get iHaveReadClue => "I have read NeoW’s  ";

  String get privacyPolicy => "Privacy Policy.";

  String get iAgreeProcessing =>
      "I agree to Clue processing the health data I choose to share with the app, so they can provide their service.";

  String get iShowedAbove =>
      "I showed the above policies to my parent/guardian. and they agreed I could use Clue and that Clue could process my health data.";

  String get quickSurvey => "Yo, Quick survey time- Help us level up";

  String get averageCycle => "Average cycle length (Days)";

  String get whenDidYour => "When did your last periods begin?";

  String get averagePeriod => "Average period length (Days)";

  String get letsSprinkle => "Let’s sprinkle some magic together";

  String get iDontRemember => "I don’t Remember";

  String get date => "Date";

  String get days => "Days";

  String get getReminder => "Get reminders about your cycle";

  String get stayYourPeriod => "Stay unstoppable, even during your period!";

  String get nightReminder => "Night Reminder Time";

  String get cancel => "Cancel";

  String get delete => "Delete";

  String get ok => "Ok";

  String get setReminder => "Set Reminder";

  String get mood => "Mood";

  String get or => "or";

  String get plSelectState => "Please select your state!";

  String get plSelectCity => "Please select your city!";

  String get male => "Male";

  String get edit => "Edit";

  String get accepted => "Accepted";

  String get transgender => "Transgender";

  String get otherPlSpec => "Other, please specify";

  String get solo => "Solo";

  String get tied => "Tied";

  String get sendRequest => "Send request";

  String get openForSur => "Open For Surprises";

  String get yourBDayHelp =>
      "(Your birthdate helps us tailor the app for you!)";

  String get numberOfDays => "Number of days between two periods?";

  String get howLongDosePeriod => "How long does your period last?";

  String get neowInNews => "NeoW in News";

  String get quickQuestion => "Quick Question";

  String get periodMedication => "Period Medication";

  String get deStress => "De-Stress";

  String get healthMixLatest => "Health Mix - Latest";

  String get latest => "Latest";

  String get expertAdvice => "Expert Advice";

  String get cycleWisdom => "Cycle Wisdom";

  String get grooveWithNeow => "Groove with neow";

  String get testimonials => "Testimonials";

  String get funCorner => "Fun corner";

  String get calebSpeaks => "Celeb Speaks";

  String get avgSleepTime => "Average sleep time";

  String get empowHer => "EmpowHer";

  String get interest => "Interest";

  String get dashboard => "Dashboard";

  String get aboutUs => "About us";

  String get help => "Help";

  String get rateUs => "Rate and Review";

  String get logout => "Logout";

  String get home => "Home";

  String get forum => "Forum";

  String get flow => "Flow";

  String get staining => "Staining";

  String get low => "Low";

  String get medium => "Medium";

  String get high => "High";

  String get clotSize => "Clot size";

  String get small => "Small";

  String get accountAccess => "Account access";

  String get yourNaveli => "Your Naveli";

  String get large => "Large";

  String get pain => "Pain";

  String get workingAbility => "Working ability";

  String get always => "Always";

  String get almostAlways => "Almost Always";

  String get almostNever => "Almost Never";

  String get none => "None";

  String get location => "Location";

  String get periodCramps => "Period Cramps";

  String get noHurt => "No Pain";

  String get hurtLittleBit => "Little";

  String get hurtMore => "Bad";

  String get hurtWorst => "Severe";

  String get collectionMethod => "Collection Method";

  String get sanitaryPads => "Sanitary Pads";

  String get cloth => "Cloth";

  String get period_panty => "Period Panty";

  String get tampons => "Tampons";

  String get cups => "Cups";

  String get relaxed => "Relaxed";

  String get sad => "Sad";

  String get energy => "Energy";

  String get lively => "Lively";

  String get irritated => "Irritated";

  String get stress => "Stress";

  String get moderate => "Moderate";

  String get acne => "Acne";

  String get minimal => "Minimal";

  String get rejected => "Rejected";

  String get severe => "Severe";

  String get add => "Add";

  String get lbs => "Lbs";

  String get cm => "Cm";

  String get ft => "Ft";

  String get bedTime => "BedTime";

  String get wakeUpTime => "WakeUp Time";

  String get sleepTime => "Sleep time";

  String get hr => "Hr";

  String get reminderFor => "Reminder For";

  String get selectState => "Select State";

  String get selectDistrict => "Select District";

  String get zodiac => "Zodiac";

  String get selectYourWeight => "Select your weight";

  String get enterNaveliUid => "Enter naveli's Unique Id";

  String get trackYourWeight => "Track your weight and achieve your goals.";

  String get verificationFailed => "verification failed please try again!";

  String get newomeDescription =>
      "I am anyone who has periods and wants to understand my body better while staying healthy.";

  String get cycleDescription =>
      "I am an individual seeking to understand more about periods and overall health and wellness.";

  String get buddyDescription =>
      "I am a partner or guardian who wants to monitor my Neowme's health using her unique buddy code.";

  String get alreadySentRequest =>
      "You have already sent request to another naveli";

  String get keepTrackOfWater =>
      "Keep track of your water intake and set reminders to stay hydrated and healthy";

  String get freqOfChange => "Frequency of Change in a Day";

  String get neverMissADate =>
      "Never miss a date! Stay effortlessly organized by setting dates, events, and tasks with ease.";

  String get aajMainUpar => "Aaj Main Upar Asman Neeche";

  String get whatTimeDoGoBed => "What time do you usually go to bed?";

  String get plEnterUid => "Please enter Unique Id";

  String get plSlReminderDate => "Please select reminder date";

  String get plSlReminderType => "Please select reminder type";

  String get plSlReminderFor => "Please enter reminder for";

  String get whatTimeWakeUp =>
      "What time do you usually wake up in the morning?";

  String get yeDukhKaahe => "Ye dukh kaahe khatam nahi hota hai";

  String get plSelectWeightType => "Please select weight type";

  String get trackAndConquer => "Track and conquer your ailments";

  String get monitorYourBmi =>
      "Monitor your BMI for insights into your overall health and body composition";

  String get howManyDays => "How many days you experience severe pain?";

  String get effortlesslyTrack =>
      "Effortlessly track your medication! Set reminders to monitor your progress with ease.";

  String get howManyTimesYou =>
      "How many times you change your pad/ panty/ cup/ tampon/ others daily?";

  String get exploreTheHidden => "Explore the hidden wonders about your body?";

  String get capacityToPerform =>
      "Capacity to perform tasks effectively while on periods";

  String get uncoveringTruth => "Uncovering Truths and Solving Misconceptions";

  String get decodingPeriod => "Decoding Periods: All you need to know!";

  String get plSelectHirsutism => "Please all hirsutism!";

  String get leadingLadies => "Leading Ladies- : Women Making Headlines";

  String get questionOfDay => "Question of the Day";

  String get periodPainCan =>
      "Period pain can occur in various locations including the lower abdomen, lower back,thighs, etc. How many places does it hurt?";

  String get underStandYourBody =>
      "Understand Your Body Better: Track Symptoms During Your Period";

  String get ifYouHave =>
      "If you have any burning questions, don't hesitate to ask! Our experts are here to provide answers";

  String get eatGlowRepeat =>
      "Eat, Glow, Repeat: Yummy nutrition tips from our experts";

  String get welcomeToNeow =>
      "Welcome to Neow’s Forum- Hey New Women! Welcome to the Neow’s Forum. Engage in insightful discussions, find support, and be inspired to thrive  in every aspect of your life. Join us to connect, grow, and celebrate the journey of womanhood together!";

  String get welcomeToSecret =>
      "Welcome to Secret Diary, your personal space for thoughts, dreams and reflections. Express yourself freely and unlock the power of self-discovery.";

  /// new ///

  String get deActiveYourAcc => "Deactivate your Account";

  String get metricSystem => "Metric system!";

  String get yes => "Yes";

  String get no => "No";

  String get music => "Music";

  String get learning => "Learning";

  String get bodyCare => "Body care";

  String get gratitude => "Gratitude";

  String get workout => "Workout";

  String get hangout => "Hangout";

  String get screenTime => "Screen time";

  String get food => "Food";

  String get cleaning => "   Cleaning   ";

  String get periodDate => "Period date";

  String get cycleLength => "Cycle length";

  String get periodLength => "Period length";

  String get askMeAny => "Hi! You Can Ask Me\nAnything";
  String get announcements => "Announcements ";

  String get askNow => "Ask Now";
  String get check => "Check Now";

  String get goals => "Goals";

  String get addGoals => "Add Goals";

  String get yourGoals => "Your Goals";

  String get dailyDiary => "Daily Diary";

  String get hobbies => "Hobbies";

  String get addHobbies => "Add Hobbies";

  String get yourHobbies => "Your Hobbies";

  String get toDoList => "To Do List";

  String get habitToCut => "Habits to cut";

  String get addHabitsCut => "Add Habits cut";

  String get yourHabits => "Your Habits";

  String get addHabitsAdopt => "Add Habits adopt";

  String get habitsToAdopt => "Habits to adopt";

  String get newThingsToTry => "New things to try";

  String get addThings => "Add Things";

  String get bookToRead => "Books to Read";

  String get addBook => "Add Book";

  String get yourBookToRead => "Your Books to Read";

  String get movieToWatch => "Movies to watch";

  String get addMovies => "Add Movies";

  String get yourThings => "Your Things";

  String get familyGoals => "Family Goals";

  String get yourFamilyGoals => "Your Family Goals";

  String get yourMovieToWatch => "Your Movies to watch";

  String get placeToVisit => "Places to Visit";

  String get yourPlacesToVisit => "Your Places to Visit";

  String get makeAWish => "Make a Wish";

  String get addYourWish => "Add your wish";

  String get addPlaces => "Add Places";

  String get reflection => "Reflection";

  String get goalsAchieved => "Goals Achieved";

  String get quote => "Quote";

  String get month => "Month";

  String get year => "Year";

  String get glass => "glass";

  String get goalsYetToAchieved => "Goals - Yet to Achieve";

  String get unlockTheSecrets => "Unlock the secrets of your cycle!";

  String get mainFocusOfMonth => "Main Focus of the Month";

  String get doubleTapOnBox => "Double Tap on box and write your wish";

  String get max250Char => "(Max. 250 Character)";

  String get max100Char => "(Max. 100 Character)";

  String get monthlyMission => "Monthly Mission";

  String get yeDinYeMahine => "Ye Din, Ye Mahine, Saal !";

  String get rakhnaHaiKhyaal => "Rakhna Hai Apna Khayaal";

  String get targetsMet => "Targets met ?";

  String get monthlyReminder => "Monthly Reminder";

  String get reminderDate => "Reminder Date ";

  String get reminderType => "Reminder Type ";

  String get mainFocus => "Main Focus of the Month";

  String get addYourBullet => "add your bullet point for your to do list";

  String get itDoseNotMatter =>
      "It does not matter how slowly you go as long as you do not stop.";

  String get addYourSecret => "add your bullet point for your secret diary";

  String get reflectOnYour =>
      "Reflect on your monthly goals and achievements effortlessly and strive for progress each time!";

  String get symptomsHundredScore =>
      "You might have heavy Menstrual Bleeding. Get Yourself Examine For";

  String get symptomsPainScore =>
      "You might have Dysmenorrheal the Possible cause may be";

  String get kickOffMonthlyMission =>
      "Kick off your Monthly Missions effortlessly! Set and track goals for the month ahead. Stay motivated, organized, and achieve success with ease.";

  String get yourDailyDose =>
      "Your daily dose of joy! Record your thoughts, moments, and goals effortlessly. Let's make every day memorable together!";

  String get symptomsHundredOption =>
      "• FIBROIDS\n• CYST\n• ENDOMETRIAL POLYP\n• CANCER";

  String get symptomsPainOption =>
      "• ENDOMETRIOSIS\n• FIBROIDS\n• PELVIC INFECTIONS\n• CYST";

  String get whatsYourGender => "Whats your gender vibe? fam?";

  @override
  // TODO: implement reorderItemDown
  String get reorderItemDown => throw UnimplementedError();

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => throw UnimplementedError();

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => throw UnimplementedError();

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => throw UnimplementedError();
}

class $en extends S {
  const $en();
}

class $mr extends S {
  $mr();

  // hindi words start //

  @override
  String get appName => "नवेली";

  @override
  String get plEnterEmail => "कृपया ईमेल दर्ज करें।";

  @override
  String get plEnterEmailOrMobile => "कृपया ईमेल या मोबाइल नंबर दर्ज करें।";

  @override
  String get plEnterValidEmail => "कृपया वैध ईमेल पता दर्ज करें।";

  @override
  String get noInternet => "कोई इंटरनेट सेवा नहीं।";

  @override
  String get doYouKnow => "क्या आप जानते हैं?";

  @override
  String get update => "अद्यतन";

  @override
  String get here => "यहाँ";

  @override
  String get letKnowYou => "आइये आपको बेहतर जानते हैं!";

  @override
  String get enterYourName => "आपका नाम";

  @override
  String get plSelectYourGender => "कृपया अपना लिंग चुनें";

  @override
  String get plEnterName => "कृपया आपका नाम डाले";

  @override
  String get nutrition => "पोषण";

  @override
  String get download => "डाउनलोड पीडीऍफ़";

  @override
  String get reports => "रिपोर्ट्स";

  @override
  String get askYourQuestion => "अपना सवाल पूछें";

  @override
  String get queOfDay => "आज का प्रश्न";

  @override
  String get plWriteQue => "कृपया अपना सवाल लिखें";

  @override
  String get plSelectYourMedicine => "कृपया अपनी दवाओं का चयन करें";

  @override
  String get plSelectTs => "निृपया सेवा की शर्तों को स्वीकार करें।";

  @override
  String get plSelectPrivacy => "कृपया गोपनीयता नीति स्वीकार करें";

  @override
  String get ailments => "रोग";

  @override
  String get plSelectYourRelation => "कृपया अपनी संबंध स्थिति चुनें:";

  @override
  String get plEnterMobile => "कृपया मोबाइल नंबर दर्ज करें.";

  @override
  String get plSelectSleepTime => "कृपया अपने सोने का समय चुनें";

  @override
  String get plWakeUpSleepTime => "कृपया अपने जागने का समय चुनें";

  @override
  String get plFeelAnswer => "कृपया सभी प्रश्नों के उत्तर महसूस करें";

  @override
  String get plSelectMedicine => "कृपया दवा का चयन करें।";

  @override
  String get plSelectAilment => "कृपया बीमारी का चयन करें।";

  @override
  String get plAddComment => "कृपया अपना मंतव्य दें ।";

  @override
  String get plEnterHamAapkeKon => "कृपया अपने रिश्ते की जानकारी दें।";

  @override
  String get plEnterAge => "कृपया आयु चुनें";

  @override
  String get selectOption => "कृपया नीचे दिए गए विकल्प का चयन करें।";

  @override
  String get like => "पसंद";

  @override
  String get dislike => "नापसन्द";

  @override
  String get plEnterHeight => "कृपया लंबाई दर्ज करें।";

  @override
  String get plSelectWeight => "कृपया वज़न चुनें";

  @override
  String get plSelectPreviousPeriodDate =>
      "कृपया अपने पिछले मासिक धर्म  की तारीख दर्ज करें।";

  @override
  String get userDataSyncFailed => "उपयोगकर्ता डेटा समन्वयन विफल";

  @override
  String get plSelectYourBday => "कृपया अपनी जन्म तिथि का चयन करें।";

  @override
  String get plEnterValidOtp => "कृपया वैध ओटीपी दर्ज करें";

  @override
  String get mythVsFacts => "मिथक बनाम सच्चाई";

  @override
  String get logYourSymptoms => "अपने लक्षणों को बताएं।";

  @override
  String get womenInNews => "ख़बरों में NeoW";

  @override
  String get oops => "उफ़! कुछ गलत हो गया।";

  @override
  String get allAboutPeriods => "मासिक धर्म  को समझें";

  @override
  String get plEnter10DigitsMobile =>
      "कृपया 10 अंकों का मोबाइल नंबर दर्ज करें.";

  @override
  String get plSelectUserType => "कृपया उपयोगकर्ता का प्रकार चुनें।";

  @override
  String get plEnterPassword => "कृपया पासवर्ड दर्ज करें।";

  @override
  String get sleep => "नींद";

  @override
  String get pco => "PCO";

  @override
  String get pms => "PMS";

  @override
  String get share => "साझा करें";

  @override
  String get comment => "टिप्पणी";

  @override
  String get welcomeForum => "Neow's Forum में आपका स्वागत है";

  @override
  String get water => "पानी";

  @override
  String get follow => "अनुसरण करें";

  @override
  String get settings => "सेटिंग्स";

  @override
  String get profile => "प्रोफ़ाइल";

  @override
  String get welcomeToOurForum => "हमारे मंच में आपका स्वागत है।";

  @override
  String get kg => "किग्रा";

  @override
  String get hamAapkeKon => "हम आपके हैं कौन ?";

  @override
  String get naveliUniqueId => "नवेली की अनूठी पहचान";

  @override
  String get gender => "लिंग";

  @override
  String get secretDiary => "गुप्त डायरी";

  @override
  String get healthMix => "हेल्थ मिक्स";

  @override
  String get reminder => "स्मरण-पत्र";

  @override
  String get hisutism => "लोमश हिर्सुटिज़्म";

  @override
  String get dataNotFound => "डेटा नहीं मिला";

  @override
  String get contactNoNotAvailable => "संपर्क संख्या उपलब्ध नहीं है|";

  @override
  String get locationService => 'स्थान सेवा';

  @override
  String get waterReminder => 'पानी अनुस्मारक';

  @override
  String get logYourWeight => 'अपना वजन बताएं';

  @override
  String get logYourSleepHour => 'अपनी नींद के घंटे बताएं';

  @override
  String get width => 'चौड़ाई';

  @override
  String get areYouSure => 'क्या आपको यकीन है?';

  @override
  String get thisActionPermanentlyDelete =>
      'यह कार्रवाई इस एल्बम को स्थायी रूप से हटा देगी।';

  @override
  String get min => 'मिनट';

  @override
  String get height => 'ऊंचाई';

  @override
  String get track => 'ट्रैक करें';

  @override
  String get age => 'आयु';

  @override
  String get locationPermission => 'स्थान अनुमति';

  @override
  String get plEnableLocationService =>
      'वर्तमान स्थान प्राप्त करने के लिए कृपया लोकेशन सर्विस को सक्षम करें।';

  @override
  String get plAllowLocationPermission =>
      'वर्तमान स्थान प्राप्त करने के लिए कृपया लोकेशन परमिशन दें।';

  @override
  String get enableService => 'सेवा को सक्षम करें';

  @override
  String get allowPermission => 'अनुमति दें';

  @override
  String get done => 'हो गया';

  @override
  String get online => "आप अब ऑनलाइन हैं।";

  @override
  String get periodsInformation => "मासिक धर्म सम्बंधित सूचना";

  @override
  String get superWomen => "सुपर महिलाएँ";

  @override
  String get offline => "आप अब ऑफ़लाइन हैं";

  @override
  String get login => "लोग इन करें";

  @override
  String get medication => "इलाज";

  @override
  String get signUp => "साइन अप करें";

  @override
  String get alreadyHave => "पहले से ही अकाउंट है? लॉग इन करें";

  @override
  String get dontHave => "अकाउंट नहीं है? साइन अप करें";

  @override
  String get forgotPassword => "पासवर्ड भूल गए";

  @override
  String get whatsYourGender => "आपका लिंग क्या है?";

  @override
  String get relationshipStatus => "रिश्ते की स्थिति";

  @override
  String get yourJourney => "मोमबत्ती में आपका सफ़र?";

  @override
  String get selectDate => "तारीख़ चुनें";

  @override
  String get name => "नाम";

  @override
  String get other => "अन्य";

  @override
  String get enterOtherGender => "अन्य लिंग दर्ज करें";

  @override
  String get female => "महिला";

  @override
  String get or => "या";

  @override
  String get selectAny => "नीचे से कोई भी एक चुनें";

  @override
  String get whoAreYou => "आप कौन हैं?";

  @override
  String get neowMe => "Neow";

  @override
  String get buddy => "दोस्त";

  @override
  String get cycleEnthu => "साइकिल उत्साही";

  @override
  String get emailOrPhone => "ई-मेल या फोन नंबर|";

  @override
  String get password => "पासवर्ड";

  @override
  String get welcomeToNewYou => "New You! में आपका स्वागत है";

  @override
  String get welcome =>
      "हम आपसे कुछ सवाल पूछेंगे ताकि हम आपके अनुभव को व्यक्तिगत बना सकें।";

  @override
  String get yoQuickSurvey =>
      "यह एप्लिकेशन को आपके अनुसार ढालने में मदद करेगा।";

  @override
  String get myDailyInsights => "मेरे दैनिक अंतर्दृष्टि - आज";

  @override
  String get yourFabulousName => "कृपया अपना नाम दर्ज करें";

  @override
  String get neowmeName => "Neow नाम तो सुना ही होगा";

  @override
  String get sunaHoga => " सुना ही होगा";

  @override
  String get email => "ईमेल";

  @override
  String get phone => "फोन नंबर.";

  @override
  String get submit => "प्रस्तुत करें";

  @override
  String get willAsk =>
      " हम आपसे कुछ सवाल पूछेंगे ताकि हम आपके अनुभव को व्यक्तिगत बना सकें।";

  @override
  String get resendOtp => "ओटीपी फिर से भेजेंं";

  @override
  String get requestOtp => "नया ओटीपी का अनुरोध करें";

  @override
  String get seconds => "सेकंड";

  @override
  String get enterYourOtp => "अपना ओटीपी दर्ज करें";

  @override
  String get beforeWeGet => "शुरुआत करने से पहले";

  @override
  String get yatriGanDhyanDe => "यात्रीगण कृपया ध्यान दें";

  @override
  String get pleaseAsk =>
      "कृपया अपने माता-पिता या अभिभावक से अपने क्लू अकाउंट को स्थापित करने में मदद  लें।";

  @override
  String get asYouAre =>
      "चूँकि आप 16 वर्ष से कम उम्र के हैं, हमें कानूनी रूप से आपके माता-पिता या अभिभावक से निम्नलिखित जानकारियाँ पूछने की आवश्यकता है";

  @override
  String get theirPermission => "क्लू ऐप का उपयोग करने के लिए उनकी अनुमति।";

  @override
  String get theirHelp =>
      "आपकी गोपनीयता सेटिंग्स को स्थापित करने में उनकी मदद।";

  @override
  String get accept => "स्वीकार करें";

  @override
  String get next => "अगला";

  @override
  String get sleepNow => "अब सो जाएँ";

  @override
  String get apply => "लागू करें";

  @override
  String get quiz => "प्रश्नोत्तरी";

  @override
  String get knowYourBody => "अपने शरीर को जानो";

  @override
  String get myDashboard => "मेरा डैशबोर्ड";

  @override
  String get weight => "वजन";

  @override
  String get calculateBmi => "बीएमआई की गणना करें";

  @override
  String get bmiScore => "बीएमआई स्कोर";

  @override
  String get normal => "सामान्य";

  @override
  String get bmi => "बीएमआई";

  @override
  String get bmiCalculator => "बीएमआई कैलकुलेटर";

  @override
  String get youAndClue => "तुम और क्लू";

  @override
  String get wePromise =>
      "हम आपके डेटा को सुरक्षित और निजी रखने का वादा करते हैं। कृपया हमारी नीतियों को जानने के लिए थोड़ा समय निकालें।";

  @override
  String get iAgree => "मैं क्लू से सहमत हूँ।";

  @override
  String get termsOfServices => "सेवा की शर्तें।";

  @override
  String get iHaveReadClue => "मैंने क्लू को पढ़ा है";

  @override
  String get privacyPolicy => "गोपनीयता नीति.";

  @override
  String get iAgreeProcessing =>
      "मैं इस बात से सहमत हूँ कि ‘क्लू’ मेरे स्वास्थ्य डेटा को प्रोसेस करेगा जो मैं ऐप के साथ साझा करना चुनता हूँ, ताकि वे अपनी सेवा प्रदान कर सकें।";

  @override
  String get iShowedAbove =>
      "मैंने अपने माता-पिता/ अभिभावक से ऊपर उल्लिखित नीतियों को साझा किया। उन्होंने मुझे ‘क्लू’ का उपयोग करने एवं  ‘क्लू’ ऐप्प पर मेरे स्वास्थ्य डेटा को प्रोसेस कर सकने के लिए स्वीकृति प्रदान की है।";

  @override
  String get quickSurvey =>
      "अहा! त्वरित सर्वेक्षण का समय। हमें स्तर बढ़ाने में मदद करें।";

  @override
  String get averageCycle => "औसत मासिक धर्म की लम्बाई(दिनोमे)";

  @override
  String get whenDidYour => "आपकी पिछली मासिक धर्म कब शुरू हुई थी?";

  @override
  String get averagePeriod => "मासिक धर्म सामान्य अवधि (दिन)";

  @override
  String get letsSprinkle => "आइए मिलकर कुछ जादू बिखेरें";

  @override
  String get iDontRemember => "मुझे याद नहीं है";

  @override
  String get date => "तारीख";

  @override
  String get days => "दिन";

  @override
  String get getReminder =>
      "अपने मासिक धर्म को याद दिलाने के लिए रिमाइंडर सेट करें";

  @override
  String get stayYourPeriod => "अपनी मासिक धर्म के दौरान भी निर्बाध रहें!";

  @override
  String get nightReminder => "रात्रि में याद दिलाने का समय";

  @override
  String get cancel => "रद्द करें";

  @override
  String get delete => "मिटाएँ";

  @override
  String get ok => "ठीक है";

  @override
  String get setReminder => "रिमाइंडर सेट करें";

  @override
  String get mood => "मनोदशा";

  @override
  String get plSelectState => "कृपया अपना राज्य चुनें!";

  @override
  String get plSelectCity => "कृपया अपना शहर चुनें!";

  @override
  String get male => "पुरुष";

  @override
  String get edit => "संपादन करना";

  @override
  String get accepted => "स्वीकृत";

  @override
  String get transgender => "ट्रांसजेंडर";

  @override
  String get otherPlSpec => "अन्य, कृपया निर्दिष्ट करें";

  @override
  String get solo => "अकेला";

  @override
  String get tied => "विवाहित";

  @override
  String get sendRequest => "रिक्वेस्ट भेजे";

  @override
  String get openForSur => "अन्य";

  @override
  String get yourBDayHelp =>
      "(आपकी जन्मतिथि हमें आपके लिए ऐप तैयार करने में मदद करती है!)";

  @override
  String get numberOfDays =>
      "पीरियड की औसत अवधि- दो पीरियड के बीच की दिनों की संख्या";

  @override
  String get howLongDosePeriod =>
      "औसर्त पीररयड्स अवधि - आपके पीरयड्स कितने समय तक चलती है?";

  @override
  String get neowInNews => "ख़बरों में NeoW";

  @override
  String get quickQuestion => "प्रश्नोत्तरी";

  @override
  String get periodMedication => "पीरियड दवा";

  @override
  String get deStress => "डी-तनाव";

  @override
  String get healthMixLatest => "स्वास्थ्य मिश्रण - नवीनतम";

  @override
  String get latest => "नवीनतम";

  @override
  String get expertAdvice => "अनुभवी सलाह";

  @override
  String get cycleWisdom => "साइकिल ज्ञान";

  @override
  String get grooveWithNeow => "ग्रूव विद NeoW";

  @override
  String get testimonials => "टेस्टीमोनियल";

  @override
  String get funCorner => " फन कार्न";

  @override
  String get calebSpeaks => "सेलेब बोलता है";

  @override
  String get avgSleepTime => "औसत नींद का समय";

  @override
  String get empowHer => "सशक्ति";

  @override
  String get interest => "रुचि";

  @override
  String get dashboard => "डैशबोर्ड";

  @override
  String get aboutUs => "हमारे बारे में";

  @override
  String get help => "मदद";

  @override
  String get rateUs => "रेट और रिव्यू";

  @override
  String get logout => "लॉग आउट";

  @override
  String get home => "होम";

  @override
  String get forum => "फोरम";

  @override
  String get flow => "रक्त प्रवाह";

  @override
  String get staining => "पीरियड्स स्टेन";

  @override
  String get low => "कम";

  @override
  String get medium => "मध्यम";

  @override
  String get high => "उच्च";

  @override
  String get clotSize => "रक्त थक्का का साइज़";

  @override
  String get small => "छोटा";

  @override
  String get accountAccess => "खाते तक पहुंच";

  @override
  String get yourNaveli => "आपकी नवेली";

  @override
  String get large => "बड़ा";

  @override
  String get pain => "दर्द";

  @override
  String get workingAbility => "कार्य करने की क्षमता";

  @override
  String get always => "हमेशा";

  @override
  String get almostAlways => "लगभग हमेशा";

  @override
  String get almostNever => "लगभग नहीं";

  @override
  String get none => "कोई नहीं";

  @override
  String get location => "दर्द के स्थान";

  @override
  String get periodCramps => "पीरियड्स का दर्द";

  @override
  String get noHurt => "कोई दर्द नहीं";

  @override
  String get hurtLittleBit => "थोड़ा सा दर्द";

  @override
  String get hurtMore => "सामान्य से ज्यादा दर्द";

  @override
  String get hurtWorst => "बहुत ज्यादा दर्द";

  @override
  String get collectionMethod => "संग्रहण विधि";

  @override
  String get sanitaryPads => "सैनिटरी पैड";

  @override
  String get cloth => "कपड़ा";

  @override
  String get tampons => "टैम्पन";

  @override
  String get cups => "कप";

  @override
  String get relaxed => "आराम मिला।";

  @override
  String get sad => "उदास";

  @override
  String get energy => "ऊर्जा";

  @override
  String get lively => "जीवंत";

  @override
  String get irritated => "चिढ़ा हुआ";

  @override
  String get stress => "तनाव";

  @override
  String get moderate => "मध्यम";

  @override
  String get acne => "मुंहासा";

  @override
  String get minimal => "कम";

  @override
  String get rejected => "अस्वीकार कर दिया";

  @override
  String get severe => "गंभीर";

  @override
  String get add => "जोड़ना";

  @override
  String get lbs => "एलबीएस";

  @override
  String get cm => "सेमी";

  @override
  String get ft => "फुट";

  @override
  String get bedTime => "सोने का समय";

  @override
  String get wakeUpTime => "जागने का समय";

  @override
  String get sleepTime => "सोने का समय";

  @override
  String get hr => "कलाक";

  @override
  String get reminderFor => "रिमाइंडर फॉर";

  @override
  String get selectState => "राज्य चुनें";

  @override
  String get selectDistrict => "जिला चुनें";

  @override
  String get zodiac => "राशि";

  @override
  String get selectYourWeight => "अपना वजन चुनें";

  @override
  String get enterNaveliUid => "नवेली की यूनिक आईडी दर्ज करें";

  @override
  String get trackYourWeight =>
      "अपना वज़न ट्रैक करें और अपने लक्ष्य प्राप्त करें।";

  @override
  String get verificationFailed => "सत्यापन विफल रहा कृपया फिर से प्रयास करें!";

  @override
  String get newomeDescription =>
      "मैं ऐसा व्यक्ति हूं जिसे पीरियड्स आते हैं और मैं स्वस्थ रहते हुए अपने शरीर को बेहतर ढंग से समझना चाहता हूं।.";

  @override
  String get cycleDescription =>
      "मैं एक ऐसा व्यक्ति हूं जो पीरियड्स और समग्र स्वास्थ्य और कल्याण के बारे में अधिक जानना चाहता हूं।";

  @override
  String get buddyDescription =>
      "मैं एक साथी या अभिभावक हूं जो अपने अनूठे दोस्त कोड का उपयोग करके मेरे नियोम के स्वास्थ्य की निगरानी करना चाहता है।";

  @override
  String get alreadySentRequest =>
      "आप पहले ही किसी अन्य नवेली को अनुरोध भेज चुके हैं";

  @override
  String get keepTrackOfWater =>
      "अपने पानी के सेवन पर नज़र रखें और हाइड्रेटेड और स्वस्थ रहने के लिए रिमाइंडर सेट करें";

  @override
  String get freqOfChange => "एक दिन में परिवर्तन की आवृत्ति";

  @override
  String get neverMissADate =>
      "कभी भी डेट मिस न करें! आसानी से तारीखें, कार्यक्रम और कार्य निर्धारित करके सहज रूप से व्यवस्थित रहें।";

  @override
  String get aajMainUpar => "आज मैं उपर अस्मान नीचे";

  @override
  String get whatTimeDoGoBed => "आप आमतौर पर किस समय सोते हैं?";

  @override
  String get plEnterUid => "कृपया विशिष्ट आईडी दर्ज करें";

  @override
  String get plSlReminderDate => "कृपया अनुस्मारक तिथि चुनें";

  @override
  String get plSlReminderType => "कृपया अनुस्मारक प्रकार चुनें";

  @override
  String get plSlReminderFor => "कृपया इसके लिए अनुस्मारक दर्ज करें";

  @override
  String get whatTimeWakeUp => "आप आमतौर पर सुबह कितने बजे उठते हैं?";

  @override
  String get yeDukhKaahe => "ये दुख कहे खतम नहीं होता है";

  @override
  String get plSelectWeightType => "कृपया वजन का प्रकार चुनें";

  @override
  String get trackAndConquer =>
      "अपने रोगों को ट्रैक करें और उन्हें दूर करने की कोशिश करे !";

  @override
  String get monitorYourBmi =>
      "अपने सामग्रिक स्वास्थ्य और शारीरिक संरचना के अंदरूनी दर्शन के लिए अपना बीएमआई मॉनिटर करें।";

  @override
  String get howManyDays => "आप कितने दिनों तक गंभीर दर्द का अनुभव करते हैं?";

  @override
  String get effortlesslyTrack =>
      "अपनी दवा को बिना किसी प्रयास के ट्रैक करें! आसानी से अपनी प्रगति की निगरानी करने के लिए अनुस्मारक निर्धारित करें।";

  @override
  String get howManyTimesYou =>
      "आप रोजाना अपना पैड/पैंटी/कप/टैम्पन/अन्य कितनी बार बदलते हैं?";

  @override
  String get exploreTheHidden => "अपने शरीर के रहस्यों को जानें।";

  @override
  String get capacityToPerform =>
      "मासिक धर्म के दौरान कार्यों को प्रभावी रूप से करने की क्षमता";

  @override
  String get uncoveringTruth => "सत्य का उजागर और गलतफहमियों का समाधान";

  @override
  String get decodingPeriod => " पीरियड्स के बारे में पूरी जानकारी।";

  @override
  String get plSelectHirsutism => "कृपया सभी हारसुटिज्म!";

  @override
  String get leadingLadies => "अग्रणी महिलाएँ-: सुर्खियाँ बटोरने वाली महिलाएँ";

  @override
  String get questionOfDay => " आज का प्रश्न";

  @override
  String get periodPainCan =>
      "मासिक धर्म का दर्द पेट के निचले हिस्से, पीठ के निचले हिस्से, जांघों आदि सहित विभिन्न स्थानों पर हो सकता है। यह कितनी जगहों पर चोट पहुँचाता है?";

  @override
  String get underStandYourBody =>
      "अपने शरीर को बेहतर समझें: अपने मासिक धर्म के दौरान लक्षणों को ट्रैक करें.";

  @override
  String get ifYouHave =>
      "यदि आपके पास स्वास्थ्य से संबंधित प्रश्न हैं, तो हिचकिचाएं नहीं! हमारे विशेषज्ञ उत्तर देने के लिए यहां हैं। ";

  @override
  String get eatGlowRepeat => "हमारे विशेषज्ञों द्वारा दिए गए पोषण सुझाव";

  @override
  String get welcomeToNeow =>
      "नियोव के फोरम में आपका स्वागत है-हे नई महिलाएं! नियोव के फोरम में आपका स्वागत है। व्यावहारिक चर्चाओं में शामिल हों, समर्थन प्राप्त करें और अपने जीवन के हर पहलू में फलने-फूलने के लिए प्रेरित हों। एक साथ जुड़ने, बढ़ने और नारीत्व की यात्रा का जश्न मनाने के लिए हमारे साथ जुड़ें!";

  @override
  String get welcomeToSecret =>
      "सीक्रेट डायरी- सीक्रेट डायरी में आपका स्वागत है, यह आपके विचारों, सपनों और अवलोकन के लिए आपका निजी स्थान है। अपने आप को स्वतंत्रता से व्यक्त करें और आत्म-खोज की शक्ति को अनलॉक करें।";

  @override
  String get wesupport =>
      "हम लैंगिक अभिव्यक्ति के सभी रूपों का समर्थन करते हैं। हालाँकि, हमें आपके बॉडी मेट्रिक्स की गणना करने के लिए इसकी आवश्यकता है";
  @override
  String get yourgender => "आपका लिंग  क्या है?";
  @override
  // TODO: implement reorderItemDown
  String get reorderItemDown => throw UnimplementedError();

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => throw UnimplementedError();

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => throw UnimplementedError();

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => throw UnimplementedError();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale(AppConstants.LANGUAGE_ENGLISH, ""),
      Locale(AppConstants.LANGUAGE_HINDI, ""),
    ];
  }

  LocaleListResolutionCallback listResolution(
      {Locale? fallback, bool withCountry = true}) {
    return (List<Locale>? locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback!, supported, withCountry);
      }
    };
  }

  Locale Function(Locale locale, Iterable<Locale> supported) resolution(
      {Locale? fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback!, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String? lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case AppConstants.LANGUAGE_HINDI:
          S.current = $mr();
          return SynchronousFuture<S>(S.current!);
        case AppConstants.LANGUAGE_ENGLISH:
          S.current = const $en();
          return SynchronousFuture<S>(S.current!);
        default:
// NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current!);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale? locale, Locale fallback, Iterable<Locale> supported,
      bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale? locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
// Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

// If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

// If no country requirement is requested, check if this locale has no country.
        if (true != withCountry &&
            (supportedLocale.countryCode == null ||
                supportedLocale.countryCode!.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String? getLang(Locale? l) => l == null
    ? null
    : l.countryCode != null && l.countryCode!.isEmpty
        ? l.languageCode
        : l.toString();
