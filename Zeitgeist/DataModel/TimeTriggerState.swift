import ReSwift

// --------------------------------------------------------------------------------

struct TimeTriggerState: StateType
{
  var startTime = Time(hour: 8, minute: 0)
  var endTime = Time(hour: 18, minute: 0)
}

//MARK: - Reducer

extension TimeTriggerState
{
   static func reducer(action: Action, state: TimeTriggerState?) -> TimeTriggerState {
      var state = state ?? TimeTriggerState()

      switch action {
      case let action as TimeTriggerActions.SetStartTime:
        state.startTime = action.time
      case let action as TimeTriggerActions.SetEndTime:
        state.endTime = action.time
      default: break
      }
      return state
   }
}
