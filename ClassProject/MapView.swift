//
//  MapView.swift
//  ClassProject
//
//  Created by Pranav Mittal on 10/17/23.
//

import SwiftUI
import CoreLocation
import MapKit


struct Food_Location: Identifiable{
    
    var id = UUID()
    var food_name = String()
//    var city_image = String()
    var coordinate = CLLocationCoordinate2D()
    
}


struct MapView: View {
    
    private static let defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    @State private var search = ""
    @State private var search2 = ""
    @State private var food_region = MKCoordinateRegion(center: defaultLocation, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @State private var markers = [
        Food_Location]()
    @ObservedObject var foodM: FoodModel
    @Environment(\.dismiss) private var dismiss
    let food: String
    
    var body: some View {
        
        VStack{
            //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $food_region,
                    interactionModes: .all,
                    annotationItems: markers
                ){ location in
                    MapMarker(coordinate: location.coordinate)
                }
            }
            .ignoresSafeArea()
            searchBar
            searchBar2
        }.onAppear {
            forwardGeocoding(addressStr: food)}
            .navigationTitle(food)
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    
    private var searchBar: some View {
        HStack {
            Button {
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = search
                searchRequest.region = food_region
                
                MKLocalSearch(request: searchRequest).start { response, error in
                    guard let response = response else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error").")
                        return
                    }
                    food_region = response.boundingRegion
                    markers = response.mapItems.map { item in
                        Food_Location(
                            
                            food_name: item.name ?? "",
                            coordinate: item.placemark.coordinate
                        )
                    }
                }
            } label: {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 12)
            }
            TextField("Enter the location", text: $search)
                .foregroundColor(.black)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white).border(Color.black, width: 5)
        }
        .padding()
    }
    

    
    private var searchBar2: some View {
        HStack {
            Button {
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = search2
                searchRequest.region = food_region
                
                MKLocalSearch(request: searchRequest).start { response, error in
                    guard let response = response else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error").")
                        return
                    }
                    food_region = response.boundingRegion
                    markers = response.mapItems.map { item in
                        Food_Location(
                            
                            food_name: item.name ?? "",
                            coordinate: item.placemark.coordinate
                        )
                    }
                }
            } label: {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 12)
            }
            TextField("Enter the food item", text: $search2)
                .foregroundColor(.black)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white).border(Color.black, width: 5)
        }
        .padding()
    }
    
    
    func forwardGeocoding(addressStr: String) {
            let geoCoder = CLGeocoder()
            
            geoCoder.geocodeAddressString(addressStr) { placemarks, error in
                if let error = error {
                    print("Geocode failed: \(error.localizedDescription)")
                } else if let placemark = placemarks?.first, let location = placemark.location {
                    let co_ordinates = location.coordinate
                    let region = MKCoordinateRegion(
                        center: co_ordinates,
                        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                    )

                    food_region = region
                    
                    
                    food_region.center = co_ordinates
                    markers = [Food_Location(food_name: placemark.locality ?? "", coordinate: co_ordinates)]
                }
            }
        }

    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(foodM: FoodModel(), food: "")
    }
}
