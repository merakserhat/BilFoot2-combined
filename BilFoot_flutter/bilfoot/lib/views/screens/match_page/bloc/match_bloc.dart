import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc() : super(const MatchState()) {
    on<MatchGetMatches>(_matchGetMatches);
  }

  _matchGetMatches(MatchGetMatches event, Emitter<MatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    Map<String, List<MatchModel>>? matches = await BilfootClient().getMatches();

    if (matches != null) {
      emit(
        MatchState(
            pastMatches: matches["past_matches"],
            upcomingMatches: matches["upcoming_matches"],
            isLoading: false),
      );
    }
  }
}
