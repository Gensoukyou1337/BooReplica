import 'profile.dart';

Profile getMockProfile() {
  return Profile(
    name: "ABCD",
    isVerified: false,
    location: "aaaa, bbbb",
    profileTags: ["Online", "New Soul"],
    personalityTags: ["26", "INTP", "Taurus"],
    profileDetails: ProfileDetails(
      lookingFor: "Friends",
      profileSummary: "Hello",
      maritalStatusTags: ["Heterosexual", "Single"],
      interestsTags: ["music", "gaming"],
      languages: ["English"],
      photoUrls: ["", "", ""],
      prompts: [Prompt(title: "I can give you what you want.", content: "You just need to ask.")],
      sixteenType: "INTP",
      sortedCogFunctions: ["Fi"],
      zodiac: "Taurus"
    ),
    posts: null,
    comments: null
  );
}