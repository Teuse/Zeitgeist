import Foundation

class TimeProcessor
{
   var enabled = false
   var startTime = Time()
   var stopTime = Time()

   weak var deleate: ProcessorDelegate?

   private var lastCheckedTime = Time()

   // --------------------------------------------------------------------------------

   func process()
   {
//      guard enabled else { return }
//
//      let now = Time(date: Date())
//
//      if startTime >= now && endTime < now {
//         //TODO: this is maybe end???
//         deleate?.processorTriggeredStart()
//      }
   }
}
