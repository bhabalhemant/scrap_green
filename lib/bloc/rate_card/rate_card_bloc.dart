import 'package:scrapgreen/bloc/rate_card/rate_card_event.dart';
import 'package:scrapgreen/bloc/rate_card/rate_card_state.dart';
import 'package:scrapgreen/models/response/rate_card_response.dart';
import 'package:scrapgreen/models/response/profile_update_response.dart';
import 'package:scrapgreen/repository/repository.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class RateCardBloc extends Bloc<RateCardEvent, RateCardState> {
  RateCardBloc();

  @override
  RateCardState get initialState => RateCardEmpty();

  @override
  Stream<RateCardState> mapEventToState(RateCardEvent event) async* {
    print(event);
    if (event is GetRateCard) {
      yield* _mapGetRateCardToState(event);
    } else if (event is UpdateRateCard) {
      yield* _mapUpdateProfileToState(event);
    }
  }

  Stream<RateCardState> _mapGetRateCardToState(GetRateCard event) async* {
    yield RateCardLoading();
    try {
//      print('try');
      RateCardResponse response = await Repository.instance.getAllRateCards();
      print(response.status);
//      RateCardResponse storedData =
//          await Repository.instance.getStoredRateCards();
//      if (storedData != null) {
//        RateCardResponse response = await Repository.instance.getAllRateCards();
//        print(response.data);
//        bool isStored =
//            await Repository.instance.storeRateCardData(response.toJson());
        if (response.status == true) {
          yield RateCardLoaded(response: response);
        } else {
          yield RateCardError(msg: 'Failed to store user data!');
        }
//      } else {
//        yield RateCardError(msg: 'Failed to get stored user data!');
//      }
    } catch (e) {

      if (e is String) {
        print('no1'+e);
        yield RateCardError(msg: e);
      } else {
        print('no2$e');
        yield RateCardError(msg: '$e');
      }
    }
  }

  Stream<RateCardState> _mapUpdateProfileToState(UpdateRateCard event) async* {
    yield RateCardLoading();
    try {
      ProfileUpdateResponse response =
          await Repository.instance.updateUserProfile(event.body);
      if (response.status) {
        yield RateCardUpdated(response: response);
      } else {
        yield RateCardError(msg: response.msg);
      }
    } catch (e) {
      if (e is String) {
        yield RateCardError(msg: e);
      } else {
        yield RateCardError(msg: '$e');
      }
    }
  }
}
