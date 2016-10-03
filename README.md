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
request to `/commands`:

```json
{
  "command": "a command that bro can understand"
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
