from slacker import Slacker
import sys

slack = Slacker(<slack_token>)

# Send a message to #general channel
slack.chat.post_message('#demo', sys.argv[1])

