import UIKit
import ReSwift

class SettingsViewController: UITableViewController
{
   private struct Section {
      let name: String
      let settings: [Setting]
   }
   private struct Setting {
      let name: String
      let cellId: String
      let storyboardId: String?
      var enabled: Bool { return storyboardId != nil }

      init(name: String, cellId: String) {
         self.name = name
         self.cellId = cellId
      }
      init(name: String, cellId: String, storyboardId: String) {
         self.name = name
         self.cellId = cellId
         self.storyboardId = storyboardId
      }
   }

   private let sections: [Section] = createSettings()


   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self)
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return sections.count
   }
   
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return sections[section].name
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return sections[section].settings.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let setting = sections[indexPath.section].settings[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: setting.cellId, for: indexPath)
      cell.textLabel?.text = setting.name
      cell.isUserInteractionEnabled = setting.enabled
      return cell
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let setting = sections[indexPath.section].settings[indexPath.row]
      let storyboardId = setting.storyboardId ?? ""
      pushViewController(withStoryboardID: storyboardId)
   }
}

extension SettingsViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}

extension SettingsViewController
{
   func pushViewController(withStoryboardID sorryboardId: String) {
      let storyboard = UIStoryboard(name: "Settings", bundle: nil)
      let controller = storyboard.instantiateViewController(withIdentifier: sorryboardId)
      navigationController?.pushViewController(controller, animated: true)
   }

   private static func createSettings() -> [Section]
   {
      var sections = [Section]()
      var settings = [
         Setting(name: "Select Timespan", storyboardId: "LocationTriggerVC"),
         Setting(name: "Select Region", storyboardId: "LocationSelectionVC"),
         ]
      sections.append(Section(name: "Location Trigger", settings: settings))

      settings = [
         Setting(name: "Select Time", storyboardId: "TimeTriggerVC"),
      ]
      sections.append(Section(name: "Time Trigger", settings: settings))

      settings = [
         Setting(name: "Repeat", storyboardId: "WeekdayVC"),
      ]
      sections.append(Section(name: "Time Trigger", settings: settings))

      return sections
   }
}
