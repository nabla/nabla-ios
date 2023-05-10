// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
 extension GQL {
  final class RegisterOrUpdateDeviceMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
     let operationDefinition: String =
      """
      mutation registerOrUpdateDevice($deviceId: UUID, $input: DeviceInput!) {
        registerOrUpdateDevice(deviceId: $deviceId, device: $input) {
          __typename
          deviceId
          sentry {
            __typename
            env
            dsn
          }
        }
      }
      """

     let operationName: String = "registerOrUpdateDevice"

     var deviceId: GQL.UUID?
     var input: DeviceInput

     init(deviceId: GQL.UUID? = nil, input: DeviceInput) {
      self.deviceId = deviceId
      self.input = input
    }

     var variables: GraphQLMap? {
      return ["deviceId": deviceId, "input": input]
    }

     struct Data: GraphQLSelectionSet {
       static let possibleTypes: [String] = ["Mutation"]

       static var selections: [GraphQLSelection] {
        return [
          GraphQLField("registerOrUpdateDevice", arguments: ["deviceId": GraphQLVariable("deviceId"), "device": GraphQLVariable("input")], type: .nonNull(.object(RegisterOrUpdateDevice.selections))),
        ]
      }

       private(set) var resultMap: ResultMap

       init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

       init(registerOrUpdateDevice: RegisterOrUpdateDevice) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "registerOrUpdateDevice": registerOrUpdateDevice.resultMap])
      }

       var registerOrUpdateDevice: RegisterOrUpdateDevice {
        get {
          return RegisterOrUpdateDevice(unsafeResultMap: resultMap["registerOrUpdateDevice"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "registerOrUpdateDevice")
        }
      }

       struct RegisterOrUpdateDevice: GraphQLSelectionSet {
         static let possibleTypes: [String] = ["UpdateDeviceOutput"]

         static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("deviceId", type: .nonNull(.scalar(GQL.UUID.self))),
            GraphQLField("sentry", type: .object(Sentry.selections)),
          ]
        }

         private(set) var resultMap: ResultMap

         init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

         init(deviceId: GQL.UUID, sentry: Sentry? = nil) {
          self.init(unsafeResultMap: ["__typename": "UpdateDeviceOutput", "deviceId": deviceId, "sentry": sentry.flatMap { (value: Sentry) -> ResultMap in value.resultMap }])
        }

         var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

         var deviceId: GQL.UUID {
          get {
            return resultMap["deviceId"]! as! GQL.UUID
          }
          set {
            resultMap.updateValue(newValue, forKey: "deviceId")
          }
        }

         var sentry: Sentry? {
          get {
            return (resultMap["sentry"] as? ResultMap).flatMap { Sentry(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "sentry")
          }
        }

         struct Sentry: GraphQLSelectionSet {
           static let possibleTypes: [String] = ["Sentry"]

           static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("env", type: .nonNull(.scalar(String.self))),
              GraphQLField("dsn", type: .nonNull(.scalar(String.self))),
            ]
          }

           private(set) var resultMap: ResultMap

           init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

           init(env: String, dsn: String) {
            self.init(unsafeResultMap: ["__typename": "Sentry", "env": env, "dsn": dsn])
          }

           var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

           var env: String {
            get {
              return resultMap["env"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "env")
            }
          }

           var dsn: String {
            get {
              return resultMap["dsn"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "dsn")
            }
          }
        }
      }
    }
  }
}
