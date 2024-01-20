//
//  User.swift
//  JSONReader
//
//  Created by Jonathan Parra on 1/10/24.
//

import Foundation

struct UserJSONData: Codable {
    let results: [User]
    let info: Info
}

struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: DateInfo
    let registered: DateInfo
    let phone: String
    let cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable {
    let offset: String
    let description: String
}

struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct DateInfo: Codable {
    let date: String
    let age: Int
}

struct ID: Codable {
    let name: String
    let value: String?
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

extension User {
    static let example = User(
        gender: "male",
        name: Name(title: "Mr", first: "Godomir", last: "Greba"),
        location: Location(
            street: Street(number: 2412, name: "Prospekt Peremogi"),
            city: "Tarashcha",
            state: "Chernivecka",
            country: "Ukraine",
            postcode: 39678,
            coordinates: Coordinates(latitude: "77.4968", longitude: "-141.5806"),
            timezone: Timezone(offset: "-11:00", description: "Midway Island, Samoa")
        ),
        email: "godomir.greba@example.com",
        login: Login(
            uuid: "3303adf5-7a3b-4f49-b372-dfb33fe1b98e",
            username: "lazycat847",
            password: "cobra",
            salt: "EPoT7pKS",
            md5: "ade4049e0d02fe21bb5bc05f5278b5a2",
            sha1: "2257a85b00ea993dd349897bb3452448a1efbda0",
            sha256: "1dba6ca4d84729a8535862bd93d385bf3a2c1cada1d417d137524c49a94f2817"
        ),
        dob: DateInfo(date: "2000-05-08T04:43:53.863Z", age: 23),
        registered: DateInfo(date: "2016-06-10T09:08:45.330Z", age: 7),
        phone: "(067) Z91-7558",
        cell: "(066) R13-4871",
        id: ID(name: "", value: nil),
        picture: Picture(
            large: "https://randomuser.me/api/portraits/men/18.jpg",
            medium: "https://randomuser.me/api/portraits/med/men/18.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/men/18.jpg"
        ),
        nat: "UA"
    )
}
