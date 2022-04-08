import ApolloCodegenLib
import ArgumentParser
import Foundation

// An outer structure to hold all commands and sub-commands handled by this script.
struct SwiftScript: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: """
        A swift-based utility for performing Apollo-related tasks.

        NOTE: If running from a compiled binary, prefix subcommands with `swift-script`. Otherwise use `swift run ApolloCodegen [subcommand]`.
        """,
        subcommands: [GenerateCode.self]
    )

    /// The sub-command to actually generate code.
    struct GenerateCode: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "generate",
            abstract: "Generates swift code from your schema + your operations based on information set up in the `GenerateCode` command."
        )

        mutating func run() throws {
            CodegenLogger.level = .error

            let fileStructure = try FileStructure()
            CodegenLogger.log("File structure: \(fileStructure)")

            let folderForInputs = fileStructure.sourceRootURL
                .apollo.childFolderURL(folderName: "Sources")
                .apollo.childFolderURL(folderName: "NablaCore")
                .apollo.childFolderURL(folderName: "Data")
                .apollo.childFolderURL(folderName: "GQL")
                .apollo.childFolderURL(folderName: "Schema")

            let folderForXPlatformSchema = fileStructure.sourceRootURL
                .apollo.parentFolderURL() // Packages folder
                .apollo.parentFolderURL() // ios folder
                .apollo.parentFolderURL() // sdk folder
                .apollo.parentFolderURL() // health folder
                .apollo.childFolderURL(folderName: "graphql")
                .apollo.childFolderURL(folderName: "sdk")

            let folderForOutputs = fileStructure.sourceRootURL
                .apollo.childFolderURL(folderName: "Sources")
                .apollo.childFolderURL(folderName: "NablaCore")
                .apollo.childFolderURL(folderName: "Data")
                .apollo.childFolderURL(folderName: "GQL")
                .apollo.childFolderURL(folderName: "Generated")

            let authenticatedOutputFile = ApolloCodegenOptions.OutputFormat.multipleFiles(
                inFolderAtURL: folderForOutputs
            )

            let authenticatedCodegenOptions = ApolloCodegenOptions(
                includes: "\(folderForInputs.path)/**/*.graphql",
                mergeInFieldsFromFragmentSpreads: false,
                namespace: "GQL",
                outputFormat: authenticatedOutputFile,
                customScalarFormat: .passthroughWithPrefix("GQL."),
                urlToSchemaFile: folderForXPlatformSchema.appendingPathComponent("patient.graphql")
            )

            try ApolloCodegen.run(from: fileStructure.sourceRootURL,
                                  with: fileStructure.cliFolderURL,
                                  options: authenticatedCodegenOptions)
        }
    }
}

// This will set up the command and parse the arguments when this executable is run.
SwiftScript.main()

extension URL {
    static func multiple(_ strings: [String]) -> URL? {
        URL(string: strings.joined(separator: ","))
    }
}
