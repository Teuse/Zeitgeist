import UIKit
import ReSwift
import MapKit
import CoreLocation

class MapViewController: UIViewController
{
   let locationManager = CLLocationManager()
   var selectedLocation = Coordinate()
   var timer: Timer?

   @IBOutlet weak var mapView: MKMapView!
   @IBOutlet weak var searchRadiusLabel: UILabel!
   @IBOutlet weak var centerPositionButton: UIButton!
   @IBOutlet weak var circleImage: UIImageView!

   // --------------------------------------------------------------------------------

   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.locationState }
      }

      centerPositionButton.backgroundColor = UIColor.white
      centerPositionButton.layer.cornerRadius = 5
      centerPositionButton.titleLabel?.text = "P"

      mapView.showsUserLocation = true
      mapView.delegate = self
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()

      timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
         self.updateRadiusLabel()
      }
   }

   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      locationManager.stopUpdatingLocation()
      timer = nil
      unsubscribe(self)
   }

   // --------------------------------------------------------------------------------

   private func center(to location: Coordinate)
   {
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let locCoord2D = CLLocationCoordinate2D(location)
      let region = MKCoordinateRegion(center: locCoord2D, span: span)
      mapView.setRegion(region, animated: true)
   }

   private func getRadius() -> CLLocationDistance
   {
      let center = MKMapPoint(mapView.centerCoordinate)
      let edgePos = CGPoint(x: circleImage.frame.origin.x, y: circleImage.center.y)
      let touchCoordinate = mapView.convert(edgePos, toCoordinateFrom: mapView)
      let edge = MKMapPoint(touchCoordinate)
      return center.distance(to: edge)
   }

   private func updateRadiusLabel()
   {
      let radius = Double(getRadius())
      if radius < 1000 {
         searchRadiusLabel.text = "Radius: \(Int(radius)) m"
      } else {
         searchRadiusLabel.text = String(format: "Radius: %.02f km", (radius / 1000))
      }
   }

   @IBAction private func onLocateMeButton(_ sender: UIButton)
   {
      locationManager.startUpdatingLocation()
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension MapViewController: StoreSubscriber
{
   func newState(state: LocationState)
   {
      if selectedLocation != state.currentLocation {
         selectedLocation = state.currentLocation
         center(to: selectedLocation)
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - Core Location

extension MapViewController: CLLocationManagerDelegate
{
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
   {
      if let location = locations.last {
         locationManager.stopUpdatingLocation()
         let coordinates = Coordinate(location.coordinate)
         center(to: coordinates)
      }
   }
}

extension MapViewController: MKMapViewDelegate
{
   func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool)
   {
      guard !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
         assertionFailure("MapViewController: No monitoring available!")
         return
      }

      let action = LocationActions.UpdateMonitoringRegion(
         coordinate: mapView.centerCoordinate, radius: getRadius())
      dispatch(action: action)
   }
}
