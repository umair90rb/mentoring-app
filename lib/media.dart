import 'package:audio_service/audio_service.dart';

class MediaLibrary {

  var _items = <MediaItem>[];

  MediaLibrary(this._items);

  List<MediaItem> get items => _items;

}