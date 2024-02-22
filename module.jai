// Integer ant Float primitives
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

// Array and String primitives
bitwriter_primitive :: (data: $T) -> []u8 #modify {
    return ifx T == []u8   || T == []s8
            || T == []u16  || T == []s16
            || T == []u32  || T == []s32
            || T == []u64  || T == []s64
            || T == string
    then true
    else false;
} {
    res: [..]u8;
    array_add(*res, ..bitwriter_primitive(data.count));
    for 0..data.count - 1 {
        array_add(*res, ..bitwriter_primitive(data.data[it]));
    }
    return res;
}

// Integer and Float primitives
bitreader_primitive :: (data: []u8, $T: Type) -> *T #modify {
    return ifx T == u8      || T == s8
            || T == u16     || T == s16
            || T == u32     || T == s32
            || T == u64     || T == s64
            || T == float32 || T == float64 then true else false;
} {
    res: *u8 = alloc(size_of(T));
    for 0..size_of(T)-1 {
        res[it] = data[it];
    }

    return cast(*T) res;
}

// Array and String primitives
bitreader_primitive :: (data: []u8, $T: Type) -> *T #modify {
    return ifx T == []u8    || T == []s8
            || T == []u16   || T == []s16
            || T == []u32   || T == []s32
            || T == []u64   || T == []s64
            || T == string then true else false;
} {
    value: *T = alloc(size_of(T));
    count_type :: type_of(value.count);
    value_type :: type_of(value.data.*);
    // Get the array length
    count := bitreader_primitive(data, count_type);
    value.count = count.*;
    free(count);
    // Allocate the array
    value.data = alloc(size_of(value_type) * value.count);
    // Read the array data
    for 0..value.count-1 {
        offset := size_of(count_type) + size_of(value_type) * it;
        data2 := []u8.{
            count = data.count - offset,
            data = data.data + offset,
        };
        res := bitreader_primitive(data2, value_type);
        value.*[it] = res.*;
        free(res);
    }

    return value;
}

bitwriter :: (data: Any) -> []u8 {
    res: [..]u8;
    
    if data.type.type == {
        case .INTEGER;
        {
            info := cast(*Type_Info_Integer) data.type;
            if info.signed {
                if info.runtime_size == {
                    case 1; array_add(*res, ..bitwriter_primitive((cast(*u8) data.value_pointer).*));
                    case 2; array_add(*res, ..bitwriter_primitive((cast(*u16) data.value_pointer).*));
                    case 4; array_add(*res, ..bitwriter_primitive((cast(*u32) data.value_pointer).*));
                    case 8; array_add(*res, ..bitwriter_primitive((cast(*u64) data.value_pointer).*));
                    case; assert(false, "What the fuck is this integer???\n");
                }
            } else {
                if info.runtime_size == {
                    case 1; array_add(*res, ..bitwriter_primitive((cast(*u8) data.value_pointer).*));
                    case 2; array_add(*res, ..bitwriter_primitive((cast(*u16) data.value_pointer).*));
                    case 4; array_add(*res, ..bitwriter_primitive((cast(*u32) data.value_pointer).*));
                    case 8; array_add(*res, ..bitwriter_primitive((cast(*u64) data.value_pointer).*));
                    case; assert(false, "What the fuck is this integer???\n");
                }
            }
        }
        case .STRUCT;
        {
            info := cast(*Type_Info_Struct) data.type;
            for elem: info.members {
                any: Any = ---;
                any.type = elem.type;
                any.value_pointer = (cast(*u8) data.value_pointer) + elem.offset_in_bytes;

                array_add(*res, ..bitwriter(any));
            }
        }
        case;
        {
            print("TODO: Implement stuff for %\n", data.type.*);
        }
    }
    return res;
}

#scope_module

#import "Basic";
