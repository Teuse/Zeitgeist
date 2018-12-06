import UIKit
import ReSwift
import MapKit
import CoreLocation

class MapViewController: UIViewController
{
    let locationManager = CLLocationManager()
//    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addRegion(_:)))
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        subscribe(self)
        mapView.showsUserLocation = true
        mapView.delegate = self
//        mapView.addGestureRecognizer(longPressGesture)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
    
    @IBAction private func addRegion(_ sender: Any) {
        print("addregion pressed")
        guard let longPress = sender as? UILongPressGestureRecognizer else {return}
        
        let touchLocation = longPress.location(in: mapView)
        let coordinates = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        let region = CLCircularRegion(center: coordinates, radius: 5000, identifier: "geofence")
        mapView.removeOverlays(mapView.overlays)
        locationManager.startMonitoring(for: region)
        let circle = MKCircle(center: coordinates, radius: region.radius)
        mapView.addOverlay(circle)
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
        
    }
}

extension MapViewController: StoreSubscriber
{
    func newState(state: AppState)
    {
    }
}

extension MapViewController: CLLocationManagerDelegate
{
    private func center(to location: CLLocation)
    {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        
        mapView.setRegion(region, animated: true)
    }
    
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
