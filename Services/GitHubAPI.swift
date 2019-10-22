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

public final class AddCommentToIssueMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation AddCommentToIssue($id: ID!, $body: String!) {
      addComment(input: {subjectId: $id, body: $body}) {
        __typename
        clientMutationId
        commentEdge {
          __typename
          node {
            __typename
            ...CommentDetail
          }
        }
      }
    }
    """

  public let operationName = "AddCommentToIssue"

  public var queryDocument: String { return operationDefinition.appending(CommentDetail.fragmentDefinition) }

  public var id: GraphQLID
  public var body: String

  public init(id: GraphQLID, body: String) {
    self.id = id
    self.body = body
  }

  public var variables: GraphQLMap? {
    return ["id": id, "body": body]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addComment", arguments: ["input": ["subjectId": GraphQLVariable("id"), "body": GraphQLVariable("body")]], type: .object(AddComment.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addComment: AddComment? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addComment": addComment.flatMap { (value: AddComment) -> ResultMap in value.resultMap }])
    }

    /// Adds a comment to an Issue or Pull Request.
    public var addComment: AddComment? {
      get {
        return (resultMap["addComment"] as? ResultMap).flatMap { AddComment(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addComment")
      }
    }

    public struct AddComment: GraphQLSelectionSet {
      public static let possibleTypes = ["AddCommentPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientMutationId", type: .scalar(String.self)),
        GraphQLField("commentEdge", type: .object(CommentEdge.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(clientMutationId: String? = nil, commentEdge: CommentEdge? = nil) {
        self.init(unsafeResultMap: ["__typename": "AddCommentPayload", "clientMutationId": clientMutationId, "commentEdge": commentEdge.flatMap { (value: CommentEdge) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? {
        get {
          return resultMap["clientMutationId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "clientMutationId")
        }
      }

      /// The edge from the subject's comment connection.
      public var commentEdge: CommentEdge? {
        get {
          return (resultMap["commentEdge"] as? ResultMap).flatMap { CommentEdge(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "commentEdge")
        }
      }

      public struct CommentEdge: GraphQLSelectionSet {
        public static let possibleTypes = ["IssueCommentEdge"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(node: Node? = nil) {
          self.init(unsafeResultMap: ["__typename": "IssueCommentEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
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
    }
  }
}

public final class EditCommentIssueMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation EditCommentIssue($id: ID!, $body: String!) {
      updateIssueComment(input: {id: $id, body: $body}) {
        __typename
        clientMutationId
        issueComment {
          __typename
          ...CommentDetail
        }
      }
    }
    """

  public let operationName = "EditCommentIssue"

  public var queryDocument: String { return operationDefinition.appending(CommentDetail.fragmentDefinition) }

  public var id: GraphQLID
  public var body: String

  public init(id: GraphQLID, body: String) {
    self.id = id
    self.body = body
  }

  public var variables: GraphQLMap? {
    return ["id": id, "body": body]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateIssueComment", arguments: ["input": ["id": GraphQLVariable("id"), "body": GraphQLVariable("body")]], type: .object(UpdateIssueComment.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateIssueComment: UpdateIssueComment? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateIssueComment": updateIssueComment.flatMap { (value: UpdateIssueComment) -> ResultMap in value.resultMap }])
    }

    /// Updates an IssueComment object.
    public var updateIssueComment: UpdateIssueComment? {
      get {
        return (resultMap["updateIssueComment"] as? ResultMap).flatMap { UpdateIssueComment(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateIssueComment")
      }
    }

    public struct UpdateIssueComment: GraphQLSelectionSet {
      public static let possibleTypes = ["UpdateIssueCommentPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientMutationId", type: .scalar(String.self)),
        GraphQLField("issueComment", type: .object(IssueComment.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(clientMutationId: String? = nil, issueComment: IssueComment? = nil) {
        self.init(unsafeResultMap: ["__typename": "UpdateIssueCommentPayload", "clientMutationId": clientMutationId, "issueComment": issueComment.flatMap { (value: IssueComment) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? {
        get {
          return resultMap["clientMutationId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "clientMutationId")
        }
      }

      /// The updated comment.
      public var issueComment: IssueComment? {
        get {
          return (resultMap["issueComment"] as? ResultMap).flatMap { IssueComment(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "issueComment")
        }
      }

      public struct IssueComment: GraphQLSelectionSet {
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
  }
}

public final class DeleteCommentIssueMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation DeleteCommentIssue($id: ID!) {
      deleteIssueComment(input: {id: $id}) {
        __typename
        clientMutationId
      }
    }
    """

  public let operationName = "DeleteCommentIssue"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteIssueComment", arguments: ["input": ["id": GraphQLVariable("id")]], type: .object(DeleteIssueComment.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteIssueComment: DeleteIssueComment? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteIssueComment": deleteIssueComment.flatMap { (value: DeleteIssueComment) -> ResultMap in value.resultMap }])
    }

    /// Deletes an IssueComment object.
    public var deleteIssueComment: DeleteIssueComment? {
      get {
        return (resultMap["deleteIssueComment"] as? ResultMap).flatMap { DeleteIssueComment(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "deleteIssueComment")
      }
    }

    public struct DeleteIssueComment: GraphQLSelectionSet {
      public static let possibleTypes = ["DeleteIssueCommentPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientMutationId", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(clientMutationId: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "DeleteIssueCommentPayload", "clientMutationId": clientMutationId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? {
        get {
          return resultMap["clientMutationId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "clientMutationId")
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
            nodes {
              __typename
              ...CommentDetail
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
            GraphQLField("nodes", type: .list(.object(Node.selections))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
            self.init(unsafeResultMap: ["__typename": "IssueCommentConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of nodes.
          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
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
      id
      author {
        __typename
        avatarUrl(size: 40)
        login
      }
      bodyText
      createdAt
      viewerDidAuthor
    }
    """

  public static let possibleTypes = ["PullRequest", "Issue", "GistComment", "TeamDiscussion", "TeamDiscussionComment", "CommitComment", "IssueComment", "PullRequestReviewComment", "PullRequestReview"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("author", type: .object(Author.selections)),
    GraphQLField("bodyText", type: .nonNull(.scalar(String.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
    GraphQLField("viewerDidAuthor", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public static func makePullRequest(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "PullRequest", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeIssue(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "Issue", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeGistComment(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "GistComment", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeTeamDiscussion(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "TeamDiscussion", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeTeamDiscussionComment(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "TeamDiscussionComment", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeCommitComment(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "CommitComment", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makeIssueComment(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "IssueComment", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequestReviewComment(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "PullRequestReviewComment", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
  }

  public static func makePullRequestReview(id: GraphQLID, author: Author? = nil, bodyText: String, createdAt: String, viewerDidAuthor: Bool) -> CommentDetail {
    return CommentDetail(unsafeResultMap: ["__typename": "PullRequestReview", "id": id, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "bodyText": bodyText, "createdAt": createdAt, "viewerDidAuthor": viewerDidAuthor])
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

  /// Did the viewer author this comment.
  public var viewerDidAuthor: Bool {
    get {
      return resultMap["viewerDidAuthor"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerDidAuthor")
    }
  }

  public struct Author: GraphQLSelectionSet {
    public static let possibleTypes = ["User", "Organization", "Bot", "Mannequin", "EnterpriseUserAccount"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", arguments: ["size": 40], type: .nonNull(.scalar(String.self))),
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
