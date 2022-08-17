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
        @Argument() var packageName: String
        
        static var configuration = CommandConfiguration(
            commandName: "generate",
            abstract: "Generates swift code from your schema + your operations based on information set up in the `GenerateCode` command."
        )

        mutating func run() throws {
            CodegenLogger.level = .error
            
            let supportedPackageNames = ["NablaCore", "NablaMessagingCore"]
            guard supportedPackageNames.contains(packageName) else {
                throw CommandError(message: "Unknown package name \"\(packageName)\". Supported package names are: \(supportedPackageNames)")
            }
            
            try codegen(packageName: packageName)
        }
        
        private func codegen(packageName: String) throws {
            let fileStructure = try FileStructure()
            CodegenLogger.log("File structure: \(fileStructure)")
            
            let packageFolder = fileStructure.rootFolderURL
                .apollo.childFolderURL(folderName: "Sources")
                .apollo.childFolderURL(folderName: packageName)
            
            let gqlFolder = packageFolder
                .apollo.childFolderURL(folderName: "Data")
                .apollo.childFolderURL(folderName: "GQL")
            
            let folderForInputs = gqlFolder
                .apollo.childFolderURL(folderName: "Schema")

            let folderForOutputs = gqlFolder
                .apollo.childFolderURL(folderName: "Generated")

            let authenticatedOutputFormat = ApolloCodegenOptions.OutputFormat.multipleFiles(
                inFolderAtURL: folderForOutputs
            )
            
            try? FileManager.default.removeItem(at: folderForOutputs)

            let authenticatedCodegenOptions = ApolloCodegenOptions(
                includes: "\(folderForInputs.path)/**/*.graphql",
                mergeInFieldsFromFragmentSpreads: false,
                modifier: .internal, // Does not work, see extra command in build.sh
                namespace: "GQL",
                outputFormat: authenticatedOutputFormat,
                customScalarFormat: .passthroughWithPrefix("GQL."),
                urlToSchemaFile: fileStructure.xplatformSchemaFolderUrl.appendingPathComponent("patient.graphql")
            )

            try ApolloCodegen.run(from: fileStructure.codegenFolderUrl,
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

struct CommandError: Error {
    let message: String
}
