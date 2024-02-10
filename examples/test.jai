#import,dir "..";

main :: () {
    test(u8, 5);
    test(s8, -5);
    test(u16, 999);
    test(s16, -99);
}

test :: ($T: Type, data: T) {
    value : T = cast(T) data;
    res1 := bitwriter_primitive(value);
    res2 := bitreader_primitive(res1, T);
    print("Type: %, Value: %, Res1: %, Res2: %\n",
          T, value, res1, res2.*);
    free(res2);
} 

#import "Basic";
