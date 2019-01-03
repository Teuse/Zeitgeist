import ReSwift

struct WeekdayState: StateType, Codable
{
   let weekdayTrigger = WeekTrigger()
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension WeekdayState
{
   static func reducer(action: Action, state: WeekdayState?) -> WeekdayState {
      let state = state ?? WeekdayState()

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
