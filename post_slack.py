from slacker import Slacker
import sys

slack = Slacker('xoxb-283252429493-Oj9UwziwOGBm6kCtJFj5oGQN')

# Send a message to #general channel
slack.chat.post_message('#demo', sys.argv[1])

