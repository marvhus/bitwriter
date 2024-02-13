
#load "primitives.jai";

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
