import ApolloCodegenLib
import Foundation

// An object representing the filesystem structure. Allows you to grab references to folders in the filesystem without having to pass them through as environment variables.
struct FileStructure {
    let rootFolderURL: URL
    let codegenFolderUrl: URL
    let cliFolderURL: URL
    let xplatformSchemaFolderUrl: URL

    init() throws {
        // Grab the parent folder of this file on the filesystem
        let parentFolderOfScriptFile = FileFinder.findParentFolder()
        CodegenLogger.log("Parent folder of script file: \(parentFolderOfScriptFile)")

        // Use that to calculate the source root for both your main project and this codegen project.
        // NOTE: You may need to change this if your project has a different structure than the suggested structure.
        codegenFolderUrl = parentFolderOfScriptFile
            .parentFolderURL() // Result: Sources folder
            .parentFolderURL() // Result: ApolloCodegen folder
        
        rootFolderURL = codegenFolderUrl
            .parentFolderURL() // Result: root folder

        // Set up the folder where you want the typescript CLI to download.
        cliFolderURL = rootFolderURL
            .childFolderURL(folderName: "ApolloCodegen")
            .childFolderURL(folderName: "ApolloCLI")
        
        // TODO: Copy server schema inside ios sdk folder
        xplatformSchemaFolderUrl = rootFolderURL
            .parentFolderURL() // sdk folder
            .parentFolderURL() // health folder
            .childFolderURL(folderName: "graphql")
            .childFolderURL(folderName: "patient")
    }
}

extension FileStructure: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        Root folder URL: \(rootFolderURL)
        ApolloCodgegen folder URL: \(codegenFolderUrl)
        CLI folder URL: \(cliFolderURL)
        XPlatform schema folder URL: \(xplatformSchemaFolderUrl)
        """
    }
}
