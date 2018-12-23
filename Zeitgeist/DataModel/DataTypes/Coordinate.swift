import Foundation
import CoreLocation

struct Coordinate: Codable {
   let latitude: Double
   let longitude: Double

   init() {
      self.latitude = 0.0
      self.longitude = 0.0
   }
   init(latitude: Double, longitude: Double) {
      self.latitude = latitude
      self.longitude = longitude
   }
}

func == (left: Coordinate, right: Coordinate) -> Bool {
   return left.latitude == right.latitude && left.longitude == right.longitude
}

func != (left: Coordinate, right: Coordinate) -> Bool {
   return !(left == right)
}

extension CLLocationCoordinate2D {
   init(_ coordinate: Coordinate) {
      self = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
   }
}

extension Coordinate {
   init(_ coordinate: CLLocationCoordinate2D) {
      self = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
   }
}
