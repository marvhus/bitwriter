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
    print("%\n", res);
}

#import "Basic";
