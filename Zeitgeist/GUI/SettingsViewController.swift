import UIKit
import ReSwift

class SettingsViewController: UIViewController
{
   private let settings = SettingsDataSource()
 
   @IBOutlet weak var tableView: UITableView!
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self)
      
      tableView.delegate = self
      tableView.dataSource = self
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

extension SettingsViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource
{
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
      let setting = settings.setting(for: indexPath)
      if let storyboardId = setting.destinationId {
         pushViewController(withStoryboardID: storyboardId)
      }
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let setting = settings.setting(for: indexPath)
//      let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultSettingCell", for: indexPath)
      let cell = UITableViewCell(style: .default, reuseIdentifier: "SettingsCellId")
      cell.textLabel?.text = setting.name
      cell.selectionStyle = .none
      
      if let storyboardId = setting.contentId {
         cell.accessoryType = .none
         let storyboard = UIStoryboard(name: "Settings", bundle: nil)
         if let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as? EnableSettingCell {
            controller.type = setting.enableSettingType
            controller.view.frame = cell.frame
            cell.addSubview(controller.view)
         }
      }
      else {
         cell.accessoryType = .disclosureIndicator
      }
      return cell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return settings.count
   }
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return settings.name(for: section)
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return settings.count(for: section)
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
