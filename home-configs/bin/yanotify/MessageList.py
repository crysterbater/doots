import sys

class MessageList:

    def __init__(self):
        self.decorate = True
        self.messages = []
        self.current_message = 0;

    def show(self, i):
        if(i >= len(self.messages) or i < 0):
            return

        self.current_message = i
        #if inactive

        message = self.messages[i].get()
        if(self.decorate):
            status = str(i + 1) + '/' + str(len(self.messages) ) + ' '
        else:
            status = ""

        sys.stdout.write(status + message + '\n')
        sys.stdout.flush()

    def add(self, m):
        pos = len(self.messages)
        self.messages.insert(pos, m)
        self.show(pos)

    def handle(self, m):
        self.add(m)

    def navigate(self, direction, smart):
        temp = self.current_message + direction
        self.show(temp)
