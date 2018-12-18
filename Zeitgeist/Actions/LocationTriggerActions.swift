import Foundation
import ReSwift
import CoreLocation


struct LocationTriggerActions
{
  struct CurrentLocation: Action {
    let location: CLLocation
  }

  struct StartTimeFrame: Action {
    let timeFrame: TimeFrame
  }

  struct EndTimeFrame: Action {
    let timeFrame: TimeFrame
  }
}
