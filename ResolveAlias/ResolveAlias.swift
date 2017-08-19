import Foundation

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
