import 'i_provider.dart';
import '../searchers/i_search_result.dart';

abstract class IProviderResult {
  IProvider get provider;

  ISearchResult get searchResult;
}
