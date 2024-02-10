bitwriter_primitive :: (data: $T) -> []u8 #modify {
    return ifx T == u8      || T == s8
        ||     T == u16     || T == s16
        ||     T == u32     || T == s32
        ||     T == u64     || T == s64
        ||     T == float32 || T == float64
    then true
    else false;
} {
    res: [..]u8;
    ptr := cast(*u8) *data;
    for 0..size_of(T)-1  array_add(*res, ptr[it]);
    return res;
}

bitreader_primitive :: (data: []u8, $T: Type) -> *T #modify {
    return ifx T == u8      || T == s8
        ||     T == u16     || T == s16
        ||     T == u32     || T == s32
        ||     T == u64     || T == s64
        ||     T == float32 || T == float64
    then true
    else false;
} {
    value: *u8 = alloc(size_of(T));
    for data  value[it_index] = it;
    return cast(*T) value;
}
