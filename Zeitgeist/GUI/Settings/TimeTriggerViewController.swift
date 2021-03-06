import UIKit
import ReSwift
import MapKit
import CoreLocation

class TimeTriggerViewController: UIViewController
{
   @IBOutlet private weak var beginPicker: UIDatePicker!
   @IBOutlet private weak var endPicker: UIDatePicker!

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

   // --------------------------------------------------------------------------------

   @IBAction func onStartTimeChanged(_ sender: UIDatePicker)
   {
      let dateComps = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
      let time = Time(hour: dateComps.hour ?? 0,
                      minute: dateComps.minute ?? 0)

      let action = TimeActions.SetStartTime(time: time)
      dispatch(action: action)
   }

   @IBAction func onEndTimeChanged(_ sender: UIDatePicker)
   {
      let dateComps = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
      let time = Time(hour: dateComps.hour ?? 0,
                      minute: dateComps.minute ?? 0)

      let action = TimeActions.SetEndTime(time: time)
      dispatch(action: action)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension TimeTriggerViewController: StoreSubscriber
{
   func newState(state: TimeState)
   {
      let cal = Calendar.current
      beginPicker.date = cal.date(bySettingHour: state.startTime.hour,
                                               minute: state.startTime.minute,
                                               second: 0, of: Date())!
      endPicker.minimumDate = beginPicker.date

      endPicker.date = Calendar.current.date(bySettingHour: state.endTime.hour,
                                             minute: state.endTime.minute,
                                             second: 0, of: Date())!
      beginPicker.maximumDate = endPicker.date
   }
}
