const LightWalletProvider = require('@digix/truffle-lightwallet-provider');

const { KEYSTORE, PASSWORD } = process.env;

if (!KEYSTORE || !PASSWORD) { throw new Error('You must export KEYSTORE and PASSWORD (see truffle.js)'); }

module.exports = {
  networks: {
    kovan: {
      provider: new LightWalletProvider({
        keystore: KEYSTORE,
        password: PASSWORD,
        rpcUrl: 'https://kovan.infura.io/',
        pollingInterval: 2000,
        // debug: true,
      }),
      gas: 4600000,
      network_id: '42',
    },
    mainnet: {
      provider: new LightWalletProvider({
        keystore: KEYSTORE,
        password: PASSWORD,
        rpcUrl: 'https://mainnet.infura.io/',
        pollingInterval: 5000,
        // debug: true,
      }),
      network_id: '1',
    },
    classic: {
      provider: new LightWalletProvider({
        keystore: KEYSTORE,
        password: PASSWORD,
        rpcUrl: 'https://digixparity04.digix.io/',
        pollingInterval: 5000,
        // debug: true,
      }),
      gas: 400000,
      network_id: '61',
    },
    development: {
      host: 'localhost',
      port: 6545,
      network_id: '*',
    },
  },
};
