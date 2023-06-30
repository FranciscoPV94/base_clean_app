String getFileExtension(String filePath) {
  final extensions = [
    'doc',
    'docx',
    'jpeg',
    'jpg',
    'pdf',
    'png',
    'ppt',
    'pptx',
    'txt',
    'xlsx',
    'xsl',
    'tiff',
    'tif'
  ];
  final reversedStr = filePath.split('').reversed.join();
  final strArr = reversedStr.split('.');
  final fileExtension = strArr[0].split('').reversed.join().toLowerCase();
  if (!extensions.contains(fileExtension)) {
    return 'unknow';
  }
  return fileExtension;
}

String getFileName(String filePath) {
  try {
    final reversedStr = filePath.split('/').reversed;
    return reversedStr.first;
  } catch (e) {
    return filePath;
  }
}
