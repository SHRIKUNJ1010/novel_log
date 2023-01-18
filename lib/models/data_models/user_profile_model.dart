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

  UserProfileModel({
    this.userId,
    this.userName,
    this.email,
    this.userProfileImageUrl,
    this.todayChapterReadCount,
    List<int> weeklyChapterReadCount = const [],
    List<int> monthlyChapterReadCount = const [],
    List<int> yearlyChapterReadCount = const [],
    this.dailyAverageChapterReadCount,
    this.totalChapterReadCount,
    this.totalNovelReadCompleteWithNovelComplete,
    this.totalNovelReadCompleteWithNovelHiatus,
    this.totalStartedNovelCount,
  }) {
    weeklyChapterReadCount.isEmpty
        ? this.weeklyChapterReadCount = List.filled(7, 0)
        : this.weeklyChapterReadCount = weeklyChapterReadCount;
    monthlyChapterReadCount.isEmpty
        ? this.monthlyChapterReadCount = List.filled(31, 0)
        : this.monthlyChapterReadCount = monthlyChapterReadCount;
    yearlyChapterReadCount.isEmpty
        ? this.yearlyChapterReadCount = List.filled(365, 0)
        : this.yearlyChapterReadCount = yearlyChapterReadCount;
  }

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    email = json['email'];
    userProfileImageUrl = json['user_profile_image_url'];
    todayChapterReadCount = json['today_chapter_read_count'];
    weeklyChapterReadCount = json['weekly_chapter_read_count'];
    monthlyChapterReadCount = json['monthly_chapter_read_count'];
    yearlyChapterReadCount = json['yearly_chapter_read_count'];
    dailyAverageChapterReadCount = json['daily_average_chapter_read_count'];
    totalChapterReadCount = json['total_chapter_read_count'];
    totalNovelReadCompleteWithNovelComplete =
        json['total_novel_read_complete_with_novel_complete'];
    totalNovelReadCompleteWithNovelHiatus =
        json['total_novel_read_complete_with_novel_hiatus'];
    totalStartedNovelCount = json['total_started_novel_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'];
    data['user_name'];
    data['email'];
    data['user_profile_image_url'];
    data['today_chapter_read_count'];
    data['weekly_chapter_read_count'];
    data['monthly_chapter_read_count'];
    data['yearly_chapter_read_count'];
    data['daily_average_chapter_read_count'];
    data['total_chapter_read_count'];
    data['total_novel_read_complete_with_novel_complete'];
    data['total_novel_read_complete_with_novel_hiatus'];
    data['total_started_novel_count'];
    return data;
  }
}
