import 'package:novel_log/utility/enum_variable_types.dart';

class NovelDiscriptionModel {
  String? novelId;
  String? novelName;
  String? novelAuthorName;
  String? novelGenre;
  String? novelDiscription;
  String? novelImageUrl;
  bool? isNovel;
  int? totalNovelChapterCount;
  int? readNovelChapterCount;
  String? novelLinkUrl;
  NovelStatus? novelStatus;
  NovelReadingStatus? novelReadingStatus;
  bool? isHidden;
  bool? isInWishList;

  NovelDiscriptionModel({
    this.novelId,
    this.novelName,
    this.novelAuthorName,
    this.novelGenre,
    this.novelDiscription,
    this.novelImageUrl,
    this.isNovel,
    this.totalNovelChapterCount,
    this.readNovelChapterCount,
    this.novelLinkUrl,
    String novelStatus = '',
    String novelReadingStatus = '',
    this.isHidden,
    this.isInWishList,
  }) {
    switch (novelStatus) {
      case 'production':
        this.novelStatus = NovelStatus.production;
        break;
      case 'hiatus':
        this.novelStatus = NovelStatus.hiatus;
        break;
      case 'completed':
        this.novelStatus = NovelStatus.completed;
        break;
      default:
        this.novelStatus = NovelStatus.production;
        break;
    }
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

  NovelDiscriptionModel.fromJson(Map<String, dynamic> json) {
    novelId = json['novel_id'];
    novelName = json['novel_name'];
    novelAuthorName = json['novel_author_name'];
    novelGenre = json['novel_genre'];
    novelDiscription = json['novel_discription'];
    novelImageUrl = json['novel_image_url'];
    isNovel = json['is_novel'] == '1' ? true : false;
    totalNovelChapterCount = json['total_novel_chapter_count'];
    readNovelChapterCount = json['read_novel_chapter_count'];
    novelLinkUrl = json['novel_link_url'];
    switch (json['novel_status']) {
      case 'production':
        novelStatus = NovelStatus.production;
        break;
      case 'hiatus':
        novelStatus = NovelStatus.hiatus;
        break;
      case 'completed':
        novelStatus = NovelStatus.completed;
        break;
      default:
        novelStatus = NovelStatus.production;
        break;
    }
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
    isHidden = json['is_hidden'] == '1' ? true : false;
    isInWishList = json['is_in_wish_list'] == '1' ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['novel_id'] = novelId;
    data['novel_name'] = novelName;
    data['novel_author_name'] = novelAuthorName;
    data['novel_genre'] = novelGenre;
    data['novel_discription'] = novelDiscription;
    data['novel_image_url'] = novelImageUrl;
    data['is_novel'] = (isNovel ?? false) ? '1' : '0';
    data['total_novel_chapter_count'] = totalNovelChapterCount;
    data['read_novel_chapter_count'] = readNovelChapterCount;
    data['novel_link_url'] = novelLinkUrl;
    switch (novelStatus) {
      case NovelStatus.production:
        data['novel_status'] = 'production';
        break;
      case NovelStatus.hiatus:
        data['novel_status'] = 'hiatus';
        break;
      case NovelStatus.completed:
        data['novel_status'] = 'completed';
        break;
      default:
        data['novel_status'] = 'production';
        break;
    }
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
    data['is_hidden'] = (isHidden ?? false) ? '1' : '0';
    data['is_in_wish_list'] = (isInWishList ?? false) ? '1' : '0';
    return data;
  }
}
