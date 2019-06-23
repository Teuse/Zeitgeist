
import UIKit

class RecordingButtons: UIViewController
{
   @IBAction private func onVacationClicked(_ sender: UIButton)
   {
      let confirmVC = createConfirmViewController()
      confirmVC.type = .vacation
      show(confirmVC, sender: nil)
   }
   
   @IBAction private func onSicknessClicked(_ sender: UIButton)
   {
      let confirmVC = createConfirmViewController()
      confirmVC.type = .sickness
      show(confirmVC, sender: nil)
   }
   
   private func createConfirmViewController() -> ConfirmViewController
   {
      let storyboard = UIStoryboard(name: "TimeRecording", bundle: nil)
      let viewController = storyboard.instantiateViewController(withIdentifier: "ConfirmViewController")
      let confirmVC = viewController as? ConfirmViewController
      assert(confirmVC != nil, "The ConfirmViewController must exist!")
      return confirmVC!
   }
}
