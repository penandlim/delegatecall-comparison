## Comparison of delegatecall revert handling in OpenZeppelin and Uniswap's v3-periphery

The Multicall contract from Uniswap's v3-periphery relies on bad revert handling. It incorrectly shifts the pointer of returned data array by 4, which causes the length to be the concatenation of the actual length and the first 4 bytes of the revert data, which is usually the 4 byte Error signature.

![image](https://github.com/penandlim/delegatecall-comparison/assets/4276174/1d057d3d-78d6-4739-b2fd-89564602ac02)


Although the current solidity implementation of abi.decode is able to ignore the length given and parse the string correctly, the reliance of abi.decode should not be the determining factor of whether the code is secure or not.

Furthermore, OpenZeppelin's library is able to bubble up custom errors correctly thus should be preferred over the Uniswap's implementation.

### Relevant links

https://web.archive.org/web/20240207202615/https://medium.com/@0xdeadbeef0x/the-double-edged-sword-of-abi-decode-f81529e62bcc
https://medium.com/@0xdeadbeef0x/the-double-edged-sword-of-abi-decode-f81529e62bcc
https://github.com/Uniswap/v3-periphery/issues/254
