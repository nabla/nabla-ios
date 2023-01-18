import Foundation
import Contacts

// sourcery: AutoMockable
protocol AddressFormatter {
    func format(_ address: Address) -> String
}

final class FoundationAddressFormatter: AddressFormatter {
    func format(_ address: Address) -> String {
        let cnAddress = CNMutablePostalAddress()
        cnAddress.street = address.address
        cnAddress.city = address.city
        cnAddress.postalCode = address.zipCode
        if let country = address.country {
            cnAddress.country = country
        }
        if let state = address.state {
            cnAddress.state = state
        }
        return CNPostalAddressFormatter.string(from: cnAddress, style: .mailingAddress)
    }
}
