import Foundation

let version = "v0.0.4-alpha"

func resolveAliasFile(_ url: URL) throws -> URL? {

    var isAliasOfAny: AnyObject?

    try (url as NSURL).getResourceValue(&isAliasOfAny, forKey: URLResourceKey.isAliasFileKey)

    switch isAliasOfAny {
    case let isAlias as Bool:
        if isAlias {
            return try URL(resolvingAliasFileAt: url, options: NSURL.BookmarkResolutionOptions())
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

    if let resolvepath = try resolveAliasFile(aliasURL)?.path {
        print(resolvepath)
    } else {
        var standardError = StandardErrorOutputStream()
        print("Not alias file: \(filePath)", to: &standardError)
        exit(1)
    }
} else {
    print("ResolveAlias, version \(version)\n\nusage: ResolveAlias <file>")
}
