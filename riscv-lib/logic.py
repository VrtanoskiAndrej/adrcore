class BitLogic(list):
    '''
    BITS REPRESENTATION:
        0b1100 => ['0', '0', '1', '1']
        The notation allows for conventional indexing
    '''
    
    bits = []
    size = 0

    def __init__(self, size, data=0):
        assert (size > 0)
        
        self.size = size
        if data == 0:
            self.zero()
        else:
            self.set(data)
    
    def __str__(self):
        bin_str = ''.join(self.bits[::-1])
        return f'{self.size}\'b{bin_str}'
    
    def __getitem__(self, key):
        if isinstance(key, slice):
            indices = range(*key.indices(len(self.bits)))
            elements = [self.bits[i] for i in indices]
            return int(''.join(elements[::-1]), 2)
        return self.bits[key]
    
    def zero(self):
        self.bits = ['0'] * self.size
    
    def set(self, value):
        assert(value < 2 ** self.size)
        
        self.zero()
        # convert value to binary string and reverse it
        # for correct indexing
        bin_str = "{0:b}".format(value)[::-1]
        for i in range(len(bin_str)):
            self.bits[i] = bin_str[i]
    
