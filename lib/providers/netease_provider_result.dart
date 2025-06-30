import 'i_provider.dart';
import 'i_provider_result.dart';
import '../searchers/i_search_result.dart';

class NeteaseProviderResult implements IProviderResult {
  @override
  IProvider get provider => throw UnimplementedError();

  @override
  ISearchResult get searchResult => throw UnimplementedError();
} 