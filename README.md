# bitwriter

A simple Jai library for reading/writing your values from/to binary data.

> [!WARNING]  
> Here be dragons.  This is just something I am making for fun.  Don't expect it to be production ready.

## TODO
- [x] **Writing primitives**  
    Make some function that can write the primary types:
    u8, s8, u16, s16, u32, s32, u64, s64, float32, float64.
- [x] **Reading primitives**  
    Make some function that can read the primary types:
    u8, s8, u16, s16, u32, s32, u64, s64, float32, float64.
- [x] **Writing arbitrary structs**  
    Make some function that can take in any struct and
    recursively writes all the data inside it to a buffer.
- [ ] **Reading arbitrary structs**  
    Make some function that can take in any buffer and recursively
    read all the date in it into a given struct.
- [ ] **Ability to give custom writers**  
    Make some function that lets you tell the library to use a custom writer
    for a given type when recursively writing.
- [ ] **Ability to give custom readers**  
    Make some function that lets you tell the library to use a custom reader
    for a given type when recusively reading.
