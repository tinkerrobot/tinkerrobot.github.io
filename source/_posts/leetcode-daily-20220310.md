---
title: "【LeetCode Daily】2022.03.10 题解"
date: 2022-03-10 01:00:00
tags:
- LeetCode
- LeetCode Daily
- Algorithm
categories:
- LeetCode Daily
---

今日题目：

* [0589. N 叉树的前序遍历](https://leetcode-cn.com/problems/n-ary-tree-preorder-traversal/)
* [0002. Add Two Numbers](https://leetcode.com/problems/add-two-numbers/)

<!-- more -->

## 0589. N 叉树的前序遍历

### 思路

所谓前序遍历，指的是先访问节点自身，然后从左向右依次对每个子节点做前序遍历。因此可以使用栈，每次访问并弹出栈顶元素时，就将其子节点从右向左（因为栈的特性是后进先出，所以这里是逆序）依次压入栈中。

### 代码

```c#
public class Solution {
    public IList<int> Preorder(Node root) {
        var result = new List<int>();
        if(root == null) {
            return result;
        }

        var s = new Stack<Node>();
        s.Push(root);
        while(s.Count > 0) {
            var node = s.Pop();
            result.Add(node.val);
            for(var i = node.children.Count - 1; i >= 0; --i) {
                s.Push(node.children[i]);
            }
        }

        return result;
    }
}
```

## 0002. Add Two Numbers

### 思路

使用链表模拟竖式加法，从低位向高位逐级相加即可。

### 代码

```c#
public class Solution {
    public ListNode AddTwoNumbers(ListNode l1, ListNode l2) {
        var guard = new ListNode();
        var p1 = l1;
        var p2 = l2;
        var p = guard;
        var carry = 0;
        while(p1 != null || p2 != null) {
            var v1 = p1 == null ? 0 : p1.val;
            var v2 = p2 == null ? 0 : p2.val;
            p1 = p1 == null ? null : p1.next;
            p2 = p2 == null ? null : p2.next;
            var sum = v1 + v2 + carry;
            carry = sum / 10;
            p.next = new ListNode(sum % 10);
            p = p.next;
        }

        if(carry > 0) {
            p.next = new ListNode(carry);
        }

        return guard.next;
    }
}
```