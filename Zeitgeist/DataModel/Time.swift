import Foundation

struct Time {
   var hour:Int = 0
   var minute:Int = 0

   init() {}
   init(hour: Int, minute: Int) {
      self.hour = hour
      self.minute = minute
   }

   mutating func addMinutes(_ min: Int)
   {
      minute += min
      if minute >= 60 {
         hour += 1
         minute -= 60
      }
      else if minute < 0 {
         hour -= 1
         minute += 60
      }
      //        var dateComponents = DateComponents()
      //        dateComponents.hour = hour
      //        dateComponents.minute = minute
      //        let date = Calendar.current.date(from: dateComponents)
      //        Calendar.current.date(byAdding: .minute, to: date)
      //        hour = Calendar.current.component(.hour, from: date)
      //        minute = Calendar.current.component(.minute, from: date)
   }
}

func < (left: Time, right: Time) -> Bool {
   return left.hour < right.hour ||
      (left.hour == right.hour && left.minute < right.minute)
}

func > (left: Time, right: Time) -> Bool {
   return left.hour > right.hour ||
      (left.hour == right.hour && left.minute > right.minute)
}

func == (left: Time, right: Time) -> Bool {
   return left.hour == right.hour && left.minute == right.minute
}

func <= (left: Time, right: Time) -> Bool {
   return left == right || left < right
}

func >= (left: Time, right: Time) -> Bool {
   return left == right || left > right
}
