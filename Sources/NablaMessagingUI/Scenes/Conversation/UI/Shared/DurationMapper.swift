import Foundation

struct DurationMapper {
    // MARK: - Public

    func map(durationInSeconds: Int) -> String {
        let minutes = (durationInSeconds / 60)
        let seconds = durationInSeconds % 60

        return "\(padTime(value: minutes)):\(padTime(value: seconds))"
    }

    // MARK: - Private

    private func padTime(value: Int) -> String {
        if value < 10 {
            return "0\(value)"
        } else {
            return value.description
        }
    }
}
