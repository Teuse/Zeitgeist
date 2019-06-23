import ReSwift

struct AppState: StateType, Codable
{
   var recordingState = RecordingState()
   var calendarState = CalendarState()
   var locationState = LocationState()
   var timeState = TimeState()
   var weekdayState = WeekdayState()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension AppState
{
   static func reducer(action: Action, state: AppState?) -> AppState {
      var state = state ?? AppState()
      state.recordingState = RecordingState.reducer(action: action, state: state.recordingState)
      state.locationState = LocationState.reducer(action: action, state: state.locationState)
      state.timeState = TimeState.reducer(action: action, state: state.timeState)
      state.weekdayState = WeekdayState.reducer(action: action, state: state.weekdayState)

      return state
   }
}
