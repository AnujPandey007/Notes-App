import 'package:hive/hive.dart';

part 'social-post.g.dart';

//This is a model for social post

@HiveType()
class SocialPost {
 @HiveField(0)
 final String title;
 @HiveField(1)
 final String description;
 @HiveField(2)
 final String image;
 @HiveField(3)
 final String author;
 @HiveField(4)
 final String avatar;
 @HiveField(5)
 final String topic;
 @HiveField(6)
 final String comments;
 @HiveField(7)
 final String upvotes;
 @HiveField(8)
 final String downvotes;

 SocialPost(this.title, this.description, this.image, this.author, this.avatar, this.topic, this.comments, this.upvotes, this.downvotes);
}