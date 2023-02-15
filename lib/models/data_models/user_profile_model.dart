class UserProfileModel {
  String? userId;
  String? userName;
  String? email;
  String? userProfileImageUrl;
  String? userHiddenPin;
  int? todayChapterReadCount;
  List<dynamic> weeklyChapterReadCount = List.filled(7, 0);
  List<dynamic> monthlyChapterReadCount = List.filled(31, 0);
  List<dynamic> yearlyChapterReadCount = List.filled(365, 0);
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
    List<dynamic> weeklyChapterReadCount = const [],
    List<dynamic> monthlyChapterReadCount = const [],
    List<dynamic> yearlyChapterReadCount = const [],
    this.dailyAverageChapterReadCount,
    this.totalChapterReadCount,
    this.totalNovelReadCompleteWithNovelComplete,
    this.totalNovelReadCompleteWithNovelHiatus,
    this.totalStartedNovelCount,
    this.userHiddenPin,
  }) {
    weeklyChapterReadCount.isEmpty ? this.weeklyChapterReadCount = List.filled(7, 0) : this.weeklyChapterReadCount = weeklyChapterReadCount;
    monthlyChapterReadCount.isEmpty ? this.monthlyChapterReadCount = List.filled(31, 0) : this.monthlyChapterReadCount = monthlyChapterReadCount;
    yearlyChapterReadCount.isEmpty ? this.yearlyChapterReadCount = List.filled(365, 0) : this.yearlyChapterReadCount = yearlyChapterReadCount;
  }

  UserProfileModel.create({
    required this.userId,
    required this.userName,
    required this.email,
    this.totalStartedNovelCount = 0,
    this.userProfileImageUrl = '',
    this.todayChapterReadCount = 0,
    this.totalNovelReadCompleteWithNovelHiatus = 0,
    this.totalNovelReadCompleteWithNovelComplete = 0,
    this.totalChapterReadCount = 0,
    this.dailyAverageChapterReadCount = 0,
    this.userHiddenPin = '',
    List<dynamic> weeklyChapterReadCount = const [],
    List<dynamic> monthlyChapterReadCount = const [],
    List<dynamic> yearlyChapterReadCount = const [],
  }) {
    weeklyChapterReadCount.isEmpty ? this.weeklyChapterReadCount = List.filled(7, 0) : this.weeklyChapterReadCount = weeklyChapterReadCount;
    monthlyChapterReadCount.isEmpty ? this.monthlyChapterReadCount = List.filled(31, 0) : this.monthlyChapterReadCount = monthlyChapterReadCount;
    yearlyChapterReadCount.isEmpty ? this.yearlyChapterReadCount = List.filled(365, 0) : this.yearlyChapterReadCount = yearlyChapterReadCount;
  }

  UserProfileModel.fromJson(String tempUserId, Map<String, dynamic> json) {
    userId = tempUserId;
    userName = json['user_name'] ?? '';
    email = json['email'] ?? '';
    userProfileImageUrl = json['user_profile_image_url'] ?? '';
    todayChapterReadCount = json['today_chapter_read_count'] ?? '';
    dailyAverageChapterReadCount = json['daily_average_chapter_read_count'] ?? '';
    totalChapterReadCount = json['total_chapter_read_count'] ?? '';
    totalNovelReadCompleteWithNovelComplete = json['total_novel_read_complete_with_novel_complete'] ?? '';
    totalNovelReadCompleteWithNovelHiatus = json['total_novel_read_complete_with_novel_hiatus'] ?? '';
    totalStartedNovelCount = json['total_started_novel_count'] ?? '';
    weeklyChapterReadCount = json['weekly_chapter_read_count'] ?? [];
    monthlyChapterReadCount = json['monthly_chapter_read_count'] ?? [];
    yearlyChapterReadCount = json['yearly_chapter_read_count'] ?? [];
    userHiddenPin = json['user_hidden_pin'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['email'] = email;
    data['user_profile_image_url'] = userProfileImageUrl;
    data['today_chapter_read_count'] = todayChapterReadCount;
    data['daily_average_chapter_read_count'] = dailyAverageChapterReadCount;
    data['total_chapter_read_count'] = totalChapterReadCount;
    data['total_novel_read_complete_with_novel_complete'] = totalNovelReadCompleteWithNovelComplete;
    data['total_novel_read_complete_with_novel_hiatus'] = totalNovelReadCompleteWithNovelHiatus;
    data['total_started_novel_count'] = totalStartedNovelCount;
    data['weekly_chapter_read_count'] = weeklyChapterReadCount;
    data['monthly_chapter_read_count'] = monthlyChapterReadCount;
    data['yearly_chapter_read_count'] = yearlyChapterReadCount;
    data['user_hidden_pin'] = userHiddenPin;
    return data;
  }

  UserProfileModel.edit({
    required UserProfileModel oldModel,
    String? userId,
    String? userName,
    String? email,
    int? totalStartedNovelCount,
    String? userProfileImageUrl,
    int? todayChapterReadCount,
    int? totalNovelReadCompleteWithNovelHiatus,
    int? totalNovelReadCompleteWithNovelComplete,
    int? totalChapterReadCount,
    int? dailyAverageChapterReadCount,
    String? userHiddenPin,
    List<dynamic> weeklyChapterReadCount = const [],
    List<dynamic> monthlyChapterReadCount = const [],
    List<dynamic> yearlyChapterReadCount = const [],
  }) {
    this.userId = userId ?? oldModel.userId;
    this.userName = userName ?? oldModel.userName;
    this.email = email ?? oldModel.email;
    this.totalStartedNovelCount = totalStartedNovelCount ?? oldModel.totalStartedNovelCount;
    this.userProfileImageUrl = userProfileImageUrl ?? oldModel.userProfileImageUrl;
    this.userHiddenPin = userHiddenPin ?? oldModel.userHiddenPin;
    this.todayChapterReadCount = todayChapterReadCount ?? oldModel.todayChapterReadCount;
    this.totalNovelReadCompleteWithNovelHiatus = totalNovelReadCompleteWithNovelHiatus ?? oldModel.totalNovelReadCompleteWithNovelHiatus;
    this.totalNovelReadCompleteWithNovelComplete = totalNovelReadCompleteWithNovelComplete ?? oldModel.totalNovelReadCompleteWithNovelComplete;
    this.totalChapterReadCount = totalChapterReadCount ?? oldModel.totalChapterReadCount;
    this.dailyAverageChapterReadCount = (dailyAverageChapterReadCount ?? oldModel.dailyAverageChapterReadCount) as double?;
    this.weeklyChapterReadCount = weeklyChapterReadCount.isNotEmpty ? weeklyChapterReadCount : oldModel.weeklyChapterReadCount;
    this.monthlyChapterReadCount = monthlyChapterReadCount.isNotEmpty ? monthlyChapterReadCount : oldModel.monthlyChapterReadCount;
    this.yearlyChapterReadCount = yearlyChapterReadCount.isNotEmpty ? yearlyChapterReadCount : oldModel.yearlyChapterReadCount;
  }

//end of file
}
