import Foundation

struct TimeFrame: Codable {
   var begin = Time()
   var end = Time()

   init() {}
   init(startHour: Int, endHour: Int) {
      self.begin.hour = startHour
      self.end.hour = endHour
   }
}

struct Time: Codable {
   var hour:Int = 0
   var minute:Int = 0

   init() {}
   init(hour: Int, minute: Int) {
      self.hour = hour
      self.minute = minute
   }
   init(date: Date) {
      let comp = Calendar.current.dateComponents([.hour, .minute], from: date)
      self.hour = comp.hour ?? 0
      self.minute = comp.minute ?? 0
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
