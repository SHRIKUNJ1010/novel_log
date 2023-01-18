class UserProfileModel {
  String? userId;
  String? userName;
  String? email;
  String? userProfileImageUrl;
  int? todayChapterReadCount;
  List<int> weeklyChapterReadCount = List.filled(7, 0);
  List<int> monthlyChapterReadCount = List.filled(31, 0);
  List<int> yearlyChapterReadCount = List.filled(365, 0);
  double? dailyAverageChapterReadCount;
  int? totalChapterReadCount;
  int? totalNovelReadCompleteWithNovelComplete;
  int? totalNovelReadCompleteWithNovelHiatus;
  int? totalStartedNovelCount;
}
