from pprint import pprint
import csv

class RISCVISA():
    isa = []
    isa_map = {}
    name_lookup = {}
    header = []

    def __init__(self, filename):
        # parse csv file to create a list of instruction types
        with open(filename) as rvfile:
            rvreader = csv.reader(rvfile)
            for rvinst in rvreader:
                instruction_def = []
                for field in rvinst:
                    field = field.strip()
                    val = None

                    # convert field in csv to int if possible
                    try:
                        val = int(field, 0)
                    except ValueError:
                        val = field
                    instruction_def.append(val)
                self.isa.append(instruction_def)

        # skip header line
        self.header = self.isa[0]
        self.isa = self.isa[1:]
            
        # construct isa map
        map_keys = self.header[1:]
        for inst in self.isa:
            self.isa_map[inst[0]] = dict(zip(map_keys, inst[1:]))

        # construct lookup map
        for inst in self.isa:
            self.name_lookup[(inst[2], inst[3], inst[4])] = inst[0]

    def display(self):        
        print('*** INST ARRAY ***')
        print(self.header)
        for inst in self.isa:
            print(inst)
        print()
        
        print('*** INST MAP ***')
        pprint(self.isa_map)
        print()
        
        print('*** NAME LOOKUP ***')
        pprint(self.name_lookup)
        print()
        
    def get_name(self, field):
        return self.name_lookup.get(field, 'invalid')

    def get_field(self, name):
        return self.isa_map.get(name, {})

rv32_filename = 'rv32.csv'
rv32 = RISCVISA(rv32_filename)