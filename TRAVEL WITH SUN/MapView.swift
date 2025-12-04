//
//  MapView.swift
//  TRAVEL WITH SUN
//
//  Created by Elbek Mirzamakhmudov on 04/12/25.
//

import SwiftUI
import MapKit


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


struct MapView: View {
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            
            center: CLLocationCoordinate2D(latitude: 40.84896998756215, longitude: 14.27406539853419),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
       ZStack {
            Map(
                initialPosition: position,
                interactionModes: [.zoom, .pan]
            ).mapStyle(.imagery)
           HStack(spacing: 50) {
               Button("Paris") {
                   position = MapCameraPosition.region(
                       MKCoordinateRegion(
                           center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                           span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                       )
                   )
               }

               Button("Tokyo") {
                   position = MapCameraPosition.region(
                       MKCoordinateRegion(
                           center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                           span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                       )
                   )
               }
           }.offset(x:UIScreen.screenWidth
                    ,y:UIScreen.screenHeight * 0.9)
        }
    }
}

#Preview {
   MapView()
}
