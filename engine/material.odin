package engine

MaterialProperty :: enum {
    Solid,
    Transparent,
}

MaterialProperties :: bit_set[MaterialProperty] 

Material :: struct {
    using header: CellAttributes,
    props: MaterialProperties,
}