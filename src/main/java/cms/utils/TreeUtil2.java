//package cms.utils;
//
//import cms.po.Catalog;
//import cms.vo.TreeNode;
//
//import java.util.LinkedList;
//import java.util.List;
//
///**
// * 构造无限级树结构
// */
//public class TreeUtil2 {
//
//    public static List<TreeNode> catalog2TreeNode(List<Catalog> list) {
//        List<TreeNode> result = new LinkedList<TreeNode>();
//        for (Catalog catalog : list) {
//            TreeNode treeNode = new TreeNode();
//            treeNode.setId(catalog.getId());
//            treeNode.setPid(catalog.getPid());
//            treeNode.setDeep(catalog.getDeep());
//            treeNode.setName(catalog.getName());
//            treeNode.setSum(catalog.getSum());
//
//            result.add(treeNode);
//        }
//
//        return result;
//    }
//
//    public static TreeNode baseTreeNode(List<TreeNode> list) {
//        TreeNode root = new TreeNode();
//        root.setDeep(0);
//        root.setPid(0);
//
//        for (TreeNode treeNode : list) {
//            if (treeNode.getPid() == 0) {
//                root.addChild(treeNode);
//            } else {
//                TreeNode tn = getChildById(root, treeNode);
//
//                tn.addChild(treeNode);
//            }
//        }
//
//        // print(root, 1);
//        return root;
//    }
//
//    private static TreeNode getChildById(TreeNode root, TreeNode treeNode) {
//        Integer pId = treeNode.getPid();
//        Integer deep = treeNode.getDeep();
//
//        List<TreeNode> searchPlace = root.getItems();
//
//        for (int i = 1; i < deep; ++i) {
//            if (i == deep - 1) {
//                for (TreeNode tn : searchPlace) {
//                    if (tn.getId() == pId) {
//                        return tn;
//                    }
//                }
//            } else {
//                List<TreeNode> temp = new LinkedList<TreeNode>();
//                for (TreeNode tn : searchPlace) {
//                    if (tn.getItems() != null) {
//                        for (TreeNode child : tn.getItems()) {
//                            temp.add(child);
//                        }
//                    }
//                }
//                searchPlace = temp;
//            }
//        }
//        return null;
//    }
//
//    private static void print(TreeNode tn, int level) {
//        if (tn.getItems() != null) {
//            for (TreeNode temp : tn.getItems()) {
//                for (int i = 0; i < level; ++i) {
//                    System.out.print(" ");
//                }
//                System.out.println(level + ":" + temp.getName());
//                print(temp, level + 1);
//            }
//        }
//    }
//}
