import ReSwift

struct WeekdayTriggerState: StateType, Codable
{
   let weekdayTrigger = WeekTrigger()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension WeekdayTriggerState
{
   static func reducer(action: Action, state: WeekdayTriggerState?) -> WeekdayTriggerState {
      let state = state ?? WeekdayTriggerState()

      switch action {
      case is ReSwiftInit:
         state.weekdayTrigger.selectWorkdays()
      case let action as TimeActions.SelectRepeat:
         state.weekdayTrigger.set(weekday: action.weekday, selected: action.selected)
      default: break
      }
      return state
   }
}
