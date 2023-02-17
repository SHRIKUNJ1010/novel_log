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
    userId = json['user_id'];
    novelName = json['novel_name'];
    novelAuthorName = json['novel_author_name'];
    novelGenre = (json['novel_genre'] as List).map((e) => e.toString()).toList();
    novelDescription = json['novel_description'];
    novelImageUrl = json['novel_image_url'];
    indexingGroupName = json['indexing_group_name'];
    isNovel = json['is_novel'] == '1' ? true : false;
    totalNovelChapterCount = json['total_novel_chapter_count'];
    readNovelChapterCount = json['read_novel_chapter_count'];
    novelLinkUrl = json['novel_link_url'];
    novelStatus = Utility.stringToNovelStatus(json['novel_status']);
    novelReadingStatus = Utility.stringToNovelReadingStatus(json['novel_reading_status']);
    isHidden = json['is_hidden'] == '1' ? true : false;
    isInWishList = json['is_in_wish_list'] == '1' ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['novel_name'] = novelName;
    data['novel_author_name'] = novelAuthorName;
    data['novel_genre'] = novelGenre;
    data['novel_description'] = novelDescription;
    data['novel_image_url'] = novelImageUrl;
    data['indexing_group_name'] = indexingGroupName;
    data['is_novel'] = (isNovel ?? false) ? '1' : '0';
    data['total_novel_chapter_count'] = totalNovelChapterCount;
    data['read_novel_chapter_count'] = readNovelChapterCount;
    data['novel_link_url'] = novelLinkUrl;
    data['novel_status'] = Utility.novelStatusToString(novelStatus!);
    data['novel_reading_status'] = Utility.novelReadingStatusToString(novelReadingStatus!);
    data['is_hidden'] = (isHidden ?? false) ? '1' : '0';
    data['is_in_wish_list'] = (isInWishList ?? false) ? '1' : '0';
    return data;
  }

//end of file
}
