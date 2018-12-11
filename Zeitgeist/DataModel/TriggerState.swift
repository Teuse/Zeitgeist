import ReSwift



struct LocationTrigger {
   var enabled = false
   var startTime = Time()
   var endTime = Time()
   var region: Int = 0
}

struct TimeTrigger {
   var enabled = false
   var time = Time()
}

// --------------------------------------------------------------------------------

struct TriggerState: StateType
{
   var startLocationTigger = LocationTrigger()
   var endLocationTrigger = LocationTrigger()

   var startTimeTrigger = TimeTrigger()
   var endTimeTrigger = TimeTrigger()

   let weekdayTrigger = WeekTrigger()

   static func reducer(action: Action, state: TriggerState?) -> TriggerState {
      let state = state ?? TriggerState()

      switch action {
      case let action as WeekdayAction:
         state.weekdayTrigger.set(weekday: action.weekday, selected: action.selected)
      default: break
      }
      return state
   }
}
