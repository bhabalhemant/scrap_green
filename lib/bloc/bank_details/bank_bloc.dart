import 'package:scrapgreen/bloc/bank_details/bank_event.dart';
import 'package:scrapgreen/bloc/bank_details/bank_state.dart';
import 'package:scrapgreen/models/response/bank_details_response.dart';
import 'package:scrapgreen/models/response/profile_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  BankBloc();

  @override
  BankState get initialState => BankEmpty();

  @override
  Stream<BankState> mapEventToState(BankEvent event) async* {
    if (event is GetBank) {
      yield* _mapGetBank(event);
    } else if (event is UpdateBank) {
      yield* _mapUpdateBank(event);
    } else if (event is AddBank) {
      yield* _mapAddBank(event);
    }
  }

  Stream<BankState> _mapGetBank(GetBank event) async* {
    yield BankLoading();
    try {
      ProfileResponse storedData =
          await Repository.instance.getStoredUserData();
//      print('storedData');
      if (storedData != null && storedData.data.id != null) {
//        Map<String, String> body = {Constants.PARAM_ID: storedData.data.id};
        BankDetailsResponse response = await Repository.instance.getBankDetailsData(storedData.data.id);
        bool isStored = await Repository.instance.storeBankDetailsData(response.toJson());
        if (response.status) {
          yield BankLoaded(response: response);
        } else {
          yield BankError(msg: response.msg);
        }
      } else {
        yield BankError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield BankError(msg: e);
      } else {
        yield BankError(msg: '$e');
      }
    }
  }

  Stream<BankState> _mapUpdateBank(UpdateBank event) async* {
    yield BankLoading();
    try {
      ProfileUpdateResponse response = await Repository.instance.updateBankDetails(event.body);
      if (response.status) {
        yield BankUpdated(response: response);
      } else {
        yield BankError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield BankError(msg: e);
      } else {
        yield BankError(msg: '$e');
      }
    }
  }

  Stream<BankState> _mapAddBank(AddBank event) async* {
    yield BankLoading();
    try {
      ProfileUpdateResponse response = await Repository.instance.addBankDetails(event.body);
      if (response.status) {
        yield BankUpdated(response: response);
      } else {
        yield BankError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield BankError(msg: e);
      } else {
        yield BankError(msg: '$e');
      }
    }
  }
}
