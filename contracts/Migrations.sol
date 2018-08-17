pragma solidity ^0.4.19;

/// @title Truffle Migrations Contract
/// @author Consensys / Tim Coulter

contract Migrations {

  /// @notice The owner of this Contract
  /// @dev Set to `msg.sender` on creation

  /// The owner of the migrations contract.
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  /// Constructor
  constructor() public {
    owner = msg.sender;
  }

  /// @notice Set the latest completed migraiton step for project
  /// @param completed Completed step
  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  /// @notice Upgrades to a new Migrations contract
  /// @param new_address Address of the new owner
  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
