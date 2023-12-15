#ifndef ADR_core
#define ADR_core

#include "define.h"
#include "fetch.h"

class Fetch;

class Core {
    public:
        void step();

        Fetch *fetch;
        // Decode decode;
        // Issue issue;
        // Execute execute;
};

#endif