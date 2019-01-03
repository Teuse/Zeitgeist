import ReSwift
import CoreLocation

struct LocationState: StateType, Codable
{
//   let locationManager = CLLocationManager()

   var enabled = false
   var region = false
   var currentLocation = Coordinate(latitude: 52.520008, longitude: 13.404954)

   var timeFrameEnabled = true
   var startTimeFrame = TimeFrame(startHour: 6, endHour: 10)
   var endTimeFrame = TimeFrame(startHour: 15, endHour: 18)

   var isTimeSelectionViewShown = false
   var isStartTimeSelector = true
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension LocationState
{
   static func reducer(action: Action, state: LocationState?) -> LocationState {
      var state = state ?? LocationState()

      switch action {
      case let action as LocationActions.EnableTrigger:
         state.enabled = action.enabled
      case let action as LocationActions.CurrentLocation:
         state.currentLocation = action.location
      case let action as LocationActions.StartTimeFrame:
         state.startTimeFrame = action.timeFrame
      case let action as LocationActions.EndTimeFrame:
         state.endTimeFrame = action.timeFrame
      default: break
      }
      return state
   }

//   static func handleEnableTrigger(enable: Bool, state: inout LocationTriggerState)
//   {
//   }
}
