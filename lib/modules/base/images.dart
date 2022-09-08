class Images {
  static String asPng(String path) => "assets/images/$path.png";
  static String asJpg(String path) => "assets/images/$path.jpg";

  static String logo = asPng("logo");
  static String login = asPng("login");
  static String anonymous = asPng("anonymous");
  static String noImage = asPng("no_image");
  static String emptyBox = asPng("empty_box");
  static String signIn = asPng("sign_in");
  static String checked = asPng("checked");
  static String customMarker = asPng("yellow-marker");
}
