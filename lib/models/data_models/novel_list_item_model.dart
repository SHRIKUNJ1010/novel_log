import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/utility.dart';

class NovelListItemModel {
  String? novelId;
  String? userId;
  String? novelName;
  String? novelImageUrl;
  String? novelAuthorName;
  String? novelDescription;
  List<String>? novelGenre;
  int? totalNovelChapterCount;
  int? readNovelChapterCount;
  String? novelLinkUrl;
  bool? isNovel;
  NovelReadingStatus? novelReadingStatus;

  NovelListItemModel({
    this.novelId,
    this.userId,
    this.novelName,
    this.novelAuthorName,
    this.novelDescription,
    this.novelGenre,
    this.novelImageUrl,
    this.totalNovelChapterCount,
    this.readNovelChapterCount,
    this.novelLinkUrl,
    this.isNovel,
    String novelReadingStatus = '',
  }) {
    this.novelReadingStatus = Utility.stringToNovelReadingStatus(novelReadingStatus);
  }

  NovelListItemModel.fromJson(String givenId, Map<String, dynamic> json) {
    novelId = givenId;
    userId = json['user_id'];
    novelName = json['novel_name'];
    novelAuthorName = json['novel_author_name'];
    novelDescription = json['novel_description'];
    novelGenre = (json['novel_genre'] as List).map((item) => item as String).toList();
    novelImageUrl = json['novel_image_url'];
    totalNovelChapterCount = int.parse(json['total_novel_chapter_count']);
    readNovelChapterCount = int.parse(json['read_novel_chapter_count']);
    novelLinkUrl = json['novel_link_url'];
    isNovel = json['is_novel'] == '1' ? true : false;
    novelReadingStatus = Utility.stringToNovelReadingStatus(json['novel_reading_status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['novel_id'] = novelId;
    data['user_id'] = userId;
    data['novel_name'] = novelName;
    data['novel_author_name'] = novelAuthorName;
    data['novel_genre'] = novelGenre;
    data['novel_description'] = novelDescription;
    data['novel_image_url'] = novelImageUrl;
    data['total_novel_chapter_count'] = totalNovelChapterCount.toString();
    data['read_novel_chapter_count'] = readNovelChapterCount.toString();
    data['novel_link_url'] = novelLinkUrl;
    data['is_novel'] = (isNovel ?? false) ? '1' : '0';
    data['novel_reading_status'] = Utility.novelReadingStatusToString(novelReadingStatus!);
    return data;
  }

//end of file
}
