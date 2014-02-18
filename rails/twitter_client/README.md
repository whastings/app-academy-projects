# Twitter Client

This is a backend for a simple Twitter client that can
retrieve users and their statuses from Twitter's API via OAuth.

## Usage:

- `TwitterSession`
    + Provides `::get` and `::post` methods for easily loading data from Twitter's API.
    + Sends user to Twitter on first use for OAuth authorization.
    + Caches OAuth access token for subsequent uses.
- `Status` model
    + Provides status fetching method, including `::get_by_twitter_user_id`
    + Provides posting statuses via `::post`
- `User` model
    + Provides user fetching methods, including `::get_by_screen_name`
    + Defines `#statuses` association.

Pair programming partner: Coburn Berry
