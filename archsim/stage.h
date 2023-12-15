#ifndef ADR_stage
#define ADR_stage

#include "define.h"
#include "core.h"

class Core;

class Stage {
    public:
        virtual void step();
        Core *core;
    private:
    
};

#endif