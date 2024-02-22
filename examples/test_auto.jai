#import,dir "..";

main :: () {
    Bar :: struct {
        f : u32;
    }
    Foo :: struct {
        a : u8;
        b : u32;
        c : struct {
            d : u64;
        };
        e : Bar;
    }
    foo := Foo.{64, 999, .{1}, .{2}};
    res := bitwriter(foo);
    print("Foo %\n", res);


    print("float %\n", bitwriter(3.14159265));

    print("[]u8  %\n", bitwriter(u8.[1,2,3,4]));
    print("[]u16 %\n", bitwriter(u16.[1,2,3,4]));
    print("[]u32 %\n", bitwriter(u32.[1,2,3,4]));
    print("[]u64 %\n", bitwriter(u64.[1,2,3,4]));

    print("[]Bar%\n", bitwriter(Bar.[.{0}, .{1}, .{2}]));

    print("string %\n", bitwriter("Hello, Sailor!"));

    print("bool %\n", bitwriter(true));
    print("bool %\n", bitwriter(false));
}

#import "Basic";
