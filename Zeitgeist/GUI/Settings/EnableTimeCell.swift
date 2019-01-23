import UIKit
import ReSwift

class EnableTimeCell: UIViewController
{
   @IBOutlet private weak var enableSwitch: UISwitch!

   // --------------------------------------------------------------------------------

   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.timeState }
      }
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   @IBAction private func onEnableSwitchChanged(_ sender: UISwitch)
   {
      dispatch(action: TimeActions.EnableTrigger(enabled: sender.isOn))
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension EnableTimeCell: StoreSubscriber
{
   func newState(state: TimeState)
   {
      enableSwitch.isOn = state.enabled
   }
}

