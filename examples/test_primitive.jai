#import,dir "..";

main :: () {
    test(u8,   5);
    test(s8,  -5);
    test(u16,  999);
    test(s16, -99);
    test(u32,  91827389);
    test(s32, -89127312);
    test(u64,  71234897119847);
    test(s64, -817234981247);
    test(float32, 1.24234);
    test(float64, 9.189234718923);
    test(bool, true);
    test(bool, false);

    test([]u8,  .[1,2,3,4]);
    test([]s8,  .[-1,-2,-3,-4]);
    test([]u16, .[100,200,300,400]);
    test([]s16, .[-100,-200,-300,-400]);
    test([]u32, .[1000,2000,3000]);
    test([]s32, .[-1000,-2000,-3000]);
    test([]u64, .[10000,20000]);
    test([]s64, .[-10000,-20000]);
    test([]float32, .[3.1415, 6.2821]);
    test([]float64, .[3.14159265, 6.28218530]);
    test(string, "Hello, Sailor!");
}

test :: ($T: Type, data: T) {
    res1 := bitwriter_primitive(data);
    res2 := bitreader_primitive(res1, T);
    print("Type: %, \n-\tValue: %, \n-\tRes1: %, \n-\tRes2: %\n",
          T, data, res1, res2.*);
    info := (cast(**Type_Info) *T).*;
    free_res(res2);
}

free_res :: (data: *$T) #modify {
    return ifx T == u8      || T == s8      || T == u16  || T == s16
            || T == u32     || T == s32     || T == u64  || T == s64
            || T == float32 || T == float64 || T == bool
    then true
    else false;
} {
    free(data);
}

free_res :: (data: *$T) #modify {
    return ifx T == []u8      || T == []s8      || T == []u16  || T == []s16
            || T == []u32     || T == []s32     || T == []u64  || T == []s64
            || T == []float32 || T == []float64 || T == []bool
            || T == string
    then true
    else false;
} {
    free(cast(*void) data.count);
    free(data);
}

#import "Basic";
