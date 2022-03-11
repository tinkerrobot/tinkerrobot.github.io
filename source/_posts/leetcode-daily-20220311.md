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

对于任意一个节点，删除之后剩余的树包括以它的每个子节点为根的子树，以及它的父节点所在那颗树。

其中，每颗子树的节点数可以通过深度优先搜索求出。

而父节点所在的那颗树的节点数目，等于树中的节点总数，减去以当前节点为根的子树的节点数。

这样，就可以求出树中任意一个节点的分数了。

### 代码

```c#
public class Solution {
    public int CountHighestScoreNodes(int[] parents) {
        // 首先，构建出题给的树，保存树中每个节点对其子节点的引用。
        var num = parents.Length;
        var children = new List<int>[num];

        for(var i = 0; i < num; ++i) {
            children[i] = new List<int>();
        }

        for(var i = 0; i < num; ++i) {
            if(parents[i] >= 0) {
                children[parents[i]].Add(i);
            }
        }

        // 使用深度优先遍历，求出以每个节点为根的子树的节点数。
        var trees = new int[num];
        dfs(0, children, trees);

        // 根据【思路】中的分析，求出每个节点的分数。
        var scores = new long[num];
        for(var i = 0; i < num; ++i) {
            var score = 1L;
            // 以每个子节点为根的子树的节点数。
            for(var j = 0; j < children[i].Count; ++j) {
                score *= trees[children[i][j]];
            }

            // 删掉以当前节点为根的子树后，剩余部分的节点数。
            var left = num - trees[i];
            if(left > 0) {
                score *= left;
            }
            scores[i] = score;
        }

        var max = long.MinValue;
        for(var i = 0; i < num; ++i) {
            max = Math.Max(max, scores[i]);
        }

        var result = 0;
        for(var i = 0; i < num; ++i) {
            if(scores[i] == max) {
                ++result;
            }
        }

        return result;
    }

    private int dfs(int node, List<int>[] children, int[] trees) {
        trees[node] = 1;
        for(var i = 0; i < children[node].Count; ++i) {
            trees[node] += dfs(children[node][i], children, trees);
        }

        return trees[node];
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