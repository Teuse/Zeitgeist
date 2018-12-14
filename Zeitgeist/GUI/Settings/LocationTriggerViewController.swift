import UIKit
import ReSwift

class LocationTriggerViewController: UIViewController
{
   private var timeSelectionVC: TimeSelectionViewController?

   @IBOutlet weak var startTimeButton: UIButton!
   @IBOutlet weak var endTimeButton: UIButton!
   @IBOutlet weak var mapViewContainer: UIView!
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.locationTriggerState }
      }
   }

   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }

   override func viewDidLayoutSubviews() {
      startTimeButton.titleLabel?.text = ""
      endTimeButton.titleLabel?.text = ""
   }
   
   @IBAction func onTimeSelectionButton(_ sender: UIButton)
   {
      dispatch(action: ToggleSelectionViewAction(isStartTime: sender == startTimeButton))
   }
}

extension LocationTriggerViewController: StoreSubscriber
{
   func newState(state: LocationTriggerState)
   {
      if state.isTimeSelectionViewShown {
         openTimeSelectionView(forStartTime: state.isStartTimeSelector)
      } else {
         closeTimeSelectionView()
      }
   }
}

extension LocationTriggerViewController
{
   private func openTimeSelectionView(forStartTime: Bool)
   {
      guard timeSelectionVC == nil else { return }
      let storyboard = UIStoryboard(name: "Settings", bundle: nil)
      timeSelectionVC = storyboard.instantiateViewController(withIdentifier: "TimeSelectionViewController") as? TimeSelectionViewController
      timeSelectionVC?.isStartTime = forStartTime
      if let controller = timeSelectionVC {
         view.addSubview(controller.view)
         controller.view.frame = mapViewContainer.frame
      }
   }
   
   private func closeTimeSelectionView()
   {
      timeSelectionVC?.view.removeFromSuperview()
      timeSelectionVC = nil
   }
}
