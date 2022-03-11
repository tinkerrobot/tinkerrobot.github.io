---
title: "【LeetCode Daily】2022.03.11 题解"
date: 2022-03-11 01:00:00
tags:
- LeetCode
- LeetCode Daily
- Algorithm
categories:
- LeetCode Daily
---

今日题目：

* [2049. 统计最高分的节点数目](https://leetcode-cn.com/problems/count-nodes-with-the-highest-score/)
* [0061. Rotate List](https://leetcode.com/problems/rotate-list/)

<!-- more -->

## 2049. 统计最高分的节点数目

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

## 0061. Rotate List

### 思路

设链表长度为 $L$，则 Rotate $K$ 位等价于将链表分成长度为 $L - K$ 和 $K$ 的两部分，然后将这两部分的顺序对调。

### 代码

```c#
public class Solution {
    public ListNode RotateRight(ListNode head, int k) {
        // 首先遍历链表，求出链表的长度 L
        var length = 0;
        var p = head;
        while(p != null) {
            ++length;
            p = p.next;
        }

        // 显然，Rotate(0) 和 Rotate(L) 都会让链表保持不变；
        // 因此，Rotate(K) 等价于 Rotate(K % L)。
        // 若 L == 0，或者 K % L == 0，则直接返回原链表。
        if(length == 0 || k % length == 0) {
            return head;
        }

        // 找到第 L - K 个节点和最后一个节点。
        k = length - k % length;
        var ph = head;
        while(--k > 0) {
            ph = ph.next;
        }
        var pt = head;
        while(pt.next != null) {
            pt = pt.next;
        }

        // 将链表从第 L - K 个节点处分为两部分，
        // 此时，原链表的第 L - K 个节点成为新链表的最后一个节点；
        // 原链表的最后一个节点与第一个节点相连；
        // 原链表的第 L - K + 1 个节点成为新链表的首节点。
        var result = ph.next;
        ph.next = null;
        pt.next = head;
        return result;
    }
}
```