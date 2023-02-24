// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GQL {
  class RegisterOrUpdateDeviceMutation: GraphQLMutation {
    static let operationName: String = "registerOrUpdateDevice"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
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
        """#
      ))

    var deviceId: GraphQLNullable<UUID>
    var input: DeviceInput

    init(
      deviceId: GraphQLNullable<UUID>,
      input: DeviceInput
    ) {
      self.deviceId = deviceId
      self.input = input
    }

    var __variables: Variables? { [
      "deviceId": deviceId,
      "input": input
    ] }

    struct Data: GQL.SelectionSet {
      let __data: DataDict
      init(data: DataDict) { __data = data }

      static var __parentType: Apollo.ParentType { GQL.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("registerOrUpdateDevice", RegisterOrUpdateDevice.self, arguments: [
          "deviceId": .variable("deviceId"),
          "device": .variable("input")
        ]),
      ] }

      var registerOrUpdateDevice: RegisterOrUpdateDevice { __data["registerOrUpdateDevice"] }

      /// RegisterOrUpdateDevice
      ///
      /// Parent Type: `UpdateDeviceOutput`
      struct RegisterOrUpdateDevice: GQL.SelectionSet {
        let __data: DataDict
        init(data: DataDict) { __data = data }

        static var __parentType: Apollo.ParentType { GQL.Objects.UpdateDeviceOutput }
        static var __selections: [Apollo.Selection] { [
          .field("deviceId", GQL.UUID.self),
          .field("sentry", Sentry?.self),
        ] }

        var deviceId: GQL.UUID { __data["deviceId"] }
        var sentry: Sentry? { __data["sentry"] }

        /// RegisterOrUpdateDevice.Sentry
        ///
        /// Parent Type: `Sentry`
        struct Sentry: GQL.SelectionSet {
          let __data: DataDict
          init(data: DataDict) { __data = data }

          static var __parentType: Apollo.ParentType { GQL.Objects.Sentry }
          static var __selections: [Apollo.Selection] { [
            .field("env", String.self),
            .field("dsn", String.self),
          ] }

          var env: String { __data["env"] }
          var dsn: String { __data["dsn"] }
        }
      }
    }
  }

}