# bro

brother.ly's basecamp chatbot.

## Installation

Clone the repo:

```bash
$ git clone https://github.com/waxpoetic/bro.git
$ cd bro
```

Install dependencies:

```bash
$ bin/setup
```

Export configuration:

```bash
$ export BRO_USERNAME='whatever-username-you-want'
$ export BRO_PASSWORD='whatever-password-you-want'
$ export RACK_ENV='deployment'
$ export PORT=3000
```

Start the application server:

```bash
$ bin/foreman start
```

## Usage

Browse to <http://localhost:3000> and log in with the above set
username/password settings to read the commands you can use.

### Sending Commands

Commands can be sent with the following JSON payload sent via a POST
request to the above URL:

```json
{
  "command": "a command that bro can understand",
  "creator": {
    "id": 1007299143,
    "attachable_sgid": "BAh7CEkiCGdpZAY6BkVUSSIrZ2lkOi8vYmMzL1BlcnNvbQQcMDA3Mjk5MTQzP2V4cGlyZXNfaW4GOwBUSSIMcHVycG9zZQY7AFRJIg9hdHRhY2hhYmxlBjsAVEkiD2V4cGlyZXNfYXQGOwBUMA==--919d2c8b11ff403eefcab9db42dd26846d0c3102",
    "name": "Victor Cooper",
    "email_address": "victor@honchodesign.com",
    "personable_type": "User",
    "title": "Chief Strategist",
    "bio": "Don't let your dreams be dreams",
    "created_at": "2016-09-22T16:21:03.625-05:00",
    "updated_at": "2016-09-22T16:21:06.184-05:00",
    "admin": true,
    "owner": true,
    "time_zone": "America/Chicago",
    "avatar_url": "https://3.basecamp-static.com/195539477/people/BAhpBEcqCjw=--c632b967cec296b87363a697a67a87f9cc1e5b45/avatar-64-x4",
    "company": {
      "id": 1033447817,
      "name": "Honcho Design"
    }
  },
  "callback_url": "https://3.basecamp.com/195539477/integrations/2uH9aHLEVhhaXKPaqrj8yw8P/buckets/2085958501/chats/9007199254741775/lines"
}
```

Set up this bot following the [Basecamp Chatbot guide][]

### Adding New Commands

To add a command, run the Rake task generator with a `NAME` shell
argument:

```bash
$ bin/rake command NAME=TwitterPost
```

This will generate the following files:

* bot/commands/twitter_post.rb
* bot/templates/twitter_post.erb
* test/commands/twitter_post.rb

You can now begin editing the command implementation as well as the
test. The template file is provided so you can customize what is sent
back into the Campfire upon successful receipt of the message. If you
don't want to send anything back, just delete this file and the bot will
respond with an empty `200 OK` response.

**NOTE:** The server must be restarted when new commands are added.

## Development

Developers and command authors will want to make sure the test suite
passes before submitting their changes. To do so, run the following
command:

```bash
$ bin/rake test
```

You might also want to make sure that your code passes our style guide
linter, in case your editor isn't configured to automatically flag
style guide infractions as warnings. Run the following command to ensure
your code will pass style checks:

```bash
$ bin/rake lint
```

For an interactive prompt that lets you experiment with the `Bro` code
already loaded, run:

```bash
$ bin/console
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/waxpoetic/bro. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

This project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


[Basecamp Chatbot guide]: https://github.com/basecamp/bc3-api/blob/master/sections/chatbots.md
