# Personal Expense Tracker (On-chain)

A simple on-chain expense tracker that allows users to record their expenses and view **only their own total expense**.

---

##

This project is fully build by me (MOHD SHARIQ).

## Features

- Users can add expenses with amount and note
- Each user has a private expense ledger
- Users can view only their own total expense
- Expense data of other users is not accessible
- Emits an event on every expense addition

---

## Smart Contract

- Written in Solidity
- Uses `struct`, `mapping`, and `msg.sender`
- Expense data is stored per user
- Mapping is private to prevent direct access

---

## Events

- `ExpenseAdded(address user, uint256 amount, string note)`
- Emitted whenever a user adds an expense

---

## Testing

- Tests written using Foundry
- Covers:
  - Single expense addition
  - Multiple expenses for one user
  - Multi-user data isolation
  - Event emission

Run tests using:

```bash
forge test -vvvv
```
