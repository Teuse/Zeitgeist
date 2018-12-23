import UIKit
import ReSwift

class HistoryViewController: UITableViewController
{
    var records = [Record]()
    
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryRecordCell", for: indexPath)
        let rec = records[indexPath.row]
        cell.textLabel?.text = durationString(from: rec.duration)
        return cell
    }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension HistoryViewController: StoreSubscriber
{
    func newState(state: AppState)
    {
        records.removeAll()
        if let rec = state.currentRecord {
            records = [rec]
        }
        tableView.reloadData()
    }
}

