//
//  Goonies.swift
//  GitHubGoonies
//
//  Created by Jo Albright on 9/28/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import Foundation

// Normal

// new class file -> GoonieDetailViewController
// layout the detail view controller to display all of the simple & full detail info
// add a plus button to the top right of the navigationbar on the Goonies view

// Hard

// add a new view controller to storyboard below the Goonies viewcontroller
// connect the plus button with a present segue
// add a textfield, submit button to presented viewcontroller
// add a cancel button that dismisses the presented viewcontroller


// simple detail

// avatar
// username

// full detail

// full name
// location
// bio
// followers
// following
// repo count
// gist count



let API_ROOT = "https://api.github.com"

let myProfileURL = API_ROOT + "/users/joalbright"

let users: [[String:AnyObject?]] = [
    
    [
        
        "login": "joalbright",
        "id": 1536630,
        "avatar_url": "https://avatars.githubusercontent.com/u/1536630?v=3",
        "gravatar_id": "",
        "url": "https://api.github.com/users/joalbright",
        "html_url": "https://github.com/joalbright",
        "followers_url": "https://api.github.com/users/joalbright/followers",
        "following_url": "https://api.github.com/users/joalbright/following{/other_user}",
        "gists_url": "https://api.github.com/users/joalbright/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/joalbright/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/joalbright/subscriptions",
        "organizations_url": "https://api.github.com/users/joalbright/orgs",
        "repos_url": "https://api.github.com/users/joalbright/repos",
        "events_url": "https://api.github.com/users/joalbright/events{/privacy}",
        "received_events_url": "https://api.github.com/users/joalbright/received_events",
        "type": "User",
        "site_admin": false,
        "name": "Jo Albright",
        "company": "The Iron Yard",
        "blog": "jo2.co",
        "location": "Atlanta, Ga",
        "email": "me@jo2.co",
        "hireable": nil,
        "bio": nil,
        "public_repos": 43,
        "public_gists": 6,
        "followers": 69,
        "following": 75,
        "created_at": "2012-03-14T13:26:03Z",
        "updated_at": "2015-09-25T22:16:40Z"
        
    ]
    
]