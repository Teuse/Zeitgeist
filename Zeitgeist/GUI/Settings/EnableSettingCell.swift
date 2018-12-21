import UIKit
import ReSwift

enum EnableSettingType {
   case location, time, none
}

class EnableSettingCell: UIViewController
{
   var type: EnableSettingType = .none
   
   @IBOutlet weak var enableSwitch: UISwitch!
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self)
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   @IBAction private func onEnableSwitchChanged(_ sender: UISwitch)
   {
      switch type {
      case .location:
         dispatch(action: LocationActions.EnableTrigger(enabled: sender.isOn))
      case .time:
         dispatch(action: TimeActions.EnableTrigger(enabled: sender.isOn))
      case .none:
         assertionFailure("SettingType not set!")
      }
   }
}

extension EnableSettingCell: StoreSubscriber
{
   func newState(state: AppState)
   {
      switch type {
      case .location:
         enableSwitch.isOn = state.locationTriggerState.enabled
      case .time:
         enableSwitch.isOn = state.timeTriggerState.enabled
      case .none:
         assertionFailure("SettingType not set!")
      }
   }
}
