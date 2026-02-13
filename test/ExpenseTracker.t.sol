// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import {Test} from "forge-std/Test.sol";
import {TotalExpenseTracker} from "../src/ExpenseTracker.sol";

contract trackerTest is Test {
    TotalExpenseTracker public tracker;
    address public user;

    event ExpenseAdded(address indexed user, uint256 amount, string note);

    function setUp() public {
        tracker = new TotalExpenseTracker();
    }

    function testSingleExpenseIsAddingOfUser() public {
        // tracker = new TotalExpenseTracker();
        user = address(1);
        vm.startPrank(user);
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 100, "coldDrink");
        tracker.addExpense(100, "coldDrink");
        uint256 totalExpense = tracker.totalExpense();
        vm.stopPrank();
        assertEq(totalExpense, 100);
    }

    function testMultipleExpensesAreAddingOfUser() public {
        // tracker = new TotalExpenseTracker();
        user = address(1);
        vm.startPrank(user);
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 20, "coldDrink");
        tracker.addExpense(20, "coldDrink");
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 70, "tandooriMoMos");
        tracker.addExpense(70, "tandooriMoMos");
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 60, "shawarma");
        tracker.addExpense(60, "shawarma");
        uint256 totalExpense = tracker.totalExpense();

        vm.stopPrank();
        assertEq(totalExpense, 150);
    }

    function testMultiUserIsolationExpenseIsAdding() public {
        // tracker = new TotalExpenseTracker();
        // user-1
        user = address(1);
        vm.startPrank(user);
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 20, "campa");
        tracker.addExpense(20, "campa");
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 70, "tandooriMoMos");
        tracker.addExpense(70, "tandooriMoMos");
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 60, "shawarma");
        tracker.addExpense(60, "shawarma");
        uint256 totalExpenseOfUser1 = tracker.totalExpense();
        vm.stopPrank();
        assertEq(totalExpenseOfUser1, 150);

        // user-2
        user = address(2);
        vm.startPrank(user);
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 10, "tea");
        tracker.addExpense(10, "tea");
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 5, "matthi");
        tracker.addExpense(5, "matthi");
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 20, "samosa");
        tracker.addExpense(20, "samosa");
        uint256 totalExpenseOfUser2 = tracker.totalExpense();
        vm.stopPrank();
        assertEq(totalExpenseOfUser2, 35);

        // user-3

        user = address(3);
        vm.startPrank(user);
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 50, "biryani");
        tracker.addExpense(50, "biryani");
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 30, "haleem");
        tracker.addExpense(30, "haleem");
        vm.expectEmit(true, false, false, true);
        emit ExpenseAdded(user, 20, "campa");
        tracker.addExpense(20, "campa");
        uint256 totalExpenseOfUser3 = tracker.totalExpense();
        vm.stopPrank();
        assertEq(totalExpenseOfUser3, 100);
    }
}
