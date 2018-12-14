import ReSwift

// --------------------------------------------------------------------------------

struct LocationTriggerState: StateType
{
   var enabled = false
   var region = false

   var startTimeFrame = TimeFrame(startHour: 6, endHour: 10)
   var endTimeFrame = TimeFrame(startHour: 15, endHour: 18)

   var isTimeSelectionViewShown = false
   var isStartTimeSelector = true
}

//MARK: - Reducer

extension LocationTriggerState
{
   static func reducer(action: Action, state: LocationTriggerState?) -> LocationTriggerState {
      var state = state ?? LocationTriggerState()

      switch action {
      case let action as ToggleSelectionViewAction:
         handleToggleTimeSelection(isStartTime: action.isStartTime, state: &state)
      default: break
      }
      return state
   }

   static func handleToggleTimeSelection(isStartTime: Bool, state: inout LocationTriggerState)
   {
      if state.isTimeSelectionViewShown && state.isStartTimeSelector == isStartTime {
         state.isTimeSelectionViewShown = false
      }
      else {
         state.isTimeSelectionViewShown = true
      }

      state.isStartTimeSelector = isStartTime
   }
}
