import 'package:novel_log/utility/constants.dart';

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
    userName = json[userNameKeyName] ?? '';
    email = json[emailKeyName] ?? '';
    userProfileImageUrl = json[userProfileImageUrlKeyName] ?? '';
    todayChapterReadCount = json[todayChapterReadCountKeyName] ?? 0;
    dailyAverageChapterReadCount = json[dailyAverageChapterReadCountKeyName] != null
        ? json[dailyAverageChapterReadCountKeyName].runtimeType == double
            ? json[dailyAverageChapterReadCountKeyName]
            : json[dailyAverageChapterReadCountKeyName] * 1.0
        : 0.0;
    totalChapterReadCount = json[totalChapterReadCountKeyName] ?? 0;
    totalNovelReadCompleteWithNovelComplete = json[totalNovelReadCompleteWithNovelCompleteKeyName] ?? 0;
    totalNovelReadCompleteWithNovelHiatus = json[totalNovelReadCompleteWithNovelHiatusKeyName] ?? 0;
    totalStartedNovelCount = json[totalStartedNovelCountKeyName] ?? 0;
    weeklyChapterReadCount = json[weeklyChapterReadCountKeyName] ?? [];
    monthlyChapterReadCount = json[monthlyChapterReadCountKeyName] ?? [];
    yearlyChapterReadCount = json[yearlyChapterReadCountKeyName] ?? [];
    userHiddenPin = json[userHiddenPinKeyName] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[userNameKeyName] = userName;
    data[emailKeyName] = email;
    data[userProfileImageUrlKeyName] = userProfileImageUrl;
    data[todayChapterReadCountKeyName] = todayChapterReadCount;
    data[dailyAverageChapterReadCountKeyName] = dailyAverageChapterReadCount;
    data[totalChapterReadCountKeyName] = totalChapterReadCount;
    data[totalNovelReadCompleteWithNovelCompleteKeyName] = totalNovelReadCompleteWithNovelComplete;
    data[totalNovelReadCompleteWithNovelHiatusKeyName] = totalNovelReadCompleteWithNovelHiatus;
    data[totalStartedNovelCountKeyName] = totalStartedNovelCount;
    data[weeklyChapterReadCountKeyName] = weeklyChapterReadCount;
    data[monthlyChapterReadCountKeyName] = monthlyChapterReadCount;
    data[yearlyChapterReadCountKeyName] = yearlyChapterReadCount;
    data[userHiddenPinKeyName] = userHiddenPin;
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
