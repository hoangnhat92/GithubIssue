//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// The possible states of an issue.
public enum IssueState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// An issue that is still open
  case `open`
  /// An issue that has been closed
  case closed
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "OPEN": self = .open
      case "CLOSED": self = .closed
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .open: return "OPEN"
      case .closed: return "CLOSED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: IssueState, rhs: IssueState) -> Bool {
    switch (lhs, rhs) {
      case (.open, .open): return true
      case (.closed, .closed): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [IssueState] {
    return [
      .open,
      .closed,
    ]
  }
}

public final class AuthenticateQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query Authenticate($owner: String!, $name: String!) {
      repository(owner: $owner, name: $name) {
        __typename
        id
        name
        nameWithOwner
        owner {
          __typename
          login
        }
      }
    }
    """

  public let operationName = "Authenticate"

  public var owner: String
  public var name: String

  public init(owner: String, name: String) {
    self.owner = owner
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("nameWithOwner", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, nameWithOwner: String, owner: Owner) {
        self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "name": name, "nameWithOwner": nameWithOwner, "owner": owner.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// The name of the repository.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The repository's name with owner.
      public var nameWithOwner: String {
        get {
          return resultMap["nameWithOwner"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "nameWithOwner")
        }
      }

      /// The User owner of the repository.
      public var owner: Owner {
        get {
          return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "owner")
        }
      }

      public struct Owner: GraphQLSelectionSet {
        public static let possibleTypes = ["User", "Organization"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeUser(login: String) -> Owner {
          return Owner(unsafeResultMap: ["__typename": "User", "login": login])
        }

        public static func makeOrganization(login: String) -> Owner {
          return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The username used to login.
        public var login: String {
          get {
            return resultMap["login"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "login")
          }
        }
      }
    }
  }
}

public final class GetRepositoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query GetRepository($owner: String!, $name: String!, $limit: Int, $cursor: String) {
      repository(owner: $owner, name: $name) {
        __typename
        id
        name
        owner {
          __typename
          login
        }
        nameWithOwner
        issues(first: $limit, after: $cursor, orderBy: {field: CREATED_AT, direction: DESC}) {
          __typename
          edges {
            __typename
            node {
              __typename
              ...IssueDetail
            }
            cursor
          }
          pageInfo {
            __typename
            endCursor
            hasNextPage
          }
        }
      }
    }
    """

  public let operationName = "GetRepository"

  public var queryDocument: String { return operationDefinition.appending(IssueDetail.fragmentDefinition) }

  public var owner: String
  public var name: String
  public var limit: Int?
  public var cursor: String?

  public init(owner: String, name: String, limit: Int? = nil, cursor: String? = nil) {
    self.owner = owner
    self.name = name
    self.limit = limit
    self.cursor = cursor
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "limit": limit, "cursor": cursor]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
        GraphQLField("nameWithOwner", type: .nonNull(.scalar(String.self))),
        GraphQLField("issues", arguments: ["first": GraphQLVariable("limit"), "after": GraphQLVariable("cursor"), "orderBy": ["field": "CREATED_AT", "direction": "DESC"]], type: .nonNull(.object(Issue.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, owner: Owner, nameWithOwner: String, issues: Issue) {
        self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "name": name, "owner": owner.resultMap, "nameWithOwner": nameWithOwner, "issues": issues.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// The name of the repository.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The User owner of the repository.
      public var owner: Owner {
        get {
          return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "owner")
        }
      }

      /// The repository's name with owner.
      public var nameWithOwner: String {
        get {
          return resultMap["nameWithOwner"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "nameWithOwner")
        }
      }

      /// A list of issues that have been opened in the repository.
      public var issues: Issue {
        get {
          return Issue(unsafeResultMap: resultMap["issues"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "issues")
        }
      }

      public struct Owner: GraphQLSelectionSet {
        public static let possibleTypes = ["User", "Organization"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeUser(login: String) -> Owner {
          return Owner(unsafeResultMap: ["__typename": "User", "login": login])
        }

        public static func makeOrganization(login: String) -> Owner {
          return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The username used to login.
        public var login: String {
          get {
            return resultMap["login"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "login")
          }
        }
      }

      public struct Issue: GraphQLSelectionSet {
        public static let possibleTypes = ["IssueConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "IssueConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["IssueEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
            GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(unsafeResultMap: ["__typename": "IssueEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          /// A cursor for use in pagination.
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Issue"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(IssueDetail.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var issueDetail: IssueDetail {
                get {
                  return IssueDetail(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("endCursor", type: .scalar(String.self)),
            GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public final class GetListCommentsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query GetListComments($owner: String!, $name: String!, $number: Int!, $limit: Int, $cursor: String) {
      repository(owner: $owner, name: $name) {
        __typename
        issue(number: $number) {
          __typename
          ...IssueDetail
          comments(first: $limit, after: $cursor) {
            __typename
            edges {
              __typename
              node {
                __typename
                ...CommentDetail
              }
              cursor
            }
            pageInfo {
              __typename
              endCursor
              hasNextPage
            }
          }
        }
      }
    }
    """

  public let operationName = "GetListComments"

  public var queryDocument: String { return operationDefinition.appending(IssueDetail.fragmentDefinition).appending(CommentDetail.fragmentDefinition) }

  public var owner: String
  public var name: String
  public var number: Int
  public var limit: Int?
  public var cursor: String?

  public init(owner: String, name: String, number: Int, limit: Int? = nil, cursor: String? = nil) {
    self.owner = owner
    self.name = name
    self.number = number
    self.limit = limit
    self.cursor = cursor
  }

  public var variables: GraphQLMap? {
    return ["owner": owner, "name": name, "number": number, "limit": limit, "cursor": cursor]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["owner": GraphQLVariable("owner"), "name": GraphQLVariable("name")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("issue", arguments: ["number": GraphQLVariable("number")], type: .object(Issue.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(issue: Issue? = nil) {
        self.init(unsafeResultMap: ["__typename": "Repository", "issue": issue.flatMap { (value: Issue) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Returns a single issue from the current repository by number.
      public var issue: Issue? {
        get {
          return (resultMap["issue"] as? ResultMap).flatMap { Issue(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "issue")
        }
      }

      public struct Issue: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(IssueDetail.self),
          GraphQLField("comments", arguments: ["first": GraphQLVariable("limit"), "after": GraphQLVariable("cursor")], type: .nonNull(.object(Comment.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of comments associated with the Issue.
        public var comments: Comment {
          get {
            return Comment(unsafeResultMap: resultMap["comments"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "comments")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var issueDetail: IssueDetail {
            get {
              return IssueDetail(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Comment: GraphQLSelectionSet {
          public static let possibleTypes = ["IssueCommentConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
            self.init(unsafeResultMap: ["__typename": "IssueCommentConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of edges.
          public var edges: [Edge?]? {
            get {
              return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
            }
          }

          /// Information to aid in pagination.
          public var pageInfo: PageInfo {
            get {
              return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
            }
          }

          public struct Edge: GraphQLSelectionSet {
            public static let possibleTypes = ["IssueCommentEdge"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(node: Node? = nil, cursor: String) {
              self.init(unsafeResultMap: ["__typename": "IssueCommentEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "cursor": cursor])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The item at the end of the edge.
            public var node: Node? {
              get {
                return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "node")
              }
            }

            /// A cursor for use in pagination.
            public var cursor: String {
              get {
                return resultMap["cursor"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "cursor")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes = ["IssueComment"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(CommentDetail.self),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var commentDetail: CommentDetail {
                  get {
                    return CommentDetail(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }
          }

          public struct PageInfo: GraphQLSelectionSet {
            public static let possibleTypes = ["PageInfo"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(endCursor: String? = nil, hasNextPage: Bool) {
              self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// When paginating forwards, the cursor to continue.
            public var endCursor: String? {
              get {
                return resultMap["endCursor"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "endCursor")
              }
            }

            /// When paginating forwards, are there more items?
            public var hasNextPage: Bool {
              get {
                return resultMap["hasNextPage"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "hasNextPage")
              }
            }
          }
        }
      }
    }
  }
}

public struct CommentDetail: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition =
    """
    fragment CommentDetail on Comment {
      __typename
      author {
        __typename
        avatarUrl
        login
      }
      bodyText
      createdAt
    }
    """

  public static let possibleTypes = ["PullRequest", "Issue", "GistComment", "TeamDiscussion", "TeamDiscussionComment", "CommitComment", "IssueComment", "PullRequestReviewComment", "PullRequestReview"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("author", type: .object(Author.selections)),
    GraphQLField("bodyText", type: .nonNull(.scalar(String.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makePullRequest(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "PullRequest", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public static func makeIssue(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "Issue", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public static func makeGistComment(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "GistComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public static func makeTeamDiscussion(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "TeamDiscussion", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public static func makeTeamDiscussionComment(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "TeamDiscussionComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public static func makeCommitComment(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "CommitComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public static func makeIssueComment(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "IssueComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public static func makePullRequestReviewComment(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "PullRequestReviewComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public static func makePullRequestReview(author: Author? = nil, bodyText: String, createdAt: String) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "PullRequestReview", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  /// The body rendered to text.
  public var bodyText: String {
    get {
      return resultMap["bodyText"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "bodyText")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes = ["User", "Organization", "Bot", "Mannequin", "EnterpriseUserAccount"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeUser(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeOrganization(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Organization", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeBot(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Bot", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeMannequin(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Mannequin", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeEnterpriseUserAccount(avatarUrl: String, login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "avatarUrl": avatarUrl, "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A URL pointing to the actor's public avatar.
    public var avatarUrl: String {
      get {
        return resultMap["avatarUrl"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
      }
    }

    /// The username of the actor.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }
}

public struct IssueDetail: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition =
    """
    fragment IssueDetail on Issue {
      __typename
      id
      number
      title
      state
      bodyText
      createdAt
      author {
        __typename
        login
      }
      repository {
        __typename
        name
        owner {
          __typename
          login
        }
      }
    }
    """

  public static let possibleTypes = ["Issue"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("number", type: .nonNull(.scalar(Int.self))),
    GraphQLField("title", type: .nonNull(.scalar(String.self))),
    GraphQLField("state", type: .nonNull(.scalar(IssueState.self))),
    GraphQLField("bodyText", type: .nonNull(.scalar(String.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
    GraphQLField("author", type: .object(Author.selections)),
    GraphQLField("repository", type: .nonNull(.object(Repository.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, number: Int, title: String, state: IssueState, bodyText: String, createdAt: String, author: Author? = nil, repository: Repository) {
    self.init(unsafeResultMap: ["__typename": "Issue", "id": id, "number": number, "title": title, "state": state, "bodyText": bodyText, "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "repository": repository.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// Identifies the issue number.
  public var number: Int {
    get {
      return resultMap["number"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "number")
    }
  }

  /// Identifies the issue title.
  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  /// Identifies the state of the issue.
  public var state: IssueState {
    get {
      return resultMap["state"]! as! IssueState
    }
    set {
      resultMap.updateValue(newValue, forKey: "state")
    }
  }

  /// Identifies the body of the issue rendered to text.
  public var bodyText: String {
    get {
      return resultMap["bodyText"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "bodyText")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// The actor who authored the comment.
  public var author: Author? {
    get {
      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "author")
    }
  }

  /// The repository associated with this node.
  public var repository: Repository {
    get {
      return Repository(unsafeResultMap: resultMap["repository"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "repository")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes = ["User", "Organization", "Bot", "Mannequin", "EnterpriseUserAccount"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeUser(login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "User", "login": login])
    }

    public static func makeOrganization(login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Organization", "login": login])
    }

    public static func makeBot(login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Bot", "login": login])
    }

    public static func makeMannequin(login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "Mannequin", "login": login])
    }

    public static func makeEnterpriseUserAccount(login: String) -> Author {
      return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The username of the actor.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }

  public struct Repository: GraphQLSelectionSet {
    public static let possibleTypes = ["Repository"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String, owner: Owner) {
      self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "owner": owner.resultMap])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The name of the repository.
    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    /// The User owner of the repository.
    public var owner: Owner {
      get {
        return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "owner")
      }
    }

    public struct Owner: GraphQLSelectionSet {
      public static let possibleTypes = ["User", "Organization"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("login", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public static func makeUser(login: String) -> Owner {
        return Owner(unsafeResultMap: ["__typename": "User", "login": login])
      }

      public static func makeOrganization(login: String) -> Owner {
        return Owner(unsafeResultMap: ["__typename": "Organization", "login": login])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }
    }
  }
}
