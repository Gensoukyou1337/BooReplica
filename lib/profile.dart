class Profile {
  String? name;
  bool? isVerified;
  String? location;
  List<String>? profileTags;
  List<String>? personalityTags;
  ProfileDetails? profileDetails;
  Posts? posts;
  Comments? comments;
  
  Profile({
    this.name,
    this.isVerified,
    this.location,
    this.profileTags,
    this.personalityTags,
    this.profileDetails,
    this.posts,
    this.comments
  });
}

class ProfileDetails {
  String? lookingFor; //Should be an enum between Dating and Friends
  String? profileSummary;
  List<String>? maritalStatusTags;
  List<String>? interestsTags;
  List<String>? languages;
  List<String>? photoUrls;
  List<Prompt>? prompts;
  String? sixteenType;
  List<String>? sortedCogFunctions;
  String? zodiac;

  ProfileDetails({
    this.lookingFor,
    this.profileSummary,
    this.maritalStatusTags,
    this.interestsTags,
    this.languages,
    this.photoUrls,
    this.prompts,
    this.sixteenType,
    this.sortedCogFunctions,
    this.zodiac
  });
}

class Posts {
  List<String>? postsStrings;

  Posts({this.postsStrings});
}

class Comments {
  List<String>? commentsStrings;

  Comments({this.commentsStrings});
}

class Prompt {
  String? title;
  String? content;

  Prompt({this.title, this.content});
}