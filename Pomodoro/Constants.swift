//
//  Constants.swift
//  Pomodoro
//
//  Created by Daiana koishebayeva on 24.02.2023.
//

import Foundation
import UIKit

struct K {
    static let segueIdentifier = "showSettings"
    static let workTime = "preferredWorkTime"
}

enum Constants {
    struct Images {
        static let doneIcon = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            UIImage(named: "checkMark")?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        static let deleteIcon = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            UIImage(named: "delete")?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        static let backIcon = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            UIImage(named: "goBack")?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
    }
}
