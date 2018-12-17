import UIKit
import ReSwift

class SettingsViewController: UITableViewController
{
   struct Setting {
      let name: String
      let storyboardId: String
      init(name: String, storyboardId: String) {
         self.name = name
         self.storyboardId = storyboardId
      }
   }
   
   let settings = [
   [
      Setting(name: "Location Trigger", storyboardId: "LocationTriggerVC"),
      Setting(name: "Location Selection", storyboardId: "LocationSelectionVC"),
      Setting(name: "Time Trigger", storyboardId: "TimeTriggerVC"),
      Setting(name: "Weekdays", storyboardId: "WeekdayVC"),
      ]
   ]
   
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
      return settings.count
   }
   
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return "Trigger"
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return settings[section].count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
      let setting = settings[indexPath.section][indexPath.row]
      cell.textLabel?.text = setting.name
      return cell
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let setting = settings[indexPath.section][indexPath.row]
      let storyboardId = setting.storyboardId
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

}
