//
//  selfTestDataModel.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 16.11.21.
//

import Foundation

struct selfTestDataModel: Codable, Identifiable {
    public var id: String?
    public var serial: String?
    public var date: String?
    public var hasBatteryError: String?
    public var hasRedErrors: String?
    public var hasWarnings: String?
    public var selfTestMessage: String?
    public var selfTestType: String?

    enum CodingKeys: String, CodingKey {
        case id = "uniqeSelfTestId"
        case date = "strDate"
        case serial, selfTestType,selfTestMessage,hasBatteryError,hasRedErrors, hasWarnings
    }
}
