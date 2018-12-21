import ReSwift

struct TimeTrigger {
   var enabled = false
   var time = Time()
}

// --------------------------------------------------------------------------------

struct WeekdayTriggerState: StateType
{
   let weekdayTrigger = WeekTrigger()

   static func reducer(action: Action, state: WeekdayTriggerState?) -> WeekdayTriggerState {
      let state = state ?? WeekdayTriggerState()

      switch action {
      case let action as TimeActions.SelectRepeat:
         state.weekdayTrigger.set(weekday: action.weekday, selected: action.selected)
      default: break
      }
      return state
   }
}
