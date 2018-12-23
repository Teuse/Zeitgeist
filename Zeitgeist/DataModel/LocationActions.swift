import Foundation
import ReSwift
import CoreLocation

struct LocationActions
{
   struct EnableTrigger: Action {
      let enabled: Bool
   }
   
   struct StartTimeFrame: Action {
      let timeFrame: TimeFrame
   }
   
   struct EndTimeFrame: Action {
      let timeFrame: TimeFrame
   }

   struct CurrentLocation: Action {
      let location: Coordinate
   }

   struct UpdateMonitoringRegion: Action {
      let coordinate: CLLocationCoordinate2D
      let radius: CLLocationDistance
   }
}
