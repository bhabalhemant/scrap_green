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
      RateCardResponse storedData =
          await Repository.instance.getStoredRateCards();
      print('storedData${storedData}');
      if (storedData != null) {
//        Map<String, String> body = {Constants.PARAM_ID: storedData.data.id};
        RateCardResponse response = await Repository.instance.getAllRateCards();
        bool isStored =
            await Repository.instance.storeRateCardData(response.toJson());
//        print('test ${isStored}');
        if (isStored) {
          yield RateCardLoaded(response: response);
        } else {
          yield RateCardError(msg: 'Failed to store user data!');
        }
      } else {
        yield RateCardError(msg: 'Failed to get stored user data!');
      }
    } catch (e) {
      if (e is String) {
        yield RateCardError(msg: e);
      } else {
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
