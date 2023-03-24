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
const String novelIdKeyName = 'novel_id';

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
const String novelNameKeyName = 'novel_name';
const String novelAuthorNameKeyName = 'novel_author_name';
const String novelGenreKeyName = 'novel_genre';
const String novelDescriptionKeyName = 'novel_description';
const String novelImageUrlKeyName = 'novel_image_url';
const String indexingGroupNameKeyName = 'indexing_group_name';
const String isNovelKeyName = 'is_novel';
const String totalNovelChapterCountKeyName = 'total_novel_chapter_count';
const String readNovelChapterCountKeyName = 'read_novel_chapter_count';
const String novelLinkUrlKeyName = 'novel_link_url';
const String novelStatusKeyName = 'novel_status';
const String novelReadingStatusKeyName = 'novel_reading_status';
const String isHiddenKeyName = 'is_hidden';
const String isInWishListKeyName = 'is_in_wish_list';
