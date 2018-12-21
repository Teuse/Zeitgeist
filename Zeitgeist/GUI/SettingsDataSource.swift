import Foundation
import UIKit

struct Setting {
   let name: String
   let destinationId: String?
   let contentId: String?
   let enableSettingType: EnableSettingType
   
   init(name: String, destinationId: String) {
      self.name = name
      self.destinationId = destinationId
      self.contentId = nil
      self.enableSettingType = .none
   }
   
   init(name: String, contentId: String, type: EnableSettingType) {
      self.name = name
      self.contentId = contentId
      self.enableSettingType = type
      self.destinationId = nil
   }
}

// --------------------------------------------------------------------------------

class SettingsDataSource
{
   var count: Int {
      return sections.count
   }
   
   func name(for section: Int) -> String {
      return sections[section].name
   }
   
   func count(for section: Int) -> Int {
      return sections[section].settings.count
   }
   
   func setting(for indexPath: IndexPath) -> Setting {
      return sections[indexPath.section].settings[indexPath.row]
   }
   
   // --------------------------------------------------------------------------------
   
   private struct Section {
      let name: String
      var settings = [Setting]()
      init(name: String) {
         self.name = name
      }
   }
   
   private let sections: [Section] = createSettings()
   
   private static func createSettings() -> [Section]
   {
      var sec1 = Section(name: "Location Trigger")
      sec1.settings = [
         Setting(name: "Enable Location Trigger", contentId: "EnableSettingCell", type: .location),
         Setting(name: "Select Timespan", destinationId: "LocationTriggerVC"),
         Setting(name: "Select Region", destinationId: "LocationSelectionVC"),
      ]
      
      var sec2 = Section(name: "Time Trigger")
      sec2.settings = [
         Setting(name: "Enable Time Trigger", contentId: "EnableSettingCell", type: .time),
         Setting(name: "Select Time", destinationId: "TimeTriggerVC"),
      ]
      
      var sec3 = Section(name: "Weekday Selection")
      sec3.settings = [
         Setting(name: "Repeat", destinationId: "WeekdayVC"),
      ]
      
      return [sec1, sec2, sec3]
   }
}
