import Foundation

//struct Day
//{
//   let weekday: Weekday
//   var enabled = false
//
//   init(_ weekday: Weekday) {
//      self.weekday = weekday
//   }
//}

class WeekTrigger
{
   private var enabled = [Weekday]()

   func set(weekday: Weekday, selected: Bool)
   {
      if selected && !isSelected(weekday: weekday) {
         enabled.append(weekday)
      }
      else {
         enabled.removeAll(where: {$0 == weekday})
      }
   }

   func isSelected(weekday: Weekday) -> Bool {
      return enabled.contains(where: {$0 == weekday})
   }
}

enum Weekday: Int, CaseIterable
{
   case monday = 0
   case tuesday = 1
   case wednesday = 2
   case thursday = 3
   case friday = 4
   case saturday = 5
   case sunday = 6
   
   var name: String {
      switch self {
      case .monday:    return "Monday"
      case .tuesday:   return "Tuesday"
      case .wednesday: return "Wednesday"
      case .thursday:  return "Thursday"
      case .friday:    return "Friday"
      case .saturday:  return "Saturday"
      case .sunday:    return "Sunday"
      }
   }
}
