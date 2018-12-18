import UIKit
import ReSwift
import CoreLocation
import MapKit

class LocationSelectionViewController: UIViewController
{
   var location = CLLocation()
//   var fixItems = [String]()
   var searchItems = [MKMapItem]()
   
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
      title = "Select Region"
   }
   
   private func set(editing: Bool)
   {
      tableView.isHidden = !editing
      self.searchBar.setShowsCancelButton(editing, animated: true)
   }
}

extension LocationSelectionViewController: StoreSubscriber
{
   func newState(state: LocationTriggerState)
   {
      location = state.currentLocation
   }
}

extension LocationSelectionViewController: UISearchBarDelegate
{
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchBar.endEditing(true)
   }
   
   func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      set(editing: true)
   }
   
   func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      set(editing: false)
   }
   
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
   {
      let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 0.01, longitudinalMeters: 0.01)

      let request = MKLocalSearch.Request()
      request.naturalLanguageQuery = searchText
      request.region = region
      let search = MKLocalSearch(request: request)
      search.start { response, _ in
         guard let response = response else { return }
         self.searchItems = response.mapItems
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
      return searchItems.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
      let selectedItem = searchItems[indexPath.row].placemark
      cell.textLabel?.text = selectedItem.name
      return cell
   }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
      let coordinate = searchItems[indexPath.row].placemark.coordinate
      let location = CLLocation(latitude: coordinate.longitude, longitude: coordinate.longitude)
      dispatch(action: LocationTriggerActions.CurrentLocation(location: location))

      searchBar.endEditing(true)
   }
}
