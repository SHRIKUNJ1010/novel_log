import 'package:novel_log/utility/enum_variable_types.dart';

class NovelListItemModel {
  String? novelId;
  String? userId;
  String? novelName;
  String? novelImageUrl;
  int? totalNovelChapterCount;
  int? readNovelChapterCount;
  String? novelLinkUrl;
  bool? isNovel;
  NovelReadingStatus? novelReadingStatus;

  NovelListItemModel({
    this.novelId,
    this.userId,
    this.novelName,
    this.novelImageUrl,
    this.totalNovelChapterCount,
    this.readNovelChapterCount,
    this.novelLinkUrl,
    this.isNovel,
    String novelReadingStatus = '',
  }) {
    switch (novelReadingStatus) {
      case 'not_started':
        this.novelReadingStatus = NovelReadingStatus.notStarted;
        break;
      case 'reading':
        this.novelReadingStatus = NovelReadingStatus.reading;
        break;
      case 'hiatusCompleted':
        this.novelReadingStatus = NovelReadingStatus.hiatusCompleted;
        break;
      case 'completed':
        this.novelReadingStatus = NovelReadingStatus.completed;
        break;
      default:
        this.novelReadingStatus = NovelReadingStatus.reading;
        break;
    }
  }

  NovelListItemModel.fromJson(String givenId, Map<String, dynamic> json) {
    novelId = givenId;
    userId = json['user_id'];
    novelName = json['novel_name'];
    novelImageUrl = json['novel_image_url'];
    totalNovelChapterCount = int.parse(json['total_novel_chapter_count']);
    readNovelChapterCount = int.parse(json['read_novel_chapter_count']);
    novelLinkUrl = json['novel_link_url'];
    isNovel = json['is_novel'] == '1' ? true : false;
    switch (json['novel_reading_status']) {
      case 'not_started':
        novelReadingStatus = NovelReadingStatus.notStarted;
        break;
      case 'reading':
        novelReadingStatus = NovelReadingStatus.reading;
        break;
      case 'hiatus_completed':
        novelReadingStatus = NovelReadingStatus.hiatusCompleted;
        break;
      case 'completed':
        novelReadingStatus = NovelReadingStatus.completed;
        break;
      default:
        novelReadingStatus = NovelReadingStatus.reading;
        break;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['novel_id'] = novelId;
    data['user_id'] = userId;
    data['novel_name'] = novelName;
    data['novel_image_url'] = novelImageUrl;
    data['total_novel_chapter_count'] = totalNovelChapterCount.toString();
    data['read_novel_chapter_count'] = readNovelChapterCount.toString();
    data['novel_link_url'] = novelLinkUrl;
    data['is_novel'] = (isNovel ?? false) ? '1' : '0';
    switch (novelReadingStatus) {
      case NovelReadingStatus.notStarted:
        data['novel_reading_status'] = 'not_started';
        break;
      case NovelReadingStatus.reading:
        data['novel_reading_status'] = 'reading';
        break;
      case NovelReadingStatus.hiatusCompleted:
        data['novel_reading_status'] = 'hiatus_completed';
        break;
      case NovelReadingStatus.completed:
        data['novel_reading_status'] = 'completed';
        break;
      default:
        data['novel_reading_status'] = 'reading';
        break;
    }
    return data;
  }

//end of file
}
