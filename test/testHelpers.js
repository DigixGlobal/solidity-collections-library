const bN = web3.toBigNumber;
module.exports = {

  // web3.toAscii results in some padding \u0000 at the end,
  // this function fixes this problem
  // link to issue: https://github.com/ethereum/web3.js/issues/337
  myToAscii(input) {
    return web3.toAscii(input).replace(/\u0000/g, '');
  },
  bN,
  // testAddresses is used to test contracts/lib/LibraryDLL.sol
  testAddresses: [
    '0x817229b2d1cb37bf23b20185d59aff8595e52401',
    '0x249b1bf054d2b2643a0e38948aa92ccb6c2ccd7e',
    '0x1cd24e853af2027df542551f393b1bd0db2f1a03',
    '0x54e3872db39fc3a1fa018688bff59dd6409b0a23',
    '0x4db089d50f72996895dc4224c8c6fae0f104bc1d',
    '0x74cd5f20ee949189bdc83f7f6088063eb7fdcc86',
    '0xa1fada6e4f11770a672ca678d6290b311f53c256',
    '0xd52a101f5e10559846d58ca2a1f99689f05ddc36',
    '0xf7efab25c05198f7888ba162cd529ef6c24775ec',
    '0x9015c93a07f81d751d596c2b1f1eadb681d101ff',
    '0xee65d96c59f7e619b82c80044968441fa2294cd5',
    '0x3ff03f2a39b25a20c28eb29bb73af71d837529dd',
    '0x94a80f9361f2057583596ce21b21c3e68ebebf75',
    '0x8b70a78e11d94c6aef5f7421ce960f1092cebf06',
    '0x40ed0f182df5158a1087ecbb80261c981c36bbf7',
    '0xdb733de562cbe4d2c9352b0c308ab7e5fd1f2815',
    '0x6b0fe0e38924b303dcd6d43d8761d58b706c4527',
    '0x3d6cd190653ab276f67712366fa89b9aefb1011d',
    '0x3221c89a8c6e2c8854a8eddcbb197312657de2f2',
    '0xf903ac86e05120384dc1a447f284b9f207880e86',
  ],
  // exampleAddresses is used to test contracts in contracts/abstract
  exampleAddresses: ['blah',
    '0x7812421a7579d8182dc6f2b68ab56595db01553f',
    '0x419f0a80d85f3c7dc3553394d91c9a339332a01e',
    '0xf5dfe2a3f8cf5ca8723b51be6fc065bea0cfe893',
    '0x5dc52d499a77af45f43174cfe7982dc68c331c38',
    '0x727c89006bd885f9a77254797a362d69e8a1f4da',
    '0x0f66ec3df48ec1e216d24e225b772696e031b698',
    '0xd2b90da1b96cbe2aa1b000000000000000000000',
  ],
  exampleUints: [bN(0),
    bN(1002),
    bN(1003),
    bN(1004),
    bN(1005),
    bN(1006),
    bN(1007),
  ],
  emptyAddress: '0x0000000000000000000000000000000000000000',
};
