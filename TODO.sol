// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract TodoList {
    address public owner;
    uint public taskCount;

    struct Task {
        uint Id;
        string content;
        bool completed;
    }

mapping(uint=> Task)public tasks;

event TaskAdded (uint id, string content,bool completed);
event TaskCompleted(uint id, string content, bool completed);

modifier onlyOwner() {
    require (msg.sender == owner, "Only the owner can sell this function");
    _;
}

constructor() {
    owner = msg.sender;
}

function addTask (string memory _content) external onlyOwner {
    taskCount++;
    tasks[taskCount] = Task(taskCount, _content, false);
    emit TaskAdded(taskCount, _content, false);
}

function completeTask(uint _taskid) external onlyOwner {
    require(_taskid <= taskCount && _taskid >0, "Invalid task ID");
    tasks[_taskid].completed = true;
    emit TaskCompleted(_taskid, tasks[_taskid].content, true);
  }
}