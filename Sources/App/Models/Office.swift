//
//  Office.swift
//  App
//
//  Created by Viktor Nakyden on 25.07.19.
//

import Foundation

enum OfficeType: String, Codable {
    case intive
    case intence
}

struct Office: Codable {
    let locationId: LocationID
    let city: String
    let address: String
    let lat: String
    let long: String
    let phone: String
    let email: String
    let employeesNumber: Int
    let images: [String]
    let description: String
    let officeType: OfficeType

    static func mock(for locationId: LocationID) -> [Office] {
        let loremDescription = "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"

        switch locationId {
        case .ber:
            return  [
                Office(
                    locationId: .ber,
                    city: "Berlin",
                    address: "Boxhagener Str. 82, 10245 Berlin",
                    lat: "52.508550",
                    long: "13.466620",
                    phone: "+49 941 569 590 0",
                    email: "berlin@intive.com",
                    employeesNumber: 15,
                    images: ["berlin-1.jpeg", "berlin-2.jpeg", "berlin-3.jpeg"],
                    description: loremDescription,
                    officeType: .intive
                )
            ]
        case .muc:
            return  [
                Office(
                    locationId: .muc,
                    city: "Munich",
                    address: "Neumarkter Str. 61, 81673 Munich",
                    lat: "48.132780",
                    long: "11.624330",
                    phone: "+49 941 569 590 0",
                    email: "munich@intive.com",
                    employeesNumber: 60,
                    images: ["munich-1.jpeg", "munich-2.jpeg", "munich-3.jpeg"],
                    description: loremDescription,
                    officeType: .intive
                )
            ]
        case .reg:
            return  [
                Office(
                    locationId: .reg,
                    city: "Regensburg",
                    address: "Prinz-Ludwig-Str. 17, 93055 Regensburg",
                    lat: "49.016490",
                    long: "12.121630",
                    phone: "+49 941 569 590 0",
                    email: "regensburg@intive.com",
                    employeesNumber: 100,
                    images: ["regensburg-1.jpeg", "regensburg-2.jpeg", "regensburg-3.jpeg", "regensburg-4.jpeg"],
                    description: loremDescription,
                    officeType: .intive
                ),
                Office(
                    locationId: .reg,
                    city: "Regensburg",
                    address: "Bruderwöhrdstr. 29, 93055 Regensburg",
                    lat: "49.016490",
                    long: "12.121630",
                    phone: "+49 941 280 460 0",
                    email: "regensburg@intence.de",
                    employeesNumber: 100,
                    images: ["reg-intence-1.jpeg"],
                    description: loremDescription,
                    officeType: .intence
                )
            ]
        }

    }
}
