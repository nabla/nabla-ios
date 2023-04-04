// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension GQL {
  struct DeviceInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      deviceModel: String,
      os: GraphQLEnum<DeviceOs>,
      osVersion: GraphQLNullable<String> = nil,
      codeVersion: Int,
      sdkModules: [GraphQLEnum<SdkModule>]
    ) {
      __data = InputDict([
        "deviceModel": deviceModel,
        "os": os,
        "osVersion": osVersion,
        "codeVersion": codeVersion,
        "sdkModules": sdkModules
      ])
    }

    var deviceModel: String {
      get { __data["deviceModel"] }
      set { __data["deviceModel"] = newValue }
    }

    var os: GraphQLEnum<DeviceOs> {
      get { __data["os"] }
      set { __data["os"] = newValue }
    }

    var osVersion: GraphQLNullable<String> {
      get { __data["osVersion"] }
      set { __data["osVersion"] = newValue }
    }

    var codeVersion: Int {
      get { __data["codeVersion"] }
      set { __data["codeVersion"] = newValue }
    }

    var sdkModules: [GraphQLEnum<SdkModule>] {
      get { __data["sdkModules"] }
      set { __data["sdkModules"] = newValue }
    }
  }

}