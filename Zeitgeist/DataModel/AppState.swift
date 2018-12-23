import ReSwift

struct AppState: StateType, Codable
{
   var locationTriggerState = LocationState()
   var timeTriggerState = TimeState()
   var weekdayTriggerState = WeekdayTriggerState()

   var currentRecord: Record? {
      return DBAccess.shared.getToday()
   }
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension AppState
{
   static func reducer(action: Action, state: AppState?) -> AppState {
      var state = state ?? AppState()
      state.locationTriggerState = LocationState.reducer(action: action, state: state.locationTriggerState)
      state.timeTriggerState = TimeState.reducer(action: action, state: state.timeTriggerState)
      state.weekdayTriggerState = WeekdayTriggerState.reducer(action: action, state: state.weekdayTriggerState)

      switch action {
      //        case is ReSwiftInit:
      case is StartAction:
         handleStart(&state)
      case is StopAction:
         handleStop(&state)
      default: break
      }
      return state
   }

   static func handleStart(_ state: inout AppState)
   {
      let today = state.currentRecord
      if today == nil {
         _ = DBAccess.shared.createRecord()
      }
   }

   static func handleStop(_ state: inout AppState)
   {
      guard let today = state.currentRecord else {
         assertionFailure("StopAction failed: TodayRecord doesn't exist!")
         return
      }
      today.end = Date()
   }
}
