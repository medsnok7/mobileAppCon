import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileappconcorde/signup/blocs/sign_up_events.dart';
import 'package:mobileappconcorde/signup/blocs/sign_up_states.dart';

class SignUpBlocs extends Bloc<SignUpEvents, SignUpStates> {
  SignUpBlocs() : super(SignUpStates());
}
