class UserProfileModel {
  int? userId;
  String? userName;
  String? email;
  int? todayChapterReadCount;
  List<int> weeklyChapterReadCount = [];
  List<int> monthlyChapterReadCount = [];
  List<int> yearlyChapterReadCount = [];
  double? dailyAverageChapterReadCount;
  int? totalChapterReadCount;
  int? totalNovelReadCompleteWithNovelComplete;
  int? totalNovelReadCompleteWithNovelHiatus;
  int? totalStartedNovelCount;
}
