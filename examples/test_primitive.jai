#import,dir "..";

main :: () {
    test(u8, 5);
    test(s8, -5);
    test(u16, 999);
    test(s16, -99);
    test(u32, 91827389);
    test(s32, -89127312);
    test(u64, 71234897119847);
    test(s64, -817234981247);
    test(float32, 1.24234);
    test(float64, 9.189234718923);

    test([]u8,  u8.[1,2,3,4]);
    test([]s8,  s8.[-1,-2,-3,-4]);
    test([]u16, u16.[100,200,300,400]);
    test([]s16, s16.[-100,-200,-300,-400]);
    test([]u32, u32.[1000,2000,3000,4000]);
    test([]s32, s32.[-1000,-2000,-3000,-4000]);
    test([]u64, u64.[10000,20000,30000,40000]);
    test([]s64, s64.[-10000,-20000,-30000,-40000]);

    test(string, "Hello, Sailor!");
}

test :: ($T: Type, data: T) {
    res1 := bitwriter_primitive(data);
    res2 := bitreader_primitive(res1, T);
    print("Type: %, \n-\tValue: %, \n-\tRes1: %, \n-\tRes2: %\n",
          T, data, res1, res2.*);
    free(res2);
} 

#import "Basic";
