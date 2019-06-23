import Foundation

class Pause
{
   let begin: Date
   let end: Date?
   
   init(begin: Date, end: Date? = nil) {
      self.begin = begin
      self.end = end
   }
}
