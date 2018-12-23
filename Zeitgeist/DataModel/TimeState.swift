import ReSwift

// --------------------------------------------------------------------------------

struct TimeState: StateType, Codable
{
   var enabled = false
   var startTime = Time(hour: 8, minute: 0)
   var endTime = Time(hour: 18, minute: 0)
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension TimeState
{
   static func reducer(action: Action, state: TimeState?) -> TimeState {
      var state = state ?? TimeState()
      
      switch action {
      case let action as TimeActions.EnableTrigger:
         state.enabled = action.enabled
      case let action as TimeActions.SetStartTime:
         state.startTime = action.time
      case let action as TimeActions.SetEndTime:
         state.endTime = action.time
      default: break
      }
      return state
   }
}
