import Foundation

enum RemotePatientTransformer {
    // MARK: - Internal
    
    static func transform(_ fragment: GQL.PatientFragment) -> Patient {
        Patient(
            id: fragment.id,
            displayName: fragment.displayName
        )
    }
}
