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
}

test :: ($T: Type, data: T) {
    value : T = cast(T) data;
    res1 := bitwriter_primitive(value);
    res2 := bitreader_primitive(res1, T);
    print("Type: %, \tValue: %, \tRes1: %, \tRes2: %\n",
          T, value, res1, res2.*);
    free(res2);
} 

#import "Basic";
