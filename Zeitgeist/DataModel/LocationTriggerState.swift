import ReSwift
import CoreLocation

// --------------------------------------------------------------------------------

struct LocationTriggerState: StateType
{
   var currentLocation = CLLocation(latitude: 52.520008, longitude: 13.404954)
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
      case let action as LocationTriggerActions.CurrentLocation:
         state.currentLocation = action.location
      case let action as LocationTriggerActions.StartTimeFrame:
         state.startTimeFrame = action.timeFrame
      case let action as LocationTriggerActions.EndTimeFrame:
         state.endTimeFrame = action.timeFrame
      default: break
      }
      return state
   }

//   static func handleToggleTimeSelection(isStartTime: Bool, state: inout LocationTriggerState)
//   {
//   }
}
