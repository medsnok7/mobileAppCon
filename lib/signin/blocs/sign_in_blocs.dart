import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileappconcorde/signin/blocs/sign_in_events.dart';
import 'package:mobileappconcorde/signin/blocs/sign_in_states.dart';

class SignInBlocs extends Bloc<SignInEvents,SignInStates> {
  SignInBlocs():super(SignInStates());
}
