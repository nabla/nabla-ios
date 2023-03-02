import NablaCore
import XCTest

final class NablaThemeColorsTests: XCTestCase {
    func testColorsCanBeMutated() throws {
        // Assign all colors once without changing the values (prevents snapshot tests flakiness).
        NablaTheme.Colors.Background.base = NablaTheme.Colors.Background.base
        NablaTheme.Colors.Background.underCard = NablaTheme.Colors.Background.base
        
        NablaTheme.Colors.Text.base = NablaTheme.Colors.Text.base
        NablaTheme.Colors.Text.subdued = NablaTheme.Colors.Text.subdued
        NablaTheme.Colors.Text.placeholder = NablaTheme.Colors.Text.placeholder
        NablaTheme.Colors.Text.accent = NablaTheme.Colors.Text.accent
        NablaTheme.Colors.Text.onAccent = NablaTheme.Colors.Text.onAccent
        NablaTheme.Colors.Text.onAccentSubdued = NablaTheme.Colors.Text.onAccentSubdued
        
        NablaTheme.Colors.Fill.base = NablaTheme.Colors.Fill.base
        NablaTheme.Colors.Fill.subdued = NablaTheme.Colors.Fill.subdued
        NablaTheme.Colors.Fill.card = NablaTheme.Colors.Fill.card
        NablaTheme.Colors.Fill.accent = NablaTheme.Colors.Fill.accent
        NablaTheme.Colors.Fill.accentSubdued = NablaTheme.Colors.Fill.accentSubdued
        NablaTheme.Colors.Fill.danger = NablaTheme.Colors.Fill.danger
        
        NablaTheme.Colors.Stroke.base = NablaTheme.Colors.Stroke.base
        NablaTheme.Colors.Stroke.subdued = NablaTheme.Colors.Stroke.subdued
        NablaTheme.Colors.Stroke.accent = NablaTheme.Colors.Stroke.accent
        NablaTheme.Colors.Stroke.onAccent = NablaTheme.Colors.Stroke.onAccent
        NablaTheme.Colors.Stroke.danger = NablaTheme.Colors.Stroke.danger
        
        NablaTheme.Colors.ButtonBackground.base = NablaTheme.Colors.ButtonBackground.base
        NablaTheme.Colors.ButtonBackground.baseHighlighted = NablaTheme.Colors.ButtonBackground.baseHighlighted
        NablaTheme.Colors.ButtonBackground.baseDisabled = NablaTheme.Colors.ButtonBackground.baseDisabled
        NablaTheme.Colors.ButtonBackground.accent = NablaTheme.Colors.ButtonBackground.accent
        NablaTheme.Colors.ButtonBackground.accentHighlighted = NablaTheme.Colors.ButtonBackground.accentHighlighted
        NablaTheme.Colors.ButtonBackground.accentDisabled = NablaTheme.Colors.ButtonBackground.accentDisabled
        NablaTheme.Colors.ButtonBackground.accentSubdued = NablaTheme.Colors.ButtonBackground.accentSubdued
        NablaTheme.Colors.ButtonBackground.accentSubduedHighlighted = NablaTheme.Colors.ButtonBackground.accentSubduedHighlighted
        NablaTheme.Colors.ButtonBackground.accentSubduedDisabled = NablaTheme.Colors.ButtonBackground.accentSubduedDisabled
        
        NablaTheme.Colors.ButtonText.onBase = NablaTheme.Colors.ButtonText.onBase
        NablaTheme.Colors.ButtonText.onBaseHighlighted = NablaTheme.Colors.ButtonText.onBaseHighlighted
        NablaTheme.Colors.ButtonText.onBaseDisabled = NablaTheme.Colors.ButtonText.onBaseDisabled
        NablaTheme.Colors.ButtonText.onAccent = NablaTheme.Colors.ButtonText.onAccent
        NablaTheme.Colors.ButtonText.onAccentHighlighted = NablaTheme.Colors.ButtonText.onAccentHighlighted
        NablaTheme.Colors.ButtonText.onAccentDisabled = NablaTheme.Colors.ButtonText.onAccentDisabled
        NablaTheme.Colors.ButtonText.onAccentSubdued = NablaTheme.Colors.ButtonText.onAccentSubdued
        NablaTheme.Colors.ButtonText.onAccentSubduedHighlighted = NablaTheme.Colors.ButtonText.onAccentSubduedHighlighted
        NablaTheme.Colors.ButtonText.onAccentSubduedDisabled = NablaTheme.Colors.ButtonText.onAccentSubduedDisabled
    }
}
