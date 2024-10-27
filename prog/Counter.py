class Counter:
    def __init__(self):
        self.count = 0
        self.is_open = True

    def add(self):
        if not self.is_open:
            raise Exception("Counter is not open.")
        self.count += 1

    def close(self):
        self.is_open = False

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()
        if self.is_open:
            raise Exception("Counter was not used in a proper context.")
