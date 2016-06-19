package cms.utils;

import cms.po.Catalog;
import cms.vo.TreeNode;
import sun.reflect.generics.tree.Tree;

import java.util.LinkedList;
import java.util.List;

/**
 * 构造无限级树结构
 */
public class TreeUtil {

    public static List<TreeNode> catalog2TreeNode(List<Catalog> list) {
        List<TreeNode> result = new LinkedList<TreeNode>();
        for (Catalog catalog : list) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(catalog.getId());
            treeNode.setPid(catalog.getPid());
            treeNode.setDeep(catalog.getDeep());
            treeNode.setName(catalog.getName());
            treeNode.setSum(catalog.getSum());

            result.add(treeNode);
        }

        return result;
    }

    public static TreeNode baseTreeNode(List<TreeNode> list) {
        TreeNode root = new TreeNode();
        root.setDeep(0);
        root.setPid(0);

        for (TreeNode treeNode : list) {
            if (treeNode.getPid() == 0) {
                root.addChild(treeNode);
            } else {
                TreeNode tn = getChildById(list, treeNode);

                tn.addChild(treeNode);
            }
        }

        // print(root, 1);
        return root;
    }

    private static TreeNode getChildById(List<TreeNode> list, TreeNode treeNode) {
        Integer pId = treeNode.getPid();
        Integer deep = treeNode.getDeep();

        for (TreeNode tn : list) {
            if (tn.getDeep() == deep - 1) {
                if (tn.getId() == pId) {
                    return tn;
                }
            }
        }
        return null;
    }

    private static void print(TreeNode tn, int level) {
        if (tn.getItems() != null) {
            for (TreeNode temp : tn.getItems()) {
                for (int i = 0; i < level; ++i) {
                    System.out.print(" ");
                }
                System.out.println(level + ":" + temp.getName());
                print(temp, level + 1);
            }
        }
    }
}
