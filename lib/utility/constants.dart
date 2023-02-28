/*
* Created by Shrikunj Patel on 1/6/2023.
*/

const String appName = 'Novel Log';
const String fontProxima = 'Nunito';

//for firebase database
const String userCollection = 'users';
const String novelCollection = 'novels';

//Preference Data
const String prefUserId = 'PREF_USER_ID';
const String prefIsUserLoggedIn = 'PREF_IS_USER_LOGGED_IN';

//database common key names
const String userIdKeyName = 'user_id';

//database key names for user
const String userNameKeyName = 'user_name';
const String emailKeyName = 'email';
const String userProfileImageUrlKeyName = 'user_profile_image_url';
const String todayChapterReadCountKeyName = 'today_chapter_read_count';
const String dailyAverageChapterReadCountKeyName = 'daily_average_chapter_read_count';
const String totalChapterReadCountKeyName = 'total_chapter_read_count';
const String totalNovelReadCompleteWithNovelCompleteKeyName = 'total_novel_read_complete_with_novel_complete';
const String totalNovelReadCompleteWithNovelHiatusKeyName = 'total_novel_read_complete_with_novel_hiatus';
const String totalStartedNovelCountKeyName = 'total_started_novel_count';
const String weeklyChapterReadCountKeyName = 'weekly_chapter_read_count';
const String monthlyChapterReadCountKeyName = 'monthly_chapter_read_count';
const String yearlyChapterReadCountKeyName = 'yearly_chapter_read_count';
const String userHiddenPinKeyName = 'user_hidden_pin';

//database key names for novel