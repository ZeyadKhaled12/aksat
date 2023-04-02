import 'package:equatable/equatable.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repository/base_ap_repo.dart';

class SearchUc
    extends BaseUseCaseInside<String, SearchParameters> {
  final BaseApRepo baseAcsRepo;

  SearchUc(this.baseAcsRepo);

  @override
  String change(SearchParameters parameters) {
    return baseAcsRepo.acsSearch(parameters);
  }

}

class SearchParameters extends Equatable {
  final String text;

  const SearchParameters({required this.text});

  @override
  List<Object> get props => [text];
}
