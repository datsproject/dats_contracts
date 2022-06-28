require("@nomiclabs/hardhat-waffle");

const PRIVATE_KEY = "9f3e46d80ddd2fa4a815ace28ee9be47aa28ce60d5df49ae1a202e64e97cb176";


module.exports = {
    solidity: "0.8.2",
    compilers: [{ version: "0.8.7" }],
    networks: {
        mainnet: {
            url: `https://api.avax.network/ext/bc/C/rpc`,
            //accounts: [`${PRIVATE_KEY}`]
        },
        fuji: {
            url: `https://api.avax-test.network/ext/bc/C/rpc`,
            accounts: [`${PRIVATE_KEY}`]
        },
        dats: {
            url: `http://144.91.97.243:9650/ext/bc/FnTgpjfC8HiCCZu35MCjRxT7oN6yjGHvvGJ3GaENMHxG2tJzL/rpc`,
            accounts: [`${PRIVATE_KEY}`]
        }
    }
};