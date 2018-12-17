import UIKit
import ReSwift
import MapKit
import CoreLocation

class TimeSelectionViewController: UIViewController
{
   var isStartTime = true

   @IBOutlet weak var startPicker: UIDatePicker!
   @IBOutlet weak var endPicker: UIDatePicker!

   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.locationTriggerState }
      }
   }

   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }

   @IBAction func onCloseViewButton(_ sender: UIButton)
   {
      dispatch(action: ToggleSelectionViewAction(isStartTime: isStartTime))
   }

   @IBAction func onTimeChanged(_ sender: UIDatePicker)
   {
      var timeFrame = TimeFrame()
      let startComp = Calendar.current.dateComponents([.hour, .minute], from: startPicker.date)
      timeFrame.start.hour = startComp.hour ?? 0
      timeFrame.start.minute = startComp.minute ?? 0

      let endComp = Calendar.current.dateComponents([.hour, .minute], from: endPicker.date)
      timeFrame.end.hour = endComp.hour ?? 23
      timeFrame.end.minute = endComp.minute ?? 0

      if isStartTime {
         dispatch(action: StartTimeAction(timeFrame: timeFrame))
      } else {
         dispatch(action: EndTimeAction(timeFrame: timeFrame))
      }
   }
}

extension TimeSelectionViewController: StoreSubscriber
{
   func newState(state: LocationTriggerState)
   {
      isStartTime = state.isStartTimeSelector
      
      let timeFrame = isStartTime ? state.startTimeFrame : state.endTimeFrame
      startPicker.date = Calendar.current.date(bySettingHour: timeFrame.start.hour,
                                               minute: timeFrame.start.minute,
                                               second: 0, of: Date())!
      endPicker.date = Calendar.current.date(bySettingHour: timeFrame.end.hour,
                                             minute: timeFrame.end.minute,
                                             second: 0, of: Date())!
   }
}
