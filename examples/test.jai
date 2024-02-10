#import,dir "..";

main :: () {
    test(cast(u8)    5);
    test(cast(s8)   -5);
    test(cast(u16) 999);
    test(cast(s16) -99);
}

test :: (value: $T) {
    res1 := bitwriter_primitive(value);
    res2 := bitreader_primitive(res1, T);
    print("Type: %, Value: %, Res1: %, Res2: %\n",
          T, value, res1, res2.*);
    free(res2);
} 

#import "Basic";
