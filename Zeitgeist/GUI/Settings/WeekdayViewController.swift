import UIKit
import ReSwift

class WeekdayViewController: UIViewController
{
   
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

extension WeekdayViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
   }
}

extension WeekdayViewController: UITableViewDelegate, UITableViewDataSource
{
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Week.allCases.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "WeekdayCell", for: indexPath)
      let day = Week(rawValue: indexPath.row) ?? .monday
      cell.textLabel?.text = day.name
      return cell
   }
}
