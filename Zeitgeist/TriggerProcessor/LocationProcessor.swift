import Foundation
import CoreLocation

class LocationProcessor: NSObject
{
   let locationManager = CLLocationManager()
   let regionId = "LocationTriggerRegion"

   func monitorRegion(center: CLLocationCoordinate2D, radius: CLLocationDistance)
   {
      let region = CLCircularRegion(center: center, radius: radius, identifier: regionId)
      region.notifyOnEntry = true
      region.notifyOnExit = true
      locationManager.startMonitoring(for: region)
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

      //      if let region = region as? CLCircularRegion
      //      {
      print("Enter Region")
      //      }
   }

   func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
   {
      guard region.identifier == regionId else {
         print("LocationTriggerProcessor: Received didExitRegion event with unknown ID: \(region.identifier)")
         return
      }

      //      if let region = region as? CLCircularRegion
      //      {
      print("Exit Region")
      //      }
   }
}
