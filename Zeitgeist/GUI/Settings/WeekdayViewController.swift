import UIKit
import ReSwift

class WeekdayViewController: UIViewController
{
   var weekTrigger = WeekTrigger()
   @IBOutlet weak var tableView: UITableView!
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.weekdayTriggerState }
      }
      tableView.delegate = self
      tableView.dataSource = self
      title = "Select Repetition"
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension WeekdayViewController: StoreSubscriber
{
   func newState(state: WeekdayTriggerState)
   {
      weekTrigger = state.weekdayTrigger
      tableView.reloadData()
   }
}

// --------------------------------------------------------------------------------
//MARK: - TableView

extension WeekdayViewController: UITableViewDelegate, UITableViewDataSource
{
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Weekday.allCases.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "WeekdayCell", for: indexPath)
      let day = Weekday(rawValue: indexPath.row) ?? .monday
      cell.textLabel?.text = day.name
      cell.accessoryType = weekTrigger.isSelected(weekday: day) ? .checkmark : .none
      return cell
   }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let day = Weekday(rawValue: indexPath.row) ?? .monday
      let selected = weekTrigger.isSelected(weekday: day)
      dispatch(action: TimeActions.SelectRepeat(weekday: day, selected: !selected))
   }
}
