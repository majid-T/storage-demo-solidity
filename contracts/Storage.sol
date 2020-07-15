pragma solidity >0.5.0;

contract Storage {
    bytes4 bytes4data = 0xaabbccdd;
    uint72 uintdata = 0x123456;
    bool booldata = true;
    address addrdata = 0xdC962cEAb6C926E3a9B133c46c7258c0E371b82b;

    function getData()
        public
        view
        returns (
            bytes4 output1,
            uint64 output2,
            bool output3,
            address output4
        )
    {
        assembly {
            // loading all storage data to stack
            let d1 := sload(bytes4data_slot)
            let d2 := sload(uintdata_slot)
            let d3 := sload(booldata_slot)
            let d4 := sload(addrdata_slot)

            // getting data from stack and bitwise ops where required
            output1 := shl(224, and(d1, 0xffffffff))
            output2 := shr(shl(3, uintdata_offset), d1)
            output3 := d3
            output4 := d4
        }
    }
}
