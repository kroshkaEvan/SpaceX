//
//  Launch.swift
//  SpaceX
//
//  Created by Эван Крошкин on 31.08.22.
//

import Foundation

struct Launch: Codable {
    let rocket: TypeRocket
    let name, dateLocal: String
    var success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case rocket, name, success
        case dateLocal = "date_local"
    }
    
    var date: String {
        reformat(inputDate: dateLocal )
    }
    
    private func reformat(inputDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let date = inputFormatter.date(from: inputDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            outputFormatter.dateStyle = .medium
            let outputDate = outputFormatter.string(from: date)
            return outputDate
        } else {
            return inputDate
        }
    }
}

enum TypeRocket: String, Codable {
    case the5E9D0D95Eda69955F709D1Eb = "5e9d0d95eda69955f709d1eb"
    case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
    case the5E9D0D95Eda69974Db09D1Ed = "5e9d0d95eda69974db09d1ed"
}
