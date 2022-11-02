import Foundation
import NablaCore
import NablaMessagingCore

public extension PatientNameComponents {
    init(_ patient: Patient) {
        self.init(displayName: patient.displayName)
    }
}
