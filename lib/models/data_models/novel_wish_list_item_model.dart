import 'package:novel_log/utility/enum_variable_types.dart';

class NovelWishListItemModel {
  String? novelId;
  String? userId;
  String? novelName;
  String? novelAuthorName;
  String? novelGenre;
  String? novelImageUrl;
  bool? isNovel;
  int? totalNovelChapterCount;
  String? novelLinkUrl;
  NovelStatus? novelStatus;

  NovelWishListItemModel({
    this.novelId,
    this.userId,
    this.novelName,
    this.novelAuthorName,
    this.novelGenre,
    this.novelImageUrl,
    this.isNovel,
    this.totalNovelChapterCount,
    this.novelLinkUrl,
    String novelStatus = '',
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
  }

  NovelWishListItemModel.fromJson(String givenId, Map<String, dynamic> json) {
    novelId = givenId;
    userId = json['user_id'];
    novelName = json['novel_name'];
    novelAuthorName = json['novel_author_name'];
    novelGenre = json['novel_genre'];
    novelImageUrl = json['novel_image_url'];
    isNovel = json['is_novel'] == '1' ? true : false;
    totalNovelChapterCount = json['total_novel_chapter_count'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['novel_id'] = novelId;
    data['user_id'] = userId;
    data['novel_name'] = novelName;
    data['novel_author_name'] = novelAuthorName;
    data['novel_genre'] = novelGenre;
    data['novel_image_url'] = novelImageUrl;
    data['is_novel'] = (isNovel ?? false) ? '1' : '0';
    data['total_novel_chapter_count'] = totalNovelChapterCount;
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
    return data;
  }

//end of file
}
