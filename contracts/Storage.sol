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
            //First three values are less the 32bytes so will be in slot1, loadinf slot 1 will load all three
            let dataSlot1 := sload(bytes4data_slot)

            //Address is 20 bytes so will occupy its own slot, value will be in slot2
            let dataSlot2 := sload(addrdata_slot)

            // Returning byte4 (4*8 =32 bits first data) - 224+32=256total , thats where 224 is coming from
            output1 := shl(224, and(dataSlot1, 0xffffffff))

            // Returning uint64 bit value, from its offset in slot1
            output2 := shr(shl(3, uintdata_offset), dataSlot1)

            // Returning bool value 1 bit, from slot 1
            output3 := shr(shl(3, booldata_offset), dataSlot1)

            // Returning address which has its own slot2 now
            output4 := dataSlot2
        }
    }
}
