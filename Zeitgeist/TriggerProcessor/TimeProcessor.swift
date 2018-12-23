import Foundation

class TimeProcessor
{
   typealias Callback = () -> Void

   var enabled = false

   private var startTime = Time()
   private var endTime = Time()

   private let callback: Callback
   private let calendar = Calendar.current

   func setTime(_ time: Time) {
      startTime = time
      endTime = time
      endTime.addMinutes(1)
   }

   func setTimeRange(start startTime: Time, end endTime: Time) {
      self.startTime = startTime
      self.endTime = endTime
   }

   // --------------------------------------------------------------------------------

   init(triggerCallback: @escaping(Callback)) {
      callback = triggerCallback
   }

   // --------------------------------------------------------------------------------



   func process()
   {
      guard enabled else { return }

      let date = Date()
      let now = Time(hour: calendar.component(.hour, from: date),
                     minute: calendar.component(.minute, from: date))

      if startTime >= now && endTime < now {
         callback()
      }
   }
}
