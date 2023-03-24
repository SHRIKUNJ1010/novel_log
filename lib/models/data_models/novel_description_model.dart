import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';

class NovelDescriptionModel {
  String? novelId;
  String? userId;
  String? novelName;
  String? novelAuthorName;
  List<String>? novelGenre;
  String? novelDescription;
  String? novelImageUrl;
  bool? isNovel;
  int? totalNovelChapterCount;
  int? readNovelChapterCount;
  String? novelLinkUrl;
  String? indexingGroupName;
  NovelStatus? novelStatus;
  NovelReadingStatus? novelReadingStatus;
  bool? isHidden;
  bool? isInWishList;

  NovelDescriptionModel({
    this.novelId = '',
    this.userId = '',
    this.novelName = '',
    this.novelAuthorName = '',
    this.novelGenre = const [],
    this.novelDescription = '',
    this.novelImageUrl = '',
    this.indexingGroupName = '',
    this.isNovel = true,
    this.totalNovelChapterCount = 0,
    this.readNovelChapterCount = 0,
    this.novelLinkUrl = '',
    String novelStatus = 'production',
    String novelReadingStatus = 'reading',
    this.isHidden = false,
    this.isInWishList = false,
  }) {
    this.novelStatus = Utility.stringToNovelStatus(novelStatus);
    this.novelReadingStatus = Utility.stringToNovelReadingStatus(novelReadingStatus);
  }

  NovelDescriptionModel.fromJson(String tempNovelId, Map<String, dynamic> json) {
    novelId = tempNovelId;
    userId = json[userIdKeyName];
    novelName = json[novelNameKeyName];
    novelAuthorName = json[novelAuthorNameKeyName];
    novelGenre = (json[novelGenreKeyName] as List).map((e) => e.toString()).toList();
    novelDescription = json[novelDescriptionKeyName];
    novelImageUrl = json[novelImageUrlKeyName];
    indexingGroupName = json[indexingGroupNameKeyName];
    isNovel = json[isNovelKeyName] == '1' ? true : false;
    totalNovelChapterCount = json[totalNovelChapterCountKeyName];
    readNovelChapterCount = json[readNovelChapterCountKeyName];
    novelLinkUrl = json[novelLinkUrlKeyName];
    novelStatus = Utility.stringToNovelStatus(json[novelStatusKeyName] ?? '');
    novelReadingStatus = Utility.stringToNovelReadingStatus(json[novelReadingStatusKeyName] ?? '');
    isHidden = json[isHiddenKeyName] == '1' ? true : false;
    isInWishList = json[isInWishListKeyName] == '1' ? true : false;
  }

  NovelDescriptionModel.fromJsonLocal(Map<String, dynamic> json) {
    novelId = json[novelIdKeyName];
    userId = json[userIdKeyName];
    novelName = json[novelNameKeyName];
    novelAuthorName = json[novelAuthorNameKeyName];
    novelGenre = (json[novelGenreKeyName] as List).map((e) => e.toString()).toList();
    novelDescription = json[novelDescriptionKeyName];
    novelImageUrl = json[novelImageUrlKeyName];
    indexingGroupName = json[indexingGroupNameKeyName];
    isNovel = json[isNovelKeyName] == '1' ? true : false;
    totalNovelChapterCount = json[totalNovelChapterCountKeyName];
    readNovelChapterCount = json[readNovelChapterCountKeyName];
    novelLinkUrl = json[novelLinkUrlKeyName];
    novelStatus = Utility.stringToNovelStatus(json[novelStatusKeyName]);
    novelReadingStatus = Utility.stringToNovelReadingStatus(json[novelReadingStatusKeyName]);
    isHidden = json[isHiddenKeyName] == '1' ? true : false;
    isInWishList = json[isInWishListKeyName] == '1' ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[userIdKeyName] = userId;
    data[novelNameKeyName] = novelName;
    data[novelAuthorNameKeyName] = novelAuthorName;
    data[novelGenreKeyName] = novelGenre;
    data[novelDescriptionKeyName] = novelDescription;
    data[novelImageUrlKeyName] = novelImageUrl;
    data[indexingGroupNameKeyName] = indexingGroupName;
    data[isNovelKeyName] = (isNovel ?? false) ? '1' : '0';
    data[totalNovelChapterCountKeyName] = totalNovelChapterCount;
    data[readNovelChapterCountKeyName] = readNovelChapterCount;
    data[novelLinkUrlKeyName] = novelLinkUrl;
    data[novelStatusKeyName] = Utility.novelStatusToString(novelStatus!);
    data[novelReadingStatusKeyName] = Utility.novelReadingStatusToString(novelReadingStatus!);
    data[isHiddenKeyName] = (isHidden ?? false) ? '1' : '0';
    data[isInWishListKeyName] = (isInWishList ?? false) ? '1' : '0';
    return data;
  }

//end of file
}
