import UIKit
import ReSwift
import CoreLocation
import MapKit

class LocationSelectionViewController: UIViewController
{
   var matchingItems = [MKMapItem]()
   
   @IBOutlet weak var searchBar: UISearchBar!
   @IBOutlet weak var tableView: UITableView!
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.locationTriggerState }
      }
   }

   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   override func viewDidLoad() {
      tableView.isHidden = true
      tableView.delegate = self
      tableView.dataSource = self
      searchBar.delegate = self
      searchBar.showsCancelButton = false
   }
}

extension LocationSelectionViewController: StoreSubscriber
{
   func newState(state: LocationTriggerState)
   {
      
   }
}

extension LocationSelectionViewController: UISearchBarDelegate
{
   func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      tableView.isHidden = false
      searchBar.showsCancelButton = true
//      UIView.animate(withDuration: 1) {
//         self.cancelButton.frame.size.width = 85
//      }
   }
   func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      tableView.isHidden = true
      searchBar.showsCancelButton = false
//      UIView.animate(withDuration: 1) {
//         self.cancelButton.frame.size.width = 0
//      }
   }
   
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      let request = MKLocalSearch.Request()
      request.naturalLanguageQuery = searchText
//      request.region = mapView.region
      let search = MKLocalSearch(request: request)
      search.start { response, _ in
         guard let response = response else { return }
         self.matchingItems = response.mapItems
         self.tableView.reloadData()
      }
   }
}

extension LocationSelectionViewController: UITableViewDelegate, UITableViewDataSource
{
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return matchingItems.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
      let selectedItem = matchingItems[indexPath.row].placemark
      cell.textLabel?.text = selectedItem.name
      return cell
   }
//
//   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//   }
}
