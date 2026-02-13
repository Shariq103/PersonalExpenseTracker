// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract TotalExpenseTracker {
    event ExpenseAdded(address indexed user, uint256 amount, string note);

    mapping(address => Expense[]) private myExpense;

    struct Expense {
        uint256 _amount;
        string _note;
    }

    function addExpense(
        uint256 _amount,
        string memory _note
    ) public returns (Expense memory) {
        myExpense[msg.sender].push(Expense(_amount, _note));
        emit ExpenseAdded(msg.sender, _amount, _note);
        return Expense(_amount, _note);
    }

    function totalExpense() public view returns (uint256) {
        uint256 TotalExpense = 0;
        for (uint256 i = 0; i < myExpense[msg.sender].length; i++) {
            TotalExpense += myExpense[msg.sender][i]._amount;
        }
        return TotalExpense;
    }
}
