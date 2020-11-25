# HackerNewsAggregator

Appliction setup:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## API Reference
This api is rate limited you cannot request more than 5 events per minute

### HTTP API
The api endpoint is ass folllows 
##### GET /api/get-hacker-news-top-stories
get the top 50 stoires paginated with page size of 10
params:
* page(integer)

### WebSocket 
web sockets uses phoenix channels, reference for available client libraries https://hexdocs.pm/phoenix/channels.html#client-libraries

##### top_stories:lobby
join does not requiere authentication 
Events:
* fetch_stories (will push all the top hacker news stories in a list after join)
* update_action (whenever and update ocourse will send one of two actions explained below)
actions:
```json
{
    "action": "replace",
    "old_item": <old_story>,
    "new_item": <new_story>
}

{
    "action": "add",
    "item": <story_to_add>
}
```




