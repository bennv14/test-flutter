class ResponseModel {
  final FileModel file;
  final int id;
  final String name;

  const ResponseModel({
    required this.file,
    required this.id,
    required this.name,
  });
}

class FileModel {
  final String url;
  final FileTypes type;

  const FileModel({
    required this.url,
    required this.type,
  });
}

enum FileTypes {
  image,
  audio,
}

const List<ResponseModel> mock = [
  ResponseModel(
    file: FileModel(
      url:
          "https://raw.githubusercontent.com/bennv14/test-flutter/refs/heads/test/cache/assets/images/pic_1.jpg",
      type: FileTypes.image,
    ),
    id: 1,
    name: "Pic 1",
  ),
  ResponseModel(
    file: FileModel(
      url:
          "https://raw.githubusercontent.com/bennv14/test-flutter/refs/heads/test/cache/assets/images/pic_2.jpg",
      type: FileTypes.image,
    ),
    id: 2,
    name: "Pic 2",
  ),
  ResponseModel(
    file: FileModel(
      url:
          "https://raw.githubusercontent.com/bennv14/test-flutter/refs/heads/test/cache/assets/images/pic_3.png",
      type: FileTypes.image,
    ),
    id: 3,
    name: "Pic 3",
  ),
  ResponseModel(
    file: FileModel(
      url:
          "https://raw.githubusercontent.com/bennv14/test-flutter/refs/heads/test/cache/assets/images/pic_4.jpg",
      type: FileTypes.image,
    ),
    id: 4,
    name: "Pic 4",
  ),
];
