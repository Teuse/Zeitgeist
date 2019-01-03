import UIKit
import ReSwift
import CoreLocation

class EnableLocationCell: UIViewController
{
   let locationManager = CLLocationManager()
   var authStatus: CLAuthorizationStatus!

   @IBOutlet weak var enableSwitch: UISwitch!

   // --------------------------------------------------------------------------------
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.locationState }
      }
      authStatus = CLLocationManager.authorizationStatus()
      locationManager.delegate = self
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }

   // --------------------------------------------------------------------------------

   @IBAction private func onEnableSwitchChanged(_ sender: UISwitch)
   {
      if sender.isOn && !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
         let text = "Your device does not support location monitoring. Therefor, you are not able to use the 'Location Trigger' feature."
         showAlert(withTitle: "Location Monitoring Unavailable", text: text)
         dispatch(action: LocationActions.EnableTrigger(enabled: false))
      }

      setEnabled(sender.isOn)
   }

   private func setEnabled(_ enabled: Bool)
   {
      switch CLLocationManager.authorizationStatus()
      {
      case .authorizedAlways, .authorizedWhenInUse:
         dispatch(action: LocationActions.EnableTrigger(enabled: enabled))
      case .denied:
         showAlert(withTitle: "Location Service Restricted", text: "Blub")
      case .restricted:
         showAlert(withTitle: "Location Service Denied", text: "Blub")
      case .notDetermined:
         locationManager.requestAlwaysAuthorization()
      }
   }

   private func showAlert(withTitle title: String, text: String)
   {
      let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
      let btnTitle = NSLocalizedString("OK", comment: "Default action")
      let alertAction = UIAlertAction(title: btnTitle, style: .default) { [weak self] _ in
         self?.dispatch(action: LocationActions.EnableTrigger(enabled: false))
      }
      alert.addAction(alertAction)
      present(alert, animated: true, completion: nil)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension EnableLocationCell: StoreSubscriber
{
   func newState(state: LocationState)
   {
      enableSwitch.isOn = state.enabled
   }
}

// --------------------------------------------------------------------------------
//MARK: - Core Location

extension EnableLocationCell: CLLocationManagerDelegate
{
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
   {
      guard authStatus != status else { return }

      authStatus = status
      switch status
      {
      case .authorizedAlways, .authorizedWhenInUse:
         dispatch(action: LocationActions.EnableTrigger(enabled: true))
      case .notDetermined:
         break
      default:
         dispatch(action: LocationActions.EnableTrigger(enabled: false))
      }
   }
}
