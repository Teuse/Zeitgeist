import ReSwift

// --------------------------------------------------------------------------------

struct TimeTriggerState: StateType
{
   var enabled = false
   var startTime = Time(hour: 8, minute: 0)
   var endTime = Time(hour: 18, minute: 0)
}

//MARK: - Reducer

extension TimeTriggerState
{
   static func reducer(action: Action, state: TimeTriggerState?) -> TimeTriggerState {
      var state = state ?? TimeTriggerState()
      
      switch action {
      case let action as TimeActions.SetStartTime:
         state.startTime = action.time
      case let action as TimeActions.SetEndTime:
         state.endTime = action.time
      default: break
      }
      return state
   }
}
