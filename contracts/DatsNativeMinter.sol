//SPDX-License-Identifier: MIT
pragma solidity >=0.6.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//import "./INativeMinter.sol";

interface IAllowList {
  // Set [addr] to have the admin role over the minter list
  function setAdmin(address addr) external;

  // Set [addr] to be enabled on the minter list
  function setEnabled(address addr) external;

  // Set [addr] to have no role over the minter list
  function setNone(address addr) external;

  // Read the status of [addr]
  function readAllowList(address addr) external view returns (uint256);
}

interface INativeMinter is IAllowList {
  // Mint [amount] number of native coins and send to [addr]
  function mintNativeCoin(address addr, uint256 amount) external;
}

contract DatsNativeMinter is ERC20, Ownable {
  // Precompiled Native Minter Contract Address
  //0x55090A22D5c42a02D15c5CE7b90c0dcccd860139;
  address constant MINTER_ADDRESS = 0x0200000000000000000000000000000000000001; 
  // Designated Blackhole Address
  //address constant BLACKHOLE_ADDRESS = 0x0100000000000000000000000000000000000000;
  string private constant TOKEN_NAME = "DATS Token";
  string private constant TOKEN_SYMBOL = "DATS";

  INativeMinter nativeMinter = INativeMinter(MINTER_ADDRESS);

  event Deposit(address indexed dst, uint256 wad);
  event Mintdrawal(address indexed src, uint256 wad);

  constructor(uint256 initSupply) ERC20(TOKEN_NAME, TOKEN_SYMBOL) {
    // Mints INIT_SUPPLY to owner
    _mint(_msgSender(), initSupply);
  }

  // Mints [amount] number of ERC20 token to [to] address.
  function mint(address to, uint256 amount) external onlyOwner {
    _mint(to, amount);
  }

  // Burns [amount] number of ERC20 token from [from] address.
  function burn(address from, uint256 amount) external onlyOwner {
    _burn(from, amount);
  }

  // Swaps [amount] number of ERC20 token for native coin.
  function mintdraw(uint256 wad) external {
    // Burn ERC20 token first.
    _burn(_msgSender(), wad);
    // Mints [amount] number of native coins (gas coin) to [msg.sender] address.
    // Calls NativeMinter precompile through INativeMinter interface.
    nativeMinter.mintNativeCoin(_msgSender(), wad);
    emit Mintdrawal(_msgSender(), wad);
  }

  // Swaps [amount] number of native gas coins for ERC20 tokens.
  function deposit() external payable {
    // Burn native token by sending to BLACKHOLE_ADDRESS
    //payable(BLACKHOLE_ADDRESS).transfer(msg.value);
    // Mint ERC20 token.
    _mint(_msgSender(), msg.value);
    emit Deposit(_msgSender(), msg.value);
  }

  function decimals() public view virtual override returns (uint8) {
    return 18;
  }
}