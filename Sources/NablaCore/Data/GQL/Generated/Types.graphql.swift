// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 enum GQL {
   struct DeviceInput: GraphQLMapConvertible {
     var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - deviceModel
    ///   - os
    ///   - osVersion
    ///   - codeVersion
    ///   - sdkModules
     init(deviceModel: String, os: DeviceOs, osVersion: Swift.Optional<String?> = nil, codeVersion: Int, sdkModules: [SdkModule]) {
      graphQLMap = ["deviceModel": deviceModel, "os": os, "osVersion": osVersion, "codeVersion": codeVersion, "sdkModules": sdkModules]
    }

     var deviceModel: String {
      get {
        return graphQLMap["deviceModel"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "deviceModel")
      }
    }

     var os: DeviceOs {
      get {
        return graphQLMap["os"] as! DeviceOs
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "os")
      }
    }

     var osVersion: Swift.Optional<String?> {
      get {
        return graphQLMap["osVersion"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "osVersion")
      }
    }

     var codeVersion: Int {
      get {
        return graphQLMap["codeVersion"] as! Int
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "codeVersion")
      }
    }

     var sdkModules: [SdkModule] {
      get {
        return graphQLMap["sdkModules"] as! [SdkModule]
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "sdkModules")
      }
    }
  }

   enum DeviceOs: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
     typealias RawValue = String
    case android
    case ios
    case web
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

     init?(rawValue: RawValue) {
      switch rawValue {
        case "ANDROID": self = .android
        case "IOS": self = .ios
        case "WEB": self = .web
        default: self = .__unknown(rawValue)
      }
    }

     var rawValue: RawValue {
      switch self {
        case .android: return "ANDROID"
        case .ios: return "IOS"
        case .web: return "WEB"
        case .__unknown(let value): return value
      }
    }

     static func == (lhs: DeviceOs, rhs: DeviceOs) -> Bool {
      switch (lhs, rhs) {
        case (.android, .android): return true
        case (.ios, .ios): return true
        case (.web, .web): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

     static var allCases: [DeviceOs] {
      return [
        .android,
        .ios,
        .web,
      ]
    }
  }

   enum SdkModule: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
     typealias RawValue = String
    case messaging
    case videoCall
    case videoCallScheduling
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

     init?(rawValue: RawValue) {
      switch rawValue {
        case "MESSAGING": self = .messaging
        case "VIDEO_CALL": self = .videoCall
        case "VIDEO_CALL_SCHEDULING": self = .videoCallScheduling
        default: self = .__unknown(rawValue)
      }
    }

     var rawValue: RawValue {
      switch self {
        case .messaging: return "MESSAGING"
        case .videoCall: return "VIDEO_CALL"
        case .videoCallScheduling: return "VIDEO_CALL_SCHEDULING"
        case .__unknown(let value): return value
      }
    }

     static func == (lhs: SdkModule, rhs: SdkModule) -> Bool {
      switch (lhs, rhs) {
        case (.messaging, .messaging): return true
        case (.videoCall, .videoCall): return true
        case (.videoCallScheduling, .videoCallScheduling): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

     static var allCases: [SdkModule] {
      return [
        .messaging,
        .videoCall,
        .videoCallScheduling,
      ]
    }
  }
}
