import UIKit
import ReSwift

class LocationTriggerViewController: UIViewController
{
   @IBOutlet private weak var startFromPicker: UIDatePicker!
   @IBOutlet private weak var startToPicker: UIDatePicker!
   @IBOutlet private weak var endFromPicker: UIDatePicker!
   @IBOutlet private weak var endToPicker: UIDatePicker!

   // --------------------------------------------------------------------------------
   
   override func viewWillAppear(_ animated: Bool)
   {
      title = "Select Timespan"

      subscribe(self) { subcription in
         subcription.select { state in state.locationState }
      }
   }

   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }

   // --------------------------------------------------------------------------------

   @IBAction func onStartChanged(_ sender: UIDatePicker)
   {
      var timeFrame = TimeFrame()

      let fromComp = Calendar.current.dateComponents([.hour, .minute], from: startFromPicker.date)
      timeFrame.begin = Time(hour: fromComp.hour ?? 0, minute: fromComp.minute ?? 0)

      let toComp = Calendar.current.dateComponents([.hour, .minute], from: startToPicker.date)
      timeFrame.end = Time(hour: toComp.hour ?? 0, minute: toComp.minute ?? 0)

      let action = LocationActions.StartTimeFrame(timeFrame: timeFrame)
      dispatch(action: action)
   }

   @IBAction func onEndChanged(_ sender: UIDatePicker)
   {
      var timeFrame = TimeFrame()

      let fromComp = Calendar.current.dateComponents([.hour, .minute], from: endFromPicker.date)
      timeFrame.begin = Time(hour: fromComp.hour ?? 0, minute: fromComp.minute ?? 0)

      let toComp = Calendar.current.dateComponents([.hour, .minute], from: endToPicker.date)
      timeFrame.end = Time(hour: toComp.hour ?? 0, minute: toComp.minute ?? 0)

      let action = LocationActions.StartTimeFrame(timeFrame: timeFrame)
      dispatch(action: action)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension LocationTriggerViewController: StoreSubscriber
{
   func newState(state: LocationState)
   {
      update(picker: startFromPicker, withTime: state.startTimeFrame.begin)
      update(picker: startToPicker, withTime: state.startTimeFrame.end)
      update(picker: endFromPicker, withTime: state.endTimeFrame.begin)
      update(picker: endToPicker, withTime: state.endTimeFrame.end)
   }

   private func update(picker: UIDatePicker, withTime time: Time)
   {
      picker.date = Calendar.current.date(bySettingHour: time.hour,
                                          minute: time.minute,
                                          second: 0, of: Date())!
   }
}
