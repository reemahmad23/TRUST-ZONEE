import 'package:flutter/material.dart';

class AppLocalizations {
  static const List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('ar', ''),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  final Locale locale;

  AppLocalizations(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'language': 'Language',
      'darkMode': 'Dark Mode',
      'english': 'English',
      'arabic': 'Arabic',
      'login': 'Log In',
      'signUp': 'Sign Up',
      'dontHaveAccount': "Don't have an account ? ",
      'alreadyHaveAnAccount': 'Already have an account? ',
      'email': 'Email',
      'password': 'Password',
      'confirmPassword': 'Confirm Password',
      'plzConfirmYourPassword': 'Plz Confirm your password',
      'passwordDoNotMatch': 'Passwords do not match',
      'pleaseEnterYourEmail': 'Please enter your email',
      'invalidEmailFormat': 'Invalid email format',
      'pleaseEnterYourPassword': 'Please enter your password',
      'passwordMustBeAtLeast6Char': 'Password must be at least 6 characters',
      'passwordMustContainAtLeast1UppercaseLetter': 'Password Must contain at least one uppercase letter',
      'passwordMustContainAtLeast1LowercaseLetter': 'Password Must contain at least one lowercase letter',
      'mustContainAtLeast1num': 'Password Must contain at least one number',
      'mustContainAtLeast1SpecialChar': 'Password Must contain at least one special character',
      'userName': 'Username',
      'enterYourUserName': 'Enter your username',
      'visual': 'Visual',
      'mobility': 'Mobility',
      'hearing': 'Hearing',
      'neurological': 'Neurological',
      'invalidEmailOrPassword': 'Invalid email or password',
      'unexpectedError': 'Unexpected error',
      'serverErrorOccurred': 'Server error occurred',
      'enterYourEmail': 'Enter your email',
      'enterAValidEmail': 'Enter a valid email',
      'age': 'Age',
      'selectYourBirthDate': 'Select your birthdate',
      'disabilityType': 'Disability Type',
      'pleaseSelectADisabilityType': 'Please select a disability type',
      'contactUs': 'Contact Us',
      'website': 'Website',
      'facebook': 'Facebook',
      'twitter': 'Twitter',
      'instagram': 'Instagram',
      'events': 'Events',
      'reviews': 'Reviews',
      'addReview': 'Add Review',
      'sendReview': 'Send Review',
      'detailReview': 'Detail Review',
      'giveAReview': 'Give a Review',
      'reviewAddedSuccessfully': 'Review added successfully!',
      'failedToAddReview': 'Failed to add review:',
      'restaurantDetails': 'restaurant details',
      'sendMessage': 'Send Message',
      'badRequest': 'Bad Request',
      'address': 'Address',
      'phone': 'Phone',
      'close': 'Close',
      'details': 'Details',
      'copy': 'Copy',
      'openInBrowser': 'Open in browser',
      'copied': 'Copied',
      "reviewSubmittedSuccessfully":"Review submitted successfully",
      'noImage': 'No Image',
      'failedToLoadImage': 'Failed to load image',
      // Existing + New
      'favoritePlaces': 'Favorite Places',
      'messages': 'Messages',
      'search': 'Search',
      'username': 'username',
      'chatBotAI': 'Chat Bot AI ',
      'editProfile': 'Edit Profile',
      'dateOfBirth': 'Date Of Birth',
      'disability': 'Disability Type',
      'saveChanges': 'Save Changes',
      'profile': 'Profile',
      'edit': 'EDIT',
      'logOut': 'LOG OUT',
      'myFavorites': 'My Favorites',
      'settings': 'Settings',
      'language': 'Language',
      'notification': 'Notifications',
      'help': 'Help',
      'categories': 'Categories',
      'restaurantsAndCafes': 'Restaurants and Cafes',
      'fitnessAndSports': 'Fitness and Sports',
      'shopping': 'Shopping',
      'healthCareFacilities': 'HealthCare  Facilities',
      'governmentEntities': ' Government Entities',
      'searchBranches': 'Search Branches',
      'entertainment': 'Entertainment',
      'noFavoritePlaceYet': 'No Favorite Place Yet..',
      'noNameYet': 'No Name Yet..',
      'searchBranch': 'Search Branch',
      'placeName': 'Place Name',
      'noPlaceMatchYourSearch': 'No Place Match Your Search',
      'error': 'Error',
      'noAge': 'No age',
      'unexpected': 'Unexpected',
      'retry': 'Retry',
      'regenerate': 'Regenerate',
      'name': 'Name',
      'failedToStartConversation': 'Failed To Start Conversation',
      'activeNow': 'Active now',
      'conversationError': 'Conversation Error',
      'add': 'Add',
      'enterUserId': 'Enter User ID',
      'startNewConversation': 'Start New Conversation',
      'enterUsernameToChat': 'Enter the username to chat with',
      'noConversation': 'No Conversation',
      'noResultFound': 'No result found',


    },
    'ar': {
      'language': 'اللغة',
      'darkMode': 'الوضع الليلي',
      'english': 'انجليزية',
      'arabic': 'العربية',
      'login': 'تسجيل الدخول',
      'signUp': 'إنشاء حساب',
      'dontHaveAccount': 'ليس لديك حساب؟ ',
      'alreadyHaveAnAccount': 'هل لديك حساب؟ ',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirmPassword': 'تأكيد كلمة المرور',
      'plzConfirmYourPassword': 'يرجى تأكيد كلمة المرور',
      'passwordDoNotMatch': 'كلمتا المرور غير متطابقتين',
      'pleaseEnterYourEmail': 'يرجى إدخال البريد الإلكتروني',
      'invalidEmailFormat': 'تنسيق البريد الإلكتروني غير صحيح',
      'pleaseEnterYourPassword': 'يرجى إدخال كلمة المرور',
      'passwordMustBeAtLeast6Char': 'يجب أن تكون كلمة المرور 6 أحرف على الأقل',
      'passwordMustContainAtLeast1UppercaseLetter': 'يجب أن تحتوي على حرف كبير واحد على الأقل',
      'passwordMustContainAtLeast1LowercaseLetter': 'يجب أن تحتوي على حرف صغير واحد على الأقل',
      'mustContainAtLeast1num': 'يجب أن تحتوي على رقم واحد على الأقل',
      'mustContainAtLeast1SpecialChar': 'يجب أن تحتوي على رمز خاص واحد على الأقل',
      'userName': 'اسم المستخدم',
      'enterYourUserName': 'أدخل اسم المستخدم',
      'visual': 'بصري',
      'mobility': 'حركي',
      'hearing': 'سمعي',
      'neurological': 'عصبي',
      'invalidEmailOrPassword': 'بريد إلكتروني أو كلمة مرور غير صحيحة',
      'unexpectedError': 'خطأ غير متوقع',
      'serverErrorOccurred': 'حدث خطأ في الخادم',
      'enterYourEmail': 'أدخل بريدك الإلكتروني',
      'enterAValidEmail': 'أدخل بريد إلكتروني صالح',
      'age': 'العمر',
      'selectYourBirthDate': 'حدد تاريخ الميلاد',
      'disabilityType': 'نوع الإعاقة',
      'pleaseSelectADisabilityType': 'يرجى تحديد نوع الإعاقة',
      'contactUs': 'تواصل معنا',
      'website': 'الموقع الإلكتروني',
      'facebook': 'فيسبوك',
      'twitter': 'تويتر',
      'instagram': 'إنستغرام',
      'events': 'الفعاليات',
      'reviews': 'المراجعات',
      'addReview': 'إضافة مراجعة',
      'sendReview': 'إرسال مراجعة',
      'detailReview': 'تفاصيل المراجعة',
      'giveAReview': 'أضف مراجعة',
      'reviewAddedSuccessfully': 'تمت إضافة المراجعة بنجاح!',
      'failedToAddReview': 'فشل في إضافة المراجعة:',
      'restaurantDetails': 'تفاصيل المطعم',
      'sendMessage': 'إرسال رسالة',
      'badRequest': 'طلب خاطئ',
      'address': 'العنوان',
      'phone': 'الهاتف',
      'close': 'إغلاق',
      'details': 'تفاصيل',
      'copy': 'نسخ',
      'openInBrowser': 'فتح في المتصفح',
      'copied': 'تم النسخ',
      "reviewSubmittedSuccessfully":"تم إرسال التقييم بنجاح",
      'noImage': 'لا توجد صورة',
      'failedToLoadImage': 'فشل تحميل الصورة',
      // Existing + New
      'favoritePlaces': 'الأماكن المفضلة',
      'messages': 'الرسائل',
      'search': 'بحث',
      'username': 'اسم المستخدم',
      'chatBotAI': 'الدردشة بالذكاء الاصطناعي',
      'editProfile': 'تعديل الملف الشخصي',
      'dateOfBirth': 'تاريخ الميلاد',
      'disability': 'نوع الإعاقة',
      'saveChanges': 'حفظ التعديلات',
      'profile': 'الملف الشخصي',
      'edit': 'تعديل',
      'logOut': 'تسجيل الخروج',
      'myFavorites': 'مفضلتي',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'notification': 'الإشعارات',
      'help': 'المساعدة',
      'categories': 'الفئات',
      'restaurantsAndCafes': 'مطاعم ومقاهي',
      'fitnessAndSports': 'الرياضة واللياقة',
      'shopping': 'التسوق',
      'healthCareFacilities': 'مرافق الرعاية الصحية',
      'governmentEntities': 'الجهات الحكومية',
      'searchBranches': 'بحث عن الفروع',
      'entertainment': 'الترفيه',
      'noFavoritePlaceYet': 'لا يوجد أماكن مفضلة بعد..',
      'noNameYet': 'لا يوجد اسم بعد..',
      'searchBranch': 'بحث عن فرع',
      'placeName': 'اسم المكان',
      'noPlaceMatchYourSearch': 'لا يوجد أماكن تطابق البحث',
      'error': 'خطأ',
      'noAge': 'لا يوجد عمر',
      'unexpected': 'غير متوقع',
      'retry': 'إعادة المحاولة',
      'regenerate': 'توليد من جديد',
      'name': 'الاسم',
      'failedToStartConversation': 'فشل بدء المحادثة',
      'activeNow': 'نشط الآن',
      'conversationError': 'خطأ في المحادثة',
      'add': 'إضافة',
      'enterUserId': 'أدخل معرف المستخدم',
      'startNewConversation': 'ابدأ محادثة جديدة',
      'enterUsernameToChat': 'أدخل اسم المستخدم للدردشة معه',
      'noConversation': 'لا توجد محادثات',
      'noResultFound': 'لم يتم العثور على نتائج',

    },
  };

  String getText(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Getters for all keys
  String get language => getText('language');
  String get darkMode => getText('darkMode');
  String get english => getText('english');
  String get arabic => getText('arabic');
  String get login => getText('login');
  String get signUp => getText('signUp');
  String get dontHaveAccount => getText('dontHaveAccount');
  String get alreadyHaveAnAccount => getText('alreadyHaveAnAccount');
  String get email => getText('email');
  String get password => getText('password');
  String get confirmPassword => getText('confirmPassword');
  String get plzConfirmYourPassword => getText('plzConfirmYourPassword');
  String get passwordDoNotMatch => getText('passwordDoNotMatch');
  String get pleaseEnterYourEmail => getText('pleaseEnterYourEmail');
  String get invalidEmailFormat => getText('invalidEmailFormat');
  String get pleaseEnterYourPassword => getText('pleaseEnterYourPassword');
  String get passwordMustBeAtLeast6Char => getText('passwordMustBeAtLeast6Char');
  String get passwordMustContainAtLeast1UppercaseLetter => getText('passwordMustContainAtLeast1UppercaseLetter');
  String get passwordMustContainAtLeast1LowercaseLetter => getText('passwordMustContainAtLeast1LowercaseLetter');
  String get mustContainAtLeast1num => getText('mustContainAtLeast1num');
  String get mustContainAtLeast1SpecialChar => getText('mustContainAtLeast1SpecialChar');
  String get userName => getText('userName');
  String get enterYourUserName => getText('enterYourUserName');
  String get visual => getText('visual');
  String get mobility => getText('mobility');
  String get hearing => getText('hearing');
  String get neurological => getText('neurological');
  String get invalidEmailOrPassword => getText('invalidEmailOrPassword');
  String get unexpectedError => getText('unexpectedError');
  String get serverErrorOccurred => getText('serverErrorOccurred');
  String get enterYourEmail => getText('enterYourEmail');
  String get enterAValidEmail => getText('enterAValidEmail');
  String get age => getText('age');
  String get selectYourBirthDate => getText('selectYourBirthDate');
  String get disabilityType => getText('disabilityType');
  String get pleaseSelectADisabilityType => getText('pleaseSelectADisabilityType');
  String get contactUs => getText('contactUs');
  String get website => getText('website');
  String get facebook => getText('facebook');
  String get twitter => getText('twitter');
  String get instagram => getText('instagram');
  String get events => getText('events');
  String get reviews => getText('reviews');
  String get addReview => getText('addReview');
  String get sendReview => getText('sendReview');
  String get detailReview => getText('detailReview');
  String get giveAReview => getText('giveAReview');
  String get reviewAddedSuccessfully => getText('reviewAddedSuccessfully');
  String get failedToAddReview => getText('failedToAddReview');
  String get restaurantDetails => getText('restaurantDetails');
  String get sendMessage => getText('sendMessage');
  String get badRequest => getText('badRequest');
  String get address => getText('address');
  String get phone => getText('phone');
  String get close => getText('close');
  String get details => getText('details');
  String get copy => getText('copy');
  String get openInBrowser => getText('openInBrowser');
  String get copied => getText('copied');
  String get reviewSubmittedSuccessfully => getText('reviewSubmittedSuccessfully');
  String get noImage => getText('noImage');
  String get failedToLoadImage => getText('failedToLoadImage');
  // باقي الـ getters المضافة:

  String get favoritePlaces => getText('favoritePlaces');
  String get messages => getText('messages');
  String get search => getText('search');
  String get username => getText('username');
  String get chatBotAI => getText('chatBotAI');
  String get editProfile => getText('editProfile');
  String get dateOfBirth => getText('dateOfBirth');
  String get disability => getText('disability');
  String get saveChanges => getText('saveChanges');
  String get profile => getText('profile');
  String get edit => getText('edit');
  String get logOut => getText('logOut');
  String get myFavorites => getText('myFavorites');
  String get settings => getText('settings');
  String get notification => getText('notification');
  String get help => getText('help');
  String get categories => getText('categories');
  String get restaurantsAndCafes => getText('restaurantsAndCafes');
  String get fitnessAndSports => getText('fitnessAndSports');
  String get shopping => getText('shopping');
  String get healthCareFacilities => getText('healthCareFacilities');
  String get governmentEntities => getText('governmentEntities');
  String get searchBranches => getText('searchBranches');
  String get entertainment => getText('entertainment');
  String get noFavoritePlaceYet => getText('noFavoritePlaceYet');
  String get noNameYet => getText('noNameYet');
  String get searchBranch => getText('searchBranch');
  String get placeName => getText('placeName');
  String get noPlaceMatchYourSearch => getText('noPlaceMatchYourSearch');
  String get error => getText('error');
  String get noAge => getText('noAge');
  String get unexpected => getText('unexpected');
  String get retry => getText('retry');
  String get regenerate => getText('regenerate');
  String get name => getText('name');
  String get failedToStartConversation => getText('failedToStartConversation');
  String get activeNow => getText('activeNow');
  String get conversationError => getText('conversationError');
  String get add => getText('add');
  String get enterUserId => getText('enterUserId');
  String get startNewConversation => getText('startNewConversation');
  String get enterUsernameToChat => getText('enterUsernameToChat');
  String get noConversation => getText('noConversation');
  String get noResultFound => getText('noResultFound');


}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
