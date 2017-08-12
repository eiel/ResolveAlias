import Foundation

let version = "v0.0.4-alpha"

func resolveFinderAlias(_ url: URL) throws -> String? {

    var isAliasOfAny: AnyObject?

    try (url as NSURL).getResourceValue(&isAliasOfAny, forKey: URLResourceKey.isAliasFileKey)
    switch isAliasOfAny {
    case let isAlias as Bool:
        if isAlias {
            let original = try URL(resolvingAliasFileAt: url, options: NSURL.BookmarkResolutionOptions())
            return original.path
        }
    default:
        return nil
    }

    return nil
}

class StandardErrorOutputStream: TextOutputStream {
    func write(_ string: String) {
        let stderr = FileHandle.standardError
        if let odata = string.data(using: String.Encoding.utf8) {
            stderr.write(odata)
        }
    }
}

let arguments: [String] = CommandLine.arguments

if arguments.count > 1 {
    let filePath = arguments[1]
    let aliasURL = URL(fileURLWithPath: filePath)

    if let url = try resolveFinderAlias(aliasURL) {
        print(url)
    } else {
        var standardError = StandardErrorOutputStream()
        print("Not alias file: \(filePath)", to: &standardError)
        exit(1)
    }
} else {
    print("ResolveAlias, version \(version)\n\nusage: ResolveAlias <file>")
}
