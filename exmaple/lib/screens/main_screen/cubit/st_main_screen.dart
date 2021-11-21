abstract class StMainScreen{}

class StMainScreenInit extends StMainScreen{}

class StMainScreenLoaded extends StMainScreen{}

class StMainScreenLoading extends StMainScreen{}

class StMainScreenNoAuthError extends StMainScreen{}

class StMainScreenNoInternetError extends StMainScreen {}

class StMainScreenError extends StMainScreen{
  final int? error;
  final String? message;
  StMainScreenError({this.error,this.message});
}
    