import UIKit
import ReSwift
import MapKit
import CoreLocation

class MapViewController: UIViewController
{
   let locationManager = CLLocationManager()
   var selectedLocation = CLLocation()

   @IBOutlet weak var mapView: MKMapView!


   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.locationTriggerState }
      }
      mapView.showsUserLocation = true
      mapView.delegate = self

      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
   }

   override func viewDidLoad()
   {
      enableLocationServices()
   }

   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      locationManager.stopUpdatingLocation()
      unsubscribe(self)
   }

   private func enableLocationServices()
   {
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined:
         locationManager.requestAlwaysAuthorization()
      case .restricted:
         showDeniedAlert(withTitle: "Location Service Restricted", text: "Blub")
      case .denied:
         showDeniedAlert(withTitle: "Location Service Denied", text: "Blub")
      case .authorizedWhenInUse:
         showRestrictedLocationServiceWarning()
      case .authorizedAlways:
         break
      }
   }

   private func showDeniedAlert(withTitle title: String, text: String)
   {
      let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
         self.navigationController?.popViewController(animated: true)
      }))
      present(alert, animated: true, completion: nil)
   }

   private func showRestrictedLocationServiceWarning()
   {
      let alert = UIAlertController(title: "Location Access Restricted", message: "With restricted access, it is not possible to use this trigger while app is closed!", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
   }

   private func addCircle(at location: CLLocation, radius: Double)
   {
      let region = CLCircularRegion(center: location.coordinate, radius: radius, identifier: "geofence")
      mapView.removeOverlays(mapView.overlays)
      locationManager.startMonitoring(for: region)
      let circle = MKCircle(center: location.coordinate, radius: region.radius)
      mapView.addOverlay(circle)
   }

   private func center(to location: CLLocation)
   {
      let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
      let region = MKCoordinateRegion(center: location.coordinate, span: span)

      mapView.setRegion(region, animated: true)
   }
}

extension MapViewController: StoreSubscriber
{
   func newState(state: LocationTriggerState)
   {
      if selectedLocation != state.currentLocation {
         selectedLocation = state.currentLocation
         center(to: selectedLocation)
         addCircle(at: selectedLocation, radius: 4000)
      }
   }
}

extension MapViewController: CLLocationManagerDelegate
{


   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
   {
      switch status {
      case .restricted, .denied:
         self.navigationController?.popViewController(animated: true)
      default:
         enableLocationServices()
      }
   }

   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
   {
      if let location = locations.last {
         center(to: location)
         locationManager.stopUpdatingLocation()
      }
   }
}

extension MapViewController: MKMapViewDelegate
{
   func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
   {
      guard let circelOverLay = overlay as? MKCircle else {
         return MKOverlayRenderer()
      }

      let circleRenderer = MKCircleRenderer(circle: circelOverLay)
      circleRenderer.strokeColor = .blue
      circleRenderer.fillColor = .blue
      circleRenderer.alpha = 0.2
      return circleRenderer
   }
}
