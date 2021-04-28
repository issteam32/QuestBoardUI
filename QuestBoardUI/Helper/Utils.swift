//
//  Utils.swift
//  QuestBoardUI
//
//  Created by Yong Jia on 28/4/21.
//

import Foundation

public class Utils {
    public static func convertDateFromStr(dtStr: String) -> Double {
        let isoDate = "\(dtStr)T00:00:00+0000"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        return date.timeIntervalSince1970
    }
}
