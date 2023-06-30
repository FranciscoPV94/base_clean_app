import 'package:default_app/data/datasource/session_datasource_imp.dart';

class TokenFacade {
  Future<String?> getRefreshToken() async =>
      SessionDatasource().getRefreshToken();
}
