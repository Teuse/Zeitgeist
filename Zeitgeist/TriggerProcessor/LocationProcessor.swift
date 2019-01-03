import Foundation
import CoreLocation

class LocationProcessor: NSObject
{
   private let locationManager = CLLocationManager()
   private let regionId = "LocationTriggerRegion"
   private var region: CLCircularRegion?

   weak var deleate: ProcessorDelegate?
   
   var timeFrameEnalbed = true
   var startTimeFrame = TimeFrame()
   var stopTimeFrame = TimeFrame()

   // --------------------------------------------------------------------------------

   func monitorRegion(center: CLLocationCoordinate2D, radius: CLLocationDistance)
   {
      let region = CLCircularRegion(center: center, radius: radius, identifier: regionId)
      self.region = region
      region.notifyOnEntry = true
      region.notifyOnExit = true
      locationManager.startMonitoring(for: region)
   }

   func stopMonitoring()
   {
      if let reg = region {
         locationManager.stopMonitoring(for: reg)
      }
      region = nil
   }

   // --------------------------------------------------------------------------------

   private func isInTimeFrame(_ timeFrame: TimeFrame) -> Bool
   {
      let now = Time(date: Date())
      return timeFrameEnalbed
         && now >= timeFrame.begin
         && now < timeFrame.end
   }
}

// --------------------------------------------------------------------------------
//MARK: - LocationManager

extension LocationProcessor: CLLocationManagerDelegate
{
   func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
   {
      guard region.identifier == regionId else {
         print("LocationTriggerProcessor: Received didEnterRegion event with unknown ID: \(region.identifier)")
         return
      }

      if isInTimeFrame(startTimeFrame) {
         print("LocationProcessor will trigger start")
         deleate?.processorTriggeredStart()
      }
   }

   func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
   {
      guard region.identifier == regionId else {
         print("LocationTriggerProcessor: Received didExitRegion event with unknown ID: \(region.identifier)")
         return
      }

      if isInTimeFrame(stopTimeFrame) {
         print("LocationProcessor will trigger end")
         deleate?.processorTriggeredEnd()
      }
   }
}
