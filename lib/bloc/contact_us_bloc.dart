import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/contact_us_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsBloc extends Bloc<ContactUsEventBase, ContactUsState> {
  ContactUsBloc();

  @override
  ContactUsState get initialState => Empty();

  @override
  Stream<ContactUsState> mapEventToState(ContactUsEventBase event) async* {
    if (event is ContactUsEvent) {
      yield* _mapContactUsEvent(event);
    }
  }

  Stream<ContactUsState> _mapContactUsEvent(ContactUsEvent event) async* {
    yield ContactUsLoading();
    try {
      ContactUsResponse response =
      await Repository.instance.attemptContactUs(event.body);
      if (response.status == true) {
        yield ContactUsLoaded(response: response);
      } else {
        yield ContactUsError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield ContactUsError(msg: e);
      } else {
        yield ContactUsError(msg: '$e');
      }
    }
  }
}

abstract class ContactUsEventBase extends Equatable {
  ContactUsEventBase();
}

class ContactUsEvent extends ContactUsEventBase {
  Map<String, dynamic> body;

  ContactUsEvent({@required this.body}) : assert(body != null);

  @override
  List<Object> get props => [body];
}

abstract class ContactUsState extends Equatable {
  ContactUsState();

  @override
  List<Object> get props => [];
}

class Empty extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsLoaded extends ContactUsState {
  final ContactUsResponse response;

  ContactUsLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ContactUsError extends ContactUsState {
  final String msg;

  ContactUsError({@required this.msg}) : assert(msg != null);

  @override
  List<Object> get props => [msg];
}
