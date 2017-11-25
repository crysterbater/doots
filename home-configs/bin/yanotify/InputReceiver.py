import os, time
from threading import Thread

PIPE = "/tmp/yanotify"

class InputReceiver(Thread):
    def __init__(self, f = None):
        #Fifo business
        if os.path.exists(PIPE):
            os.remove(PIPE)
        os.mkfifo(PIPE)

        #Input Display
        if(f == None):
            self.function = self.printInput
        else:
            self.function = f

        #Thread business
        super(InputReceiver, self).__init__()
        self.daemon = True
        self.start()

    def run(self):
        while True:
            fifo = open(PIPE, "r")
            for line in fifo:
                self.function(line)
            fifo.close()

    def printInput(self, s):
        print(s)


if __name__ == "__main__":
    InputReceiver()
    while True:
        time.sleep(1)
