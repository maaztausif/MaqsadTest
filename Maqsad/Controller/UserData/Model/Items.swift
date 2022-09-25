//
//  Items.swift
//
//  Created by maaz tausif on 25/09/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class Items: Codable {

  enum CodingKeys: String, CodingKey {
    case followingUrl = "following_url"
    case eventsUrl = "events_url"
    case followersUrl = "followers_url"
    case starredUrl = "starred_url"
    case score
    case htmlUrl = "html_url"
    case reposUrl = "repos_url"
    case nodeId = "node_id"
    case type
    case id
    case siteAdmin = "site_admin"
    case url
    case receivedEventsUrl = "received_events_url"
    case login
    case gistsUrl = "gists_url"
    case gravatarId = "gravatar_id"
    case organizationsUrl = "organizations_url"
    case subscriptionsUrl = "subscriptions_url"
    case avatarUrl = "avatar_url"
  }

  var followingUrl: String?
  var eventsUrl: String?
  var followersUrl: String?
  var starredUrl: String?
  var score: Int?
  var htmlUrl: String?
  var reposUrl: String?
  var nodeId: String?
  var type: String?
  var id: Int?
  var siteAdmin: Bool?
  var url: String?
  var receivedEventsUrl: String?
  var login: String?
  var gistsUrl: String?
  var gravatarId: String?
  var organizationsUrl: String?
  var subscriptionsUrl: String?
  var avatarUrl: String?

  init (followingUrl: String?, eventsUrl: String?, followersUrl: String?, starredUrl: String?, score: Int?, htmlUrl: String?, reposUrl: String?, nodeId: String?, type: String?, id: Int?, siteAdmin: Bool?, url: String?, receivedEventsUrl: String?, login: String?, gistsUrl: String?, gravatarId: String?, organizationsUrl: String?, subscriptionsUrl: String?, avatarUrl: String?) {
    self.followingUrl = followingUrl
    self.eventsUrl = eventsUrl
    self.followersUrl = followersUrl
    self.starredUrl = starredUrl
    self.score = score
    self.htmlUrl = htmlUrl
    self.reposUrl = reposUrl
    self.nodeId = nodeId
    self.type = type
    self.id = id
    self.siteAdmin = siteAdmin
    self.url = url
    self.receivedEventsUrl = receivedEventsUrl
    self.login = login
    self.gistsUrl = gistsUrl
    self.gravatarId = gravatarId
    self.organizationsUrl = organizationsUrl
    self.subscriptionsUrl = subscriptionsUrl
    self.avatarUrl = avatarUrl
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    followingUrl = try container.decodeIfPresent(String.self, forKey: .followingUrl)
    eventsUrl = try container.decodeIfPresent(String.self, forKey: .eventsUrl)
    followersUrl = try container.decodeIfPresent(String.self, forKey: .followersUrl)
    starredUrl = try container.decodeIfPresent(String.self, forKey: .starredUrl)
    score = try container.decodeIfPresent(Int.self, forKey: .score)
    htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
    reposUrl = try container.decodeIfPresent(String.self, forKey: .reposUrl)
    nodeId = try container.decodeIfPresent(String.self, forKey: .nodeId)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    siteAdmin = try container.decodeIfPresent(Bool.self, forKey: .siteAdmin)
    url = try container.decodeIfPresent(String.self, forKey: .url)
    receivedEventsUrl = try container.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
    login = try container.decodeIfPresent(String.self, forKey: .login)
    gistsUrl = try container.decodeIfPresent(String.self, forKey: .gistsUrl)
    gravatarId = try container.decodeIfPresent(String.self, forKey: .gravatarId)
    organizationsUrl = try container.decodeIfPresent(String.self, forKey: .organizationsUrl)
    subscriptionsUrl = try container.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
    avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
  }

}
